import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/extensions/localization.dart';
import '../../../../core/injection/injection_container.dart';
import '../../../../core/storage/data/storage.dart';
import '../../../auth/presentation/view/login_view.dart';
import '../cubit/conversations_cubit.dart';
import 'chat_view.dart';
import 'package:iconsax/iconsax.dart';
import '../../../../core/config/app_colors.dart';
import '../../domain/entities/chat.dart';
import '../widgets/chat_chrome.dart';

class ConversationsView extends StatefulWidget {
  const ConversationsView({
    super.key,
    this.vendorId,
    this.startSupport = false,
  });
  final int? vendorId;
  final bool startSupport;
  @override
  State<ConversationsView> createState() => _ConversationsViewState();
}

class _ConversationsViewState extends State<ConversationsView>
    with WidgetsBindingObserver {
  late final ConversationsCubit _cubit;
  late final bool _authenticated;
  Timer? _fallback;
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    _cubit = sl<ConversationsCubit>();
    _authenticated = sl<Storage>().getToken()?.isNotEmpty == true;
    if (_authenticated) {
      _cubit.resumeLive();
      _fallback = Timer.periodic(const Duration(seconds: 5), (_) {
        if (mounted &&
            !_cubit.realtimeConnected &&
            ModalRoute.of(context)?.isCurrent == true &&
            WidgetsBinding.instance.lifecycleState ==
                AppLifecycleState.resumed) {
          _cubit.load(refresh: true);
        }
      });
      if (widget.vendorId != null || widget.startSupport) {
        WidgetsBinding.instance.addPostFrameCallback(
          (_) => _start(widget.vendorId),
        );
      } else {
        _cubit.load();
      }
    }
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (!_authenticated) return;
    if (state == AppLifecycleState.resumed) {
      _cubit.resumeLive();
      _cubit.load(refresh: true);
    } else {
      unawaited(_cubit.pauseLive());
    }
  }

  @override
  void dispose() {
    _fallback?.cancel();
    WidgetsBinding.instance.removeObserver(this);
    _cubit.close();
    super.dispose();
  }

  Future<void> _start(int? vendorId) async {
    final thread = await _cubit.start(vendorId: vendorId);
    if (!mounted || thread == null) return;
    await Navigator.of(context).push(
      MaterialPageRoute<void>(
        builder: (_) =>
            ChatView(conversationId: thread.id, title: thread.title),
      ),
    );
    if (mounted) _cubit.load();
  }

  Future<void> _open(ChatThread thread) async {
    await Navigator.of(context).push(
      MaterialPageRoute<void>(
        builder: (_) =>
            ChatView(conversationId: thread.id, title: thread.title),
      ),
    );
    if (mounted) _cubit.load();
  }

  String _preview(ChatThread thread) => thread.lastMessage?.isNotEmpty == true
      ? thread.lastMessage!
      : thread.lastMessageKind == 'image'
      ? context.tr.chatPhoto
      : thread.lastMessageKind == 'audio'
      ? context.tr.chatVoice
      : context.tr.chatStart;
  @override
  Widget build(BuildContext context) => BlocProvider.value(
    value: _cubit,
    child: Scaffold(
      backgroundColor: AppColors.scaffoldBg(context),
      appBar: chatAppBar(
        context,
        title: context.tr.chatTitle,
        actions: [
          if (_authenticated)
            Padding(
              padding: const EdgeInsetsDirectional.only(end: 8),
              child: IconButton(
                onPressed: () => _start(null),
                tooltip: context.tr.chatSupport,
                icon: const Icon(Iconsax.headphone, color: Colors.white),
              ),
            ),
        ],
      ),
      body: !_authenticated
          ? ChatEmptyState(
              title: context.tr.chatTitle,
              subtitle: context.tr.chatInboxHint,
              action: FilledButton(
                onPressed: () => Navigator.of(context).push(
                  MaterialPageRoute<void>(builder: (_) => const LoginView()),
                ),
                child: Text(context.tr.authLoginButton),
              ),
            )
          : BlocBuilder<ConversationsCubit, ConversationsState>(
              builder: (context, state) {
                if (state.busy || (state.loading && state.threads.isEmpty)) {
                  return const Center(
                    child: CircularProgressIndicator(color: AppColors.primary),
                  );
                }
                return RefreshIndicator(
                  color: AppColors.primary,
                  onRefresh: () => _cubit.load(),
                  child: ListView(
                    physics: const AlwaysScrollableScrollPhysics(),
                    padding: const EdgeInsets.all(16),
                    children: [
                      Text(
                        context.tr.chatInboxHint,
                        style: TextStyle(
                          fontSize: 13,
                          color: Theme.of(context).hintColor,
                          height: 1.5,
                        ),
                      ),
                      const SizedBox(height: 16),
                      if (state.failed)
                        ListTile(
                          title: Text(context.tr.chatFailed),
                          trailing: TextButton(
                            onPressed: () =>
                                widget.vendorId != null || widget.startSupport
                                ? _start(widget.vendorId)
                                : _cubit.load(),
                            child: Text(context.tr.chatRetry),
                          ),
                        ),
                      if (state.threads.isEmpty && !state.failed)
                        Padding(
                          padding: const EdgeInsets.only(top: 60),
                          child: ChatEmptyState(
                            title: context.tr.chatEmpty,
                            subtitle: context.tr.chatSupportHint,
                            action: OutlinedButton.icon(
                              onPressed: () => _start(null),
                              icon: const Icon(Iconsax.headphone),
                              label: Text(context.tr.chatSupport),
                            ),
                          ),
                        ),
                      for (final thread in state.threads)
                        Padding(
                          padding: const EdgeInsets.only(bottom: 10),
                          child: Material(
                            color: AppColors.cardBg(context),
                            borderRadius: BorderRadius.circular(18),
                            child: InkWell(
                              borderRadius: BorderRadius.circular(18),
                              onTap: () => _open(thread),
                              child: Padding(
                                padding: const EdgeInsets.all(14),
                                child: Row(
                                  children: [
                                    CircleAvatar(
                                      radius: 25,
                                      backgroundColor: AppColors.primary
                                          .withValues(alpha: .09),
                                      foregroundColor: AppColors.primary,
                                      child: thread.avatarUrl != null
                                          ? ClipOval(
                                              child: Image.network(
                                                thread.avatarUrl!,
                                                width: 50,
                                                height: 50,
                                                fit: BoxFit.cover,
                                                errorBuilder: (_, _, _) =>
                                                    const Icon(
                                                      Iconsax.building_4,
                                                    ),
                                              ),
                                            )
                                          : Icon(
                                              thread.kind == 'support'
                                                  ? Iconsax.headphone
                                                  : Iconsax.building_4,
                                            ),
                                    ),
                                    const SizedBox(width: 12),
                                    Expanded(
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            thread.title,
                                            maxLines: 1,
                                            overflow: TextOverflow.ellipsis,
                                            style: TextStyle(
                                              fontSize: 15,
                                              fontWeight: thread.unreadCount > 0
                                                  ? FontWeight.w700
                                                  : FontWeight.w600,
                                            ),
                                          ),
                                          const SizedBox(height: 5),
                                          Text(
                                            _preview(thread),
                                            maxLines: 1,
                                            overflow: TextOverflow.ellipsis,
                                            style: TextStyle(
                                              fontSize: 12,
                                              color: Theme.of(
                                                context,
                                              ).hintColor,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    const SizedBox(width: 10),
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.end,
                                      children: [
                                        if (thread.lastMessageAt != null)
                                          Text(
                                            TimeOfDay.fromDateTime(
                                              thread.lastMessageAt!.toLocal(),
                                            ).format(context),
                                            style: TextStyle(
                                              fontSize: 10,
                                              color: Theme.of(
                                                context,
                                              ).hintColor,
                                            ),
                                          ),
                                        const SizedBox(height: 8),
                                        if (thread.unreadCount > 0)
                                          Container(
                                            padding: const EdgeInsets.symmetric(
                                              horizontal: 7,
                                              vertical: 3,
                                            ),
                                            decoration: BoxDecoration(
                                              color: AppColors.primary,
                                              borderRadius:
                                                  BorderRadius.circular(10),
                                            ),
                                            child: Text(
                                              thread.unreadCount > 99
                                                  ? '99+'
                                                  : '${thread.unreadCount}',
                                              style: const TextStyle(
                                                fontSize: 10,
                                                fontWeight: FontWeight.w600,
                                                color: Colors.white,
                                              ),
                                            ),
                                          )
                                        else
                                          const Icon(
                                            Icons.chevron_right_rounded,
                                            size: 17,
                                            color: AppColors.primary,
                                          ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
                      if (state.hasMore)
                        TextButton(
                          onPressed: state.loading
                              ? null
                              : () => _cubit.load(more: true),
                          child: Text(context.tr.chatOlder),
                        ),
                    ],
                  ),
                );
              },
            ),
    ),
  );
}

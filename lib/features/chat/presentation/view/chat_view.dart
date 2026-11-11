import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/extensions/localization.dart';
import '../../../../core/injection/injection_container.dart';
import '../cubit/chat_cubit.dart';
import '../../domain/entities/chat.dart';
import '../widgets/chat_chrome.dart';
import '../widgets/chat_composer.dart';
import '../widgets/chat_message_bubble.dart';
import '../../../../core/config/app_colors.dart';

class ChatView extends StatefulWidget {
  const ChatView({super.key, required this.conversationId, this.title});
  final int conversationId;
  final String? title;
  @override
  State<ChatView> createState() => _ChatViewState();
}

class _ChatViewState extends State<ChatView> with WidgetsBindingObserver {
  late final ChatCubit _cubit;
  Timer? _timer;
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    _cubit = sl<ChatCubit>(param1: widget.conversationId);
    _cubit.poll();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (mounted) _cubit.resumeLive(isVisible: _visible);
    });
    _timer = Timer.periodic(const Duration(seconds: 5), (_) {
      if (!_cubit.realtimeConnected) _poll();
    });
  }

  bool _visible() =>
      mounted &&
      ModalRoute.of(context)?.isCurrent == true &&
      WidgetsBinding.instance.lifecycleState == AppLifecycleState.resumed;
  void _poll() {
    if (_visible()) {
      _cubit.poll();
    }
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.resumed) {
      _cubit.resumeLive(isVisible: _visible);
      _poll();
    } else {
      unawaited(_cubit.pauseLive());
    }
  }

  @override
  void dispose() {
    _timer?.cancel();
    WidgetsBinding.instance.removeObserver(this);
    _cubit.close();
    super.dispose();
  }

  String _day(BuildContext context, DateTime date) {
    final now = DateTime.now(), day = DateUtils.dateOnly(date);
    if (day == DateUtils.dateOnly(now)) return context.tr.chatToday;
    if (day == DateUtils.dateOnly(now.subtract(const Duration(days: 1)))) {
      return context.tr.chatYesterday;
    }
    return MaterialLocalizations.of(context).formatMediumDate(date);
  }

  @override
  Widget build(BuildContext context) => BlocProvider.value(
    value: _cubit,
    child: Scaffold(
      backgroundColor: AppColors.scaffoldBg(context),
      appBar: chatAppBar(
        context,
        title: widget.title ?? context.tr.chatTitle,
        subtitle: context.tr.chatTitle,
      ),
      body: BlocBuilder<ChatCubit, ChatState>(
        builder: (context, state) {
          if (state.loading) {
            return const Center(
              child: CircularProgressIndicator(color: AppColors.primary),
            );
          }
          if (state.failed && !state.loaded) {
            return ChatEmptyState(
              title: context.tr.chatFailed,
              action: TextButton(
                onPressed: () => _cubit.poll(),
                child: Text(context.tr.chatRetry),
              ),
            );
          }
          final rows = state.messages.reversed.toList();
          return Column(
            children: [
              Expanded(
                child: rows.isEmpty
                    ? ChatEmptyState(
                        title: context.tr.chatStart,
                        subtitle: context.tr.chatEmptyMessages,
                      )
                    : ListView.builder(
                        reverse: true,
                        padding: const EdgeInsets.fromLTRB(16, 12, 16, 16),
                        itemCount: rows.length + (state.hasOlder ? 1 : 0),
                        itemBuilder: (context, index) {
                          if (index == rows.length) {
                            return TextButton(
                              onPressed: () => _cubit.poll(older: true),
                              child: Text(context.tr.chatOlder),
                            );
                          }
                          final row = rows[index],
                              date = rows[index].createdAt?.toLocal();
                          final olderDate = index + 1 < rows.length
                              ? rows[index + 1].createdAt?.toLocal()
                              : null;
                          final divider =
                              date != null &&
                              (olderDate == null ||
                                  !DateUtils.isSameDay(date, olderDate));
                          return Column(
                            children: [
                              if (divider)
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                    vertical: 14,
                                  ),
                                  child: Container(
                                    padding: const EdgeInsets.symmetric(
                                      horizontal: 12,
                                      vertical: 5,
                                    ),
                                    decoration: BoxDecoration(
                                      color: AppColors.primary.withValues(
                                        alpha: .07,
                                      ),
                                      borderRadius: BorderRadius.circular(20),
                                    ),
                                    child: Text(
                                      _day(context, date),
                                      style: TextStyle(
                                        fontSize: 11,
                                        color: Theme.of(context).hintColor,
                                      ),
                                    ),
                                  ),
                                ),
                              ChatMessageBubble(
                                key: ValueKey(row.id),
                                message: row,
                                conversationId: widget.conversationId,
                              ),
                            ],
                          );
                        },
                      ),
              ),
              if (state.failed)
                Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 8,
                  ),
                  child: Text(
                    context.tr.chatFailed,
                    style: TextStyle(
                      fontSize: 12,
                      color: Theme.of(context).colorScheme.error,
                    ),
                  ),
                ),
              ChatComposer(
                sending: state.sending,
                onSend: (String body, ChatUpload? upload) =>
                    _cubit.send(body, attachment: upload),
              ),
            ],
          );
        },
      ),
    ),
  );
}

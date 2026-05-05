import 'package:flutter/material.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../../../../core/extensions/localization.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../core/app/app_body.dart';
import '../../../../core/injection/injection_container.dart';
import '../../../../core/storage/data/storage.dart';

class LanguageView extends StatefulWidget {
  const LanguageView({super.key});

  @override
  State<LanguageView> createState() => _LanguageViewState();
}

class _LanguageViewState extends State<LanguageView> {
  late String _selectedCode;

  @override
  void initState() {
    super.initState();
    _selectedCode = sl<Storage>().getLang();
  }

  @override
  Widget build(BuildContext context) {
    final items = const <_LanguageItem>[
      _LanguageItem(code: 'en', name: 'English', flag: '🇺🇸'),
      // _LanguageItem(code: 'es', name: 'Español', flag: '🇪🇸'),
      // _LanguageItem(code: 'fr', name: 'Français', flag: '🇫🇷'),
      // _LanguageItem(code: 'de', name: 'Deutsch', flag: '🇩🇪'),
      // _LanguageItem(code: 'it', name: 'Italiano', flag: '🇮🇹'),
      _LanguageItem(code: 'ar', name: 'العربية', flag: '🇪🇬'),
    ];

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: AppColors.background,
        elevation: 0,
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back_ios_new_rounded,
            color: AppColors.darkText,
          ),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(
          context.tr.settingsLanguage,
          style: AppTextStyles.subtitle(color: AppColors.darkText),
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: EdgeInsetsDirectional.only(start: 20.w, end: 20.w, top: 12.h),
        child: Column(
          children: [
            ...items.map(
              (e) => Padding(
                padding: EdgeInsetsDirectional.only(bottom: 12.h),
                child: _LanguageTile(
                  item: e,
                  selected: _selectedCode == e.code,
                  onTap: () async {
                    setState(() => _selectedCode = e.code);
                    final app = MyApp.of(context);
                    if (app != null) {
                      await app.setLocale(Locale(e.code));
                    }
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _LanguageItem {
  const _LanguageItem({
    required this.code,
    required this.name,
    required this.flag,
  });

  final String code;
  final String name;
  final String flag;
}

class _LanguageTile extends StatelessWidget {
  const _LanguageTile({
    required this.item,
    required this.selected,
    required this.onTap,
  });

  final _LanguageItem item;
  final bool selected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: selected
          ? AppColors.primary.withValues(alpha: 0.12)
          : AppColors.onImage,
      borderRadius: BorderRadius.circular(18.r),
      child: InkWell(
        borderRadius: BorderRadius.circular(18.r),
        onTap: onTap,
        child: Container(
          padding: EdgeInsetsDirectional.symmetric(
            horizontal: 16.w,
            vertical: 14.h,
          ),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(18.r),
            border: Border.all(
              color: selected ? AppColors.primary : AppColors.border,
              width: selected ? 1.4 : 1,
            ),
          ),
          child: Row(
            children: [
              Text(item.flag, style: TextStyle(fontSize: 22.sp)),
              SizedBox(width: 12.w),
              Expanded(
                child: Text(
                  item.name,
                  style: AppTextStyles.bodyMedium(color: AppColors.darkText),
                ),
              ),
              _RadioIndicator(selected: selected),
            ],
          ),
        ),
      ),
    );
  }
}

class _RadioIndicator extends StatelessWidget {
  const _RadioIndicator({required this.selected});
  final bool selected;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 18.r,
      height: 18.r,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        border: Border.all(
          color: selected ? AppColors.primary : AppColors.border,
          width: 2,
        ),
      ),
      child: selected
          ? Center(
              child: Container(
                width: 10.r,
                height: 10.r,
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                  color: AppColors.primary,
                ),
              ),
            )
          : null,
    );
  }
}

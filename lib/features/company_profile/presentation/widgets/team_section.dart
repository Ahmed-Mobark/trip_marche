import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../../../../core/extensions/localization.dart';
import '../../../../core/config/app_images.dart';
import '../../../../core/config/dimensions/company_profile_figma_tokens.dart';

class TeamMemberItem extends StatelessWidget {
  const TeamMemberItem({
    super.key,
    required this.member,
  });

  final TeamMemberData member;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 100.w,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(CompanyProfileFigmaTokens.teamAvatarSize),
            child: Container(
              width: CompanyProfileFigmaTokens.teamAvatarSize,
              height: CompanyProfileFigmaTokens.teamAvatarSize,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(color: AppColors.surfaceDivider),
              ),
              child: member.avatarUrl.isNotEmpty
                  ? Image.network(
                      member.avatarUrl,
                      width: CompanyProfileFigmaTokens.teamAvatarSize,
                      height: CompanyProfileFigmaTokens.teamAvatarSize,
                      fit: BoxFit.cover,
                      errorBuilder: (_, __, ___) => Image.asset(
                        AppImages.logo,
                        width: CompanyProfileFigmaTokens.teamAvatarSize,
                        height: CompanyProfileFigmaTokens.teamAvatarSize,
                        fit: BoxFit.cover,
                      ),
                    )
                  : Image.asset(
                      AppImages.logo,
                      width: CompanyProfileFigmaTokens.teamAvatarSize,
                      height: CompanyProfileFigmaTokens.teamAvatarSize,
                      fit: BoxFit.cover,
                    ),
            ),
          ),
          SizedBox(height: CompanyProfileFigmaTokens.rowGapSmall),
          SizedBox(
            width: 80.w,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  member.name,
                  style: AppTextStyles.caption(color: AppColors.darkText(context)).copyWith(fontWeight: FontWeight.w600),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: CompanyProfileFigmaTokens.rowGapSmall),
                Text(
                  member.role,
                  style: AppTextStyles.caption(color: AppColors.secondaryGrey).copyWith(fontWeight: FontWeight.w400),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class TeamSection extends StatelessWidget {
  const TeamSection({super.key, required this.members});

  final List<TeamMemberData> members;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: EdgeInsets.symmetric(horizontal: CompanyProfileFigmaTokens.screenPadding),
          child: Align(
            alignment: Alignment.centerLeft,
            child: Text(
              context.tr.companyProfileOurTeam,
              style: AppTextStyles.heading3(
                color: AppColors.darkText(context),
              ).copyWith(fontSize: CompanyProfileFigmaTokens.titleFontSize, fontWeight: FontWeight.w700),
            ),
          ),
        ),
        SizedBox(height: CompanyProfileFigmaTokens.rowGapMedium),
        SizedBox(
          height: CompanyProfileFigmaTokens.teamSectionListHeight,
          child: ListView.separated(
            scrollDirection: Axis.horizontal,
            padding: EdgeInsets.symmetric(horizontal: CompanyProfileFigmaTokens.screenPadding),
            itemCount: members.length,
            separatorBuilder: (_, __) => SizedBox(width: CompanyProfileFigmaTokens.rowGapLarge),
            itemBuilder: (context, index) {
              final member = members[index];
              return TeamMemberItem(member: member);
            },
          ),
        ),
      ],
    );
  }
}

class TeamMemberData {
  const TeamMemberData({
    required this.name,
    required this.role,
    required this.avatarUrl,
  });

  final String name;
  final String role;
  final String avatarUrl;
}

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../../../../core/extensions/localization.dart';
import '../../../../core/config/dimensions/company_profile_figma_tokens.dart';
import '../models/team_member_model.dart';
import 'profile_section_title.dart';
import 'profile_avatar.dart';

class TeamMemberItem extends StatelessWidget {
  const TeamMemberItem({super.key, required this.member});

  final TeamMemberModel member;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 100.w,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          ProfileAvatar(
            imageUrl: member.avatarUrl,
            size: CompanyProfileFigmaTokens.teamAvatarSize,
            borderRadius: CompanyProfileFigmaTokens.teamAvatarSize,
          ),
          SizedBox(height: CompanyProfileFigmaTokens.rowGapSmall),
          SizedBox(
            width: 80.w,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  member.name,
                  style: AppTextStyles.caption(
                    color: AppColors.darkText(context),
                  ).copyWith(fontWeight: FontWeight.w600),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: CompanyProfileFigmaTokens.rowGapSmall),
                Text(
                  member.role,
                  style: AppTextStyles.caption(
                    color: AppColors.secondaryGrey(context),
                  ).copyWith(fontWeight: FontWeight.w400),
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

  final List<TeamMemberModel> members;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: CompanyProfileFigmaTokens.screenPadding,
      ),
      child: Column(
        children: [
          ProfileSectionTitle(title: context.tr.companyProfileOurTeam),
          SizedBox(height: CompanyProfileFigmaTokens.rowGapMedium),
          SizedBox(
            height: CompanyProfileFigmaTokens.teamSectionListHeight,
            child: ListView.separated(
              scrollDirection: Axis.horizontal,
              padding: EdgeInsets.zero,
              itemCount: members.length,
              separatorBuilder: (_, __) =>
                  SizedBox(width: CompanyProfileFigmaTokens.rowGapLarge),
              itemBuilder: (context, index) {
                final member = members[index];
                return TeamMemberItem(member: member);
              },
            ),
          ),
        ],
      ),
    );
  }
}

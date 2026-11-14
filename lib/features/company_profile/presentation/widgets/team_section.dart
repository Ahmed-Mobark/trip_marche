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

  Future<void> _showMemberDetails(BuildContext context) {
    final role = member.role.trim();
    final description = member.shortDescription?.trim() ?? '';

    return showDialog<void>(
      context: context,
      builder: (dialogContext) => AlertDialog(
        insetPadding: const EdgeInsets.symmetric(horizontal: 24),
        contentPadding: const EdgeInsets.fromLTRB(24, 20, 24, 24),
        content: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 360),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Align(
                alignment: AlignmentDirectional.centerEnd,
                child: IconButton(
                  tooltip: MaterialLocalizations.of(
                    dialogContext,
                  ).closeButtonTooltip,
                  onPressed: () => Navigator.of(dialogContext).pop(),
                  icon: const Icon(Icons.close),
                ),
              ),
              ProfileAvatar(
                imageUrl: member.avatarUrl,
                size: CompanyProfileFigmaTokens.teamAvatarSize * 2,
                borderRadius: CompanyProfileFigmaTokens.teamAvatarSize * 2,
              ),
              const SizedBox(height: 16),
              Text(
                member.name,
                textAlign: TextAlign.center,
                style: AppTextStyles.subtitle(
                  color: AppColors.darkText(dialogContext),
                ),
              ),
              if (role.isNotEmpty) ...[
                const SizedBox(height: 6),
                Text(
                  role,
                  textAlign: TextAlign.center,
                  style: AppTextStyles.caption(
                    color: AppColors.secondaryGrey(dialogContext),
                  ),
                ),
              ],
              if (member.isManager) ...[
                const SizedBox(height: 10),
                DecoratedBox(
                  decoration: BoxDecoration(
                    color: AppColors.primary.withValues(alpha: 0.1),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 12,
                      vertical: 6,
                    ),
                    child: Text(
                      context.tr.companyProfileManager,
                      style: AppTextStyles.caption(color: AppColors.primary),
                    ),
                  ),
                ),
              ],
              if (description.isNotEmpty) ...[
                const SizedBox(height: 16),
                Text(
                  description,
                  textAlign: TextAlign.center,
                  style: AppTextStyles.body(
                    color: AppColors.darkText(dialogContext),
                  ),
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => _showMemberDetails(context),
      child: SizedBox(
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
                    member.isManager
                        ? context.tr.companyProfileManager
                        : member.role,
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
        crossAxisAlignment: CrossAxisAlignment.start,
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

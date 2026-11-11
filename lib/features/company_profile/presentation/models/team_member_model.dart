class TeamMemberModel {
  const TeamMemberModel({
    required this.name,
    required this.role,
    required this.avatarUrl,
    this.isManager = false,
    this.shortDescription,
  });

  final String name;
  final String role;
  final String avatarUrl;
  final bool isManager;
  final String? shortDescription;
}

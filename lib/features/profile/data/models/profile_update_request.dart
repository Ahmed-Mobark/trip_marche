class ProfileUpdateRequest {
  final String? name;
  final String? phone;

  const ProfileUpdateRequest({this.name, this.phone});

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (name != null && name!.trim().isNotEmpty) {
      map['name'] = name!.trim();
    }
    if (phone != null && phone!.trim().isNotEmpty) {
      map['phone'] = phone!.trim();
    }
    return map;
  }
}

import '../../domain/entities/help_page.dart';

class HelpPageModel extends HelpPage {
  const HelpPageModel({required super.slug, required super.title, super.body});

  factory HelpPageModel.fromJson(Map<String, dynamic> json) => HelpPageModel(
    slug: json['slug']?.toString() ?? '',
    title: json['title']?.toString() ?? '',
    body: json['body']?.toString() ?? '',
  );
}

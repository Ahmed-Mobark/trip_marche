class ReviewModel {
  const ReviewModel({
    required this.name,
    required this.avatarUrl,
    required this.country,
    required this.countryFlagUrl,
    required this.rating,
    required this.comment,
    required this.galleryImages,
  });

  final String name;
  final String avatarUrl;
  final String country;
  final String countryFlagUrl;
  final double rating;
  final String comment;
  final List<String> galleryImages;
}

class Activity {
  const Activity({
    required this.id,
    required this.name,
    required this.price,
    this.image,
  });

  final String id;
  final String name;
  final double price;
  final String? image;
}

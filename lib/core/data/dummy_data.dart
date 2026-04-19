class TripItem {
  final String id;
  final String title;
  final String imageUrl;
  final double rating;
  final int reviewCount;
  final String location;
  final String dateRange;
  final double price;
  final double? oldPrice;
  final bool isFavorite;
  final String? badge;
  final String? status;

  const TripItem({
    required this.id,
    required this.title,
    required this.imageUrl,
    required this.rating,
    required this.reviewCount,
    required this.location,
    required this.dateRange,
    required this.price,
    this.oldPrice,
    this.isFavorite = false,
    this.badge,
    this.status,
  });
}

class DestinationItem {
  final String name;
  final String imageUrl;
  final int rank;

  const DestinationItem({
    required this.name,
    required this.imageUrl,
    required this.rank,
  });
}

class DummyData {
  DummyData._();

  static const List<DestinationItem> trendingDestinations = [
    DestinationItem(name: 'Sharm El Sheikh', imageUrl: 'https://picsum.photos/200/200?random=10', rank: 1),
    DestinationItem(name: 'Hurghada', imageUrl: 'https://picsum.photos/200/200?random=11', rank: 2),
    DestinationItem(name: 'Luxor', imageUrl: 'https://picsum.photos/200/200?random=12', rank: 3),
    DestinationItem(name: 'Aswan', imageUrl: 'https://picsum.photos/200/200?random=13', rank: 4),
    DestinationItem(name: 'Dahab', imageUrl: 'https://picsum.photos/200/200?random=14', rank: 5),
    DestinationItem(name: 'Marsa Alam', imageUrl: 'https://picsum.photos/200/200?random=15', rank: 6),
  ];

  static const List<TripItem> popularTrips = [
    TripItem(id: '1', title: 'Sharm El Sheikh Adventure', imageUrl: 'https://picsum.photos/400/300?random=1', rating: 4.8, reviewCount: 245, location: 'From Cairo', dateRange: 'Jun 15 - Jun 20', price: 699),
    TripItem(id: '2', title: 'Hurghada Beach Resort', imageUrl: 'https://picsum.photos/400/300?random=2', rating: 4.6, reviewCount: 189, location: 'From Cairo', dateRange: 'Jul 1 - Jul 5', price: 549),
    TripItem(id: '3', title: 'Luxor Temple Tour', imageUrl: 'https://picsum.photos/400/300?random=3', rating: 4.9, reviewCount: 320, location: 'From Cairo', dateRange: 'Jun 22 - Jun 25', price: 399),
    TripItem(id: '4', title: 'Dahab Diving Trip', imageUrl: 'https://picsum.photos/400/300?random=4', rating: 4.7, reviewCount: 156, location: 'From Cairo', dateRange: 'Aug 10 - Aug 14', price: 459),
  ];

  static const List<TripItem> sponsoredTrips = [
    TripItem(id: '5', title: 'Royal Nile Cruise', imageUrl: 'https://picsum.photos/400/300?random=5', rating: 4.9, reviewCount: 412, location: 'From Luxor', dateRange: 'Jul 10 - Jul 15', price: 899, badge: 'Sponsored'),
    TripItem(id: '6', title: 'Siwa Oasis Escape', imageUrl: 'https://picsum.photos/400/300?random=6', rating: 4.5, reviewCount: 98, location: 'From Cairo', dateRange: 'Aug 1 - Aug 4', price: 349, badge: 'Sponsored'),
    TripItem(id: '7', title: 'Alexandria City Tour', imageUrl: 'https://picsum.photos/400/300?random=7', rating: 4.4, reviewCount: 201, location: 'From Cairo', dateRange: 'Jun 28 - Jun 30', price: 249, badge: 'Sponsored'),
  ];

  static const List<TripItem> domesticTrips = [
    TripItem(id: '8', title: 'Ain Sokhna Weekend', imageUrl: 'https://picsum.photos/400/300?random=8', rating: 4.3, reviewCount: 167, location: 'From Cairo', dateRange: 'Jun 18 - Jun 19', price: 199),
    TripItem(id: '9', title: 'Fayoum Safari', imageUrl: 'https://picsum.photos/400/300?random=9', rating: 4.6, reviewCount: 134, location: 'From Cairo', dateRange: 'Jul 5 - Jul 7', price: 279),
    TripItem(id: '10', title: 'North Coast Getaway', imageUrl: 'https://picsum.photos/400/300?random=16', rating: 4.7, reviewCount: 289, location: 'From Cairo', dateRange: 'Jul 15 - Jul 19', price: 599),
  ];

  static const List<TripItem> internationalTrips = [
    TripItem(id: '11', title: 'Istanbul Explorer', imageUrl: 'https://picsum.photos/400/300?random=17', rating: 4.8, reviewCount: 356, location: 'From Cairo', dateRange: 'Aug 5 - Aug 10', price: 1299),
    TripItem(id: '12', title: 'Dubai City Break', imageUrl: 'https://picsum.photos/400/300?random=18', rating: 4.7, reviewCount: 278, location: 'From Cairo', dateRange: 'Sep 1 - Sep 5', price: 1499),
    TripItem(id: '13', title: 'Maldives Paradise', imageUrl: 'https://picsum.photos/400/300?random=19', rating: 4.9, reviewCount: 445, location: 'From Cairo', dateRange: 'Oct 10 - Oct 17', price: 2199),
  ];

  static const List<TripItem> recommendedTrips = [
    TripItem(id: '14', title: 'Petra & Wadi Rum', imageUrl: 'https://picsum.photos/400/300?random=20', rating: 4.8, reviewCount: 198, location: 'From Cairo', dateRange: 'Sep 15 - Sep 20', price: 999),
    TripItem(id: '15', title: 'Santorini Dream', imageUrl: 'https://picsum.photos/400/300?random=21', rating: 4.9, reviewCount: 367, location: 'From Cairo', dateRange: 'Aug 20 - Aug 25', price: 1799),
    TripItem(id: '16', title: 'Cappadocia Balloon', imageUrl: 'https://picsum.photos/400/300?random=22', rating: 4.7, reviewCount: 234, location: 'From Cairo', dateRange: 'Sep 8 - Sep 12', price: 1099),
  ];

  static const List<TripItem> specialTrips = [
    TripItem(id: '17', title: 'Luxury Nile Cruise - 7 Nights', imageUrl: 'https://picsum.photos/400/300?random=23', rating: 4.9, reviewCount: 512, location: 'From Luxor', dateRange: 'Jul 1 - Jul 8', price: 1299, oldPrice: 1529, badge: 'Top Rated'),
    TripItem(id: '18', title: 'Wellness Retreat Gouna', imageUrl: 'https://picsum.photos/400/300?random=24', rating: 4.8, reviewCount: 178, location: 'From Cairo', dateRange: 'Aug 15 - Aug 20', price: 899, oldPrice: 1059, badge: 'Best Seller'),
    TripItem(id: '19', title: 'Desert Safari Adventure', imageUrl: 'https://picsum.photos/400/300?random=25', rating: 4.6, reviewCount: 245, location: 'From Cairo', dateRange: 'Sep 5 - Sep 8', price: 499, oldPrice: 599, badge: 'Popular'),
    TripItem(id: '20', title: 'Red Sea Diving Package', imageUrl: 'https://picsum.photos/400/300?random=26', rating: 4.7, reviewCount: 301, location: 'From Cairo', dateRange: 'Oct 1 - Oct 5', price: 749, oldPrice: 899, badge: 'Limited'),
  ];

  static const List<TripItem> wishlistTrips = [
    TripItem(id: '1', title: 'Sharm El Sheikh Adventure', imageUrl: 'https://picsum.photos/400/300?random=1', rating: 4.8, reviewCount: 245, location: 'From Cairo', dateRange: 'Jun 15 - Jun 20', price: 699, isFavorite: true),
    TripItem(id: '5', title: 'Royal Nile Cruise', imageUrl: 'https://picsum.photos/400/300?random=5', rating: 4.9, reviewCount: 412, location: 'From Luxor', dateRange: 'Jul 10 - Jul 15', price: 899, isFavorite: true),
    TripItem(id: '13', title: 'Maldives Paradise', imageUrl: 'https://picsum.photos/400/300?random=19', rating: 4.9, reviewCount: 445, location: 'From Cairo', dateRange: 'Oct 10 - Oct 17', price: 2199, isFavorite: true),
    TripItem(id: '15', title: 'Santorini Dream', imageUrl: 'https://picsum.photos/400/300?random=21', rating: 4.9, reviewCount: 367, location: 'From Cairo', dateRange: 'Aug 20 - Aug 25', price: 1799, isFavorite: true),
  ];

  static const List<TripItem> upcomingTrips = [
    TripItem(id: '1', title: 'Sharm El Sheikh Adventure', imageUrl: 'https://picsum.photos/400/300?random=1', rating: 4.8, reviewCount: 245, location: 'From Cairo', dateRange: 'Jun 15 - Jun 20', price: 699, status: 'Confirmed'),
    TripItem(id: '11', title: 'Istanbul Explorer', imageUrl: 'https://picsum.photos/400/300?random=17', rating: 4.8, reviewCount: 356, location: 'From Cairo', dateRange: 'Aug 5 - Aug 10', price: 1299, status: 'Confirmed'),
  ];

  static const List<TripItem> pastTrips = [
    TripItem(id: '3', title: 'Luxor Temple Tour', imageUrl: 'https://picsum.photos/400/300?random=3', rating: 4.9, reviewCount: 320, location: 'From Cairo', dateRange: 'Mar 22 - Mar 25', price: 399, status: 'Completed'),
    TripItem(id: '8', title: 'Ain Sokhna Weekend', imageUrl: 'https://picsum.photos/400/300?random=8', rating: 4.3, reviewCount: 167, location: 'From Cairo', dateRange: 'Feb 18 - Feb 19', price: 199, status: 'Completed'),
    TripItem(id: '6', title: 'Siwa Oasis Escape', imageUrl: 'https://picsum.photos/400/300?random=6', rating: 4.5, reviewCount: 98, location: 'From Cairo', dateRange: 'Jan 1 - Jan 4', price: 349, status: 'Cancelled'),
  ];

  static const List<String> recentSearches = [
    'Sharm El Sheikh',
    'Hurghada',
    'Nile Cruise',
    'Dubai',
    'Istanbul',
  ];

  static const List<String> specialCategories = [
    'Popular',
    'Day Trip',
    'Wellness',
    'Cruise',
    'Food',
    'Nature',
    'Sport',
  ];
}

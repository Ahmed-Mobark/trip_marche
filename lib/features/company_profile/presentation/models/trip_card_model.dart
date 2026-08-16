import 'package:flutter/material.dart';

class TripCardModel {
  const TripCardModel({
    this.id = 0,
    required this.title,
    required this.imageUrl,
    required this.rating,
    required this.reviewsCount,
    required this.fromCity,
    required this.dateFrom,
    required this.dateTo,
    required this.oldPrice,
    required this.newPrice,
    required this.currency,
    required this.badge,
    this.isFavorite = false,
    this.onTap,
    this.onFavoriteTap,
  });

  final int id;
  final String title;
  final String imageUrl;
  final double rating;
  final int reviewsCount;
  final String fromCity;
  final String dateFrom;
  final String dateTo;
  final double oldPrice;
  final double newPrice;
  final String currency;
  final String? badge;
  final bool isFavorite;
  final VoidCallback? onTap;
  final VoidCallback? onFavoriteTap;
}

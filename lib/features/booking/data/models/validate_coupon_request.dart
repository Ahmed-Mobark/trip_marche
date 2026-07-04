class ValidateCouponRequest {
  const ValidateCouponRequest({
    required this.code,
    required this.tripId,
    required this.amount,
  });

  final String code;
  final int tripId;
  final double amount;

  Map<String, dynamic> toJson() => {
        'code': code,
        'trip_id': tripId,
        'amount': amount,
      };
}

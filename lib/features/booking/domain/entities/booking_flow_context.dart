class BookingFlowContext {
  const BookingFlowContext({
    required this.dateRange,
    required this.travelersCount,
    required this.roomName,
    required this.roomPrice,
  });

  final String dateRange;
  final int travelersCount;
  final String roomName;
  final double roomPrice;
}

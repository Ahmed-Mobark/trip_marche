import 'package:flutter/material.dart';
import 'package:trip_marche/core/extensions/localization.dart';
import '../../domain/entities/booking_entity.dart';

class BookingCancellationDialog extends StatelessWidget {
  const BookingCancellationDialog({super.key, required this.booking});

  final Booking booking;

  @override
  Widget build(BuildContext context) {
    final tr = context.tr;
    return AlertDialog(
      title: Text(tr.myTripsCancelBooking),
      content: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              booking.trip.title,
              style: Theme.of(context).textTheme.titleMedium,
            ),
            if (booking.dates.range.isNotEmpty) ...[
              const SizedBox(height: 8),
              Text(booking.dates.range),
            ],
            const SizedBox(height: 16),
            Text(tr.myTripsCancelExplanation),
            if (booking.cancellationPolicy?.trim().isNotEmpty == true) ...[
              const SizedBox(height: 16),
              Text(
                tr.myTripsCancellationTerms,
                style: Theme.of(context).textTheme.titleSmall,
              ),
              const SizedBox(height: 8),
              Text(booking.cancellationPolicy!),
            ],
          ],
        ),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context, false),
          child: Text(tr.myTripsKeepBooking),
        ),
        FilledButton(
          style: FilledButton.styleFrom(
            backgroundColor: Theme.of(context).colorScheme.error,
          ),
          onPressed: () => Navigator.pop(context, true),
          child: Text(tr.myTripsConfirmCancellation),
        ),
      ],
    );
  }
}

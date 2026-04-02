import 'package:flutter/material.dart';
import '../../domain/entities/booking_entity.dart';

class BookingCard extends StatelessWidget {
  final BookingEntity booking;

  const BookingCard({super.key, required this.booking});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        title: Text(booking.name),
        subtitle: Text(
          "${booking.date} - ${booking.time}\n${booking.occasion}",
        ),
        trailing: Text("${booking.price} EGP"),
      ),
    );
  }
}
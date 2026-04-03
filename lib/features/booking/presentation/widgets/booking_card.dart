import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../cubit/booking_cubit.dart';
import '../../domain/entities/booking_entity.dart';

class BookingCard extends StatelessWidget {
  final BookingEntity booking;

  const BookingCard({super.key, required this.booking});

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<BookingCubit>();

    return Card(
      child: ListTile(
        title: Text("Name: ${booking.name}"),
        subtitle: Text(
          "Date & Time: ${booking.date} - ${booking.time}\n Occasion: ${booking.occasion}\n Guests: ${booking.guests} \n Table Type: ${booking.tableType}",
        ),
        trailing: IconButton(
          icon: const Icon(Icons.delete, color: Colors.red),
          onPressed: () {
            cubit.deleteBooking((booking as dynamic).id);
          },
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lottie/lottie.dart';
import '../cubit/booking_cubit.dart';
import 'second_screen.dart';
import 'package:dash_cup/features/booking/presentation/widgets/booking_card.dart';

class FirstScreen extends StatelessWidget {
  const FirstScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<BookingCubit>();

    return Scaffold(
      appBar: AppBar(title: Text("Bookings")),
      body: StreamBuilder(
        stream: cubit.repo.getBookings(),
        builder: (context, snapshot) {
          final data = snapshot.data ?? [];

          if (data.isEmpty) {
            return Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Lottie.asset("assets/animation/nothing.json"),
                SizedBox(height: 20),
                Text(
                  "No Bookings Yet",
                  style: TextStyle(fontSize: 18, color: Colors.black),
                ),
              ],
            );
          }

          return ListView(
            children: data.map((b) => BookingCard(booking: b)).toList(),
          );
        },
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
      floatingActionButton: Padding(
        padding:  EdgeInsets.symmetric( vertical: 90.h),
        child: FloatingActionButton(

          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (_) => SecondScreen()),
            );
          },
          child: Icon(Icons.add),
        ),
      ),
    );
  }
}

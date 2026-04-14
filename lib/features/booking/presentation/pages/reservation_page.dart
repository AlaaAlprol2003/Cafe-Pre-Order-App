import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'booking_page.dart';

class ReservationsPage extends StatefulWidget {
  const ReservationsPage({super.key});

  @override
  State<ReservationsPage> createState() => _ReservationsPageState();
}

class _ReservationsPageState extends State<ReservationsPage> {
  List reservations = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Reservations")),

      body: reservations.isEmpty
          ? Padding(
              padding: const EdgeInsets.all(130),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // Container(
                  //   height: 250,
                  //   child: Lottie.asset("assets/animation/nothing.json"),
                  // ),

                  const Text(
                    "No Reservations Yet",
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            )
          : ListView.builder(
              itemCount: reservations.length,
              itemBuilder: (context, index) {
                final r = reservations[index];

                return ListTile(
                  title: Text(r.name),
                  subtitle: Text("${r.guests} guests - ${r.occasion}"),
                );
              },
            ),
      ////floatingActionButtonLocation: FloatingActionButtonLocation.
      floatingActionButton: Padding(
        padding: REdgeInsets.only(bottom: 100.0),
        child: FloatingActionButton(
          onPressed: () async {
            final result = await Navigator.push(
              context,
              MaterialPageRoute(builder: (_) => const BookingPage()),
            );

            if (result != null) {
              setState(() {
                reservations.add(result);
              });
            }
          },
          child: const Icon(Icons.add),
        ),
      ),
    );
  }
}

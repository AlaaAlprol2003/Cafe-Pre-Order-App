import 'package:dash_cup/features/booking/presentation/pages/reservation_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_custom_clippers/flutter_custom_clippers.dart';
import '../../data/repository/booking_repository.dart';
import '../../domain/entities/booking.dart';

class ConfirmationPage extends StatelessWidget {
  final Reservation reservation;

  const ConfirmationPage({super.key, required this.reservation});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Confirmation")),

      body: Padding(
        padding: const EdgeInsets.all(5),

        child: Container(
          child: Column(
            mainAxisAlignment:  MainAxisAlignment.start,
            children: [
              ClipPath(
                clipper: OvalBottomBorderClipper(),
                child: Container(
                  height: 200,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage(
                        "assets/images/blur cafe background.png",
                      ),
                      fit: BoxFit.cover,
                    ),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: const [
                      Text(
                        "Book Your Table",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 28,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: 10),
                      Text(
                        "Dash Cup Cafe",
                        style: TextStyle(
                          color: Colors.white70,
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(height: 50),

              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      mainAxisAlignment:  MainAxisAlignment.start,
                      children: [
                        Text(
                          "Name: ${reservation.name}",
                          style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 10,),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      mainAxisAlignment:  MainAxisAlignment.start,
                      children: [
                        Text(
                          "Guests: ${reservation.guests}",
                          style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 10,),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      mainAxisAlignment:  MainAxisAlignment.start,
                      children: [
                        Text(
                          "Occasion: ${reservation.occasion}",
                          style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 10,),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      mainAxisAlignment:  MainAxisAlignment.start,
                      children: [
                        Text(
                          "Date: ${reservation.dateTime.toLocal().toString().split(' ')[0]}",
                          style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 10,),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      mainAxisAlignment:  MainAxisAlignment.start,
                      children: [
                        Text(
                          "Time: ${reservation.dateTime.toLocal().toString().split(' ')[1]}",
                          style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 10,),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      children: [
                        Text(
                          "Table: ${reservation.tableType}",
                          style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 10,),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      mainAxisAlignment:  MainAxisAlignment.start,
                      children: [
                        Text(
                          "Price: ${reservation.price} EGP",
                          style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                  ),

                ],
              ),
                  const SizedBox(height: 60),
              Column(
                mainAxisAlignment:  MainAxisAlignment.center,
                children: [
                  ElevatedButton(
                      style: ElevatedButton.styleFrom(

                        padding: EdgeInsets.symmetric(
                          horizontal: 30,
                          vertical: 15,
                        ),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      onPressed: () async {
                        await ReservationRepository().saveReservation(
                          reservation,
                        );

                        Navigator.push(context, MaterialPageRoute(builder: (_) => const ReservationsPage()));
                      },

                      child: const Text("Book" , style: TextStyle(fontSize: 24 , fontWeight: FontWeight.bold, color: Colors.white))
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

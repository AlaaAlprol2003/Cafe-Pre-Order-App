// ignore_for_file: use_build_context_synchronously

import 'package:animated_toggle_switch/animated_toggle_switch.dart';
import 'package:flutter/material.dart';
import 'package:flutter_custom_clippers/flutter_custom_clippers.dart';
import '../../domain/entities/booking.dart';
import '../../utils/price_calculator.dart';
import 'confirmation_page.dart';

class BookingPage extends StatefulWidget {
  const BookingPage({super.key});

  @override
  State<BookingPage> createState() => _BookingPageState();
}

class _BookingPageState extends State<BookingPage> {
  final TextEditingController nameController = TextEditingController();

  int guests = 1;

  String tableType = "Indoor";

  String occasion = "Birthday";

  DateTime? dateTime;

  double price = 0;

  void calculatePrice() {
    price = PriceCalculator.calculate(guests, occasion);
  }

  @override
  Widget build(BuildContext context) {
    calculatePrice();

    return Scaffold(
      appBar: AppBar(title: const Text("Booking")),

      body: Padding(
        padding: const EdgeInsets.all(10),

        child: Column(
          children: [
            ClipPath(
              clipper: OvalBottomBorderClipper(),
              child: Container(
                height: 200,
                width: double.infinity,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage("assets/images/abstract-blur-coffee-shop-cafe-interior.jpg"),
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
            SizedBox(height: 20),

            Container(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CircleAvatar(
                    backgroundColor: Colors.white,
                    child: IconButton(
                      onPressed: () {
                        setState(() {
                          if (guests > 1) guests--;
                        });
                      },
                      icon: const Icon(Icons.remove),
                    ),
                  ),
                  SizedBox(width: 8),

                  Text(
                    "$guests Guests",
                    style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(width: 8),

                  CircleAvatar(
                    backgroundColor: Colors.white,
                    child: IconButton(
                      onPressed: () {
                        setState(() {
                          guests++;
                        });
                      },
                      icon: const Icon(Icons.add),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 20),

            TextField(
              controller: nameController,
              decoration: const InputDecoration(
                labelText: "Name",
                fillColor: Colors.white,
              ),
            ),
            SizedBox(height: 20),

            Container(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black26,
                    blurRadius: 4,
                    offset: Offset(0, 2),
                  ),
                ],
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,

                children: [
                  Text(
                    "Table Type : ",
                    style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(width: 10),
                  AnimatedToggleSwitch<String>.rolling(
                    spacing: 20,
                    height: 50,
                    animationCurve: Curves.fastEaseInToSlowEaseOut,
                    textDirection: TextDirection.rtl,
                    indicatorSize: Size(80, 40),
                    padding: EdgeInsets.symmetric(horizontal: 8, vertical: 6),
                    current: tableType,
                    values: const ["Indoor", "Outdoor"],
                    onChanged: (value) {
                      setState(() {
                        tableType = value;
                      });
                    },
                    iconBuilder: (value, isSelected) => Text(
                      value,
                      style: TextStyle(
                        color: isSelected ? Colors.white : Colors.black,
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 20),

            Container(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black26,
                    blurRadius: 4,
                    offset: Offset(0, 2),
                  ),
                ],
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Occasion : ",
                    style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                  ),
                  DropdownButton<String>(
                    value: occasion,
                    items: const [
                      DropdownMenuItem(
                        value: "Birthday",
                        child: Text("Birthday"),
                      ),
                      DropdownMenuItem(
                        value: "Engagement",
                        child: Text("Engagement"),
                      ),
                      DropdownMenuItem(
                        value: "Wedding",
                        child: Text("Wedding"),
                      ),
                      DropdownMenuItem(value: "Match", child: Text("Match")),
                    ],
                    onChanged: (value) {
                      setState(() {
                        occasion = value!;
                      });
                    },
                  ),
                ],
              ),
            ),
            SizedBox(height: 20),

            Container(
              margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),

              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
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
                      final date = await showDatePicker(
                        context: context,
                        firstDate: DateTime.now(),
                        lastDate: DateTime(2030),
                        initialDate: DateTime.now(),
                      );

                      if (date == null) return;

                      final time = await showTimePicker(
                        context: context,
                        initialTime: TimeOfDay.now(),
                      );

                      if (time == null) return;

                      dateTime = DateTime(
                        date.day,
                        date.month,
                        date.year,
                        time.hour,
                        time.minute,
                      );
                    },

                    child: const Text(
                      "Pick Date & Time",
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 20),

            Container(
              width: 300,
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              decoration: BoxDecoration(
                color: Colors.deepOrangeAccent,
                borderRadius: BorderRadius.circular(12),
                boxShadow: [BoxShadow(color: Colors.black26, blurRadius: 4)],
              ),

              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text(
                    "Price:       $price EGP",
                    style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 20),

            Container(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
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
                    onPressed: () {
                      final reservation = Reservation(
                        name: nameController.text,
                        guests: guests,
                        tableType: tableType,
                        dateTime: dateTime!,
                        occasion: occasion,
                        price: price,
                      );

                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => ConfirmationPage(reservation: reservation),
                        ),
                      );
                    },

                    child: const Text("Confirm",
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),


                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

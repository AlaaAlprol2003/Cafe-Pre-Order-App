import 'package:dash_cup/core/resources/colors_manager.dart';
import 'package:dash_cup/features/auth/data/models/user.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class MainLayout extends StatelessWidget {
  const MainLayout({super.key});

  @override
  Widget build(BuildContext context) {
    final user = UserModel.currentUser;
    if(user == null){
      return Scaffold(body: Center(child: CircularProgressIndicator(color: ColorsManager.burntOrange,),),);
    }
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "Welcome,${user.name}\n Your Email: ${user.email}",
              style: GoogleFonts.roboto(
                fontSize: 20,
                fontWeight: FontWeight.w600,
                color: Colors.white,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

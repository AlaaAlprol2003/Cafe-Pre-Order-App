import 'package:dash_cup/core/resources/colors_manager.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

class PrivacyScreen extends StatelessWidget {
  const PrivacyScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Privacy & Terms"),
        titleTextStyle: Theme.of(context).textTheme.headlineMedium!.copyWith(
          color: ColorsManager.creamyWhite,
          fontWeight: FontWeight.w400,
        ),
        centerTitle: true,
        backgroundColor: ColorsManager.darkChocolate,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(
            Icons.arrow_back,
            color: ColorsManager.darkOrange,
            size: 25,
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: REdgeInsets.all(16),
          child: Text(
            '''
Privacy Policy

We respect your privacy and are committed to protecting your personal information. This Privacy Policy explains how we collect, use, and protect your data when you use our application.

Information We Collect:

Email address and basic account information when you register.

Usage data to improve app performance and user experience.

How We Use Your Information

To create and manage your account.

To provide authentication and security.

To improve features and fix issues.

Data Security
We take reasonable measures to protect your data. However, no method of transmission over the internet is 100% secure.

Third-Party Services
We may use trusted third-party services (such as authentication and analytics) to operate the app.

Your Rights
You can request to update or delete your personal data at any time by contacting us.

Contact Us
If you have any questions about this Privacy Policy, please contact us at:
support@DashCupTeam.com


Terms of Service

By using this application, you agree to the following terms and conditions.

User Responsibilities

You are responsible for maintaining the confidentiality of your account.

You agree not to misuse the app or attempt to harm its services.

Acceptable Use

Do not use the app for illegal purposes.

Do not attempt to access other users’ accounts.

Account Termination
We reserve the right to suspend or terminate accounts that violate these terms.

Limitation of Liability
The app is provided “as is” without warranties of any kind. We are not responsible for any damages arising from the use of the app.

Changes to These Terms
We may update these terms from time to time. Continued use of the app means you accept the updated terms.

Contact Us
For any questions about these Terms, contact us at:
support@DashCupTeam.com
''',
            style: GoogleFonts.roboto(
              fontSize: 16.sp,
              fontWeight: FontWeight.w500,
              color: ColorsManager.russet,
            ),
          ),
        ),
      ),
    );
  }
}

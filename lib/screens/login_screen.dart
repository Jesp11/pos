import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../components/forms/user_auth/login_form.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center( 
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center, 
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center, 
              children: [
                const Icon(
                  Icons.webhook_outlined,
                  size: 40,
                  color: Colors.deepPurple,
                ),
                const SizedBox(width: 12),
                Text(
                  'PoS Tópicos',
                  style: GoogleFonts.montserrat(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),
            Text(
              'Sign In To Your Account',
              style: GoogleFonts.montserrat(
                fontSize: 28,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 10),
            Text(
              "Welcome back! Sign in to your employee account",
              style: GoogleFonts.montserrat(
                fontSize: 16,
                color: Colors.grey[700],
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 60),
            const LoginForm()
          ],
        ),
      ),
    );
  }
}

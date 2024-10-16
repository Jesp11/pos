import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pos/components/forms/user_auth/register_form.dart';

class RegisterScreen extends StatelessWidget{
  const RegisterScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Center( 
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start, 
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              'Create User',
              style: GoogleFonts.montserrat(
                fontSize: 35,
                fontWeight: FontWeight.w600
              ),
            ),
            const SizedBox(height: 40),
            const RegisterForm()
          ],
        ),
      ),
    );
  }
  
}
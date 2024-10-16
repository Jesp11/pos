import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pos/components/cards/product_card.dart';


class InventoryScreen extends StatelessWidget{
  const InventoryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.deepPurple,
        centerTitle: true,
        title: Text(
          'Inventory',
          style: GoogleFonts.montserrat(
            fontSize: 30,
            color: Colors.white,
          ),
        )
      ),
      
    );
  }

}
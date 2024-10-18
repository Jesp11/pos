import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pos/models/ticket.dart';

class TicketCard extends StatelessWidget {
  final Ticket ticket;
  final Function onTap;

  const TicketCard({
    Key? key,
    required this.ticket,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4,
      margin: const EdgeInsets.symmetric(vertical: 8.0),
      child: ListTile(
        title: Text(
          'Ticket ID: ${ticket.ticketId}',
          style: GoogleFonts.montserrat(fontWeight: FontWeight.bold),
        ),
        subtitle: Text(
          'Date: ${ticket.date}\nTotal: \$${ticket.totalAmount}',
          style: GoogleFonts.montserrat(),
        ),
        onTap: () => onTap(), 
      ),
    );
  }
}

// screens/ticket_detail_screen.dart
import 'package:flutter/material.dart';
import 'package:pos/models/ticket.dart';

class TicketDetailScreen extends StatelessWidget {
  final Ticket ticket;

  TicketDetailScreen({required this.ticket});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Detalles del Ticket ${ticket.ticketId}'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('ID del Ticket: ${ticket.ticketId}', style: TextStyle(fontSize: 20)),
            SizedBox(height: 10),
            Text('Fecha: ${ticket.date}', style: TextStyle(fontSize: 18)),
            SizedBox(height: 10),
            Text('Total: \$${ticket.totalAmount}', style: TextStyle(fontSize: 18)),
          ],
        ),
      ),
    );
  }
}

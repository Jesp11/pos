import 'package:flutter/material.dart';
import 'package:pos/models/ticket.dart';
import 'package:google_fonts/google_fonts.dart';

class TicketDetailScreen extends StatelessWidget {
  final Ticket ticket;

  TicketDetailScreen({required this.ticket});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Ticket: ${ticket.ticketId}'),
        backgroundColor: Colors.deepPurple,
        foregroundColor: Colors.white,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Card(
          elevation: 4,
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Detalles del Ticket',
                  style: GoogleFonts.montserrat(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Colors.deepPurple,
                  ),
                ),
                SizedBox(height: 20),
                _buildDetailRow('ID del Ticket:', '${ticket.ticketId}'),
                Divider(),
                _buildDetailRow('Fecha:', '${ticket.date}'),
                Divider(),
                _buildDetailRow('Total:', '\$${ticket.totalAmount}'),
                SizedBox(height: 20),
                Center( // Centra el botón
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: Text('Aceptar'),
                    style: ElevatedButton.styleFrom(
                      foregroundColor: Colors.white,
                      backgroundColor: Colors.deepPurple,
                      padding: EdgeInsets.symmetric(horizontal: 48, vertical: 16), // Aumentar padding horizontal
                      minimumSize: Size(double.infinity, 50), // Botón más largo
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildDetailRow(String label, String value) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(label, style: TextStyle(fontSize: 18)),
        Text(value, style: TextStyle(fontSize: 18)),
      ],
    );
  }
}

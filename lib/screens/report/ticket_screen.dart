import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pos/components/cards/ticket_card.dart';
import 'package:pos/models/ticket.dart';
import 'package:pos/screens/report/ticket_detail_screen.dart';
import 'package:pos/services/ticket_services.dart';

class TicketScreen extends StatefulWidget {
  @override
  _TicketScreenState createState() => _TicketScreenState();
}

class _TicketScreenState extends State<TicketScreen> {
  final TicketService ticketService = TicketService();
  List<Ticket> tickets = [];

  @override
  void initState() {
    super.initState();
    _loadTickets();
  }

  Future<void> _loadTickets() async {
    tickets = await ticketService.getTickets();
    setState(() {});
  }

  void _viewTicketDetails(Ticket ticket) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => TicketDetailScreen(ticket: ticket),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.deepPurple,
        foregroundColor: Colors.white,
        title: Text(
          'Sales Tickets',
          style: GoogleFonts.montserrat(fontSize: 24, fontWeight: FontWeight.w600),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: tickets.isEmpty
            ? Center(
                child: Text(
                  'No sales tickets available.',
                  style: GoogleFonts.montserrat(fontSize: 18),
                ),
              )
            : ListView.builder(
                itemCount: tickets.length,
                itemBuilder: (context, index) {
                  final ticket = tickets[index];
                  return TicketCard(
                    ticket: ticket,
                    onTap: () => _viewTicketDetails(ticket),
                  );
                },
              ),
      ),
    );
  }
}

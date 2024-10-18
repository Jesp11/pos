import 'package:hive/hive.dart';
import 'package:pos/models/ticket.dart';

class TicketService {
  final Box ticketBox;

  TicketService() : ticketBox = Hive.box('ticketBox');

  Future<bool> registerTicket({
    required String ticketId,
    required DateTime date,
    required double totalAmount,
  }) async {
    try {
      final ticket = Ticket(
        ticketId: ticketId,
        date: date,
        totalAmount: totalAmount,
      );

      await ticketBox.add(ticket.toMap());
      return true; 
    } catch (e) {
      return false; 
    }
  }

  List<Ticket> getTickets() {
    return ticketBox.values
        .map((e) => Ticket.fromMap(Map<String, dynamic>.from(e)))
        .toList();
  }

  Future<void> deleteTicket(Ticket ticket) async {
    final index = ticketBox.values.toList().indexWhere(
      (element) => Ticket.fromMap(Map<String, dynamic>.from(element)).ticketId == ticket.ticketId,
    );

    if (index != -1) {
      await ticketBox.deleteAt(index);
    }
  }

  Future<bool> updateTicket(Ticket oldTicket, Ticket newTicket) async {
    final newId = newTicket.ticketId.trim();

    bool ticketExists = ticketBox.values.any((element) {
      final existingTicket = Ticket.fromMap(Map<String, dynamic>.from(element));
      return existingTicket.ticketId.toLowerCase() == newId.toLowerCase() &&
          existingTicket.ticketId.toLowerCase() != oldTicket.ticketId.toLowerCase();
    });

    if (ticketExists) {
      return false;
    }

    final index = ticketBox.values.toList().indexWhere(
      (element) => Ticket.fromMap(Map<String, dynamic>.from(element)).ticketId.toLowerCase() == oldTicket.ticketId.toLowerCase(),
    );

    if (index != -1) {
      await ticketBox.putAt(index, newTicket.toMap());
      return true;
    }

    return false;
  }
}

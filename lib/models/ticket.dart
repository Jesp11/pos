// models/ticket.dart
class Ticket {
  final String ticketId;
  final DateTime date;
  final double totalAmount;

  Ticket({
    required this.ticketId,
    required this.date,
    required this.totalAmount,
  });

  Map<String, dynamic> toMap() {
    return {
      'ticketId': ticketId,
      'date': date.toIso8601String(),
      'totalAmount': totalAmount,
    };
  }

  static Ticket fromMap(Map<String, dynamic> map) {
    return Ticket(
      ticketId: map['ticketId'],
      date: DateTime.parse(map['date']),
      totalAmount: map['totalAmount'],
    );
  }
}

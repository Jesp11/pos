import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pos/models/products.dart';
import 'package:pos/models/ticket.dart';
import 'package:pos/screens/sales/ticket_sale_screen.dart';
import 'package:pos/services/ticket_services.dart';
import 'package:pos/utils/generar_id.dart';

class SaleDetailScreen extends StatelessWidget {
  final Map<Product, int> selectedProducts;
  final TicketService ticketService = TicketService();

  SaleDetailScreen({required this.selectedProducts});

  double _calculateTotalCost() {
    double total = 0.0;
    selectedProducts.forEach((product, quantity) {
      if (quantity > 0) {
        total += product.price * quantity;
      }
    });
    return total;
  }

  Future<void> _generateTicket(BuildContext context) async {
    final totalAmount = _calculateTotalCost();
    if (totalAmount > 0) {
      final ticketId = generateCustomID(); 
      final date = DateTime.now();

      final success = await ticketService.registerTicket(
        ticketId: ticketId,
        date: date,
        totalAmount: totalAmount,
      );

      if (success) {
        Ticket newTicket = Ticket(ticketId: ticketId, date: date, totalAmount: totalAmount);

        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Ticket generated and saved in the ticket box.')),
        );

        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => TicketSalesScreen(ticket: newTicket),
          ),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error generating the ticket.')),
        );
      }
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Cannot generate a ticket without products.')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final filteredProducts = selectedProducts.entries
        .where((entry) => entry.value > 0)
        .toList();

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.deepPurple,
        foregroundColor: Colors.white,
        title: Text(
          'Sale Details',
          style: GoogleFonts.montserrat(fontSize: 24, fontWeight: FontWeight.w600),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: filteredProducts.isEmpty
            ? Center(
                child: Text(
                  'No products selected.',
                  style: GoogleFonts.montserrat(fontSize: 18),
                ),
              )
            : Column(
                children: [
                  Expanded(
                    child: ListView.builder(
                      itemCount: filteredProducts.length,
                      itemBuilder: (context, index) {
                        final product = filteredProducts[index].key;
                        final quantity = filteredProducts[index].value;
                        return Card(
                          elevation: 2,
                          margin: const EdgeInsets.symmetric(vertical: 8.0),
                          child: Padding(
                            padding: const EdgeInsets.all(16.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      product.name,
                                      style: GoogleFonts.montserrat(fontSize: 18),
                                    ),
                                    Text(
                                      'Quantity: $quantity',
                                      style: GoogleFonts.montserrat(fontSize: 14),
                                    ),
                                  ],
                                ),
                                Text(
                                  '\$${(product.price * quantity).toStringAsFixed(2)}',
                                  style: GoogleFonts.montserrat(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                  SizedBox(height: 16),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: () => _generateTicket(context),
                      style: ElevatedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(vertical: 16.0),
                        backgroundColor: Colors.deepPurple,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8.0),
                        ),
                      ),
                      child: Text(
                        'Total to Pay: \$${_calculateTotalCost().toStringAsFixed(2)}',
                        style: GoogleFonts.montserrat(
                          fontSize: 20,
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pos/models/products.dart';
import 'package:pos/services/ticket_services.dart';
import 'package:pos/utils/generar_id.dart';

class SaleDetailScreen extends StatelessWidget {
  final Map<Product, int> selectedProducts;
  final TicketService ticketService = TicketService(); // Instancia del servicio de tickets

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
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Ticket generado y guardado en la caja de tickets.')),
        );
        Navigator.pop(context); // Vuelve a la pantalla anterior
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error al generar el ticket.')),
        );
      }
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('No se puede generar un ticket sin productos.')),
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
          'Detalles de Venta',
          style: GoogleFonts.montserrat(fontSize: 24, fontWeight: FontWeight.w600),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: filteredProducts.isEmpty
            ? Center(
                child: Text(
                  'No hay productos seleccionados.',
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
                                      'Cantidad: $quantity',
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
                    width: double.infinity, // Hace que el botón ocupe todo el ancho
                    child: ElevatedButton(
                      onPressed: () =>{ 
                        _generateTicket(context)
                      },
                      style: ElevatedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(vertical: 16.0),
                        backgroundColor: Colors.deepPurple, // Color del botón
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8.0),
                        ),
                      ),
                      child: Text(
                        'Total a Pagar: \$${_calculateTotalCost().toStringAsFixed(2)}',
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

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class PaymentPage extends StatefulWidget {
  final double totalPrice; // Precio total a pagar

  // Constructor con un valor por defecto para evitar null
  const PaymentPage({Key? key, this.totalPrice = 0.0}) : super(key: key);

  @override
  _PaymentPageState createState() => _PaymentPageState();
}

class _PaymentPageState extends State<PaymentPage> {
  final _formKey = GlobalKey<FormState>();

  // Controladores para los campos
  final TextEditingController _cardNumberController = TextEditingController();
  final TextEditingController _cvvController = TextEditingController();
  final TextEditingController _monthController = TextEditingController();
  final TextEditingController _yearController = TextEditingController();

  // Método para procesar el pago
  void _processPayment() {
    if (_formKey.currentState!.validate()) {
      // Si el formulario es válido
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: const Text("Pago Exitoso"),
          content: const Text("¡Tu Oficina está Reservada!"),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context); // Cierra el diálogo
                Navigator.pop(context); // Regresa a la pantalla anterior
              },
              child: const Text("OK"),
            ),
          ],
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Pago"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Precio Total
              Text(
                "Total a Pagar: \$${widget.totalPrice.toStringAsFixed(2)}",
                style: const TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 24),

              // Campo Número de Tarjeta
              TextFormField(
                controller: _cardNumberController,
                keyboardType: TextInputType.number,
                maxLength: 16,
                decoration: const InputDecoration(
                  labelText: "Número de Tarjeta",
                  hintText: "1234 5678 9012 3456",
                  prefixIcon: Icon(Icons.credit_card),
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null || value.length != 16) {
                    return "Ingresa un número de tarjeta válido";
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),

              // Campo CVV
              TextFormField(
                controller: _cvvController,
                keyboardType: TextInputType.number,
                maxLength: 3,
                decoration: const InputDecoration(
                  labelText: "CVV",
                  hintText: "123",
                  prefixIcon: Icon(Icons.lock),
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null || value.length != 3) {
                    return "Ingresa un CVV válido";
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),

              // Fecha de Caducidad (Mes y Año)
              const Text(
                "Fecha de Caducidad",
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 8),
              Row(
                children: [
                  // Campo Mes
                  Expanded(
                    child: TextFormField(
                      controller: _monthController,
                      keyboardType: TextInputType.number,
                      maxLength: 2,
                      decoration: const InputDecoration(
                        labelText: "Mes",
                        hintText: "MM",
                        border: OutlineInputBorder(),
                      ),
                      validator: (value) {
                        if (value == null ||
                            value.isEmpty ||
                            int.tryParse(value)! > 12 ||
                            int.tryParse(value)! < 1) {
                          return "Mes inválido";
                        }
                        return null;
                      },
                    ),
                  ),
                  const SizedBox(width: 16),

                  // Campo Año
                  Expanded(
                    child: TextFormField(
                      controller: _yearController,
                      keyboardType: TextInputType.number,
                      maxLength: 2,
                      decoration: const InputDecoration(
                        labelText: "Año",
                        hintText: "AA",
                        border: OutlineInputBorder(),
                      ),
                      validator: (value) {
                        if (value == null ||
                            value.isEmpty ||
                            int.tryParse(value)! < 0) {
                          return "Año inválido";
                        }
                        return null;
                      },
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 24),

              // Botón Confirmar Pago
              Center(
                child: ElevatedButton(
                  onPressed: _processPayment,
                  child: const Text("Confirmar Pago"),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ReservationDetailScreen extends StatelessWidget {
  const ReservationDetailScreen({
    super.key,
    this.title = 'Carcelen, Edificio EPIQ',
    this.address = 'Av. Jaime Roldós Aguilera',
    this.price = '86',
    this.reservationDate = '29 de Octubre',
    this.reservationTime = '12:00 am - 04:00 pm',
    this.reservationName = 'Mao Astudillo',
    this.attendeesCount = '7',
  });

  final String title;
  final String address;
  final String price;
  final String reservationDate;
  final String reservationTime;
  final String reservationName;
  final String attendeesCount;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        title: Text(
          'Detalles de la Reserva',
          style: GoogleFonts.firaSans(
            color: Theme.of(context).colorScheme.primary,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Image.asset(
              'assets/default_office.jpg',
              width: double.infinity,
              height: 250, // Ajusta la altura según tus necesidades
              fit: BoxFit.cover,
            ),
            const SizedBox(height: 16),
            Text(
              title,
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Theme.of(context).colorScheme.tertiary,
              ),
            ),
            const SizedBox(height: 8),
            Text(address, style: const TextStyle(fontSize: 16)),
            const SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Costo Total: \$$price',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Theme.of(context).colorScheme.primary,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            const Divider(),
            const Text(
              'Detalles de la Reserva',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            Row(
              children: [
                Icon(
                  Icons.calendar_today,
                  size: 20,
                  color: Theme.of(context).colorScheme.tertiary,
                ),
                const SizedBox(width: 8),
                Text(
                  'Día: $reservationDate',
                  style: const TextStyle(fontSize: 16),
                ),
              ],
            ),
            const SizedBox(height: 8),
            Row(
              children: [
                Icon(
                  Icons.access_time,
                  size: 20,
                  color: Theme.of(context).colorScheme.tertiary,
                ),
                const SizedBox(width: 8),
                Text(
                  'Hora: $reservationTime',
                  style: const TextStyle(fontSize: 16),
                ),
              ],
            ),
            const SizedBox(height: 8),
            Row(
              children: [
                Icon(
                  Icons.person,
                  size: 20,
                  color: Theme.of(context).colorScheme.tertiary,
                ),
                const SizedBox(width: 8),
                Text(
                  'Reservado a nombre de: $reservationName',
                  style: const TextStyle(fontSize: 16),
                ),
              ],
            ),
            const SizedBox(height: 8),
            Row(
              children: [
                Icon(
                  Icons.group,
                  size: 20,
                  color: Theme.of(context).colorScheme.tertiary,
                ),
                const SizedBox(width: 8),
                Text(
                  'Cantidad de asistentes: $attendeesCount',
                  style: const TextStyle(fontSize: 16),
                ),
              ],
            ),
            const SizedBox(height: 16),
            const Divider(),
            const SizedBox(height: 16),
            const Text(
              'Gracias por tu reserva. Nos alegra que hayas elegido nuestra oficina. ¡Te esperamos!',
              style: TextStyle(fontSize: 16),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomAppBar(
        color: Theme.of(context).colorScheme.primary,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            ElevatedButton(
              onPressed: () {
                showDialog(
                  context: context,
                  builder: (context) => AlertDialog(
                    title: Text(
                      "¿Cancelar Reserva?",
                      style: TextStyle(color: Theme.of(context).colorScheme.error),
                    ),
                    content: const Text("¿Estás seguro de que deseas cancelar tu reserva?\nEsta acción no se puede deshacer."),
                    actions: [
                      ElevatedButton(
                        onPressed: () {
                          Navigator.pop(context); // Cierra el diálogo sin cancelar
                        },
                        style: const ButtonStyle(elevation: WidgetStatePropertyAll(5)),
                        child: const Text("No, mantener"),
                      ),
                      TextButton(
                        onPressed: () {
                          Navigator.pop(context); // Cierra el diálogo
                          Navigator.of(context).pop(true); // Regresa a la pantalla anterior con confirmación de cancelación
                        },
                        child: Text("Sí, cancelar", style: TextStyle(color: Theme.of(context).colorScheme.error),),
                      ),
                    ],
                  ),
                );

              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Theme.of(context).colorScheme.error,
                foregroundColor: Theme.of(context).colorScheme.onError,
                elevation: 10,
              ),
              child: const Text('Cancelar Reserva'),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.pop(context); // Regresa al menú principal o a otra pantalla
              },
              style: ElevatedButton.styleFrom(elevation: 10),
              child: const Text('Volver al Inicio'),
            ),
          ],
        ),
      ),
    );
  }
}

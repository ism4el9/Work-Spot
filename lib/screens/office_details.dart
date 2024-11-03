import 'package:astro_office/screens/login_page.dart';
import 'package:astro_office/screens/pay.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class OfficeDetailScreen extends StatefulWidget {
  const OfficeDetailScreen({
    super.key,
    this.title = 'Carcelen, Edificio EPIQ',
    this.address = 'Carcelen',
    this.description = 'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.',
    this.price = 43,
    this.schedule = 'Por definir',
    this.services = const [
      {'label': 'Wi-Fi', 'icon': Icons.wifi},
      {'label': 'Impresora', 'icon': Icons.print},
      {'label': 'Café', 'icon': Icons.coffee},
      {'label': 'Sala de Reuniones', 'icon': Icons.door_back_door},
      {'label': 'Aire Acondicionado', 'icon': Icons.air},
      {'label': 'Seguridad 24/7', 'icon': Icons.security},
    ],
    required this.isUserLoggedIn
  });

  final String title;
  final String address;
  final String description;
  final num price;
  final String schedule;
  final List<Map<String, dynamic>> services;

  final bool isUserLoggedIn;

  @override
  State<OfficeDetailScreen> createState() => _OfficeDetailScreenState();
}

class _OfficeDetailScreenState extends State<OfficeDetailScreen> {
  bool isFavorite = false;

  void toggleFavorite() {
    setState(() {
      isFavorite = !isFavorite;
    });
  }

  DateTime selectedDate = DateTime.now();
  TimeOfDay selectedEntryTime = const TimeOfDay(hour: 11, minute: 0);
  TimeOfDay selectedExitTime = const TimeOfDay(hour: 12, minute: 0);
  final TextEditingController nameController = TextEditingController();

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: selectedDate,
      firstDate: DateTime.now(),
      lastDate: DateTime.now().add(const Duration(days: 365)),
    );
    if (picked != null && picked != selectedDate) {
      setState(() {
        selectedDate = picked;
      });
    }
  }

  Future<void> _selectEntryTime(BuildContext context) async {
    final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: selectedEntryTime,
    );
    if (picked != null && picked != selectedEntryTime) {
      setState(() {
        selectedEntryTime = picked;
      });
    }
  }

  Future<void> _selectExitTime(BuildContext context) async {
    final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: selectedExitTime,
    );
    if (picked != null && picked != selectedExitTime) {
      setState(() {
        selectedExitTime = picked;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        title: Row(
          children: [
            const Text('Detalle de la Oficina'),
            const Spacer(),
            IconButton(
              icon: Icon(
                isFavorite ? Icons.bookmark : Icons.bookmark_border,
                color: Theme.of(context).colorScheme.tertiary,
              ),
              onPressed: toggleFavorite,
            ),
          ],
        ),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16.0),
        children: [
          Image.asset(
            'assets/default_office.jpg',
            width: double.infinity,
            height: 250, // Ajusta la altura según tus necesidades
            fit: BoxFit.cover,
          ),
          const SizedBox(height: 16),
          Text(
            widget.title,
            style: GoogleFonts.firaSans(
              color: Theme.of(context).colorScheme.primary,
              fontWeight: FontWeight.bold,
              fontSize: 24,
            ),
          ),
          const SizedBox(height: 8),
          Text(widget.address),
          const SizedBox(height: 16),
          Text(
            widget.description,
            maxLines: 3,
            overflow: TextOverflow.ellipsis,
          ),
          const SizedBox(height: 16),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Precio: \$${widget.price}/h",
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Theme.of(context).colorScheme.primary,
                ),
              ),
            ],
          ),
          const Divider(),
          const Text(
            'Lo que esta oficina ofrece',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: widget.services.map((service) {
              return Row(
                children: [
                  Icon(service['icon'],color: Theme.of(context).colorScheme.tertiary,),
                  const SizedBox(width: 8),
                  Text(service['label']),
                ],
              );
            }).toList(),
          ),
          const Divider(),
          const SizedBox(height: 16),

          // Placeholder para la ubicación
          const Text(
            'Ubicación',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          Container(
            height: 150,
            color: Theme.of(context).colorScheme.surfaceDim,
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.location_on,
                      size: 40, color: Theme.of(context).colorScheme.tertiary),
                  const SizedBox(height: 20),
                  Text(
                    'Ubicación: ${widget.address}',
                    textAlign: TextAlign.center,
                    style: const TextStyle(fontSize: 16),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 16),

          // Selector de fecha, hora de entrada, hora de salida y nombre
          const Text(
            'Detalles de la reserva',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 8),
          ListTile(
            title: const Text("Fecha de reserva"),
            subtitle: Text("${selectedDate.toLocal()}".split(' ')[0]),
            trailing: Icon(
              Icons.calendar_today,
              color: Theme.of(context).colorScheme.tertiary,
            ),
            onTap: () => _selectDate(context),
          ),
          ListTile(
            title: const Text("Hora de entrada"),
            subtitle: Text(selectedEntryTime.format(context)),
            trailing: Icon(Icons.access_time,
                color: Theme.of(context).colorScheme.tertiary),
            onTap: () => _selectEntryTime(context),
          ),
          ListTile(
            title: const Text("Hora de salida"),
            subtitle: Text(selectedExitTime.format(context)),
            trailing: Icon(Icons.access_time,
                color: Theme.of(context).colorScheme.tertiary),
            onTap: () => _selectExitTime(context),
          ),
          const SizedBox(height: 8),
          TextField(
            controller: nameController,
            decoration: InputDecoration(
              labelText: '¿A nombre de quién?',
              border: OutlineInputBorder(
                borderSide: BorderSide(
                  color: Theme.of(context).colorScheme.tertiary,
                ),
                borderRadius: const BorderRadius.all(Radius.circular(30)),
              ),
            ),
          ),
        ],
      ),
      bottomNavigationBar: BottomAppBar(
        height: 120,
        color: Theme.of(context).colorScheme.primary.withOpacity(1),
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 10),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Total: \$${(widget.price * 2)}",
                    style: TextStyle(
                      fontSize: 27,
                      fontWeight: FontWeight.bold,
                      color: Theme.of(context).colorScheme.onPrimary,
                    ),
                  ),
                  ElevatedButton(
                    onPressed: () async {
                      final result = await Navigator.of(context).push(
                        MaterialPageRoute(builder: (context) => widget.isUserLoggedIn ? const PaymentPage(totalPrice: 86,) : LoginPage(payment: true,)),
                      );

                      if (result == true) {
                        // Navegar de regreso a HomePage con el resultado `true`
                        if (context.mounted) {
                          Navigator.of(context).pop(true);
                        }
                      }
                    },
                    style: ButtonStyle(
                      backgroundColor: WidgetStatePropertyAll(
                          Theme.of(context).colorScheme.tertiary),
                      foregroundColor: WidgetStatePropertyAll(
                          Theme.of(context).colorScheme.onTertiary),
                      elevation: const WidgetStatePropertyAll(8),
                    ),
                    child: const Text('Reservar'),
                  ),
                ],
              ),
              const SizedBox(height: 8),
              Row(
                children: [
                  Text(
                    '${'${selectedDate.toLocal()}'.split(' ')[0]}  |  ',
                    style: TextStyle(
                      fontSize: 14,
                      color: Theme.of(context).colorScheme.onPrimary,
                    ),
                  ),
                  Text(
                    '${selectedEntryTime.format(context)} - ',
                    style: TextStyle(
                      fontSize: 14,
                      color: Theme.of(context).colorScheme.onPrimary,
                    ),
                  ),
                  Text(
                    selectedExitTime.format(context),
                    style: TextStyle(
                      fontSize: 14,
                      color: Theme.of(context).colorScheme.onPrimary,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

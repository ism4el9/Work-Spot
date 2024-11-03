import 'package:astro_office/config/officeApi/auth.dart';
import 'package:astro_office/screens/home_page.dart';
import 'package:astro_office/screens/office_details.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

class OfficeSearchPage extends StatefulWidget {
  const OfficeSearchPage({super.key});

  @override
  State<OfficeSearchPage> createState() => _OfficeSearchPageState();
}

class _OfficeSearchPageState extends State<OfficeSearchPage> {
  bool? isPrivateSelected; // Cambiado a null inicialmente para representar "ambos"
  DateTime? selectedDate;
  TimeOfDay? startTime;
  TimeOfDay? endTime;
  int attendees = 0;
  final TextEditingController _sectorController = TextEditingController();

  final List<Map<String, String>> nearbyOffices = [
    {
      "direccion": "Av. Amazonas y Naciones Unidas",
      "edificio": "Edificio World Trade Center",
      "personas": "Capacidad: 15 personas",
      "tipo": "Privado",
    },
    {
      "direccion": "Av. República y Shyris",
      "edificio": "Edificio República Plaza",
      "personas": "Capacidad: 10 personas",
      "tipo": "Compartido",
    },
    {
      "direccion": "Calle Eloy Alfaro y 6 de Diciembre",
      "edificio": "Edificio Metropolitan",
      "personas": "Capacidad: 8 personas",
      "tipo": "Privado",
    },
  ];

  List<Map<String, String>> get filteredOffices {
    if (isPrivateSelected == null) {
      return nearbyOffices; // Mostrar todas las oficinas si no se ha seleccionado ninguna
    }
    String tipo = isPrivateSelected! ? "Privado" : "Compartido";
    return nearbyOffices.where((office) => office["tipo"] == tipo).toList();
  }

  void _navigateToSearchedCard(Map<String, String> office) {
    Navigator.of(context).push(
      MaterialPageRoute(builder: (context) => const OfficeDetailScreen(isUserLoggedIn: false,)),
    );
  }

  String _formatDate(DateTime date) {
    return DateFormat('dd/MM/yyyy').format(date);
  }

  String _formatTime(TimeOfDay time) {
    final now = DateTime.now();
    final dt = DateTime(now.year, now.month, now.day, time.hour, time.minute);
    return DateFormat('HH:mm').format(dt);
  }

  Future<void> _selectTime(BuildContext context, bool isStart) async {
    final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    );
    if (picked != null) {
      setState(() {
        if (isStart) {
          startTime = picked;
        } else {
          endTime = picked;
        }
      });
    }
  }

  void _resetFilters() {
    setState(() {
      isPrivateSelected = null;
      _sectorController.clear();
      selectedDate = null;
      startTime = null;
      endTime = null;
      attendees = 0;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        title: Text(
          "Búsqueda",
          style: GoogleFonts.firaSans(
            color: Theme.of(context).colorScheme.primary,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Selector de Privado / Compartido
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  _buildToggleButton("Privado", true),
                  const SizedBox(width: 8),
                  _buildToggleButton("Compartido", false),
                ],
              ),
              const SizedBox(height: 16),

              TextField(
                controller: _sectorController,
                decoration: InputDecoration(
                  labelText: '¿En qué sector o edificio?',
                  prefixIcon: const Icon(Icons.search),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                ),
              ),
              const SizedBox(height: 16),

              const Text(
                "Recomendaciones",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 8),
              ListView.builder(
                shrinkWrap: true,
                itemCount: filteredOffices.length,
                itemBuilder: (context, index) {
                  final office = filteredOffices[index];
                  return InkWell(
                    onTap: () async {
                      final result = await Navigator.of(context).push(
                        MaterialPageRoute(builder: (context) => const OfficeDetailScreen(isUserLoggedIn: false,)),
                      );
                      if (result == true) {
                        AuthService().login();
                        // Navegar de regreso a HomePage con el resultado `true`
                        if (context.mounted) {
                          Navigator.of(context).pop(true);
                        }
                      }
                    },
                    child: Card(
                      child: ListTile(
                        title: Text(
                          office["edificio"]!,
                          style: TextStyle(
                              color: Theme.of(context).colorScheme.primary),
                        ),
                        subtitle: Text(
                          "${office["direccion"]!}\n${office["personas"]!}",
                        ),
                        trailing: Text(
                          office["tipo"]!,
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Theme.of(context).colorScheme.tertiary,
                          ),
                        ),
                      ),
                    ),
                  );
                },
              ),
              const SizedBox(height: 16),

              const Text(
                "Fecha de Reserva",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 8),
              ListTile(
                leading: const Icon(Icons.calendar_today),
                title: Text(
                  selectedDate == null
                      ? 'Seleccione el Día'
                      : 'Fecha: ${_formatDate(selectedDate!)}',
                ),
                onTap: () async {
                  final picked = await showDatePicker(
                    context: context,
                    initialDate: DateTime.now(),
                    firstDate: DateTime.now(),
                    lastDate: DateTime(2025),
                  );
                  if (picked != null) {
                    setState(() {
                      selectedDate = picked;
                    });
                  }
                },
              ),
              const SizedBox(height: 16),

              const Text(
                "Horas de Reserva",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 8),
              Row(
                children: [
                  Expanded(
                    child: ListTile(
                      title: Text(
                        startTime == null
                            ? 'Hora de Inicio'
                            : 'Inicio: ${_formatTime(startTime!)}',
                      ),
                      onTap: () => _selectTime(context, true),
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: ListTile(
                      title: Text(
                        endTime == null
                            ? 'Hora de Fin'
                            : 'Fin: ${_formatTime(endTime!)}',
                      ),
                      onTap: () => _selectTime(context, false),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 24),

              const Text(
                "Número de Asistentes",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 8),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text('Número de Asistentes:'),
                  Row(
                    children: [
                      IconButton(
                        icon: const Icon(Icons.remove),
                        onPressed: () {
                          if (attendees > 0) {
                            setState(() {
                              attendees--;
                            });
                          }
                        },
                      ),
                      Text('$attendees'),
                      IconButton(
                        icon: const Icon(Icons.add),
                        onPressed: () {
                          setState(() {
                            attendees++;
                          });
                        },
                      ),
                    ],
                  ),
                ],
              ),
              const SizedBox(height: 24),

              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  ElevatedButton(
                    onPressed: _resetFilters,
                    child: const Text("Borrar Filtros"),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      Navigator.of(context).pushAndRemoveUntil(
                        MaterialPageRoute(builder: (context) => MyHomePage(authService: AuthService(), results: true,)),
                        (Route<dynamic> route) => false,
                      );
                    },
                    child: const Text("Buscar"),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildToggleButton(String text, bool isPrivate) {
    bool isSelected = isPrivateSelected == isPrivate;
    return Expanded(
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: isSelected
              ? Theme.of(context).colorScheme.primary
              : Theme.of(context).colorScheme.surface,
          foregroundColor: isSelected
              ? Theme.of(context).colorScheme.onPrimary
              : Theme.of(context).colorScheme.onSurface,
        ),
        onPressed: () {
          setState(() {
            isPrivateSelected = isSelected ? null : isPrivate; // Permite deseleccionar
          });
        },
        child: Text(text),
      ),
    );
  }
}

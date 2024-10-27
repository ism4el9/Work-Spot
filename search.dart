import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class OfficeSearchPage extends StatefulWidget {
  const OfficeSearchPage({Key? key}) : super(key: key);

  @override
  _OfficeSearchPageState createState() => _OfficeSearchPageState();
}

class _OfficeSearchPageState extends State<OfficeSearchPage> {
  bool isPrivateSelected = true; // Estado inicial
  DateTimeRange? selectedDateRange;
  int attendees = 0;
  final TextEditingController _sectorController = TextEditingController();

  // Lista de oficinas quemadas con tipo
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

  // Filtrar las oficinas según el tipo seleccionado
  List<Map<String, String>> get filteredOffices {
    String tipo = isPrivateSelected ? "Privado" : "Compartido";
    return nearbyOffices.where((office) => office["tipo"] == tipo).toList();
  }

  // Navegar a `searched_card.dart` con datos de oficina seleccionada
  void _navigateToSearchedCard(Map<String, String> office) {
    Navigator.pushNamed(
      context,
      '/searched_card',
      arguments: office,
    );
  }

  // Realizar búsqueda y enviar datos al `searched_card.dart`
  void _search() {
    Navigator.pushNamed(
      context,
      '/searched_card',
      arguments: {
        "edificio": _sectorController.text.isNotEmpty
            ? _sectorController.text
            : "Sin especificar",
        "tipo": isPrivateSelected ? "Privado" : "Compartido",
        "capacidad": "$attendees personas",
        "fecha": selectedDateRange != null
            ? 'Desde: ${_formatDate(selectedDateRange!.start)}\n'
              'Hasta: ${_formatDate(selectedDateRange!.end)}'
            : 'Sin fecha seleccionada',
      },
    );
  }

  // Formatear la fecha en dd/MM/yyyy
  String _formatDate(DateTime date) {
    return DateFormat('dd/MM/yyyy').format(date);
  }

  // Borrar filtros y reiniciar valores
  void _resetFilters() {
    setState(() {
      isPrivateSelected = true;
      _sectorController.clear();
      selectedDateRange = null;
      attendees = 0;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Búsqueda de WorkSpot"),
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

              // Campo de Edificio o Sector
              TextField(
                controller: _sectorController,
                decoration: const InputDecoration(
                  labelText: '¿En qué sector o edificio?',
                  prefixIcon: Icon(Icons.search),
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 16),

              // Recomendaciones
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
                    onTap: () => _navigateToSearchedCard(office),
                    child: Card(
                      child: ListTile(
                        title: Text(office["edificio"]!),
                        subtitle: Text(
                          "${office["direccion"]!}\n${office["personas"]!}",
                        ),
                        trailing: Text(
                          office["tipo"]!,
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.blueAccent,
                          ),
                        ),
                      ),
                    ),
                  );
                },
              ),
              const SizedBox(height: 16),

              // Fechas de Reserva
              const Text(
                "Fechas de Reserva",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 8),
              ListTile(
                leading: const Icon(Icons.calendar_today),
                title: Text(
                  selectedDateRange == null
                      ? 'Seleccione los Días'
                      : 'Desde: ${_formatDate(selectedDateRange!.start)}\n'
                        'Hasta: ${_formatDate(selectedDateRange!.end)}',
                ),
                onTap: () async {
                  final DateTimeRange? picked = await showDateRangePicker(
                    context: context,
                    firstDate: DateTime.now(),
                    lastDate: DateTime(2025),
                  );
                  if (picked != null) {
                    setState(() {
                      selectedDateRange = picked;
                    });
                  }
                },
              ),
              const SizedBox(height: 16),

              // Número de Asistentes
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

              // Botones de Buscar y Borrar Filtros
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  ElevatedButton(
                    onPressed: _resetFilters,
                    child: const Text("Borrar Filtros"),
                  ),
                  ElevatedButton(
                    onPressed: _search,
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

  // Método para crear los botones de selección
  Widget _buildToggleButton(String text, bool isPrivate) {
    bool isSelected =
        (isPrivate && isPrivateSelected) || (!isPrivate && !isPrivateSelected);
    return Expanded(
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: isSelected ? Colors.blue : Colors.grey[300],
        ),
        onPressed: () {
          setState(() {
            isPrivateSelected = isPrivate;
          });
        },
        child: Text(
          text,
          style: TextStyle(
            color: isSelected ? Colors.white : Colors.black,
          ),
        ),
      ),
    );
  }
}
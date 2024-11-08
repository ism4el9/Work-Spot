import 'package:astro_office/config/officeApi/auth.dart';
import 'package:astro_office/screens/home_page.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class FiltersPage extends StatefulWidget {
  const FiltersPage({super.key});

  @override
  State<FiltersPage> createState() => _FiltersPageState();
}

class _FiltersPageState extends State<FiltersPage> {

  // Valores del rango de precios
  double _minPrice = 5;
  double _maxPrice = 100;

  // Instalaciones seleccionadas
  final List<String> _selectedFacilities = [];

  // Extras seleccionados
  final List<String> _selectedExtras = [];

  // Opciones disponibles
  final List<String> _facilities = [
    'Cafetería',
    'Wi-Fi',
    'Estacionamiento',
    'Aire Acondicionado',
    'Recepción',
  ];

  final List<String> _extras = [
    'Pizarras',
    'Proyectores',
    'Pantallas',
  ];

  // Alternar selección de instalaciones o extras
  void _toggleSelection(List<String> selectedList, String item) {
    setState(() {
      selectedList.contains(item)
          ? selectedList.remove(item)
          : selectedList.add(item);
    });
  }

  // Resetear los filtros a sus valores predeterminados
  void _resetFilters() {
    setState(() {
      _minPrice = 5;
      _maxPrice = 100;
      _selectedFacilities.clear();
      _selectedExtras.clear();
    });
  }

  // Aplicar los filtros y navegar a search.dart
  void _applyFilters() {
    Navigator.of(context).pushAndRemoveUntil(
                    MaterialPageRoute(builder: (context) => MyHomePage(authService: AuthService(), results: true,)),
                    (Route<dynamic> route) => false,
                  );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        title: Text(
          "Filtros",
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

            // Rango de Precio
            const Text(
              "Precio por Hora",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            RangeSlider(
              values: RangeValues(_minPrice, _maxPrice),
              min: 5,
              max: 100,
              divisions: 19,
              labels: RangeLabels(
                '\$${_minPrice.round()}',
                '\$${_maxPrice.round()}',
              ),
              onChanged: (RangeValues values) {
                setState(() {
                  _minPrice = values.start;
                  _maxPrice = values.end;
                });
              },
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Mínimo: \$${_minPrice.round()}'),
                Text('Máximo: \$${_maxPrice.round()}'),
              ],
            ),
            const SizedBox(height: 16),

            // Instalaciones
            const Text(
              "Instalaciones",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            Wrap(
              spacing: 8.0,
              children: _facilities.map((facility) {
                final isSelected = _selectedFacilities.contains(facility);
                return FilterChip(
                  label: Text(facility),
                  selected: isSelected,
                  selectedColor: Theme.of(context).colorScheme.tertiary,
                  onSelected: (_) => _toggleSelection(_selectedFacilities, facility),
                );
              }).toList(),
            ),
            const SizedBox(height: 16),

            // Extras
            const Text(
              "Amenidades Extra",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            Wrap(
              spacing: 8.0,
              children: _extras.map((extra) {
                final isSelected = _selectedExtras.contains(extra);
                return FilterChip(
                  label: Text(extra),
                  selected: isSelected,
                  selectedColor: Theme.of(context).colorScheme.tertiary,
                  onSelected: (_) => _toggleSelection(_selectedExtras, extra),
                );
              }).toList(),
            ),
            const Spacer(), // Empuja los botones hacia abajo

            // Botones de Limpiar Filtros y Aplicar
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                ElevatedButton(
                  onPressed: _resetFilters,
                  child: const Text("Limpiar Filtros"),
                ),
                ElevatedButton(
                  onPressed: _applyFilters,
                  child: const Text("Aplicar"),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

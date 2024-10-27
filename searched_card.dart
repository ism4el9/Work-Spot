import 'package:flutter/material.dart';

class SearchedCardPage extends StatelessWidget {
  const SearchedCardPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final Map<String, String> office =
        ModalRoute.of(context)!.settings.arguments as Map<String, String>;

    return Scaffold(
      appBar: AppBar(
        title: const Text("Resultados de Búsqueda"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Card(
          child: ListTile(
            title: Text(office["edificio"] ?? "Sin especificar"),
            subtitle: Text(
              "Tipo: ${office["tipo"]}\nCapacidad: ${office["capacidad"]}\nFecha: ${office["fecha"]}",
            ),
          ),
        ),
      ),
    );
  }
}
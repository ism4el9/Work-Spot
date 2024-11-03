import 'package:astro_office/screens/filters.dart';
import 'package:astro_office/screens/search.dart';
import 'package:flutter/material.dart';

class SearchBarWithIcons extends StatelessWidget {
  const SearchBarWithIcons({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Container(
            height: 70,
            
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.surface,
              borderRadius: BorderRadius.circular(25),
              boxShadow: [
                  BoxShadow(
                    color: Theme.of(context).colorScheme.tertiary.withAlpha(125),
                    spreadRadius: 2,
                    blurRadius: 10,
                    blurStyle: BlurStyle.solid
                  ),
                ],
            ),
            child:  Row(
              children: [
                const SizedBox(width: 20),
                const Icon(Icons.search),
                const SizedBox(width: 10),
                Expanded(
                  child: GestureDetector(
                    onTap: () {
                      // Navega a la nueva página y elimina todo el stack
                      Navigator.of(context).push(
                          MaterialPageRoute(builder: (context) => const OfficeSearchPage()),
                        );
                    },
                    child: Container(
                      color: Colors.transparent, // Hace el área clicable
                      child: const TextField(
                        enabled: false, // Deshabilita el teclado
                        decoration: InputDecoration(
                          hintText: 'Buscar',
                          border: InputBorder.none,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
        const SizedBox(width: 10),
        IconButton(
          icon: const Icon(Icons.filter_alt),
          onPressed: () {
            Navigator.of(context).push(
                    MaterialPageRoute(builder: (context) => const FiltersPage()),
                  );
          },
        ),
      ],
    );
  }
}

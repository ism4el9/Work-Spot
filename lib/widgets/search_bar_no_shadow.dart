import 'package:flutter/material.dart';

class SearchBarNoShadow extends StatelessWidget {
  const SearchBarNoShadow({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Container(
            height: 55,
            
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.surface,
              borderRadius: BorderRadius.circular(25),
              border: Border.all(
                color: Theme.of(context).colorScheme.primary
              ),
            ),
            child: const Row(
              children: [
                SizedBox(width: 20),
                Icon(Icons.search),
                SizedBox(width: 10),
                Expanded(
                  child: TextField(
                    decoration: InputDecoration(
                      hintText: 'Buscar',
                      border: InputBorder.none,
                    ),
                  ),
                ),
                
              ],
            ),
          ),
        ),
        
      ],
    );
  }
}

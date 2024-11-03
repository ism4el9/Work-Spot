import 'package:flutter/material.dart';

class SharedPrivateToggle extends StatelessWidget {
  final bool isSharedSelected;
  final bool isPrivateSelected;
  final Function(int) onToggle;

  const SharedPrivateToggle({super.key, 
    required this.isSharedSelected,
    required this.onToggle, 
    required this.isPrivateSelected,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        GestureDetector(
          onTap: () {
            onToggle(1);
          },
          child: Column(
            children: [
              Icon(
                Icons.group,
                color: isSharedSelected ? Theme.of(context).colorScheme.primary : Theme.of(context).colorScheme.surfaceDim,
              ),
              Text(
                "Compartido",
                style: TextStyle(
                  color: isSharedSelected ? Theme.of(context).colorScheme.primary : Theme.of(context).colorScheme.surfaceDim,
                ),
              ),
            ],
          ),
        ),
        Container(
          height: 30,
          width: 1,
          color: Theme.of(context).colorScheme.surfaceDim,
        ),
        GestureDetector(
          onTap: () {
            onToggle(2);
          },
          child: Column(
            children: [
              Icon(
                Icons.person,
                color: isPrivateSelected ? Theme.of(context).colorScheme.primary : Theme.of(context).colorScheme.surfaceDim,
              ),
              Text(
                "Privado",
                style: TextStyle(
                  color: isPrivateSelected ? Theme.of(context).colorScheme.primary : Theme.of(context).colorScheme.surfaceDim,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

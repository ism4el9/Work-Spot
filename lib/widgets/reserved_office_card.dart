import 'package:flutter/material.dart';

class ReservedOfficeCard extends StatelessWidget {
  final String imageUrl;
  final String title;
  final String asistants;
  final String time;
  final String day;
  final String name;

  const ReservedOfficeCard({super.key, 
    required this.imageUrl,
    required this.title,
    required this.asistants,
    required this.time,
    required this.day,
    required this.name,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.all(10),
      shadowColor: Theme.of(context).colorScheme.tertiary,
      elevation: 2,
      child: Stack(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Imagen sin márgenes, ocupando todo el ancho de la tarjeta
              ClipRRect(
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(4),
                  topRight: Radius.circular(4),
                ),
                child: Image.asset(
                  imageUrl,
                  width: double.infinity,
                  height: 250, // Ajusta la altura según tus necesidades
                  fit: BoxFit.cover,
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 5),
                    Text(asistants),
                    const SizedBox(height: 5),
                    Text(time, style: TextStyle(color: Theme.of(context).colorScheme.tertiary)),
                  ],
                ),
              ),
            ],
          ),
          // Chip de tipo de oficina (Privado/Compartido) en la esquina superior derecha
          Positioned(
            top: 260, // Ajusta el valor según sea necesario para que no se solape con la imagen
            right: 10, // Ajusta el valor para separarlo del borde derecho
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(day),
                const SizedBox(height: 36),
                Text(name, style: TextStyle(color: Theme.of(context).colorScheme.primary)),
              ] 
            ),
          ),
        ],
      ),
    );
  }
}

import 'package:flutter/material.dart';

class OfficeCard extends StatefulWidget {
  final String imageUrl;
  final String title;
  final String description;
  final String price;
  final String type;

  const OfficeCard({
    super.key,
    required this.imageUrl,
    required this.title,
    required this.description,
    required this.price,
    required this.type,
  });

  @override
  State<OfficeCard> createState() => _OfficeCardState();
}

class _OfficeCardState extends State<OfficeCard> {
  bool isFavorite = false;

  void toggleFavorite() {
    setState(() {
      isFavorite = !isFavorite;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.all(10),
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
                child: Stack(
                  children: [
                    Image.asset(
                      widget.imageUrl,
                      width: double.infinity,
                      height: 250,
                      fit: BoxFit.cover,
                    ),
                    // Botón de favorito en la esquina superior derecha de la imagen
                    Positioned(
                      top: 8,
                      right: 8,
                      child: IconButton(
                        icon: Icon(
                          isFavorite ? Icons.bookmark : Icons.bookmark_border,
                          color: Theme.of(context).colorScheme.tertiary,
                        ),
                        onPressed: toggleFavorite,
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      widget.title,
                      style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 5),
                    Text(widget.description),
                    const SizedBox(height: 5),
                    Text(
                      widget.price,
                      style: TextStyle(color: Theme.of(context).colorScheme.tertiary),
                    ),
                  ],
                ),
              ),
            ],
          ),
          // Chip de tipo de oficina en la esquina inferior derecha
          Positioned(
            top: 260,
            right: 15,
            child: Text(
              widget.type,
              style: TextStyle(
                color: Theme.of(context).colorScheme.primary,
                fontStyle: FontStyle.italic,
                fontSize: 17,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

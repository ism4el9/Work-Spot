import 'package:flutter/material.dart';

class OfficeCardMini extends StatefulWidget {

  final String imageUrl;
  final String title;
  final String description;
  final String price;
  final String type;

  const OfficeCardMini({
    super.key,
    required this.imageUrl,
    required this.title,
    required this.description,
    required this.price,
    required this.type,
  });

  @override
  State<OfficeCardMini> createState() => _OfficeCardMiniState();
}

class _OfficeCardMiniState extends State<OfficeCardMini> {
  bool isFavorite = true;

  void toggleFavorite() {
    setState(() {
      isFavorite = !isFavorite;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.all(10),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Imagen en miniatura en el lado izquierdo
            ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: 
                  Image.asset(
                    widget.imageUrl,
                    width: 80, // Tamaño reducido
                    height: 80,
                    fit: BoxFit.cover,
                  ),
            ),
            const SizedBox(width: 10),
            // Información a la derecha de la imagen
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    widget.title,
                    style: const TextStyle(
                        fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 5),
                  Text(
                    widget.description,
                    maxLines:
                        2, // Limita el número de líneas para que se mantenga compacto
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 5),
                  Text(
                    widget.price,
                    style: TextStyle(
                      color: Theme.of(context).colorScheme.tertiary,
                    ),
                  ),
                  
                ],
              ),
            ),
            
            // Chip de tipo de oficina (Privado/Compartido) en la esquina superior derecha
            Align(
              alignment: Alignment.bottomRight,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    widget.type,
                    style: TextStyle(
                      color: Theme.of(context).colorScheme.primary,
                    ),
                  ),
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
          ],
        ),
      ),
    );
  }
}

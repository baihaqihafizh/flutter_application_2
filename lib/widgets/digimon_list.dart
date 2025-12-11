import 'package:flutter/material.dart';
import 'package:flutter_application_2/models/digimon.dart';

class DigimonList extends StatelessWidget {
  final Digimon digimon;
  final bool isFavorite;
  final VoidCallback onTap;
  final VoidCallback onFavoriteTap;

  const DigimonList({
    super.key,
    required this.digimon,
    required this.isFavorite,
    required this.onTap,
    required this.onFavoriteTap,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4,
      shape:
          RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: ListTile(
        onTap: onTap,
        leading: Hero(
          tag: digimon.name,
          child: ClipRRect(
            borderRadius: BorderRadius.circular(12),
            child: Image.asset(
              digimon.image,
              width: 56,
              height: 56,
              fit: BoxFit.cover,
            ),
          ),
        ),
        title: Text(
          digimon.name,
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
        subtitle: Text(digimon.type),
        trailing: IconButton(
          icon: Icon(
            isFavorite ? Icons.favorite : Icons.favorite_border,
            color: isFavorite ? Color(0xFF00C8FF) : Colors.grey,
          ),
          onPressed: onFavoriteTap,
        ),
        ),
    );
  }
}
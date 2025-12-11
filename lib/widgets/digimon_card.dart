import 'package:flutter/material.dart';
import 'package:flutter_application_2/models/digimon.dart';

class DigimonCard extends StatelessWidget {
  final Digimon digimon;
  final bool isFavorite;
  final VoidCallback onTapFavorite;
  final VoidCallback onTap;

  const DigimonCard({
    super.key,
    required this.digimon,
    required this.isFavorite,
    required this.onTapFavorite,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(24),
      child: Card(
        elevation: 8,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(24),
        ),
        clipBehavior: Clip.antiAlias,
        child: Column(
          children: [
            // BAGIAN GAMBAR
            Stack(
              children: [
                Container(
                  height: 160,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [
                        Color(0xFF00C8FF),
                        Color(0xFF0097CC),
                      ],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                  ),
                  child: Hero(
                    tag: digimon.name,
                    child: Image.asset(
                      digimon.image,
                      fit: BoxFit.contain,
                    ),
                  ),
                ),

                // Favorite Button berada di pojok kanan atas
                Positioned(
                  top: 10,
                  right: 10,
                  child: Material(
                    color: Colors.white,
                    shape: CircleBorder(),
                    elevation: 4,
                    child: IconButton(
                      onPressed: onTapFavorite,
                      icon: Icon(
                        isFavorite
                            ? Icons.favorite
                            : Icons.favorite_border,
                        color: isFavorite
                            ? Color(0xFF00C8FF)
                            : Colors.grey,
                        size: 20,
                      ),
                    ),
                  ),
                ),
              ],
            ),

            // BAGIAN BAWAH
            Padding(
  padding: const EdgeInsets.all(8.0),
  child: Container(
    decoration: BoxDecoration(
      color: Color(0xFF00C8FF), // <-- BIRU
      borderRadius: BorderRadius.circular(12),
    ),
    child: Padding(
      padding: const EdgeInsets.fromLTRB(12, 10, 12, 16),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  digimon.name,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                    color: Color(0xFF00C8FF), // <-- Biar kontras
                  ),
                ),
                SizedBox(height: 4),
                Text(
                  digimon.type,
                  style: TextStyle(
                    fontSize: 14,
                    color: Color(0xFF00C8FF), // <-- Sesuaikan warna text
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    ),
  ),
)

          ],
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';

class DigimonTypeChip extends StatelessWidget {
  final String type;

  const DigimonTypeChip({super.key, required this.type});

  // --- menentukan warna utama skill ---
  Color _skillColor() {
    if (type.toLowerCase().contains("Reptile") ||
        type.toLowerCase().contains("Vaccine")) {
      return Color(0xFF00C8FF);
    }
    if (type.toLowerCase().contains("blaster") ||
        type.toLowerCase().contains("ice") ||
        type.toLowerCase().contains("wind")) {
      return Color(0xFF00C8FF);
    }
    if (type.toLowerCase().contains("shock") ||
        type.toLowerCase().contains("thunder") ||
        type.toLowerCase().contains("electric")) {
      return Color(0xFF00C8FF);
    }
    if (type.toLowerCase().contains("claw") ||
        type.toLowerCase().contains("strike") ||
        type.toLowerCase().contains("charge")) {
      return Color(0xFF00C8FF);
    }

    return Colors.grey;
  }

  @override
  Widget build(BuildContext context) {
    final baseColor = _skillColor();

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(999),
        gradient: LinearGradient(
          colors: [
            Colors.white,
            Colors.white,
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        border: Border.all(
          color: Colors.transparent,
          width: 1,
        ),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            Icons.star,
            size: 12,
            color: Color(0xFF00C8FF),
          ),
          const SizedBox(width: 4),
          Text(
            type,
            style: TextStyle(
              fontWeight: FontWeight.w600,
              fontSize: 12,
              color: Color(0xFF00C8FF),
            ),
          ),
        ],
      ),
    );
  }
}

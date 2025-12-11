import 'package:flutter/material.dart';

class  Digimon{
  final String name;
  final String image;
  final String type;
  final String description;
  final int basePower;
  final List<String> skills;

  Digimon({
  required this.name,
  required this.image,
  required this.type,
  required this.description,
  required this.basePower,
  required this.skills,
  });
}
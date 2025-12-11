import 'package:flutter/material.dart';
import 'package:flutter_application_2/models/digimon.dart';
import 'package:flutter_application_2/widgets/type_chip_digimon.dart';

class DigimonDetailPage extends StatefulWidget {
  final Digimon digimon;
  final bool isFavorite;

  const DigimonDetailPage({
    super.key,
    required this.digimon,
    required this.isFavorite,
  });

  @override
  State<DigimonDetailPage> createState() => _DigimonDetailPageState();
}

class _DigimonDetailPageState extends State<DigimonDetailPage> {
  late bool _isFavorite;

  @override
  void initState() {
    _isFavorite = widget.isFavorite;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final pkm = widget.digimon;

    return WillPopScope(
      onWillPop: () async {
        Navigator.pop(context, _isFavorite);
        return false;
      },
      child: Scaffold(
        appBar: AppBar(
          title: Text(pkm.name),
          actions: [
            IconButton(
              onPressed: () {
                setState(() {
                  _isFavorite = !_isFavorite;
                });
              },
              icon: Icon(
                _isFavorite ? Icons.favorite : Icons.favorite_border,
                color: _isFavorite ? const Color(0xFF00C8FF) : Colors.grey,
              ),
            ),
          ],
        ),
        body: LayoutBuilder(
          builder: (context, constraints) {
            final isWide = constraints.maxWidth > 700;

            // IMAGE BOX
            final imageBox = Hero(
              tag: pkm.name,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(20),
                child: Image.asset(
                  pkm.image,
                  width: double.infinity,
                  fit: BoxFit.cover,
                ),
              ),
            );

            // INFO BOX
            final infoBox = Card(
              margin: const EdgeInsets.all(12.0),
              elevation: 8,
              shadowColor: Colors.black38,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
              ),
              child: Container(
                decoration: BoxDecoration(
                  gradient: const LinearGradient(
                    colors: [
                      Color(0xFF00C8FF),
                      Color(0xFF00C8FF),
                    ],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Center(
                        child: Text(
                          pkm.name.toUpperCase(),
                          style: const TextStyle(
                            fontSize: 32,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                      ),
                      const SizedBox(height: 12),

                      Center(child: DigimonTypeChip(type: pkm.type)),
                      const SizedBox(height: 16),

                      Center(
                        child: Text(
                          "Base Power ${pkm.basePower}",
                          style: const TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                      ),

                      const SizedBox(height: 20),

                      const Text(
                        "Deskripsi",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 22,
                          color: Colors.white,
                        ),
                      ),
                      const SizedBox(height: 10),

                      Text(
                        pkm.description,
                        textAlign: TextAlign.justify,
                        style: const TextStyle(
                          height: 1.4,
                          color: Colors.white,
                          fontSize: 16,
                        ),
                      ),

                      const SizedBox(height: 20),

                      const Text(
                        "Skill",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 22,
                          color: Colors.white,
                        ),
                      ),
                      const SizedBox(height: 10),

                      Wrap(
                        spacing: 10,
                        children: pkm.skills.map((skill) {
                          return Chip(
                            label: Text(
                              skill,
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Color(0xFF00C8FF),
                              ),
                            ),
                            avatar: const Icon(Icons.star, color: Color(0xFF00C8FF),),
                            backgroundColor: Colors.white,
                          );
                        }).toList(),
                      ),
                    ],
                  ),
                ),
              ),
            );

            // RESPONSIVE
            if (isWide) {
              return Row(
                children: <Widget>[
                  Expanded(flex: 1, child: imageBox),
                  Expanded(flex: 1, child: infoBox),
                ],
              );
            }

            // MOBILE
            return SingleChildScrollView(
              child: Column(
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: imageBox,
                  ),
                  infoBox,
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}

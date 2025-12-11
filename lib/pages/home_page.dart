import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_application_2/data/digimon_data.dart';
import 'package:flutter_application_2/pages/detai_page.dart';
import 'package:flutter_application_2/widgets/digimon_card.dart';
import 'package:flutter_application_2/widgets/digimon_list.dart';

class DigimonHomePage extends StatefulWidget {
  const DigimonHomePage({super.key});

  @override
  State<DigimonHomePage> createState() => _DigimonHomePageState();
}

class _DigimonHomePageState extends State<DigimonHomePage> {
  String _searchQuery = '';
  bool _showFavoritesOnly = false;
  final Set<String> _favorites = {};
  final TextEditingController _searchController = TextEditingController();

  // ---------------------------
  // 🔥 Banner Controller
  // ---------------------------
  final PageController _bannerController = PageController();
  int _bannerIndex = 0;

  late Timer _autoSlideTimer;

  final List<String> bannerImages = [
    "assets/bener1.png",
    "assets/bener2.png",
    "assets/bener3.png",
  ];

  @override
  void initState() {
    super.initState();

    // 🔥 AUTO SLIDE TIAP 3 DETIK
    _autoSlideTimer = Timer.periodic(const Duration(seconds: 3), (timer) {
      if (_bannerController.hasClients) {
        int next = (_bannerIndex + 1) % bannerImages.length;
        _bannerController.animateToPage(
          next,
          duration: const Duration(milliseconds: 600),
          curve: Curves.easeInOut,
        );
      }
    });
  }

  @override
  void dispose() {
    _bannerController.dispose();
    _searchController.dispose();
    _autoSlideTimer.cancel();
    super.dispose();
  }

  Future<void> _openDetailPage(digimon, isFav) async {
    final result = await Navigator.push<bool>(
      context,
      MaterialPageRoute(
        builder: (_) => DigimonDetailPage(
          digimon: digimon,
          isFavorite: isFav,
        ),
      ),
    );

    if (result != null) {
      setState(() {
        if (result) {
          _favorites.add(digimon.name);
        } else {
          _favorites.remove(digimon.name);
        }
      });
    }
  }

  void _toggleFavorite(String name) {
    setState(() {
      if (_favorites.contains(name)) {
        _favorites.remove(name);
      } else {
        _favorites.add(name);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final filtered = dataDigimon.where((p) {
      final q = _searchQuery.toLowerCase();
      final matchesSearch = p.name.toLowerCase().contains(q);
      final matchesFavorite =
          !_showFavoritesOnly || _favorites.contains(p.name);
      return matchesSearch && matchesFavorite;
    }).toList();

    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: [
            Image.asset(
              'assets/Group 3.png',
              height: 35,
            ),
            const SizedBox(width: 10),
      Expanded(
        child: const Text(
          'Digiview',
          style: TextStyle(
            fontSize: 21,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
              ),
      ),
            Expanded(
              child: const Text(
                'Made by HAKER ID',
                style: TextStyle(
                  fontSize: 15,
                  color: Colors.white,
                ),
              ),
            ),
          ],
        ),
        backgroundColor: Color(0xFF00C8FF),
        
      ),
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          children: <Widget>[
            // =============================
            // 🔥 BANNER SWIPE (AUTO + PARALLAX)
            // =============================
            SizedBox(
              height: 200,
              child: Stack(
                children: [
                  PageView.builder(
                    controller: _bannerController,
                    itemCount: bannerImages.length,
                    onPageChanged: (index) {
                      setState(() => _bannerIndex = index);
                    },
                    itemBuilder: (context, index) {
                      // PARALLAX OFFSET
                      double offset = 0;
                      if (_bannerController.position.haveDimensions) {
                        offset = index - _bannerController.page!;
                      }

                      return Transform.translate(
                        offset: Offset(offset * -20, 0), // 🔥 PARALLAX GERAK
                        child: Padding(
                          padding: const EdgeInsets.all(10),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(18),
                            child: Container(
                              color: Colors.white,
                              child: Image.asset(
                                bannerImages[index],
                                fit: BoxFit.cover,
                                alignment: Alignment.center,
                              ),
                            ),
                          ),
                        ),
                      );
                    },
                  ),

                  // 🔥 Indicator
                  Positioned(
                    bottom: 10,
                    left: 0,
                    right: 0,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: List.generate(
                        bannerImages.length,
                        (i) => AnimatedContainer(
                          duration: const Duration(milliseconds: 300),
                          margin: const EdgeInsets.symmetric(horizontal: 4),
                          height: 8,
                          width: _bannerIndex == i ? 18 : 8,
                          decoration: BoxDecoration(
                            color: _bannerIndex == i
                                ? Color(0xFF00C8FF)
                                : Colors.white.withOpacity(0.4),
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 15),

            // 🔍 SEARCH & FAVORITE FILTER
            Row(
              children: <Widget>[
                Expanded(
                  child: TextField(
                    controller: _searchController,
                    decoration: const InputDecoration(
                      hintText: 'Search Digimon...',
                      prefixIcon: Icon(Icons.search),
                      border: OutlineInputBorder(),
                    ),
                    onChanged: (value) {
                      setState(() => _searchQuery = value);
                    },
                  ),
                ),
                Switch(
                  value: _showFavoritesOnly,
                  onChanged: (val) {
                    setState(() => _showFavoritesOnly = val);
                  },
                ),
              ],
            ),

            const SizedBox(height: 10),

  Expanded(
  child: LayoutBuilder(
    builder: (context, constraints) {
      // ============================================================
      // MODE LIST (LAYAR KECIL < 600px)
      // ============================================================
      if (constraints.maxWidth < 600) {
        return ListView.builder(
          itemCount: filtered.length,
          itemBuilder: (context, index) {
            final digimon = filtered[index];
            final isFav = _favorites.contains(digimon.name);

            return Container(
              margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
              decoration: BoxDecoration(
                color: Color(0xFF00C8FF), // <-- warna item
                borderRadius: BorderRadius.circular(12),
              ),
              child: DigimonList(
                digimon: digimon,
                isFavorite: isFav,
                onTap: () => _openDetailPage(digimon, isFav),
                onFavoriteTap: () => _toggleFavorite(digimon.name),
              ),
            );
          },
        );
      }

      // ============================================================
      // MODE GRID (TABLET / WEB)
      // ============================================================
      int count = 2;
      if (constraints.maxWidth >= 900) count = 4;
      else if (constraints.maxWidth >= 650) count = 6;

      return GridView.builder(
        itemCount: filtered.length,
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: count,
          crossAxisSpacing: 12,
          mainAxisSpacing: 12,
          childAspectRatio: 3 / 4,
        ),
        itemBuilder: (context, index) {
          final digimon = filtered[index];
          final isFav = _favorites.contains(digimon.name);

          return Container(
            decoration: BoxDecoration(
              color: Color(0xFF00C8FF), // <-- warna grid item
              borderRadius: BorderRadius.circular(16),
            ),
            child: DigimonCard(
              digimon: digimon,
              isFavorite: isFav,
              onTap: () => _openDetailPage(digimon, isFav),
              onTapFavorite: () => _toggleFavorite(digimon.name),
            ),
          );
        },
      );
    },
  ),
),

    Padding(
  padding: const EdgeInsets.only(top: 12, bottom: 8),
  child: Row(
    mainAxisAlignment: MainAxisAlignment.center,
    children: [
      Image.asset(
        'assets/logo.png',   // GANTI dengan path logomu
        height: 18,
      ),
      const SizedBox(width: 6),
      const Text(
        'Made by HAKER ID',
        style: TextStyle(
          fontSize: 12,
          color: Color(0xFF00C8FF),
        ),
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

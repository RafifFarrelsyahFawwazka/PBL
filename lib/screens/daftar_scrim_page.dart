import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class DaftarScrimPage extends StatefulWidget {
  const DaftarScrimPage({super.key});

  @override
  State<DaftarScrimPage> createState() => _DaftarScrimPageState();
}

class _DaftarScrimPageState extends State<DaftarScrimPage> {
  final _searchController = TextEditingController();
  String _searchQuery = '';

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  // Sample Scrim list data
  final List<Map<String, String>> _allScrims = [
    {
      'title': 'Shadow Cup Qualifier',
      'image': 'https://images.unsplash.com/photo-1542751371-adc38448a05e?w=400&fit=crop',
      'prize': 'Rp. 500.000',
      'price': 'Rp. 50.000',
      'slots': '4/16 terisi',
    },
    {
      'title': 'Free Fire Grand League',
      'image': 'https://images.unsplash.com/photo-1587202372775-e229f172b9d7?w=400&fit=crop',
      'prize': 'Rp. 750.000',
      'price': 'Rp. 75.000',
      'slots': '12/24 terisi',
    },
    {
      'title': 'Booyah Arena Masters',
      'image': 'https://images.unsplash.com/photo-1607604276583-eef5d076aa5f?w=400&fit=crop',
      'prize': 'Rp. 1.000.000',
      'price': 'Gratis',
      'slots': '8/16 terisi',
    },
    {
      'title': 'Survival Mode Cup',
      'image': 'https://images.unsplash.com/photo-1511512578047-dfb367046420?w=400&fit=crop',
      'prize': 'Rp. 300.000',
      'price': 'Rp. 20.000',
      'slots': '15/16 terisi',
    },
    {
      'title': 'Chrono Clash Series',
      'image': 'https://images.unsplash.com/photo-1550745165-9bc0b252726f?w=400&fit=crop',
      'prize': 'Rp. 600.000',
      'price': 'Rp. 40.000',
      'slots': '2/16 terisi',
    },
    {
      'title': 'Bermuda Master Cup',
      'image': 'https://images.unsplash.com/photo-1538481199705-c710c4e965fc?w=400&fit=crop',
      'prize': 'Rp. 450.000',
      'price': 'Rp. 30.000',
      'slots': '6/16 terisi',
    },
    {
      'title': 'Kalahari Open League',
      'image': 'https://images.unsplash.com/photo-1560253023-3ec5d502959f?w=400&fit=crop',
      'prize': 'Rp. 800.000',
      'price': 'Rp. 50.000',
      'slots': '9/24 terisi',
    },
    {
      'title': 'Purgatory Ultimate Pro',
      'image': 'https://images.unsplash.com/photo-1518709268805-4e9042af9f23?w=400&fit=crop',
      'prize': 'Rp. 1.500.000',
      'price': 'Rp. 100.000',
      'slots': '14/16 terisi',
    },
  ];

  @override
  Widget build(BuildContext context) {
    // Filter scrims based on query
    final filteredScrims = _allScrims.where((scrim) {
      final title = scrim['title']!.toLowerCase();
      return title.contains(_searchQuery.toLowerCase());
    }).toList();

    return Scaffold(
      backgroundColor: const Color(0xFFFDF8F2),
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // 1. Search Bar & Horizontal categories container
            Padding(
              padding: const EdgeInsets.only(left: 24.0, right: 24.0, top: 16.0, bottom: 8.0),
              child: Column(
                children: [
                  // Oval search field
                  Container(
                    decoration: BoxDecoration(
                      boxShadow: [
                        BoxShadow(
                          color: const Color(0x0A1E1B18),
                          blurRadius: 8,
                          offset: const Offset(0, 4),
                        ),
                      ],
                    ),
                    child: TextField(
                      controller: _searchController,
                      onChanged: (val) {
                        setState(() {
                          _searchQuery = val;
                        });
                      },
                      style: GoogleFonts.outfit(
                        fontSize: 15,
                        color: const Color(0xFF1E1B18),
                      ),
                      decoration: InputDecoration(
                        hintText: 'Search scrims...',
                        hintStyle: GoogleFonts.outfit(
                          color: const Color(0xFFC4BEB5),
                        ),
                        prefixIcon: const Icon(
                          Icons.search,
                          color: Color(0xFFF2C94C),
                          size: 22,
                        ),
                        suffixIcon: _searchQuery.isNotEmpty
                            ? IconButton(
                                icon: const Icon(Icons.clear, size: 18),
                                onPressed: () {
                                  _searchController.clear();
                                  setState(() {
                                    _searchQuery = '';
                                  });
                                },
                              )
                            : null,
                        filled: true,
                        fillColor: Colors.white,
                        contentPadding: const EdgeInsets.symmetric(vertical: 14),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(30),
                          borderSide: const BorderSide(
                            color: Color(0xFFF2C94C),
                            width: 1.5,
                          ),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(30),
                          borderSide: const BorderSide(
                            color: Color(0xFFF2C94C),
                            width: 2.0,
                          ),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),

                  // Horizontal category chips
                  SizedBox(
                    height: 32,
                    child: ListView(
                      scrollDirection: Axis.horizontal,
                      children: [
                        _buildCategoryTag('Terpopuler', true),
                        _buildCategoryTag('Turnamen', false),
                        _buildCategoryTag('Liga', false),
                        _buildCategoryTag('Sparing', false),
                        _buildCategoryTag('Duo/Solo', false),
                      ],
                    ),
                  ),
                ],
              ),
            ),

            // 2. Scrollable Grid of Scrim Cards
            Expanded(
              child: filteredScrims.isEmpty
                  ? Center(
                      child: Text(
                        'Tidak ada hasil ditemukan.',
                        style: GoogleFonts.outfit(
                          color: const Color(0xFF827D75),
                          fontSize: 14,
                        ),
                      ),
                    )
                  : GridView.builder(
                      padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 16.0),
                      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        crossAxisSpacing: 16,
                        mainAxisSpacing: 16,
                        childAspectRatio: 0.72,
                      ),
                      itemCount: filteredScrims.length,
                      itemBuilder: (context, index) {
                        final scrim = filteredScrims[index];
                        return _buildScrimCard(
                          scrim['title']!,
                          scrim['image']!,
                          scrim['prize']!,
                          scrim['price']!,
                          scrim['slots']!,
                        );
                      },
                    ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCategoryTag(String label, bool isSelected) {
    return Container(
      margin: const EdgeInsets.only(right: 8),
      child: FilterChip(
        label: Text(
          label,
          style: GoogleFonts.outfit(
            fontSize: 12,
            fontWeight: isSelected ? FontWeight.w800 : FontWeight.w600,
            color: const Color(0xFF1E1B18),
          ),
        ),
        selected: isSelected,
        onSelected: (bool selected) {},
        backgroundColor: isSelected ? const Color(0xFFF2C94C) : const Color(0x80FFFFFF),
        selectedColor: const Color(0xFFF2C94C),
        checkmarkColor: const Color(0xFF1E1B18),
        padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 2),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
          side: BorderSide(
            color: isSelected ? const Color(0xFF1E1B18) : const Color(0xFFEADFCF),
            width: 1,
          ),
        ),
      ),
    );
  }

  Widget _buildScrimCard(
    String title,
    String imageUrl,
    String prize,
    String price,
    String slots,
  ) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.zero,
        border: Border.all(color: const Color(0xFF1E1B18), width: 1.5),
        boxShadow: [
          BoxShadow(
            color: const Color(0xFF1E1B18).withAlpha(15),
            blurRadius: 5,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          // Image top half
          Expanded(
            child: Stack(
              children: [
                Image.network(
                  imageUrl,
                  width: double.infinity,
                  height: double.infinity,
                  fit: BoxFit.cover,
                ),
                Container(
                  color: Colors.black.withAlpha(80),
                ),
                Positioned(
                  top: 8,
                  left: 8,
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                    color: const Color(0xFFF2C94C),
                    child: Text(
                      'Terpopuler',
                      style: GoogleFonts.outfit(
                        fontSize: 9,
                        fontWeight: FontWeight.w800,
                        color: const Color(0xFF1E1B18),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          
          // Details bottom half
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: GoogleFonts.outfit(
                    fontSize: 14,
                    fontWeight: FontWeight.w900,
                    color: const Color(0xFF1E1B18),
                  ),
                ),
                const SizedBox(height: 10),
                
                // Item 1: Trophy
                Row(
                  children: [
                    const Icon(Icons.emoji_events_outlined, size: 13, color: Color(0xFFB59357)),
                    const SizedBox(width: 6),
                    Expanded(
                      child: Text(
                        prize,
                        style: GoogleFonts.outfit(
                          fontSize: 11,
                          fontWeight: FontWeight.w700,
                          color: const Color(0xFF827D75),
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 4),

                // Item 2: Home/Ticket
                Row(
                  children: [
                    const Icon(Icons.storefront_outlined, size: 13, color: Color(0xFFB59357)),
                    const SizedBox(width: 6),
                    Expanded(
                      child: Text(
                        price,
                        style: GoogleFonts.outfit(
                          fontSize: 11,
                          fontWeight: FontWeight.w700,
                          color: const Color(0xFF827D75),
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 4),

                // Item 3: Users registered
                Row(
                  children: [
                    const Icon(Icons.group_outlined, size: 13, color: Color(0xFFB59357)),
                    const SizedBox(width: 6),
                    Expanded(
                      child: Text(
                        slots,
                        style: GoogleFonts.outfit(
                          fontSize: 11,
                          fontWeight: FontWeight.w800,
                          color: const Color(0xFFD4A017),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class BerandaPage extends StatelessWidget {
  final VoidCallback onNavigateToScrimList;

  const BerandaPage({super.key, required this.onNavigateToScrimList});

  @override
  Widget build(BuildContext context) {
    // Fetch dynamic user info from Supabase Auth Metadata
    final user = Supabase.instance.client.auth.currentUser;
    final displayName = user?.userMetadata?['display_name'] ?? 'Azaria Amanda';
    
    // Get initials for Avatar
    final initials = displayName.length >= 2 
        ? displayName.substring(0, 2).toUpperCase()
        : displayName.substring(0, displayName.length).toUpperCase();

    return Scaffold(
      backgroundColor: const Color(0xFFFDF8F2),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // 1. Header (Avatar, Name, Bell)
              Row(
                children: [
                  CircleAvatar(
                    radius: 24,
                    backgroundColor: const Color(0xFFF2C94C),
                    child: Text(
                      initials,
                      style: GoogleFonts.outfit(
                        fontWeight: FontWeight.w900,
                        fontSize: 16,
                        color: const Color(0xFF1E1B18),
                      ),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Halo,',
                          style: GoogleFonts.outfit(
                            fontSize: 13,
                            color: const Color(0xFF827D75),
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        Text(
                          displayName,
                          style: GoogleFonts.outfit(
                            fontSize: 18,
                            fontWeight: FontWeight.w900,
                            color: const Color(0xFF1E1B18),
                          ),
                        ),
                      ],
                    ),
                  ),
                  // Notification bell with badge
                  Stack(
                    children: [
                      Container(
                        padding: const EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          border: Border.all(
                            color: const Color(0xFFEADFCF),
                            width: 1.5,
                          ),
                        ),
                        child: const Icon(
                          Icons.notifications_outlined,
                          size: 22,
                          color: Color(0xFF1E1B18),
                        ),
                      ),
                      Positioned(
                        top: 2,
                        right: 2,
                        child: Container(
                          width: 12,
                          height: 12,
                          decoration: BoxDecoration(
                            color: const Color(0xFFF2C94C),
                            shape: BoxShape.circle,
                            border: Border.all(
                              color: const Color(0xFFFDF8F2),
                              width: 1.5,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              const SizedBox(height: 24),

              // 2. Featured Banner Card (Carousel Mock)
              Container(
                height: 190,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.zero,
                  border: Border.all(color: const Color(0xFF1E1B18), width: 2.0),
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.zero,
                  child: Stack(
                    children: [
                      // Banner Image (Unsplash Gaming Setup)
                      Image.network(
                        'https://images.unsplash.com/photo-1598550476439-6847785fce6e?w=800&auto=format&fit=crop&q=60',
                        width: double.infinity,
                        height: double.infinity,
                        fit: BoxFit.cover,
                        loadingBuilder: (context, child, loadingProgress) {
                          if (loadingProgress == null) return child;
                          return Container(
                            color: const Color(0xFFEADFCF),
                            child: const Center(
                              child: CircularProgressIndicator(strokeWidth: 2),
                            ),
                          );
                        },
                      ),
                      // Gradient overlay to keep text readable
                      Container(
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            begin: Alignment.topCenter,
                            end: Alignment.bottomCenter,
                            colors: [
                              Colors.transparent,
                              Colors.black.withAlpha(200),
                            ],
                          ),
                        ),
                      ),
                      // Text & tags content
                      Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Container(
                              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                              decoration: const BoxDecoration(
                                color: Color(0xFFF2C94C),
                              ),
                              child: Text(
                                'Periferal Gaming',
                                style: GoogleFonts.outfit(
                                  fontSize: 10,
                                  fontWeight: FontWeight.w800,
                                  color: const Color(0xFF1E1B18),
                                ),
                              ),
                            ),
                            const SizedBox(height: 8),
                            Text(
                              'Rexus Gaming Chair RGC 101',
                              style: GoogleFonts.outfit(
                                fontSize: 18,
                                fontWeight: FontWeight.w900,
                                color: Colors.white,
                              ),
                            ),
                            const SizedBox(height: 2),
                            Text(
                              'By Rexus',
                              style: GoogleFonts.outfit(
                                fontSize: 11,
                                fontWeight: FontWeight.w500,
                                color: const Color(0xFFC4BEB5),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 12),

              // Page Indicators for Banner
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    width: 24,
                    height: 6,
                    decoration: BoxDecoration(
                      color: const Color(0xFFF2C94C),
                      borderRadius: BorderRadius.circular(3),
                    ),
                  ),
                  const SizedBox(width: 6),
                  Container(
                    width: 6,
                    height: 6,
                    decoration: const BoxDecoration(
                      color: Color(0xFFEADFCF),
                      shape: BoxShape.circle,
                    ),
                  ),
                  const SizedBox(width: 6),
                  Container(
                    width: 6,
                    height: 6,
                    decoration: const BoxDecoration(
                      color: Color(0xFFEADFCF),
                      shape: BoxShape.circle,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 24),

              // 3. Section Title: Scrim Terkini
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Container(
                        width: 4,
                        height: 18,
                        color: const Color(0xFFF2C94C),
                      ),
                      const SizedBox(width: 8),
                      Text(
                        'Scrim Terkini',
                        style: GoogleFonts.outfit(
                          fontSize: 18,
                          fontWeight: FontWeight.w900,
                          color: const Color(0xFF1E1B18),
                        ),
                      ),
                    ],
                  ),
                  GestureDetector(
                    onTap: onNavigateToScrimList,
                    child: Row(
                      children: [
                        Text(
                          'Lihat Lainnya',
                          style: GoogleFonts.outfit(
                            fontSize: 12,
                            fontWeight: FontWeight.w700,
                            color: const Color(0xFFD4A017),
                          ),
                        ),
                        const SizedBox(width: 2),
                        const Icon(
                          Icons.arrow_forward_ios,
                          size: 10,
                          color: Color(0xFFD4A017),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),

              // 4. Horizontal Categories
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
              const SizedBox(height: 16),

              // 5. Scrim List Grid (2 Columns, showing 4 items in main view)
              GridView.count(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                crossAxisCount: 2,
                crossAxisSpacing: 16,
                mainAxisSpacing: 16,
                childAspectRatio: 0.72,
                children: [
                  _buildScrimCard('Shadow Cup Qualifier', 'https://images.unsplash.com/photo-1542751371-adc38448a05e?w=400&fit=crop'),
                  _buildScrimCard('Free Fire Grand League', 'https://images.unsplash.com/photo-1587202372775-e229f172b9d7?w=400&fit=crop'),
                  _buildScrimCard('Booyah Arena Masters', 'https://images.unsplash.com/photo-1607604276583-eef5d076aa5f?w=400&fit=crop'),
                  _buildScrimCard('Survival Mode Cup', 'https://images.unsplash.com/photo-1511512578047-dfb367046420?w=400&fit=crop'),
                ],
              ),
            ],
          ),
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

  Widget _buildScrimCard(String title, String imageUrl) {
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
          // Image top half with category tag overlay
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
          
          // Card Details bottom half
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
                        'Rp. 500.000',
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
                        'Rp. 50.000',
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
                        '4/16 terisi',
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

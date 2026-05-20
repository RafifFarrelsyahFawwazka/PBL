import 'dart:math';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'login_screen.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFDF8F2),
      body: SafeArea(
        child: Stack(
          children: [
            // Decorative rotated square in the bottom-left corner
            Positioned(
              bottom: -50,
              left: -50,
              child: Transform.rotate(
                angle: 15 * pi / 180,
                child: Container(
                  width: 160,
                  height: 160,
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: const Color(0xFFEADFCF),
                      width: 1.5,
                    ),
                  ),
                ),
              ),
            ),
            
            // Main Content
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 32.0, vertical: 24.0),
              child: customBorderPadding(), // Helper space
            ),
          ],
        ),
      ),
    );
  }

  // Extracted layout to keep code clean and readable
  Widget customBorderPadding() {
    return Builder(
      builder: (context) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Header: Custom Burger Menu Icon (Top-Left)
            Align(
              alignment: Alignment.topLeft,
              child: InkWell(
                onTap: () {},
                borderRadius: BorderRadius.circular(4),
                child: Padding(
                  padding: const EdgeInsets.all(4.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Container(
                        width: 32,
                        height: 2.5,
                        color: const Color(0xFFF2C94C), // Accent gold line
                      ),
                      const SizedBox(height: 6),
                      Container(
                        width: 20,
                        height: 2.5,
                        color: const Color(0xFFF2C94C),
                      ),
                    ],
                  ),
                ),
              ),
            ),

            const Spacer(flex: 2),

            // Logo & Brand Section
            Center(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  // Rotated diamond logo stack
                  Stack(
                    alignment: Alignment.center,
                    clipBehavior: Clip.none,
                    children: [
                      // Rotated square (diamond)
                      Transform.rotate(
                        angle: 45 * pi / 180,
                        child: Container(
                          width: 86,
                          height: 86,
                          decoration: BoxDecoration(
                            color: Colors.transparent,
                            border: Border.all(
                              color: const Color(0xFFF2C94C),
                              width: 2.0,
                            ),
                          ),
                        ),
                      ),
                      // Upright gaming controller icon
                      const Icon(
                        Icons.sports_esports_outlined,
                        size: 36,
                        color: Color(0xFF1E1B18),
                      ),
                      // Small solid yellow square offset bottom-right
                      Positioned(
                        bottom: -4,
                        right: -4,
                        child: Container(
                          width: 20,
                          height: 20,
                          decoration: BoxDecoration(
                            color: const Color(0xFFF2C94C),
                            border: Border.all(
                              color: const Color(0xFF1E1B18),
                              width: 1.5,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 36),

                  // Brand name: BOOYAHHUB
                  Text(
                    'BOOYAHHUB',
                    style: GoogleFonts.outfit(
                      fontSize: 32,
                      fontWeight: FontWeight.w900,
                      letterSpacing: 0.5,
                      color: const Color(0xFF1E1B18),
                    ),
                  ),
                  const SizedBox(height: 6),

                  // Brand subtitle: FREE FIRE ARENA
                  Text(
                    'FREE FIRE ARENA',
                    style: GoogleFonts.outfit(
                      fontSize: 13,
                      fontWeight: FontWeight.w600,
                      letterSpacing: 3.0,
                      color: const Color(0xFF827D75),
                    ),
                  ),
                ],
              ),
            ),

            const Spacer(flex: 3),

            // Interactive Buttons
            Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                // Solid yellow MASUK button
                Container(
                  decoration: BoxDecoration(
                    boxShadow: [
                      BoxShadow(
                        color: const Color(0x141E1B18),
                        blurRadius: 10,
                        offset: const Offset(0, 4),
                      )
                    ],
                  ),
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => const LoginScreen()),
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFFF2C94C),
                      foregroundColor: const Color(0xFF1E1B18),
                      elevation: 0,
                      padding: const EdgeInsets.symmetric(vertical: 16.0),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.zero,
                        side: const BorderSide(
                          color: Color(0xFF1E1B18),
                          width: 2.0,
                        ),
                      ),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'MASUK',
                          style: GoogleFonts.outfit(
                            fontSize: 14,
                            fontWeight: FontWeight.w800,
                            letterSpacing: 2.0,
                          ),
                        ),
                        const SizedBox(width: 8),
                        const Icon(
                          Icons.login,
                          size: 18,
                          color: Color(0xFF1E1B18),
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 16),

                // Outline BUAT AKUN BARU button
                OutlinedButton(
                  onPressed: () {
                    // Action for sign up
                  },
                  style: OutlinedButton.styleFrom(
                    foregroundColor: const Color(0xFFB59357),
                    padding: const EdgeInsets.symmetric(vertical: 16.0),
                    side: const BorderSide(
                      color: Color(0xFFEADFCF),
                      width: 1.5,
                    ),
                    shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.zero,
                    ),
                  ),
                  child: Text(
                    'BUAT AKUN BARU',
                    style: GoogleFonts.outfit(
                      fontSize: 14,
                      fontWeight: FontWeight.w800,
                      letterSpacing: 1.5,
                    ),
                  ),
                ),
              ],
            ),

            const Spacer(flex: 1),

            // Footer Decor: Icons & Progress Lines
            Column(
              children: [
                // Horizontal small dashes / indicators
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(width: 24, height: 1.5, color: const Color(0xFFE2D7C5)),
                    const SizedBox(width: 6),
                    Container(width: 24, height: 1.5, color: const Color(0xFFE2D7C5)),
                    const SizedBox(width: 6),
                    Container(width: 24, height: 1.5, color: const Color(0xFFE2D7C5)),
                  ],
                ),
                const SizedBox(height: 16),

                // Bottom row of verification icons
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: const [
                    Icon(
                      Icons.public,
                      size: 16,
                      color: Color(0xFFB0A99E),
                    ),
                    SizedBox(width: 16),
                    Icon(
                      Icons.shield_outlined,
                      size: 16,
                      color: Color(0xFFB0A99E),
                    ),
                    SizedBox(width: 16),
                    Icon(
                      Icons.verified_user_outlined,
                      size: 16,
                      color: Color(0xFFB0A99E),
                    ),
                  ],
                ),
              ],
            ),
          ],
        );
      },
    );
  }
}

import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'beranda_page.dart';
import 'daftar_scrim_page.dart';
import 'login_screen.dart';

class MainNavigationPage extends StatefulWidget {
  const MainNavigationPage({super.key});

  @override
  State<MainNavigationPage> createState() => _MainNavigationPageState();
}

class _MainNavigationPageState extends State<MainNavigationPage> {
  int _currentIndex = 0;

  // Callback to allow pages (like BerandaPage) to request tab switches
  void _changeTab(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  late final List<Widget> _pages;

  @override
  void initState() {
    super.initState();
    _pages = [
      BerandaPage(onNavigateToScrimList: () => _changeTab(1)),
      const DaftarScrimPage(),
      const _StubPage(title: 'Riwayat Scrim', icon: Icons.history),
      const _ProfilePage(),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFDF8F2),
      body: Stack(
        children: [
          // Screen content
          Padding(
            padding: const EdgeInsets.only(bottom: 90.0), // Padding to prevent navigation overlap
            child: _pages[_currentIndex],
          ),

          // Custom floating bottom navigation bar
          Positioned(
            left: 24,
            right: 24,
            bottom: 20,
            child: Container(
              height: 64,
              decoration: BoxDecoration(
                color: const Color(0xFF1E1B18),
                borderRadius: BorderRadius.circular(32),
                boxShadow: [
                  BoxShadow(
                    color: const Color(0xFF1E1B18).withAlpha(40),
                    blurRadius: 15,
                    offset: const Offset(0, 8),
                  ),
                ],
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  _buildNavItem(0, Icons.home_filled, 'Beranda'),
                  _buildNavItem(1, Icons.edit_document, 'Daftar'),
                  _buildNavItem(2, Icons.history, 'Riwayat'),
                  _buildNavItem(3, Icons.person, 'Profil'),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildNavItem(int index, IconData icon, String label) {
    final isSelected = _currentIndex == index;

    return GestureDetector(
      onTap: () {
        setState(() {
          _currentIndex = index;
        });
      },
      behavior: HitTestBehavior.opaque,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 250),
        curve: Curves.easeInOut,
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        decoration: BoxDecoration(
          color: isSelected ? Colors.white : Colors.transparent,
          borderRadius: BorderRadius.circular(20),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              icon,
              color: isSelected ? const Color(0xFF1E1B18) : Colors.white,
              size: 20,
            ),
            if (isSelected) ...[
              const SizedBox(width: 8),
              Text(
                label,
                style: TextStyle(
                  color: const Color(0xFF1E1B18),
                  fontSize: 12,
                  fontWeight: FontWeight.w800,
                  fontFamily: 'Outfit',
                ),
              ),
            ]
          ],
        ),
      ),
    );
  }
}

// Simple placeholder stub pages
class _StubPage extends StatelessWidget {
  final String title;
  final IconData icon;

  const _StubPage({required this.title, required this.icon});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(icon, size: 64, color: const Color(0xFFC4BEB5)),
          const SizedBox(height: 16),
          Text(
            title,
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: const Color(0xFF1E1B18),
              fontFamily: 'Outfit',
            ),
          ),
          const SizedBox(height: 8),
          const Text(
            'Halaman ini sedang dalam pengembangan.',
            style: TextStyle(color: Color(0xFF827D75)),
          ),
        ],
      ),
    );
  }
}

// Profile Page with Logout functionality
class _ProfilePage extends StatelessWidget {
  const _ProfilePage();

  Future<void> _handleLogout(BuildContext context) async {
    await Supabase.instance.client.auth.signOut();
    if (context.mounted) {
      Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(builder: (context) => const LoginScreen()),
        (route) => false,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final user = Supabase.instance.client.auth.currentUser;
    final displayName = user?.userMetadata?['display_name'] ?? 'Pemain Arena';
    final email = user?.email ?? 'email@arena.com';

    return Center(
      child: Padding(
        padding: const EdgeInsets.all(32.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CircleAvatar(
              radius: 48,
              backgroundColor: const Color(0xFFF2C94C),
              child: Text(
                displayName.substring(0, displayName.length >= 2 ? 2 : displayName.length).toUpperCase(),
                style: const TextStyle(
                  fontSize: 32,
                  fontWeight: FontWeight.w900,
                  color: Color(0xFF1E1B18),
                ),
              ),
            ),
            const SizedBox(height: 24),
            Text(
              displayName,
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.w900,
                color: Color(0xFF1E1B18),
                fontFamily: 'Outfit',
              ),
            ),
            const SizedBox(height: 4),
            Text(
              email,
              style: const TextStyle(
                fontSize: 14,
                color: Color(0xFF827D75),
              ),
            ),
            const SizedBox(height: 48),
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
                onPressed: () => _handleLogout(context),
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFFF2C94C),
                  foregroundColor: const Color(0xFF1E1B18),
                  elevation: 0,
                  padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 16.0),
                  shape: const RoundedRectangleBorder(
                    borderRadius: BorderRadius.zero,
                    side: BorderSide(
                      color: Color(0xFF1E1B18),
                      width: 2.0,
                    ),
                  ),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: const [
                    Text(
                      'KELUAR AKUN',
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w800,
                        letterSpacing: 1.5,
                        fontFamily: 'Outfit',
                      ),
                    ),
                    SizedBox(width: 8),
                    Icon(Icons.logout, size: 18),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import '../constants/app_colors.dart';
import '../data/mock_data.dart';
import 'saved_places_screen.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.greyLight,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.fromLTRB(20, 16, 20, 100),
          child: Column(
            children: [
              const Text('Profile',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: AppColors.green)),
              const SizedBox(height: 24),
              CircleAvatar(
                radius: 48, backgroundColor: AppColors.gold,
                child: const Text('SC',
                    style: TextStyle(fontSize: 32, fontWeight: FontWeight.w900, color: AppColors.green)),
              ),
              const SizedBox(height: 12),
              const Text('Sarah Chen',
                  style: TextStyle(fontSize: 22, fontWeight: FontWeight.w900, color: AppColors.green)),
              const SizedBox(height: 4),
              Text('sarah@example.com',
                  style: TextStyle(fontSize: 13, color: AppColors.green.withOpacity(0.5))),
              const SizedBox(height: 24),

              // Stats
              Row(
                children: [
                  _stat('12', 'Tours'),
                  _stat('45', 'Scans'),
                  _stat('8', 'Badges'),
                  _stat('3', 'Countries'),
                ],
              ),

              const SizedBox(height: 24),

              // Saved places
              _sectionTitle('My Collection'),
              _menuTile(Icons.bookmark_rounded, 'Saved Places', '12 sites', onTap: () {
                Navigator.push(context, MaterialPageRoute(builder: (_) => const SavedPlacesScreen()));
              }),
              _menuTile(Icons.history_rounded, 'Tour History', '8 tours'),
              _menuTile(Icons.favorite_rounded, 'Favorites', '5 places'),
              _menuTile(Icons.download_rounded, 'Offline Guides', '2 sites'),

              const SizedBox(height: 16),

              // Settings
              _sectionTitle('Settings'),
              _menuTile(Icons.language_rounded, 'Language', 'English'),
              _menuTile(Icons.notifications_rounded, 'Notifications', 'On'),
              _menuTile(Icons.dark_mode_rounded, 'Theme', 'System'),
              _menuTile(Icons.location_on_rounded, 'Location Services', 'On'),

              const SizedBox(height: 16),

              _sectionTitle('Support'),
              _menuTile(Icons.help_rounded, 'Help & Support', ''),
              _menuTile(Icons.info_outline_rounded, 'About HeritageOS', 'v1.0.0'),

              const SizedBox(height: 20),
              SizedBox(
                width: double.infinity,
                child: OutlinedButton(
                  onPressed: () {},
                  style: OutlinedButton.styleFrom(
                    side: const BorderSide(color: Color(0xFFE53935)),
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                  ),
                  child: const Text('Sign Out',
                      style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Color(0xFFE53935))),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _stat(String value, String label) {
    return Expanded(
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 4),
        padding: const EdgeInsets.symmetric(vertical: 14),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(14),
          boxShadow: [BoxShadow(color: AppColors.green.withOpacity(0.06), blurRadius: 8)],
        ),
        child: Column(
          children: [
            Text(value,
                style: const TextStyle(fontSize: 20, fontWeight: FontWeight.w900, color: AppColors.green)),
            const SizedBox(height: 2),
            Text(label,
                style: TextStyle(fontSize: 11, color: AppColors.green.withOpacity(0.44))),
          ],
        ),
      ),
    );
  }

  Widget _sectionTitle(String title) {
    return Align(
      alignment: Alignment.centerLeft,
      child: Padding(
        padding: const EdgeInsets.only(bottom: 10),
        child: Text(title,
            style: const TextStyle(fontSize: 13, fontWeight: FontWeight.bold, color: AppColors.green)),
      ),
    );
  }

  Widget _menuTile(IconData icon, String title, String trailing, {VoidCallback? onTap}) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.only(bottom: 8),
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(14),
          boxShadow: [BoxShadow(color: AppColors.green.withOpacity(0.04), blurRadius: 6)],
        ),
        child: Row(
          children: [
            Icon(icon, size: 20, color: AppColors.green),
            const SizedBox(width: 14),
            Expanded(
                child: Text(title,
                    style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w500, color: AppColors.green))),
            if (trailing.isNotEmpty)
              Text(trailing,
                  style: TextStyle(fontSize: 12, color: AppColors.green.withOpacity(0.44))),
            const SizedBox(width: 4),
            Icon(Icons.chevron_right_rounded, size: 20, color: AppColors.green.withOpacity(0.25)),
          ],
        ),
      ),
    );
  }
}

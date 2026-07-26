import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../constants/app_colors.dart';
import '../providers/auth_provider.dart';
import '../providers/heritage_provider.dart';
import '../models/place_model.dart';
import '../screens/ai_guide_screen.dart';
import '../screens/qr_screen.dart';
import '../screens/profile_screen.dart';
import '../screens/heritage_directory_screen.dart';
import '../screens/heritage_place_screen.dart';
import '../screens/map_screen.dart';
import '../screens/quiz_screen.dart';
import '../screens/tickets_screen.dart';
import '../screens/tour_screen.dart';
import '../widgets/status_bar.dart';
import '../widgets/bottom_nav.dart';

class HomeScreen extends ConsumerStatefulWidget {
  const HomeScreen({super.key});
  @override
  ConsumerState<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends ConsumerState<HomeScreen> {
  int _navIdx = 0;

  final _categories = const [
    Category(icon: '🏛️', label: 'Museums', count: 12),
    Category(icon: '⛪', label: 'Churches', count: 28),
    Category(icon: '🗿', label: 'Ruins', count: 18),
    Category(icon: '⛰️', label: 'Parks', count: 9),
    Category(icon: '🏰', label: 'Castles', count: 6),
  ];

  final _events = const [
    Event(title: 'Adwa Victory Day Commemoration', venue: 'Adwa Memorial, Addis', date: 'Mar 1', time: '9:00 AM'),
    Event(title: 'Timkat Festival Guide', venue: 'Gondar · Fasilides Bath', date: 'Jan 19', time: '6:00 AM'),
    Event(title: 'Lalibela Pilgrimage Walk', venue: 'Rock Churches', date: 'Sep 12', time: '7:00 AM'),
  ];

  @override
  Widget build(BuildContext context) {
    final screens = [
      _buildHomeContent(),
      const HeritageDirectoryScreen(),
      const AIGuideScreen(),
      const QRScreen(),
      const ProfileScreen(),
    ];

    return Scaffold(
      backgroundColor: AppColors.greyLight,
      body: screens[_navIdx],
      bottomNavigationBar: BottomNav(
        currentIndex: _navIdx,
        onTap: (i) => setState(() => _navIdx = i),
      ),
    );
  }

  Widget _buildHomeContent() {
    final authUser = ref.watch(authStateProvider).value;
    final userProfile = ref.watch(userProfileProvider);
    final featuredPlaces = ref.watch(featuredPlacesProvider);

    final userName = userProfile.value?.name ?? authUser?.displayName ?? 'Guest';
    final initials = userName.isNotEmpty
        ? userName.split(' ').map((n) => n[0]).take(2).join().toUpperCase()
        : '??';

    return Column(
      children: [
        Container(
          color: AppColors.green,
          child: Column(
            children: [
              const CustomStatusBar(light: true),
              Padding(
                padding: const EdgeInsets.fromLTRB(20, 0, 20, 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('Selam ☀️',
                                style: TextStyle(fontSize: 12, fontWeight: FontWeight.w600, color: AppColors.gold)),
                            const SizedBox(height: 2),
                            Text(userName,
                                style: const TextStyle(fontSize: 22, fontWeight: FontWeight.w900, color: Colors.white)),
                          ],
                        ),
                        Row(
                          children: [
                            GestureDetector(
                              onTap: () => Navigator.push(
                                  context, MaterialPageRoute(builder: (_) => const TicketsScreen())),
                              child: Stack(
                                children: [
                                  const Icon(Icons.notifications_outlined, color: Colors.white, size: 24),
                                  Positioned(
                                    top: -2, right: -2,
                                    child: Container(
                                      width: 16, height: 16,
                                      decoration: BoxDecoration(color: AppColors.gold, borderRadius: BorderRadius.circular(8)),
                                      child: const Center(
                                          child: Text('3',
                                              style: TextStyle(fontSize: 9, fontWeight: FontWeight.bold, color: AppColors.green))),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            const SizedBox(width: 12),
                            CircleAvatar(
                              radius: 20,
                              backgroundColor: AppColors.gold,
                              backgroundImage: authUser?.photoURL != null
                                  ? NetworkImage(authUser!.photoURL!)
                                  : null,
                              child: authUser?.photoURL == null
                                  ? Text(initials,
                                      style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w900, color: AppColors.green))
                                  : null,
                            ),
                          ],
                        ),
                      ],
                    ),
                    const SizedBox(height: 16),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
                      decoration: BoxDecoration(
                          color: Colors.white.withOpacity(0.12), borderRadius: BorderRadius.circular(18)),
                      child: Row(
                        children: [
                          Icon(Icons.search, color: Colors.white.withOpacity(0.65), size: 18),
                          const SizedBox(width: 10),
                          Text('Search Lalibela, Axum, Adwa…',
                              style: TextStyle(fontSize: 14, color: Colors.white.withOpacity(0.55))),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),

        Expanded(
          child: SingleChildScrollView(
            padding: const EdgeInsets.only(bottom: 80),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _sectionHeader('Featured Heritage Sites', 'See all'),
                SizedBox(
                  height: 200,
                  child: featuredPlaces.when(
                    data: (places) => places.isEmpty
                        ? const Center(child: Text('No featured places'))
                        : ListView.builder(
                            scrollDirection: Axis.horizontal,
                            padding: const EdgeInsets.symmetric(horizontal: 20),
                            itemCount: places.length,
                            itemBuilder: (_, i) {
                              final place = places[i];
                              return GestureDetector(
                                onTap: () => Navigator.push(
                                    context, MaterialPageRoute(builder: (_) => HeritagePlaceScreen(place: place))),
                                child: Container(
                                  width: 200,
                                  margin: const EdgeInsets.only(right: 16),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(20),
                                    boxShadow: [BoxShadow(color: AppColors.green.withOpacity(0.1), blurRadius: 12)],
                                  ),
                                  child: Stack(
                                    children: [
                                      ClipRRect(
                                        borderRadius: BorderRadius.circular(20),
                                        child: SizedBox(
                                          width: 200, height: 200,
                                          child: Image.network(place.imageUrl, fit: BoxFit.cover,
                                              errorBuilder: (_, __, ___) => Container(color: AppColors.sand)),
                                        ),
                                      ),
                                      Container(
                                        height: 200,
                                        decoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(20),
                                          gradient: LinearGradient(
                                            begin: Alignment.topCenter, end: Alignment.bottomCenter,
                                            colors: [Colors.transparent, Colors.black.withOpacity(0.7)],
                                          ),
                                        ),
                                      ),
                                      Positioned(
                                        top: 12, left: 12,
                                        child: Container(
                                          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                                          decoration: BoxDecoration(color: AppColors.gold, borderRadius: BorderRadius.circular(8)),
                                          child: Text(place.category,
                                              style: const TextStyle(fontSize: 9, fontWeight: FontWeight.bold, color: AppColors.green)),
                                        ),
                                      ),
                                      Positioned(
                                        top: 12, right: 12,
                                        child: Row(
                                          children: [
                                            const Icon(Icons.star, size: 11, color: AppColors.gold),
                                            const SizedBox(width: 3),
                                            Text('${place.rating}',
                                                style: const TextStyle(fontSize: 11, fontWeight: FontWeight.bold, color: Colors.white)),
                                          ],
                                        ),
                                      ),
                                      Positioned(
                                        bottom: 16, left: 16, right: 16,
                                        child: Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            Text(place.name,
                                                style: const TextStyle(fontSize: 15, fontWeight: FontWeight.bold, color: Colors.white)),
                                            const SizedBox(height: 4),
                                            Row(
                                              children: [
                                                const Icon(Icons.location_on, size: 10, color: AppColors.gold),
                                                const SizedBox(width: 4),
                                                Text('${place.city}, ${place.country}',
                                                    style: const TextStyle(fontSize: 11, color: Colors.white70)),
                                              ],
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              );
                            },
                          ),
                    loading: () => const Center(child: CircularProgressIndicator()),
                    error: (e, _) => Center(child: Text('Error: $e')),
                  ),
                ),

                const SizedBox(height: 20),

                _sectionHeader('Categories', 'See all'),
                SizedBox(
                  height: 90,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    itemCount: _categories.length,
                    itemBuilder: (_, i) => _categoryItem(_categories[i]),
                  ),
                ),

                const SizedBox(height: 20),

                _sectionHeader('Quick Actions', ''),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: GridView.count(
                    crossAxisCount: 2,
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    crossAxisSpacing: 12,
                    mainAxisSpacing: 12,
                    childAspectRatio: 1.7,
                    children: [
                      _quickAction('Heritage Map', 'Explore sites', Icons.map_rounded, AppColors.green,
                          iconBg: AppColors.gold, textCol: Colors.white,
                          onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const MapScreen()))),
                      _quickAction('Daily Quiz', '5 questions', Icons.emoji_events_rounded, AppColors.sand,
                          iconBg: AppColors.gold, textCol: AppColors.green,
                          onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const QuizScreen()))),
                      _quickAction('My Tickets', '2 upcoming', Icons.confirmation_num_rounded, AppColors.sand,
                          iconBg: AppColors.green, textCol: AppColors.green,
                          onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const TicketsScreen()))),
                      _quickAction('Plan a Tour', 'AI powered', Icons.auto_awesome_rounded, AppColors.sand,
                          iconBg: AppColors.green, textCol: AppColors.green,
                          onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const TourScreen()))),
                    ],
                  ),
                ),

                const SizedBox(height: 20),

                _sectionHeader('Upcoming Events', 'See all'),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Column(
                    children: _events.map((e) => _eventCard(e)).toList(),
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _sectionHeader(String title, String action) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 0, 20, 12),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(title,
              style: const TextStyle(fontSize: 15, fontWeight: FontWeight.bold, color: AppColors.green)),
          if (action.isNotEmpty)
            Text(action,
                style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w600, color: AppColors.gold)),
        ],
      ),
    );
  }

  Widget _categoryItem(Category cat) {
    return GestureDetector(
      onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const HeritageDirectoryScreen())),
      child: Container(
        width: 66,
        margin: const EdgeInsets.only(right: 16),
        child: Column(
          children: [
            Container(
              width: 54, height: 54,
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(18),
                  boxShadow: [BoxShadow(color: AppColors.green.withOpacity(0.08), blurRadius: 10)]),
              child: Center(child: Text(cat.icon, style: const TextStyle(fontSize: 22))),
            ),
            const SizedBox(height: 8),
            Text(cat.label,
                style: const TextStyle(fontSize: 11, fontWeight: FontWeight.w600, color: AppColors.green)),
            Text('${cat.count}',
                style: TextStyle(fontSize: 10, color: AppColors.green.withOpacity(0.33))),
          ],
        ),
      ),
    );
  }

  Widget _quickAction(String label, String sub, IconData icon, Color bg,
      {required Color iconBg, required Color textCol, required VoidCallback onTap}) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(14),
        decoration: BoxDecoration(color: bg, borderRadius: BorderRadius.circular(18)),
        child: Row(
          children: [
            Container(
              width: 40, height: 40,
              decoration: BoxDecoration(color: iconBg, borderRadius: BorderRadius.circular(13)),
              child: Icon(icon, size: 18, color: iconBg == AppColors.gold ? AppColors.green : AppColors.gold),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(label,
                      style: TextStyle(fontSize: 13, fontWeight: FontWeight.bold, color: textCol)),
                  Text(sub,
                      style: TextStyle(fontSize: 11, color: textCol.withOpacity(0.44))),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _eventCard(Event event) {
    final parts = event.date.split(' ');
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(18),
        boxShadow: [BoxShadow(color: AppColors.green.withOpacity(0.07), blurRadius: 8, offset: const Offset(0, 2))],
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
            decoration: BoxDecoration(color: AppColors.sand, borderRadius: BorderRadius.circular(14)),
            child: Column(
              children: [
                Text(parts[0].toUpperCase(),
                    style: const TextStyle(fontSize: 10, fontWeight: FontWeight.bold, color: AppColors.gold)),
                Text(parts[1],
                    style: const TextStyle(fontSize: 19, fontWeight: FontWeight.w900, color: AppColors.green)),
              ],
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(event.title,
                    style: const TextStyle(fontSize: 13, fontWeight: FontWeight.bold, color: AppColors.green)),
                const SizedBox(height: 4),
                Text('${event.venue} · ${event.time}',
                    style: TextStyle(fontSize: 11, color: AppColors.green.withOpacity(0.41))),
              ],
            ),
          ),
          Icon(Icons.chevron_right, color: AppColors.green.withOpacity(0.22)),
        ],
      ),
    );
  }
}

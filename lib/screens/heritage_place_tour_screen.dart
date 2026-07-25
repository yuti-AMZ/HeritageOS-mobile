import 'package:flutter/material.dart';
import '../constants/app_colors.dart';
import '../models/heritage_place.dart';

class HeritagePlaceTourScreen extends StatefulWidget {
  final HeritagePlace place;
  const HeritagePlaceTourScreen({super.key, required this.place});
  @override
  State<HeritagePlaceTourScreen> createState() => _HeritagePlaceTourScreenState();
}

class _HeritagePlaceTourScreenState extends State<HeritagePlaceTourScreen> {
  int _selectedDuration = 30;
  final List<String> _selectedInterests = ['History', 'Architecture'];
  bool _tourGenerated = false;

  final _durations = [15, 30, 60];
  final _interests = ['History', 'Architecture', 'Culture', 'Art', 'Science', 'Nature'];

  void _generateTour() {
    setState(() => _tourGenerated = true);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: _tourGenerated ? _buildGeneratedTour() : _buildPreferences(),
    );
  }

  Widget _buildPreferences() {
    return Column(
      children: [
        Container(
          color: AppColors.green,
          child: SafeArea(
            bottom: false,
            child: Padding(
              padding: const EdgeInsets.fromLTRB(20, 0, 20, 20),
              child: Row(
                children: [
                  GestureDetector(
                    onTap: () => Navigator.pop(context),
                    child: Container(
                      width: 36, height: 36,
                      decoration: BoxDecoration(color: Colors.white24, borderRadius: BorderRadius.circular(18)),
                      child: const Icon(Icons.arrow_back_ios_new_rounded, color: Colors.white, size: 16),
                    ),
                  ),
                  const SizedBox(width: 12),
                  const Expanded(
                    child: Text('Personalized Tour',
                        style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white)),
                  ),
                ],
              ),
            ),
          ),
        ),
        Expanded(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Duration
                const Text('Available Time',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: AppColors.green)),
                const SizedBox(height: 4),
                Text('How much time do you have?',
                    style: TextStyle(fontSize: 13, color: AppColors.green.withOpacity(0.5))),
                const SizedBox(height: 12),
                Row(
                  children: _durations.map((d) {
                    final active = _selectedDuration == d;
                    return Expanded(
                      child: GestureDetector(
                        onTap: () => setState(() => _selectedDuration = d),
                        child: Container(
                          margin: const EdgeInsets.symmetric(horizontal: 4),
                          padding: const EdgeInsets.symmetric(vertical: 16),
                          decoration: BoxDecoration(
                            color: active ? AppColors.green : AppColors.sand,
                            borderRadius: BorderRadius.circular(14),
                          ),
                          child: Column(
                            children: [
                              Text('${d}',
                                  style: TextStyle(
                                      fontSize: 28,
                                      fontWeight: FontWeight.w900,
                                      color: active ? Colors.white : AppColors.green)),
                              Text('min',
                                  style: TextStyle(
                                      fontSize: 12,
                                      color: active ? Colors.white70 : AppColors.green.withOpacity(0.5))),
                            ],
                          ),
                        ),
                      ),
                    );
                  }).toList(),
                ),

                const SizedBox(height: 28),

                // Interests
                const Text('Your Interests',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: AppColors.green)),
                const SizedBox(height: 4),
                Text('Select what interests you most',
                    style: TextStyle(fontSize: 13, color: AppColors.green.withOpacity(0.5))),
                const SizedBox(height: 12),
                Wrap(
                  spacing: 8, runSpacing: 8,
                  children: _interests.map((interest) {
                    final active = _selectedInterests.contains(interest);
                    return GestureDetector(
                      onTap: () {
                        setState(() {
                          if (active) {
                            _selectedInterests.remove(interest);
                          } else {
                            _selectedInterests.add(interest);
                          }
                        });
                      },
                      child: AnimatedContainer(
                        duration: const Duration(milliseconds: 200),
                        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                        decoration: BoxDecoration(
                          color: active ? AppColors.gold : AppColors.sand,
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Text(interest,
                            style: TextStyle(
                                fontSize: 13,
                                fontWeight: FontWeight.w600,
                                color: active ? AppColors.green : AppColors.green.withOpacity(0.6))),
                      ),
                    );
                  }).toList(),
                ),

                const SizedBox(height: 32),

                // Generate button
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton.icon(
                    onPressed: _selectedInterests.isNotEmpty ? _generateTour : null,
                    icon: const Icon(Icons.auto_awesome, size: 18),
                    label: const Text('Generate Tour'),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.gold,
                      foregroundColor: AppColors.green,
                      disabledBackgroundColor: AppColors.gold.withOpacity(0.4),
                      padding: const EdgeInsets.symmetric(vertical: 18),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(18)),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildGeneratedTour() {
    final stops = widget.place.exhibits.take(_selectedDuration ~/ 10).toList();
    return Column(
      children: [
        Container(
          color: AppColors.green,
          child: SafeArea(
            bottom: false,
            child: Padding(
              padding: const EdgeInsets.fromLTRB(20, 0, 20, 20),
              child: Column(
                children: [
                  Row(
                    children: [
                      GestureDetector(
                        onTap: () => setState(() => _tourGenerated = false),
                        child: Container(
                          width: 36, height: 36,
                          decoration: BoxDecoration(color: Colors.white24, borderRadius: BorderRadius.circular(18)),
                          child: const Icon(Icons.arrow_back_ios_new_rounded, color: Colors.white, size: 16),
                        ),
                      ),
                      const SizedBox(width: 12),
                      const Expanded(
                        child: Text('Your Tour',
                            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white)),
                      ),
                    ],
                  ),
                  const SizedBox(height: 12),
                  Container(
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(color: AppColors.gold, borderRadius: BorderRadius.circular(12)),
                    child: Row(
                      children: [
                        const Icon(Icons.auto_awesome, size: 16, color: AppColors.green),
                        const SizedBox(width: 8),
                        Expanded(
                          child: Text(
                              'AI has curated a ${_selectedDuration}-min tour based on: ${_selectedInterests.join(", ")}',
                              style: const TextStyle(fontSize: 12, color: AppColors.green)),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
        Expanded(
          child: ListView.builder(
            padding: const EdgeInsets.all(20),
            itemCount: stops.length,
            itemBuilder: (_, i) {
              final exhibit = stops[i];
              return Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Column(
                    children: [
                      Container(
                        width: 32, height: 32,
                        decoration: BoxDecoration(color: AppColors.gold, borderRadius: BorderRadius.circular(16)),
                        child: Center(
                            child: Text('${i + 1}',
                                style: const TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: AppColors.green))),
                      ),
                      if (i < stops.length - 1) Container(width: 2, height: 60, color: AppColors.gold.withOpacity(0.25)),
                    ],
                  ),
                  const SizedBox(width: 14),
                  Expanded(
                    child: Container(
                      margin: const EdgeInsets.only(bottom: 12),
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(14),
                        boxShadow: [BoxShadow(color: AppColors.green.withOpacity(0.06), blurRadius: 8)],
                      ),
                      child: Row(
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadius.circular(10),
                            child: SizedBox(
                              width: 60, height: 60,
                              child: Image.network(exhibit.imageUrl, fit: BoxFit.cover,
                                  errorBuilder: (_, __, ___) => Container(color: AppColors.sand)),
                            ),
                          ),
                          const SizedBox(width: 12),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(exhibit.name,
                                    style: const TextStyle(fontSize: 13, fontWeight: FontWeight.bold, color: AppColors.green)),
                                const SizedBox(height: 2),
                                Text(exhibit.category,
                                    style: TextStyle(fontSize: 11, color: AppColors.green.withOpacity(0.5))),
                              ],
                            ),
                          ),
                          const Icon(Icons.chevron_right, color: AppColors.green, size: 18),
                        ],
                      ),
                    ),
                  ),
                ],
              );
            },
          ),
        ),
        Padding(
          padding: const EdgeInsets.fromLTRB(20, 0, 20, 32),
          child: SizedBox(
            width: double.infinity,
            child: ElevatedButton.icon(
              onPressed: () {},
              icon: const Icon(Icons.play_arrow_rounded),
              label: const Text('Start Tour'),
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.green,
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(vertical: 18),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(18)),
              ),
            ),
          ),
        ),
      ],
    );
  }
}

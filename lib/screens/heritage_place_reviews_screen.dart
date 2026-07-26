import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../constants/app_colors.dart';
import '../models/heritage_place.dart';
import '../models/review_model.dart';
import '../providers/heritage_provider.dart';

class HeritagePlaceReviewsScreen extends ConsumerStatefulWidget {
  final HeritagePlace place;
  const HeritagePlaceReviewsScreen({super.key, required this.place});

  @override
  ConsumerState<HeritagePlaceReviewsScreen> createState() => _HeritagePlaceReviewsScreenState();
}

class _HeritagePlaceReviewsScreenState extends ConsumerState<HeritagePlaceReviewsScreen> {
  double _newRating = 5.0;
  final _textController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final reviewsAsync = ref.watch(reviewsProvider(widget.place.id));

    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
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
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text('Reviews',
                              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white)),
                          const SizedBox(height: 2),
                          Text('${widget.place.rating} · ${widget.place.reviewCount} reviews',
                              style: const TextStyle(fontSize: 12, color: Colors.white60)),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          Expanded(
            child: reviewsAsync.when(
              data: (reviews) => reviews.isEmpty
                  ? Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(Icons.reviews_rounded, size: 48, color: AppColors.green.withOpacity(0.3)),
                          const SizedBox(height: 12),
                          Text('No reviews yet',
                              style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600, color: AppColors.green.withOpacity(0.5))),
                          const SizedBox(height: 8),
                          Text('Be the first to write a review!',
                              style: TextStyle(fontSize: 13, color: AppColors.green.withOpacity(0.4))),
                        ],
                      ),
                    )
                  : ListView.builder(
                      padding: const EdgeInsets.all(20),
                      itemCount: reviews.length,
                      itemBuilder: (_, i) => _reviewCard(reviews[i]),
                    ),
              loading: () => const Center(child: CircularProgressIndicator()),
              error: (e, _) => Center(child: Text('Error: $e')),
            ),
          ),
          Container(
            padding: const EdgeInsets.fromLTRB(16, 8, 16, 24),
            color: Colors.white,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
              decoration: BoxDecoration(color: AppColors.sand, borderRadius: BorderRadius.circular(22)),
              child: Row(
                children: [
                  Expanded(
                    child: TextField(
                      controller: _textController,
                      style: const TextStyle(fontSize: 13, color: AppColors.green),
                      decoration: InputDecoration(
                        hintText: 'Write a review...',
                        hintStyle: TextStyle(fontSize: 13, color: AppColors.green.withOpacity(0.35)),
                        border: InputBorder.none,
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      if (_textController.text.trim().isNotEmpty) {
                        ref.read(reviewNotifierProvider.notifier).addReview(
                          placeId: widget.place.id,
                          userId: 'demo-user',
                          userName: 'Heritage Explorer',
                          rating: _newRating,
                          text: _textController.text.trim(),
                        );
                        _textController.clear();
                      }
                    },
                    child: Container(
                      width: 38, height: 38,
                      decoration: BoxDecoration(
                        color: _textController.text.trim().isNotEmpty ? AppColors.gold : AppColors.sand,
                        borderRadius: BorderRadius.circular(19),
                      ),
                      child: Icon(Icons.send_rounded, size: 16,
                          color: AppColors.green.withOpacity(_textController.text.trim().isNotEmpty ? 1 : 0.4)),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _reviewCard(Review review) {
    final initials = review.userName.split(' ').map((n) => n[0]).take(2).join().toUpperCase();

    return Container(
      margin: const EdgeInsets.only(bottom: 14),
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: AppColors.sand,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              CircleAvatar(
                radius: 18,
                backgroundColor: AppColors.gold,
                child: Text(initials,
                    style: const TextStyle(fontSize: 13, fontWeight: FontWeight.bold, color: AppColors.green)),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(review.userName,
                        style: const TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: AppColors.green)),
                    Text(_formatDate(review.date),
                        style: TextStyle(fontSize: 11, color: AppColors.green.withOpacity(0.45))),
                  ],
                ),
              ),
              Row(
                children: List.generate(5, (j) => Icon(
                    j < review.rating.round() ? Icons.star_rounded : Icons.star_border_rounded,
                    size: 14, color: AppColors.gold)),
              ),
            ],
          ),
          const SizedBox(height: 10),
          Text(review.text,
              style: TextStyle(fontSize: 13, height: 1.5, color: AppColors.green.withOpacity(0.7))),
          if (review.tip != null) ...[
            const SizedBox(height: 8),
            Container(
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: AppColors.gold.withOpacity(0.1),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Row(
                children: [
                  const Icon(Icons.lightbulb_rounded, size: 14, color: AppColors.gold),
                  const SizedBox(width: 6),
                  Expanded(
                    child: Text('Tip: ${review.tip}',
                        style: const TextStyle(fontSize: 12, color: AppColors.gold)),
                  ),
                ],
              ),
            ),
          ],
        ],
      ),
    );
  }

  String _formatDate(DateTime date) {
    final months = ['Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun', 'Jul', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec'];
    return '${months[date.month - 1]} ${date.day}, ${date.year}';
  }
}

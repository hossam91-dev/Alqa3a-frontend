import 'package:alqa3a/core/constants/gaps.dart';
import 'package:alqa3a/core/theme/app_colors.dart';
import 'package:alqa3a/core/widgets/app_text.dart';
import 'package:flutter/material.dart';

class ProfileStatsCard extends StatelessWidget {
  final int bookingsCount;
  final int favoriteHallsCount;
  final int ratingsCount;

  const ProfileStatsCard({
    super.key,
    required this.bookingsCount,
    required this.favoriteHallsCount,
    required this.ratingsCount,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: AppGaps.g16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.03),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          _buildStatItem('حجوزاتي', bookingsCount),
          _buildDivider(),
          _buildStatItem('القاعات المفضلة', favoriteHallsCount),
          _buildDivider(),
          _buildStatItem('التقييمات', ratingsCount),
        ],
      ),
    );
  }

  Widget _buildStatItem(String label, int value) {
    return Column(
      children: [
        AppText.title(value.toString(), color: AppColors.primary, fontSize: 18),
        AppText.body(label, color: AppColors.textLight, fontSize: 12),
      ],
    );
  }

  Widget _buildDivider() {
    return Container(
      height: 30,
      width: 1,
      color: AppColors.border,
    );
  }
}

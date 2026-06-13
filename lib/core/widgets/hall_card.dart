import 'package:alqa3a/core/constants/app_strings.dart';
import 'package:alqa3a/core/constants/gaps.dart';
import 'package:alqa3a/core/constants/svg_icons.dart';
import 'package:alqa3a/core/theme/app_colors.dart';
import 'package:alqa3a/core/widgets/app_button.dart';
import 'package:alqa3a/core/widgets/app_text.dart';
import 'package:alqa3a/core/widgets/custom_network_image.dart';
import 'package:alqa3a/core/widgets/save_hall_button.dart';
import 'package:alqa3a/core/interfaces/hall_saveable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gap/gap.dart';

class HallCard extends StatelessWidget {
  final HallSaveable hall;
  final VoidCallback? onBookPressed;
  final VoidCallback? onDetailsPressed;

  const HallCard({
    super.key,
    required this.hall,
    this.onBookPressed,
    this.onDetailsPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: AppColors.border),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Stack(
            children: [
              CustomNetworkImage(
                imageUrl: hall.coverImageUrl ?? '',
                width: double.infinity,
                height: MediaQuery.sizeOf(context).height * 0.25,
                topLeft: 20,
                topRight: 20,
              ),
              Positioned(
                top: 10,
                right: 10,
                child: SaveHallButton(
                  hallId: hall.id,
                  hall: hall,
                ),
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    AppText.title(hall.name),
                    Row(
                      children: [
                        SvgPicture.asset(
                          SvgIcons.star,
                          width: 16,
                          colorFilter: const ColorFilter.mode(
                            AppColors.primary,
                            BlendMode.srcIn,
                          ),
                        ),
                        const Gap(AppGaps.g4),
                        AppText.headline(
                          hall.avgRating.toString(),
                          fontSize: 14,
                          color: AppColors.primary,
                        ),
                      ],
                    ),
                  ],
                ),
                const Gap(AppGaps.g8),
                Row(
                  children: [
                    SvgPicture.asset(SvgIcons.map, width: 14),
                    const Gap(AppGaps.g6),
                    AppText.body(
                      hall.address,
                      fontSize: 12,
                      color: AppColors.textMuted,
                    ),
                  ],
                ),
                const Gap(AppGaps.g12),
                Row(
                  children: [
                    _buildInfoItem(
                      SvgIcons.users,
                      '${AppStrings.capacityUpTo350} ${hall.capacity}',
                    ),
                    const Gap(AppGaps.g16),
                    _buildInfoItem(
                      SvgIcons.money,
                      '${AppStrings.priceStartsFrom}${hall.pricePerEvent.toInt()} ج.م',
                    ),
                  ],
                ),
                const Gap(AppGaps.g16),
                const Divider(height: 1),
                const Gap(AppGaps.g16),
                Row(
                  children: [
                    Expanded(
                      flex: 2,
                      child: AppButton(
                        text: AppStrings.bookNow,
                        onPressed: onBookPressed ?? () {},
                        height: 40,
                      ),
                    ),
                    const Gap(AppGaps.g12),
                    Expanded(
                      child: AppButton.outlined(
                        text: AppStrings.details,
                        onPressed: onDetailsPressed ?? () {},
                        height: 40,
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

  Widget _buildInfoItem(String icon, String label) {
    return Row(
      children: [
        SvgPicture.asset(
          icon,
          width: 14,
          colorFilter:
              const ColorFilter.mode(AppColors.textMuted, BlendMode.srcIn),
        ),
        const Gap(AppGaps.g6),
        AppText.body(label, fontSize: 12, color: AppColors.textMuted),
      ],
    );
  }
}

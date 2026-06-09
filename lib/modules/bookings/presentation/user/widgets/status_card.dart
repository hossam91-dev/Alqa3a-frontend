import 'package:alqa3a/core/constants/app_strings.dart';
import 'package:alqa3a/core/constants/svg_icons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gap/gap.dart';

import '../../../../../core/constants/gaps.dart';
import '../../../../../core/theme/app_colors.dart';
import '../../../../../core/widgets/app_text.dart';
import '../../../domain/entities/booking_entity.dart';

class StatusCard extends StatelessWidget {
  final BookingEntity booking;
  const StatusCard({super.key, required this.booking});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(AppGaps.g16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withAlpha(30),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    AppText.title(
                      booking.status.label,
                      color: booking.status.color,
                      fontWeight: FontWeight.bold,
                    ),
                    const Gap(AppGaps.g8),
                    Icon(Icons.circle, size: 8, color: booking.status.color),
                  ],
                ),
                const Gap(AppGaps.g8),
                 AppText.body(
                  getBookingStatusLabel(booking.status),
                  fontSize: 12,
                  color: AppColors.textMuted,
                ),
              ],
            ),
          ),
          const Gap(AppGaps.g12),
          Container(
            padding: const EdgeInsets.all(AppGaps.g8),
            decoration: BoxDecoration(
              color: booking.status.colorCard,
              shape: BoxShape.circle,
            ),
            child: SvgPicture.asset(
              SvgIcons.menuHorizontal,
              colorFilter: ColorFilter.mode(
                booking.status.color,
                BlendMode.srcIn,
              ),
            ),
          ),
        ],
      ),
    );
  }

  String getBookingStatusLabel(BookingStatus status) {
    switch(status){

      case BookingStatus.pending:
        return AppStrings.ownerReviewingRequest;
      case BookingStatus.confirmed:
       return 'تم قبول طلب الحجز';
      case BookingStatus.rejected:
       return 'هذه الحجز مرفوض';
      case BookingStatus.cancelled:
        return 'هذه الحجز ملغي';
      case BookingStatus.completed:
       return 'هذا الحجز مكتمل';
    }
  }
}

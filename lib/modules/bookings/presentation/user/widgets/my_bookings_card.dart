import 'package:alqa3a/core/router/app_router.dart';
import 'package:alqa3a/modules/bookings/domain/entities/booking_entity.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';

import '../../../../../core/constants/gaps.dart';
import '../../../../../core/constants/svg_icons.dart';
import '../../../../../core/theme/app_colors.dart';
import '../../../../../core/utils/helpers/date_format_helper.dart';
import '../../../../../core/widgets/app_button.dart';
import '../../../../../core/widgets/app_text.dart';
import 'cancel_booking_button.dart';

class MyBookingsCard extends StatelessWidget {
  final BookingEntity booking;
  final void Function() onBookingDetails;
  const MyBookingsCard({
    super.key,
    required this.booking,
    required this.onBookingDetails,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(AppGaps.g10),
        child: Column(
          spacing: AppGaps.g10,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                AppText.headline(booking.hall.name),
                AppText.headline(
                  '${booking.totalPrice.toString()}ج.م',
                  color: AppColors.primary,
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    SvgPicture.asset(SvgIcons.booking, width: 15),
                    AppText.title(DateFormatHelper.fullDate(booking.eventDate)),
                  ],
                ),

                Container(
                  padding: EdgeInsets.symmetric(
                    horizontal: AppGaps.g8,
                    vertical: AppGaps.g8,
                  ),
                  decoration: BoxDecoration(
                    color: booking.status.colorCard,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: AppText.body(
                    booking.status.label,
                    color: booking.status.color,
                  ),
                ),
              ],
            ),
            Divider(),
            Row(
              spacing: AppGaps.g8,
              children: [
                Expanded(
                  child: AppButton(
                    text: 'تفاصيل الحجز',
                    onPressed: () {
                      context.push(AppRoutes.bookingDetailsPath(booking.id));
                    },
                    height: 35,
                  ),
                ),
                booking.status.isCancelled==true?SizedBox.shrink():
                Expanded(
                  child: CancelBookingButton(bookingId: booking.id)
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

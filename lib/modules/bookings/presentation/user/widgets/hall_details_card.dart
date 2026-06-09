import 'package:alqa3a/core/constants/app_strings.dart';
import 'package:alqa3a/modules/bookings/domain/entities/booking_entity.dart';
import 'package:alqa3a/modules/bookings/presentation/user/widgets/detail_row.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

import '../../../../../core/constants/gaps.dart';
import '../../../../../core/constants/svg_icons.dart';
import '../../../../../core/theme/app_colors.dart';
import '../../../../../core/utils/helpers/date_format_helper.dart';
import '../../../../../core/widgets/app_text.dart';
import '../../../../../core/widgets/custom_network_image.dart';

class HallDetailsCard extends StatelessWidget {
  final BookingEntity booking;
  const HallDetailsCard({super.key, required this.booking});

  @override
  Widget build(BuildContext context) {
    return Container(
      clipBehavior: Clip.antiAlias,
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
      child: Column(
        children: [
          Stack(
            children: [
              CustomNetworkImage(
                imageUrl: booking.hall.coverImageUrl ?? '',
                height: MediaQuery.sizeOf(context).height * 0.27,
                width: double.infinity,
              ),
              Positioned(
                bottom: 12,
                right: 12,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    AppText.title(
                      booking.hall.name,
                    ),
                    AppText.body(
                      booking.hall.address,
                    ),
                  ],
                ),
              ),
            ],
          ),

          Padding(
            padding: const EdgeInsets.all(AppGaps.g16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const AppText.title(AppStrings.bookingDetails),
                const Gap(AppGaps.g16),
                DetailRow(
                 icon:  SvgIcons.booking,
                label:   AppStrings.date,
                 value:  DateFormatHelper.fullDate(booking.eventDate),
                ),
                const Gap(AppGaps.g12),
                DetailRow(
                icon:   SvgIcons.users,
                 label:  AppStrings.gustCount,
                value:   '${booking.guestsCount} شخص',
                ),
                const Gap(AppGaps.g12),
                DetailRow(
                icon:   SvgIcons.money,
                label:   AppStrings.totalPrice,
                value:   '${booking.totalPrice} ر.س',
                ),

              ],
            ),
          ),
        ],
      ),
    );
  }
}

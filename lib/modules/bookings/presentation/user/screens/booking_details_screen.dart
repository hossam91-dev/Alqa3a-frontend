import 'package:alqa3a/core/constants/app_padding.dart';
import 'package:alqa3a/core/constants/app_strings.dart';
import 'package:alqa3a/core/constants/gaps.dart';
import 'package:alqa3a/core/constants/svg_icons.dart';
import 'package:alqa3a/core/router/app_router.dart';
import 'package:alqa3a/core/theme/app_colors.dart';
import 'package:alqa3a/core/utils/helpers/date_format_helper.dart';
import 'package:alqa3a/core/widgets/app_button.dart';
import 'package:alqa3a/core/widgets/app_text.dart';
import 'package:alqa3a/core/widgets/back_button.dart';
import 'package:alqa3a/core/widgets/custom_loading_indicator.dart';
import 'package:alqa3a/core/widgets/custom_network_image.dart';
import 'package:alqa3a/core/widgets/error_screen.dart';
import 'package:alqa3a/modules/bookings/domain/entities/booking_entity.dart';
import 'package:alqa3a/modules/bookings/presentation/cubit/cubit.dart';
import 'package:alqa3a/modules/bookings/presentation/cubit/state.dart';
import 'package:alqa3a/modules/bookings/presentation/user/widgets/booking_success_message.dart';
import 'package:alqa3a/modules/bookings/presentation/user/widgets/hall_details_card.dart';
import 'package:alqa3a/modules/bookings/presentation/user/widgets/help_section.dart';
import 'package:alqa3a/modules/bookings/presentation/user/widgets/status_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';

class BookingDetailsScreen extends StatelessWidget {
  final String bookingId;
  const BookingDetailsScreen({super.key, required this.bookingId});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const AppText.headline(AppStrings.bookingStatus),
        leading: const CustomBackButton(),
      ),
      body: BlocBuilder<BookingsCubit, BookingsState>(
        builder: (context, state) {
          if (state is BookingDetailsLoading) {
            return const Center(
              child: CustomLoading(),
            );
          }
          if (state is BookingError) {
            return ErrorScreen(message: state.message);
          }
          if (state is BookingDetailsLoaded) {
            return SingleChildScrollView(
              padding: EdgeInsets.symmetric(
                horizontal: AppPadding.baseHorizontal,
                vertical: AppPadding.baseVertical,
              ),
              child: Column(
                children: [
                  const BookingSuccessMessage(),
                  const Gap(AppGaps.g16),
                  const AppText.headline(
                    AppStrings.bookingRequestSuccess,
                    fontWeight: FontWeight.bold,
                  ),
                  const Gap(AppGaps.g8),
                  AppText.body(
                    AppStrings.bookingStatusHint,
                    color: AppColors.textMuted,
                    textAlign: TextAlign.center,
                  ),
                  const Gap(AppGaps.g32),

                  StatusCard(booking: state.booking),
                  const Gap(AppGaps.g24),

                  HallDetailsCard(booking: state.booking),
                  const Gap(AppGaps.g24),

                  const HelpSection(),
                  const Gap(AppGaps.g24),

                  AppButton(
                    text: AppStrings.bookings,
                    onPressed: () => context.pop(),
                  ),
                  const Gap(AppGaps.g12),
                  AppButton.outlined(
                    text: AppStrings.backToHome,
                    onPressed: () => context.go(AppRoutes.home),
                  ),
                ],
              ),
            );
          }
          return const SizedBox.shrink();
        },
      ),
    );
  }
}

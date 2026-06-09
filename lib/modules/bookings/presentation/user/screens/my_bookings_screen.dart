import 'package:alqa3a/core/constants/app_strings.dart';
import 'package:alqa3a/core/constants/svg_icons.dart';
import 'package:alqa3a/core/utils/app_toast.dart';
import 'package:alqa3a/core/utils/helpers/date_format_helper.dart';
import 'package:alqa3a/core/widgets/app_button.dart';
import 'package:alqa3a/core/widgets/app_text.dart';
import 'package:alqa3a/core/widgets/custom_loading_indicator.dart';
import 'package:alqa3a/core/widgets/empty_screen.dart';
import 'package:alqa3a/modules/bookings/presentation/user/widgets/my_bookings_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gap/gap.dart';

import '../../../../../core/constants/app_padding.dart';
import '../../../../../core/constants/gaps.dart';
import '../../../../../core/theme/app_colors.dart';
import '../../../../../core/widgets/error_screen.dart';
import '../../cubit/cubit.dart';
import '../../cubit/state.dart';

class MyBookingsScreen extends StatelessWidget {
  const MyBookingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: AppPadding.baseHorizontal,
          vertical: AppPadding.baseVertical,
        ),
        child: BlocConsumer<BookingsCubit, BookingsState>(
          listener: (context, state) {
            if (state is BookingCancelledError) {
              AppToast.show(
                context,
                message: state.message,
                type: ToastType.error,
                position: ToastPosition.top,
              );
            }
            if (state is BookingCancelled) {
              AppToast.show(
                context,
                message: 'تم الغاء الحجز',
                type: ToastType.success,
                position: ToastPosition.top,
              );
              context.read<BookingsCubit>().getMyBookings();
            }
          },
          builder: (context, state) {
            if (state is BookingsLoading) {
              return const Center(
                child: CustomLoadingIndicator(petalColor: AppColors.primary),
              );
            }
            if (state is BookingsError) {
              return ErrorScreen(message: state.message);
            }
            if (state is BookingsLoaded ||
                state is BookingCancelledLoading ||
                state is BookingCancelled ||
                state is BookingCancelledError) {
              if (state.bookings.isEmpty) {
                return Center(
                  child: EmptyScreen(
                    message: 'لايوجد لديك حجوزات',
                    icon: SvgIcons.ticketX,
                    title: 'قائمة الحجوزات فارغه',
                  ),
                );
              }
              return ListView.separated(
                itemCount: state.bookings.length,
                separatorBuilder: (context, index) => const Gap(AppGaps.g20),
                itemBuilder: (context, index) {
                  final booking = state.bookings[index];
                  return MyBookingsCard(
                    booking: booking,
                    onBookingDetails: () {},
                  );
                },
              );
            }
            return SizedBox.shrink();
          },
        ),
      ),
    );
  }
}

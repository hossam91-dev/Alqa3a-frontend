import 'package:alqa3a/core/widgets/custom_loading_indicator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../core/theme/app_colors.dart';
import '../../../../../core/widgets/app_button.dart';
import '../../cubit/cubit.dart';
import '../../cubit/state.dart';

class CancelBookingButton extends StatelessWidget {
  final String bookingId;

  const CancelBookingButton({
    super.key,
    required this.bookingId,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<BookingsCubit, BookingsState>(
      builder: (context, state) {
        final isLoading = state is BookingCancelledLoading &&
            state.id == bookingId;

        return isLoading
            ? const Center(child: CustomLoading(
        ))
            : AppButton.outlined(
          text: 'إلغاء الحجز',
          onPressed: () {
            context.read<BookingsCubit>().cancelBooking(bookingId);
          },
          height: 35,
        );
      },
    );
  }
}
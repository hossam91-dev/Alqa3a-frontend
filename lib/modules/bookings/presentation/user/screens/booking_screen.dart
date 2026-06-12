import 'package:alqa3a/core/constants/app_padding.dart';
import 'package:alqa3a/core/constants/app_strings.dart';
import 'package:alqa3a/core/constants/svg_icons.dart';
import 'package:alqa3a/core/router/app_router.dart';
import 'package:alqa3a/core/theme/app_colors.dart';
import 'package:alqa3a/core/utils/app_toast.dart';
import 'package:alqa3a/core/widgets/app_button.dart';
import 'package:alqa3a/core/widgets/app_text.dart';
import 'package:alqa3a/core/widgets/app_text_field.dart';
import 'package:alqa3a/core/widgets/back_button.dart';
import 'package:alqa3a/core/widgets/custom_loading_indicator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';

import '../../../../../core/constants/gaps.dart';
import '../../cubit/cubit.dart';
import '../../cubit/state.dart';
import '../widgets/booking_date_selector.dart';
import '../widgets/guest_counter.dart';
import '../widgets/payment_methods_selector.dart';

class BookingScreen extends StatefulWidget {
  final String hallId;

  const BookingScreen({super.key, required this.hallId});

  @override
  State<BookingScreen> createState() => _BookingScreenState();
}

class _BookingScreenState extends State<BookingScreen> {
  late final TextEditingController _notesController;
  DateTime _selectedDate = DateTime.now();
  int _guestCount = 1;
  int _selectedPaymentIndex = 0;

  @override
  void initState() {
    super.initState();
    _notesController = TextEditingController();
  }

  @override
  void dispose() {
    _notesController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: AppText.title(AppStrings.bookingSubmit, fontSize: 18),
        centerTitle: true,
        leading: const CustomBackButton()
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.symmetric(
            horizontal: AppPadding.baseHorizontal,
            vertical: AppPadding.baseVertical,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildSectionTitle(AppStrings.bookingDate),
              Gap(AppGaps.g16),
              BookingDateSelector(
                initialDate: _selectedDate,
                onDateChanged: (date) => _selectedDate = date,
              ),
              Gap(AppGaps.g32),
              _buildSectionTitle(AppStrings.gustCount),
              Gap(AppGaps.g16),
              GuestCounter(
                initialCount: _guestCount,
                onChanged: (value) => _guestCount = value,
              ),
              Gap(AppGaps.g32),
              _buildSectionTitle(AppStrings.additionalNotes),
              Gap(AppGaps.g16),
              AppTextField(
                controller: _notesController,
                hint: AppStrings.additionalNotesHint,
                prefixIconPath: SvgIcons.notes,
              ),
              Gap(AppGaps.g32),
              _buildSectionTitle(AppStrings.paymentMethod),
              Gap(AppGaps.g16),
              PaymentMethodsSelector(
                initialIndex: _selectedPaymentIndex,
                onSelect: (index) => _selectedPaymentIndex = index,
              ),
              Gap(AppGaps.g48),
              BlocConsumer<BookingsCubit, BookingsState>(
                listener: (context, state) {
                  if (state is BookingCreated) {
                    AppToast.show(
                      context,
                      message: 'تم الحجز بنجاح',
                      type: ToastType.success,
                      position: ToastPosition.top,
                    );
                    context.go(AppRoutes.myBookings);
                  }
                  if (state is BookingError) {
                    AppToast.show(
                      context,
                      message: state.message,
                      type: ToastType.error,
                      position: ToastPosition.top,
                    );
                  }
                },
                builder: (context, state) {
                  if (state is BookingCreating) {
                    return const Center(
                      child: CustomLoading(
                      ),
                    );
                  }
                  return AppButton(
                    onPressed: () {
                      context.read<BookingsCubit>().createBooking(
                            hallId: widget.hallId,
                            eventDate: _selectedDate.toIso8601String(),
                            guestsCount: _guestCount,
                            notes: _notesController.text,
                          );
                    },
                    text: AppStrings.bookingSubmit,
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSectionTitle(String title) {
    return AppText.title(title, fontWeight: FontWeight.bold);
  }
}

import 'package:alqa3a/core/constants/app_padding.dart';
import 'package:alqa3a/core/constants/app_strings.dart';
import 'package:alqa3a/core/constants/gaps.dart';
import 'package:alqa3a/core/constants/svg_icons.dart';
import 'package:alqa3a/core/router/app_router.dart';
import 'package:alqa3a/core/theme/app_colors.dart';
import 'package:alqa3a/core/utils/app_toast.dart';
import 'package:alqa3a/core/widgets/app_button.dart';
import 'package:alqa3a/core/widgets/app_text.dart';
import 'package:alqa3a/core/widgets/app_text_field.dart';
import 'package:alqa3a/core/widgets/back_button.dart';
import 'package:alqa3a/core/widgets/custom_loading_indicator.dart';
import 'package:alqa3a/modules/bookings/presentation/user/widgets/booking_date_selector.dart';
import 'package:alqa3a/modules/bookings/presentation/user/widgets/guest_counter.dart';
import 'package:alqa3a/modules/smart_match/presentation/cubit/cubit.dart';
import 'package:alqa3a/modules/smart_match/presentation/cubit/state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';

class SmartMatchScreen extends StatefulWidget {
  const SmartMatchScreen({super.key});

  @override
  State<SmartMatchScreen> createState() => _SmartMatchScreenState();
}

class _SmartMatchScreenState extends State<SmartMatchScreen> {
  DateTime _selectedDate = DateTime.now();
  int _guestsCount = 0;
  final TextEditingController _budgetMin = TextEditingController();
  final TextEditingController _budgetMax = TextEditingController();
  final TextEditingController _location = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: AppText.title(AppStrings.smartMatch, fontSize: 20),
        leading: const CustomBackButton(),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: AppPadding.baseHorizontal,
          vertical: AppPadding.baseVertical,
        ),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Align(
                alignment: AlignmentDirectional.topCenter,
                child: AppText.displayLarge(
                  AppStrings.findThePerfectHall,
                  textAlign: TextAlign.center,
                ),
              ),
              Gap(AppGaps.g16),
              AppText.title(
                AppStrings.smartMatchHint,
                textAlign: TextAlign.center,
              ),
              Gap(AppGaps.g36),
              AppText.body(AppStrings.area),
              Gap(AppGaps.g10),
              AppTextField(
                controller: _location,
                prefixIconPath: SvgIcons.map,
                hint: 'اختر المنطقة (مثلاً: المعادي)',
              ),
              Gap(AppGaps.g24),
              AppText.body(AppStrings.dateOfTheParty),
              Gap(AppGaps.g10),
              BookingDateSelector(
                initialDate: _selectedDate,
                onDateChanged: (date) {
                  _selectedDate = date;
                },
              ),
              Gap(AppGaps.g24),
              AppText.body(AppStrings.gustCount),
              Gap(AppGaps.g10),
              GuestCounter(
                onChanged: (count) {
                  _guestsCount = count;
                },
              ),
              Gap(AppGaps.g24),
              AppText.body(AppStrings.expectedBudget),
              Gap(AppGaps.g10),
              Row(
                spacing: AppGaps.g20,
                children: [
                  Expanded(
                    child: AppTextField(
                      keyboardType: TextInputType.number,
                      prefixIconPath: '',
                      hint: AppStrings.from,
                      controller: _budgetMin,
                    ),
                  ),
                  Expanded(
                    child: AppTextField(
                      keyboardType: TextInputType.number,
                      prefixIconPath: '',
                      hint: AppStrings.to,
                      controller: _budgetMax,
                    ),
                  ),
                ],
              ),
              Gap(AppGaps.g36),
              BlocConsumer<SmartMatchCubit, SmartMatchState>(
                listener: (context, state) {
                  if (state is SmartMatchError) {
                    AppToast.show(
                      context,
                      message: state.message,
                      type: ToastType.error,
                      position: ToastPosition.top,
                    );
                  }
                  if(state is SmartMatchEmpty){
                    AppToast.show(
                      context,
                      message: 'لا توجد قاعات مطابقه',
                      type: ToastType.info,
                      position: ToastPosition.top,
                    );
                  }
                  if(state is SmartMatchLoaded){
                    context.push(AppRoutes.smartMatchResults,extra: state.results);
                  }
                },
                builder: (context, state) {
                  if (state is SmartMatchLoading) {
                    return const Center(
                      child: CustomLoadingIndicator(
                        petalColor: AppColors.primary,
                      ),
                    );
                  }
                  return AppButton(text: 'بدء البحث ', onPressed: () {
                    context.read<SmartMatchCubit>().match(
                      region: _location.text,
                      guestsCount: _guestsCount,
                       eventDate: _selectedDate.toIso8601String(),
                       budgetMax: double.tryParse(_budgetMax.text)??0.0,
                       budgetMin: double.tryParse(_budgetMin.text)??0.0,
                    );

                  });
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}

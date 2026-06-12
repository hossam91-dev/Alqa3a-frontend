import 'package:alqa3a/core/constants/gaps.dart';
import 'package:alqa3a/core/constants/svg_icons.dart';
import 'package:alqa3a/core/theme/app_colors.dart';
import 'package:alqa3a/core/widgets/app_text.dart';
import 'package:alqa3a/core/widgets/back_button.dart';
import 'package:alqa3a/core/widgets/custom_loading_indicator.dart';
import 'package:alqa3a/core/widgets/error_screen.dart';
import 'package:alqa3a/core/widgets/save_hall_button.dart';
import 'package:alqa3a/modules/halls/presentation/cubit/cubit.dart';
import 'package:alqa3a/modules/halls/presentation/cubit/state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../widgets/hall_details/hall_bottom_bar.dart';
import '../widgets/hall_details/hall_image_header.dart';
import '../widgets/hall_details/hall_info_section.dart';
import '../widgets/hall_details/hall_rules_section.dart';
import '../widgets/hall_details/hall_services_section.dart';

class HallDetailsScreen extends StatelessWidget {
  final String hallId;

  const HallDetailsScreen({super.key, required this.hallId});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HallsCubit, HallsState>(
      builder: (context, state) {
        return Scaffold(
          bottomNavigationBar: state is HallDetailsLoaded
              ? HallBottomBar(
                  hallId: state.hall.id,
                  price: state.hall.pricePerEvent,
                )
              : null,
          body: _buildBody(context, state),
        );
      },
    );
  }

  Widget _buildBody(BuildContext context, HallsState state) {
    if (state is HallDetailsLoading) {
      return Center(child: CustomLoading());
    }
    if (state is HallDetailsError) {
      return Center(child: ErrorScreen(message: state.message));
    }
    if (state is HallDetailsLoaded) {
      final hall = state.hall;
      return CustomScrollView(
        slivers: [
          SliverToBoxAdapter(
            child: Stack(
              clipBehavior: Clip.none,
              children: [
                HallImageHeader(
                  imageUrl: hall.coverImageUrl ?? '',
                ),

                Positioned(
                  top: MediaQuery.of(context).padding.top + 10,
                  left: 10,
                  right: 10,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const CustomBackButton(),
                      SaveHallButton(
                        hall: hall,
                        hallId: hall.id,
                      ),
                    ],
                  ),
                ),
                Positioned(
                  top: 180,
                  right: 20,
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: AppGaps.g20,
                      vertical: AppGaps.g4,
                    ),
                    decoration: BoxDecoration(
                      color: AppColors.border,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Row(
                      spacing: AppGaps.g4,
                      children: [
                        SvgPicture.asset(
                          width: 15,
                          SvgIcons.star,
                          colorFilter: const ColorFilter.mode(
                            AppColors.primary,
                            BlendMode.srcIn,
                          ),
                        ),
                        AppText.body(
                          hall.avgRating.toString(),
                          color: AppColors.primary,
                        ),
                      ],
                    ),
                  ),
                ),

                Column(
                  children: [
                    const SizedBox(height: 230),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      child: Card(
                        margin: EdgeInsets.zero,
                        shape: const RoundedRectangleBorder(
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(30),
                            topRight: Radius.circular(30),
                          ),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(AppGaps.g16),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              HallInfoSection(
                                name: hall.name,
                                address: hall.address,
                                price: hall.pricePerEvent,
                                capacity: hall.capacity,
                              ),
                              HallServicesSection(amenities: hall.amenities),
                              const HallRulesSection(),
                            ],
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),
                  ],
                ),
              ],
            ),
          ),
        ],
      );
    }
    return const SizedBox.shrink();
  }
}

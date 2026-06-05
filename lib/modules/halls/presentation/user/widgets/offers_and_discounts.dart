import 'package:alqa3a/core/constants/app_strings.dart';
import 'package:alqa3a/core/constants/gaps.dart';
import 'package:alqa3a/core/constants/svg_icons.dart';
import 'package:alqa3a/core/theme/app_colors.dart';
import 'package:alqa3a/core/widgets/app_text.dart';
import 'package:alqa3a/core/widgets/custom_loading_indicator.dart';
import 'package:alqa3a/core/widgets/custom_network_image.dart';
import 'package:alqa3a/core/widgets/empty_screen.dart';
import 'package:alqa3a/modules/halls/presentation/cubit/cubit.dart';
import 'package:alqa3a/modules/halls/presentation/cubit/state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';

import 'halls_with_discounts_empty.dart';

class OffersAndDiscounts extends StatelessWidget {
  const OffersAndDiscounts({super.key});

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.sizeOf(context).height;
    final screenWidth = MediaQuery.sizeOf(context).width;

    return BlocBuilder<HallsCubit,HallsState>(
      builder: (context, state) {
        if (state is HomeLoading){
          return const  Center(child: CustomLoadingIndicator(petalColor: AppColors.primary,));

        }
        if(state is DiscountsError){
          return Center(child: AppText.title(state.message),);
        }
        if (state is HomeLoaded || state is PopularError){
          if(state.hallsWithDiscounts.isEmpty){
            return const HallsWithDiscountsEmpty();
          }
          return SizedBox(
            height: screenHeight * 0.32,
            child: ListView.separated(
              scrollDirection: Axis.horizontal,
              itemCount: state.hallsWithDiscounts.length,
              physics: const BouncingScrollPhysics(),
              separatorBuilder: (context, index) => const Gap(AppGaps.g16),
              itemBuilder: (context, index) {
                final offer = state.hallsWithDiscounts[index];
                final cardWidth = screenWidth * 0.72;
                return SizedBox(
                  width: cardWidth,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        child: Stack(
                          children: [
                            CustomNetworkImage(
                              width: cardWidth,
                              height: double.infinity,
                              imageUrl:offer.coverImageUrl??'',
                              topLeft: 20,
                              topRight: 20,
                              bottomLeft: 20,
                              bottomRight: 20,
                            ),
                            Positioned(
                              top: 10,
                              right: 10,
                              child: Container(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 10,
                                  vertical: 4,
                                ),
                                decoration: BoxDecoration(
                                  color: AppColors.errorBg,
                                  borderRadius: BorderRadius.circular(20),
                                ),
                                child: const AppText.title(
                                  AppStrings.savePercentage,
                                  color: AppColors.primary,
                                  fontSize: 14,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      const Gap(AppGaps.g8),
                      AppText.title(
                        offer.name,
                        fontSize: 16,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                            child: AppText.body(
                              offer.address,
                              fontSize: 14,
                              color: AppColors.textMuted,
                            ),
                          ),
                           AppText.headline(
                            offer.pricePerEvent.toString(),
                            color: AppColors.primary,
                            fontSize: 16,
                          ),
                        ],
                      ),
                    ],
                  ),
                );
              },
            ),
          );
        }
        return SizedBox.shrink();
      }

    );
  }
}

import 'package:alqa3a/core/constants/app_strings.dart';
import 'package:alqa3a/core/constants/gaps.dart';
import 'package:alqa3a/core/constants/svg_icons.dart';
import 'package:alqa3a/core/widgets/empty_screen.dart';
import 'package:alqa3a/core/widgets/error_screen.dart';
import 'package:alqa3a/modules/halls/presentation/cubit/cubit.dart';
import 'package:alqa3a/core/widgets/hall_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../core/theme/app_colors.dart';
import '../../../../../core/widgets/app_text.dart';
import '../../../../../core/widgets/custom_loading_indicator.dart';
import '../../cubit/state.dart';

class MostPopularHalls extends StatelessWidget {

  const MostPopularHalls({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HallsCubit, HallsState>(
      builder: (context, state){
        if (state is HomeLoading){
          return const SliverFillRemaining(
            hasScrollBody: false,
            child: Center(child: CustomLoadingIndicator(petalColor: AppColors.primary,)),
          );
        }
        if(state is PopularError){
          return SliverFillRemaining(
            hasScrollBody: false,
            child: Center(child: ErrorScreen(message: state.message,)),
          );
        }
        if (state is HomeLoaded){
          if(state.popularHalls.isEmpty){
            return SliverFillRemaining(
                hasScrollBody: false,
                child: Center(child: EmptyScreen(
                    message: AppStrings.popularHallsFullyBooked,
                    icon: SvgIcons.starOff,
                    title: AppStrings.noHallsFound
                )));
          }
          return SliverList(
            delegate: SliverChildBuilderDelegate(
              childCount: state.popularHalls.length,
                  (context, index) {
                final hall = state.popularHalls[index];
                return Padding(
                  padding: const EdgeInsets.only(bottom: AppGaps.g16),
                  child: HallCard(
                    hall: hall,
                    onBookPressed: () {},
                    onDetailsPressed: () {},
                    onFavoritePressed: () {},
                  ),
                );
              },
            ),
          );
        }
        return const SliverToBoxAdapter(child: SizedBox.shrink());

      },

    );
  }
}

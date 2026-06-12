import 'package:alqa3a/core/constants/app_padding.dart';
import 'package:alqa3a/core/constants/app_strings.dart';
import 'package:alqa3a/core/constants/gaps.dart';
import 'package:alqa3a/core/widgets/app_text.dart';
import 'package:alqa3a/core/widgets/custom_loading_indicator.dart';
import 'package:alqa3a/modules/halls/domain/entities/hall_entity.dart';
import 'package:alqa3a/modules/halls/presentation/cubit/state.dart';
import 'package:alqa3a/modules/halls/presentation/user/widgets/explor_hall.dart';
import 'package:alqa3a/modules/halls/presentation/user/widgets/most_popular_halls.dart';
import 'package:alqa3a/modules/halls/presentation/user/widgets/offers_and_discounts.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';

import '../../cubit/cubit.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.symmetric(
          vertical: AppGaps.g20,
          horizontal: AppPadding.baseHorizontal,
        ),
        child: RefreshIndicator(
          onRefresh: () async {
            context.read<HallsCubit>().getHomeData();
          },
          child: BlocBuilder<HallsCubit,HallsState>(
            builder: (context,state){
              if(state is HomeLoading){
                return Center(child: CustomLoading(),);
              }
              return CustomScrollView(
                slivers: [
                  const SliverToBoxAdapter(
                    child: ExplorHall(),
                  ),
                  const SliverToBoxAdapter(
                    child: Gap(AppGaps.g36),
                  ),
                  SliverToBoxAdapter(
                    child: AppText.title(AppStrings.offersAndDiscounts),
                  ),
                  const SliverToBoxAdapter(
                    child: Gap(AppGaps.g20),
                  ),
                  const SliverToBoxAdapter(
                    child: OffersAndDiscounts(),
                  ),
                  const SliverToBoxAdapter(
                    child: Gap(AppGaps.g36),
                  ),
                  SliverToBoxAdapter(
                    child: AppText.title(AppStrings.mostPopularHalls),
                  ),
                  const SliverToBoxAdapter(
                    child: Gap(AppGaps.g20),
                  ),
                  const MostPopularHalls(),
                ],
              );
            },

          ),
        ),
      ),
    );
  }
}

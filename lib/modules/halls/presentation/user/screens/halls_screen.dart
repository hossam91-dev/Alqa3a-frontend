import 'dart:ffi';

import 'package:alqa3a/core/constants/app_padding.dart';
import 'package:alqa3a/core/constants/svg_icons.dart';
import 'package:alqa3a/core/widgets/custom_loading_indicator.dart';
import 'package:alqa3a/core/widgets/empty_screen.dart';
import 'package:alqa3a/core/widgets/hall_card.dart';
import 'package:alqa3a/modules/halls/domain/entities/hall_entity.dart';
import 'package:alqa3a/modules/halls/presentation/cubit/cubit.dart';
import 'package:alqa3a/modules/halls/presentation/cubit/state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../widgets/halls_search_bar.dart';
import 'package:gap/gap.dart';

import '../../../../../core/constants/gaps.dart';
import '../../../../../core/theme/app_colors.dart';
import '../../../../../core/widgets/error_screen.dart';

class HallsScreen extends StatefulWidget {
  const HallsScreen({super.key});

  @override
  State<HallsScreen> createState() => _HallsScreenState();
}

class _HallsScreenState extends State<HallsScreen> {
  final searchController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: AppPadding.baseHorizontal,
          vertical: AppGaps.g20,
        ),
        child: RefreshIndicator(
          onRefresh: () async {
            context.read<HallsCubit>().getHalls();
          },
          child: CustomScrollView(
            slivers: [
              SliverToBoxAdapter(
                child: HallsSearchBar(controller: searchController),
              ),
              const SliverToBoxAdapter(child: Gap(AppGaps.g20)),
              BlocBuilder<HallsCubit, HallsState>(
                buildWhen: (previous, current) =>
                    current is HallsLoading ||
                    current is HallsLoaded ||
                    current is HallsError,
                builder: (context, state) {
                  if (state is HallsLoading) {
                    return const SliverFillRemaining(
                      hasScrollBody: false,
                      child: Center(
                        child: CustomLoadingIndicator(
                          petalColor: AppColors.primary,
                        ),
                      ),
                    );
                  }
                  if (state is HallsError) {
                    return SliverFillRemaining(
                      hasScrollBody: false,
                      child: Center(child: ErrorScreen(message: state.message)),
                    );
                  }
                  if (state is HallsLoaded) {
                    if (state.halls.isEmpty) {
                      return const SliverFillRemaining(
                        hasScrollBody: false,
                        child: Center(
                          child: EmptyScreen(
                            message: 'لا توجد قاعات متاحه الان',
                            icon: SvgIcons.boxOpen,
                            title: 'المكان هادئ',
                          ),
                        ),
                      );
                    }
                    // استخدام SliverList مباشرة داخل CustomScrollView
                    return SliverList.separated(
                      itemCount: state.halls.length,
                      separatorBuilder: (context, index) =>
                          const Gap(AppGaps.g20),
                      itemBuilder: (context, index) {
                        final hall = state.halls[index];
                        return HallCard(hall: hall);
                      },
                    );
                  }
                  return const SliverToBoxAdapter(child: SizedBox.shrink());
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}

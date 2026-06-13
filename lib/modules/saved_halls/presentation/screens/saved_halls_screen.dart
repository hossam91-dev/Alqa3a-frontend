import 'package:alqa3a/core/constants/app_padding.dart';
import 'package:alqa3a/core/constants/gaps.dart';
import 'package:alqa3a/core/constants/svg_icons.dart';
import 'package:alqa3a/core/widgets/app_text.dart';
import 'package:alqa3a/core/widgets/back_button.dart';
import 'package:alqa3a/core/widgets/custom_loading_indicator.dart';
import 'package:alqa3a/core/widgets/empty_screen.dart';
import 'package:alqa3a/core/widgets/error_screen.dart';
import 'package:alqa3a/core/widgets/hall_card.dart';
import 'package:alqa3a/modules/saved_halls/presentation/cubit/cubit.dart';
import 'package:alqa3a/modules/saved_halls/presentation/cubit/state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/router/app_router.dart';

class SavedHallsScreen extends StatelessWidget {
  const SavedHallsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const AppText.title('القاعات المفضلة',fontSize: 20,),
        leading: const CustomBackButton(),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: AppPadding.baseHorizontal,
          vertical: AppPadding.baseVertical,
        ),
        child: BlocBuilder<SavedHallsCubit, SavedHallsState>(
          builder: (context, state) {
            if (state is SavedHallsLoading) {
              return const Center(child: CustomLoading());
            }
            if (state is SavedHallsError) {
              return Center(child: ErrorScreen(message: state.message));
            }
            if (state is SavedHallsLoaded) {
              if(state.savedHalls.isEmpty){
                return EmptyScreen(
                    message: 'لا توجد قاعات محفوظه',
                    icon: SvgIcons.boxOpen,
                    title: 'المفضله فارغه'
                );
              }
              return ListView.separated(
                itemCount: state.savedHalls.length,
                separatorBuilder: (context, index) => Gap(AppGaps.g16),
                itemBuilder: (context, index) {
                  return HallCard(
                    hall: state.savedHalls[index].hall,
                    onDetailsPressed: () => context.push(
                      AppRoutes.hallDetailsPath(
                        state.savedHalls[index].hall.id,
                      ),
                    ),
                    onBookPressed: () => context.push(
                      AppRoutes.bookingPath(state.savedHalls[index].hall.id),
                    ),
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

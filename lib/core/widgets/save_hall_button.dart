import 'package:alqa3a/core/interfaces/hall_saveable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../modules/saved_halls/presentation/cubit/cubit.dart';
import '../../modules/saved_halls/presentation/cubit/state.dart';
import '../../../../core/theme/app_colors.dart';

class SaveHallButton extends StatelessWidget {
  final String hallId;
  final HallSaveable hall;
  final double size;
  final Color? activeColor;

  const SaveHallButton({
    super.key,
    required this.hallId,
    this.size = 20,
    this.activeColor, required this.hall,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SavedHallsCubit, SavedHallsState>(
      builder: (context, state) {
        final isSaved = context.read<SavedHallsCubit>().isSaved(hallId);

        return GestureDetector(
          onTap: () => context.read<SavedHallsCubit>().toggleSave(hallId,hall),
          child: Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: AppColors.white.withAlpha(150),
              borderRadius: BorderRadius.circular(14),
            ),
            child: AnimatedSwitcher(
              duration: const Duration(milliseconds: 200),
              child: Icon(
                isSaved ? Icons.favorite : Icons.favorite_border,
                key: ValueKey(isSaved),
                size: size,
                color: isSaved
                    ? (activeColor ?? AppColors.error)
                    : AppColors.textLight,
              ),
            ),
          ),
        );
      },
    );
  }
}

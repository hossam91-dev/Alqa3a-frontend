import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../../../../../core/constants/gaps.dart';
import '../../../../../core/constants/svg_icons.dart';
import '../../../../../core/theme/app_colors.dart';
import '../../cubit/cubit.dart';

class HallsSearchBar extends StatefulWidget {
  final TextEditingController controller;
  
  const HallsSearchBar({
    super.key,
    required this.controller,
  });

  @override
  State<HallsSearchBar> createState() => _HallsSearchBarState();
}

class _HallsSearchBarState extends State<HallsSearchBar> {
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: widget.controller,
      decoration: InputDecoration(
        hintText: 'ابحث عن قاعه,منطقه,سعر',
        prefixIcon: Padding(
          padding: const EdgeInsets.all(AppGaps.g10),
          child: SvgPicture.asset(
            SvgIcons.search,
            colorFilter: const ColorFilter.mode(
              AppColors.primary,
              BlendMode.srcIn,
            ),
          ),
        ),
      ),
      onChanged: (value) {
        context.read<HallsCubit>().searchHalls(value);
      },
    );
  }
}

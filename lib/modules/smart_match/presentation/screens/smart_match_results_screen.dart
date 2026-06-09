import 'package:alqa3a/core/constants/app_padding.dart';
import 'package:alqa3a/core/constants/app_strings.dart';
import 'package:alqa3a/core/constants/gaps.dart';
import 'package:alqa3a/core/constants/svg_icons.dart';
import 'package:alqa3a/core/router/app_router.dart';
import 'package:alqa3a/core/theme/app_colors.dart';
import 'package:alqa3a/core/widgets/app_button.dart';
import 'package:alqa3a/core/widgets/app_text.dart';
import 'package:alqa3a/core/widgets/back_button.dart';
import 'package:alqa3a/core/widgets/custom_network_image.dart';
import 'package:alqa3a/modules/smart_match/domain/entities/smart_match_result_entity.dart';
import 'package:alqa3a/modules/smart_match/presentation/widgets/smart_match_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';

class SmartMatchResultsScreen extends StatelessWidget {
  final List<SmartMatchResultEntity> results;

  const SmartMatchResultsScreen({super.key, required this.results});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const AppText.title(AppStrings.smartMatchingResults, fontSize: 20),
        leading: const CustomBackButton(),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: AppPadding.baseHorizontal,
          vertical: AppPadding.baseVertical,
        ),
        child: ListView.separated(
          itemCount: results.length,
          separatorBuilder: (context, index) => Gap(AppGaps.g16),
          itemBuilder: (context, index) {
            final result = results[index];
            return SmartMatchCard(result: result);
          },
        ),
      ),
    );
  }
}

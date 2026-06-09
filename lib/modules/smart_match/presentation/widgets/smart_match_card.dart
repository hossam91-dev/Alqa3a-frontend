import 'package:alqa3a/modules/smart_match/domain/entities/smart_match_result_entity.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/constants/app_strings.dart';
import '../../../../core/constants/gaps.dart';
import '../../../../core/constants/svg_icons.dart';
import '../../../../core/router/app_router.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/widgets/app_button.dart';
import '../../../../core/widgets/app_text.dart';
import '../../../../core/widgets/custom_network_image.dart';

class SmartMatchCard extends StatelessWidget {
  final SmartMatchResultEntity result;
  final void Function()? onDetailsTap;
  const SmartMatchCard({super.key, required this.result, this.onDetailsTap});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 0.5,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
      child: Column(
        spacing: AppGaps.g10,
        children: [
          Stack(
            children: [
              CustomNetworkImage(
                imageUrl: result.coverImage ?? '',
                width: double.infinity,
                height: MediaQuery.sizeOf(context).height * 0.27,
                topRight: 20,
                topLeft: 20,
              ),
              Positioned(
                top: AppGaps.g12,
                right: AppGaps.g12,
                child: GestureDetector(
                  onTap:onDetailsTap ,
                  child: SvgPicture.asset(SvgIcons.favorite,colorFilter: ColorFilter.mode(
                    AppColors.error,
                    BlendMode.srcIn,
                  ),),
                ),
              ),
              Positioned(
                top: AppGaps.g12,
                left: AppGaps.g12,
                child: Container(
                  padding: EdgeInsets.symmetric(
                    horizontal: AppGaps.g16,
                    vertical: AppGaps.g4,
                  ),
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    color: AppColors.white,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Row(
                    spacing: AppGaps.g4,
                    children: [
                      SvgPicture.asset(
                        SvgIcons.star,
                        height: 15,
                        colorFilter: ColorFilter.mode(
                          AppColors.warning,
                          BlendMode.srcIn,
                        ),
                      ),
                      AppText.title(result.avgRating.toString()),
                    ],
                  ),
                ),
              ),
            ],
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: AppGaps.g16),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                AppText.headline(result.name),
                AppText.headline(
                  '${result.pricePerEvent} ج.م',
                  color: AppColors.primary,
                ),
              ],
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: AppGaps.g16),
            child: Row(
              children: [
                SvgPicture.asset(SvgIcons.map, height: 15),
                Gap(AppGaps.g4),
                AppText.body(result.address),
              ],
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: AppGaps.g16),
            child: Divider(),
          ),
          Padding(
            padding: EdgeInsets.symmetric(
              horizontal: AppGaps.g16,
              vertical: AppGaps.g8,
            ),
            child: Row(
              spacing: AppGaps.g20,
              children: [
                Row(
                  children: [
                    SvgPicture.asset(SvgIcons.users, height: 15),
                    Gap(AppGaps.g4),
                    AppText.body('${result.capacity}فرد'),
                  ],
                ),
                Expanded(
                  child: AppButton.outlined(
                    text: AppStrings.details,
                    onPressed: () {
                      context.push(
                        AppRoutes.hallDetailsPath(result.id),
                      );
                    },
                    textColor: AppColors.primary,
                    height: 35,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

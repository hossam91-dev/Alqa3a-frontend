import 'package:alqa3a/core/constants/gaps.dart';
import 'package:alqa3a/core/widgets/app_text.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

import '../../../../domain/entities/hall_entity.dart';

class HallServicesSection extends StatelessWidget {
  final AmenityEntity amenities;

  const HallServicesSection({super.key, required this.amenities});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Gap(AppGaps.g16),
        Divider(),
        Gap(AppGaps.g16),
        AppText.title('الخدمات والمرافق'),
        Gap(AppGaps.g16),
        // if (amenities.parking)
        const ServiceItem(value: 'جراج خاص'),
        // if (amenities.catering)
        const ServiceItem(value: 'بوفيه'),
        // if (amenities.music)
        const ServiceItem(value: 'دي جي'),
        // if (amenities.accommodation)
        const ServiceItem(value: 'اقامه للعروسين'),
        // if (amenities.photography)
        const ServiceItem(value: 'تصوير'),
        // if (amenities.ac)
        const ServiceItem(value: 'تكييف'),
      ],
    );
  }
}

class ServiceItem extends StatelessWidget {
  final String value;
  const ServiceItem({super.key, required this.value});

  @override
  Widget build(BuildContext context) {
    return AppText.headline(value);
  }
}

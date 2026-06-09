import 'package:alqa3a/core/constants/app_strings.dart';
import 'package:alqa3a/core/theme/app_colors.dart';
import 'package:alqa3a/core/widgets/app_text.dart';
import 'package:flutter/material.dart';

class GuestCounter extends StatefulWidget {
  final int initialCount;
  final ValueChanged<int> onChanged;

  const GuestCounter({
    super.key,
    this.initialCount = 250,
    required this.onChanged,
  });

  @override
  State<GuestCounter> createState() => _GuestCounterState();
}

class _GuestCounterState extends State<GuestCounter> {
  late int _count;
  late List<int> _guestOptions;

  @override
  void initState() {
    super.initState();
    _count = widget.initialCount;
    _guestOptions = List.generate(
      ((1000 - 250) ~/ 50) + 1,
      (index) => 250 + (index * 50),
    );
    // Ensure initialCount is in the options, if not, we could add it or fallback
    if (!_guestOptions.contains(_count)) {
      _count = 250;
    }
  }

  void _updateCount(int? newValue) {
    if (newValue != null) {
      setState(() {
        _count = newValue;
      });
      widget.onChanged(_count);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: AppColors.border),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const AppText.body(AppStrings.expectedGustCount),
          DropdownButton<int>(
            value: _count,
            icon: const Icon(Icons.keyboard_arrow_down, color: AppColors.primary),
            underline: const SizedBox(),
            elevation: 1,
            style: const TextStyle(color: AppColors.textDark, fontSize: 16),
            onChanged: _updateCount,
            items: _guestOptions.map<DropdownMenuItem<int>>((int value) {
              return DropdownMenuItem<int>(
                value: value,
                child: AppText.body(value.toString()),
              );
            }).toList(),
          ),
        ],
      ),
    );
  }
}

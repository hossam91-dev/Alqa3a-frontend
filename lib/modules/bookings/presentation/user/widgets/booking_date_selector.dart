import 'package:alqa3a/core/constants/app_strings.dart';
import 'package:alqa3a/core/constants/svg_icons.dart';
import 'package:alqa3a/core/theme/app_colors.dart';
import 'package:alqa3a/core/widgets/app_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gap/gap.dart';

class BookingDateSelector extends StatefulWidget {
  final DateTime initialDate;
  final ValueChanged<DateTime> onDateChanged;

  const BookingDateSelector({
    super.key,
    required this.initialDate,
    required this.onDateChanged,
  });

  @override
  State<BookingDateSelector> createState() => _BookingDateSelectorState();
}

class _BookingDateSelectorState extends State<BookingDateSelector> {
  late DateTime _selectedDate;

  @override
  void initState() {
    super.initState();
    _selectedDate = widget.initialDate;
  }

  Future<void> _selectDate(BuildContext context) async {
    final date = await showDatePicker(
      context: context,
      initialDate: _selectedDate,
      firstDate: DateTime.now(),
      lastDate: DateTime.now().add(const Duration(days: 365)),
    );
    if (date != null) {
      setState(() {
        _selectedDate = date;
      });
      widget.onDateChanged(_selectedDate);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: AppColors.border),
      ),
      child: Row(
        children: [
          SvgPicture.asset(SvgIcons.booking, width: 24),
          const Gap(12),
          AppText.body(
            '${_selectedDate.day}/${_selectedDate.month}/${_selectedDate.year}',
            fontSize: 16,
          ),
          const Spacer(),
          TextButton(
            onPressed: () => _selectDate(context),
            child: AppText.button(
             AppStrings.changeDate,
              color: AppColors.primary,
            ),
          ),
        ],
      ),
    );
  }
}

import 'package:alqa3a/core/theme/app_colors.dart';
import 'package:alqa3a/core/widgets/app_text.dart';
import 'package:flutter/material.dart';

import '../../../../shared/auth/domain/entities/user_entity.dart';

class RoleWidget extends StatefulWidget {
  final ValueChanged<UserRole>? onRoleChanged;

  const RoleWidget({super.key, this.onRoleChanged});

  @override
  State<RoleWidget> createState() => _RoleWidgetState();
}

class _RoleWidgetState extends State<RoleWidget> {
  UserRole _selectedRole = UserRole.user;

  @override
  Widget build(BuildContext context) {
    return Row(
      spacing: 40,
      children: UserRole.values.map((role) {
        final isSelected = _selectedRole == role;

        return _RoleItem(
          title: role.label,
          isSelected: isSelected,
          onTap: () {
            setState(() {
              _selectedRole = role;
            });

            if (widget.onRoleChanged != null) {
              widget.onRoleChanged!(role);
            }
          },
        );
      }).toList(),
    );
  }
}

class _RoleItem extends StatelessWidget {
  final String title;
  final bool isSelected;
  final VoidCallback onTap;

  const _RoleItem({
    super.key,
    required this.title,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: GestureDetector(
        onTap: onTap,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          alignment: AlignmentDirectional.center,
          padding: const EdgeInsets.all(15),
          decoration: BoxDecoration(
            color: isSelected ? AppColors.primary : AppColors.white,
            borderRadius: BorderRadius.circular(15),
            border: Border.all(
              color: isSelected
                  ? AppColors.primary
                  : AppColors.textLight.withOpacity(0.3),
            ),
          ),
          child: AppText.title(
            title,
            color: isSelected ? AppColors.white : AppColors.primary,
          ),
        ),
      ),
    );
  }
}

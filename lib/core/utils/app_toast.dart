import 'package:alqa3a/core/constants/constants.dart';
import 'package:alqa3a/core/theme/app_colors.dart';
import 'package:flutter/material.dart';

enum ToastType { success, error, warning, info }

enum ToastPosition { top, bottom }

class AppToast {
  static void show(
    BuildContext context, {
    required String message,
    required ToastType type,
    ToastPosition position = ToastPosition.bottom,
    Duration duration = const Duration(seconds: 3),
  }) {
    final overlayState = Overlay.of(context);
    late OverlayEntry overlayEntry;

    final config = _getToastConfig(type);

    overlayEntry = OverlayEntry(
      builder: (context) => _ToastWidget(
        message: message,
        config: config,
        position: position,
        duration: duration,
        onDismiss: () {
          overlayEntry.remove();
        },
      ),
    );

    overlayState.insert(overlayEntry);
  }

  static _ToastConfig _getToastConfig(ToastType type) {
    switch (type) {
      case ToastType.success:
        return _ToastConfig(
          backgroundColor: AppColors.background,
          borderColor: AppColors.success,
          foregroundColor: AppColors.success,
          icon: Icons.check_circle_rounded,
        );
      case ToastType.error:
        return _ToastConfig(
          backgroundColor: AppColors.background,
          borderColor: AppColors.error,
          foregroundColor: AppColors.error,
          icon: Icons.error_rounded,
        );
      case ToastType.warning:
        return _ToastConfig(
          backgroundColor: AppColors.background,
          borderColor: AppColors.warning,
          foregroundColor: AppColors.warning,
          icon: Icons.warning_rounded,
        );
      case ToastType.info:
        return _ToastConfig(
          backgroundColor: AppColors.background,
          borderColor: AppColors.info,
          foregroundColor: AppColors.info,
          icon: Icons.info_rounded,
        );
    }
  }
}

class _ToastConfig {
  final Color backgroundColor;
  final Color borderColor;
  final Color foregroundColor;
  final IconData icon;

  _ToastConfig({
    required this.backgroundColor,
    required this.borderColor,
    required this.foregroundColor,
    required this.icon,
  });
}

class _ToastWidget extends StatefulWidget {
  final String message;
  final _ToastConfig config;
  final ToastPosition position;
  final Duration duration;
  final VoidCallback onDismiss;

  const _ToastWidget({
    required this.message,
    required this.config,
    required this.position,
    required this.duration,
    required this.onDismiss,
  });

  @override
  State<_ToastWidget> createState() => _ToastWidgetState();
}

class _ToastWidgetState extends State<_ToastWidget>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<Offset> _offsetAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 400),
      vsync: this,
    );

    final startOffset = widget.position == ToastPosition.top
        ? const Offset(0, -1.5)
        : const Offset(0, 1.5);

    _offsetAnimation = Tween<Offset>(
      begin: startOffset,
      end: Offset.zero,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeOutBack));

    _controller.forward();

    Future.delayed(widget.duration, () {
      if (mounted) {
        _controller.reverse().then((_) => widget.onDismiss());
      }
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: widget.position == ToastPosition.top
          ? MediaQuery.of(context).padding.top + 16
          : null,
      bottom: widget.position == ToastPosition.bottom
          ? MediaQuery.of(context).padding.bottom + 24
          : null,
      left: 16,
      right: 16,
      child: SlideTransition(
        position: _offsetAnimation,
        child: Material(
          color: Colors.transparent,
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
            decoration: BoxDecoration(
              color: widget.config.backgroundColor,
              borderRadius: BorderRadius.circular(16),
              border: Border.all(color: widget.config.borderColor, width: 1),
              boxShadow: [
                BoxShadow(
                  color: widget.config.borderColor.withOpacity(0.15),
                  blurRadius: 12,
                  offset: const Offset(0, 4),
                ),
              ],
            ),
            child: Row(
              children: [
                Icon(
                  widget.config.icon,
                  color: widget.config.foregroundColor,
                  size: 24,
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Text(
                    widget.message,
                    style: TextStyle(
                      color: widget.config.foregroundColor,
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                      fontFamily: Constants.fontFamily,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

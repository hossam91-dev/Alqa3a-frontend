import 'package:flutter/material.dart';

enum AppTextType {
  displayLarge,
  displayMedium,
  displaySmall,
  headlineLarge,
  headlineMedium,
  headlineSmall,
  titleLarge,
  titleMedium,
  titleSmall,
  bodyLarge,
  bodyMedium,
  bodySmall,
  labelLarge,
  labelMedium,
  labelSmall,
}

class AppText extends StatelessWidget {
  final String text;
  final AppTextType type;
  final TextStyle? style;
  final Color? color;
  final double? fontSize;
  final FontWeight? fontWeight;
  final TextAlign? textAlign;
  final int? maxLines;
  final TextOverflow? overflow;
  final bool? softWrap;
  final double? letterSpacing;
  final double? lineHeight;
  final TextDecoration? decoration;
  final String? fontFamily;

  const AppText(
    this.text, {
    super.key,
    this.type = AppTextType.bodyMedium,
    this.style,
    this.color,
    this.fontSize,
    this.fontWeight,
    this.textAlign,
    this.maxLines,
    this.overflow,
    this.softWrap,
    this.letterSpacing,
    this.lineHeight,
    this.decoration,
    this.fontFamily,
  });

  // Named constructors الحالية ممتازة ومظبوطة
  const AppText.displayLarge(
    this.text, {
    super.key,
    this.type = AppTextType.displayLarge,
    this.style,
    this.color,
    this.fontSize,
    this.fontWeight,
    this.textAlign,
    this.maxLines,
    this.overflow,
    this.softWrap,
    this.letterSpacing,
    this.lineHeight,
    this.decoration,
    this.fontFamily,
  });
  const AppText.headline(
    this.text, {
    super.key,
    this.type = AppTextType.headlineMedium,
    this.style,
    this.color,
    this.fontSize,
    this.fontWeight,
    this.textAlign,
    this.maxLines,
    this.overflow,
    this.softWrap,
    this.letterSpacing,
    this.lineHeight,
    this.decoration,
    this.fontFamily,
  });
  const AppText.title(
    this.text, {
    super.key,
    this.type = AppTextType.titleMedium,
    this.style,
    this.color,
    this.fontSize,
    this.fontWeight,
    this.textAlign,
    this.maxLines,
    this.overflow,
    this.softWrap,
    this.letterSpacing,
    this.lineHeight,
    this.decoration,
    this.fontFamily,
  });
  const AppText.body(
    this.text, {
    super.key,
    this.type = AppTextType.bodyMedium,
    this.style,
    this.color,
    this.fontSize,
    this.fontWeight,
    this.textAlign,
    this.maxLines,
    this.overflow,
    this.softWrap,
    this.letterSpacing,
    this.lineHeight,
    this.decoration,
    this.fontFamily,
  });
  const AppText.caption(
    this.text, {
    super.key,
    this.type = AppTextType.labelSmall,
    this.style,
    this.color,
    this.fontSize,
    this.fontWeight,
    this.textAlign,
    this.maxLines,
    this.overflow,
    this.softWrap,
    this.letterSpacing,
    this.lineHeight,
    this.decoration,
    this.fontFamily,
  });
  const AppText.button(
    this.text, {
    super.key,
    this.type = AppTextType.labelLarge,
    this.style,
    this.color,
    this.fontSize,
    this.fontWeight,
    this.textAlign,
    this.maxLines,
    this.overflow,
    this.softWrap,
    this.letterSpacing,
    this.lineHeight,
    this.decoration,
    this.fontFamily,
  });

  TextStyle _getThemeStyle(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    // الحماية هنا: استخدام ?? لضمان عدم حدوث كراش نهائياً لو مظهرش ستايل معين
    switch (type) {
      case AppTextType.displayLarge:
        return textTheme.displayLarge ?? const TextStyle();
      case AppTextType.displayMedium:
        return textTheme.displayMedium ?? const TextStyle();
      case AppTextType.displaySmall:
        return textTheme.displaySmall ?? const TextStyle();
      case AppTextType.headlineLarge:
        return textTheme.headlineLarge ?? const TextStyle();
      case AppTextType.headlineMedium:
        return textTheme.headlineMedium ?? const TextStyle();
      case AppTextType.headlineSmall:
        return textTheme.headlineSmall ?? const TextStyle();
      case AppTextType.titleLarge:
        return textTheme.titleLarge ?? const TextStyle();
      case AppTextType.titleMedium:
        return textTheme.titleMedium ?? const TextStyle();
      case AppTextType.titleSmall:
        return textTheme.titleSmall ?? const TextStyle();
      case AppTextType.bodyLarge:
        return textTheme.bodyLarge ?? const TextStyle();
      case AppTextType.bodyMedium:
        return textTheme.bodyMedium ?? const TextStyle();
      case AppTextType.bodySmall:
        return textTheme.bodySmall ?? const TextStyle();
      case AppTextType.labelLarge:
        return textTheme.labelLarge ?? const TextStyle();
      case AppTextType.labelMedium:
        return textTheme.labelMedium ?? const TextStyle();
      case AppTextType.labelSmall:
        return textTheme.labelSmall ?? const TextStyle();
    }
  }

  @override
  Widget build(BuildContext context) {
    final themeStyle = _getThemeStyle(context);

    final effectiveStyle = themeStyle
        .copyWith(
          color: color ?? style?.color ?? themeStyle.color,
          fontSize: fontSize ?? style?.fontSize ?? themeStyle.fontSize,
          fontWeight: fontWeight ?? style?.fontWeight ?? themeStyle.fontWeight,
          letterSpacing:
              letterSpacing ?? style?.letterSpacing ?? themeStyle.letterSpacing,
          height: lineHeight ?? style?.height ?? themeStyle.height,
          decoration: decoration ?? style?.decoration ?? themeStyle.decoration,
          fontFamily: fontFamily ?? style?.fontFamily ?? themeStyle.fontFamily,
        )
        .merge(style);

    return Text(
      text,
      style: effectiveStyle,
      textAlign: textAlign,
      maxLines: maxLines,
      overflow: overflow,
      softWrap: softWrap,
    );
  }
}

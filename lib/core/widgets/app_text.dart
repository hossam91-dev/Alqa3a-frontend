import 'package:flutter/material.dart';

enum AppTextType {
  displayLarge,    // عنوان كبير جداً
  displayMedium,   // عنوان كبير
  displaySmall,    // عنوان متوسط
  headlineLarge,   // عنوان رئيسي كبير
  headlineMedium,  // عنوان رئيسي
  headlineSmall,   // عنوان رئيسي صغير
  titleLarge,      // عنوان فرعي كبير
  titleMedium,     // عنوان فرعي
  titleSmall,      // عنوان فرعي صغير
  bodyLarge,       // نص عادي كبير
  bodyMedium,      // نص عادي (default)
  bodySmall,       // نص عادي صغير
  labelLarge,      // ليبل كبير (buttons)
  labelMedium,     // ليبل (default for buttons)
  labelSmall,      // ليبل صغير (captions)
}

class AppText extends StatelessWidget {
  final String text;
  final AppTextType type;
  final TextStyle? style;          // override style
  final Color? color;              // override color
  final double? fontSize;          // override size
  final FontWeight? fontWeight;    // override weight
  final TextAlign? textAlign;
  final int? maxLines;
  final TextOverflow? overflow;
  final bool? softWrap;
  final double? letterSpacing;
  final double? lineHeight;        // height factor
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

  /// Named constructors للاستخدام السريع
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

    switch (type) {
      case AppTextType.displayLarge:
        return textTheme.displayLarge!;
      case AppTextType.displayMedium:
        return textTheme.displayMedium!;
      case AppTextType.displaySmall:
        return textTheme.displaySmall!;
      case AppTextType.headlineLarge:
        return textTheme.headlineLarge!;
      case AppTextType.headlineMedium:
        return textTheme.headlineMedium!;
      case AppTextType.headlineSmall:
        return textTheme.headlineSmall!;
      case AppTextType.titleLarge:
        return textTheme.titleLarge!;
      case AppTextType.titleMedium:
        return textTheme.titleMedium!;
      case AppTextType.titleSmall:
        return textTheme.titleSmall!;
      case AppTextType.bodyLarge:
        return textTheme.bodyLarge!;
      case AppTextType.bodyMedium:
        return textTheme.bodyMedium!;
      case AppTextType.bodySmall:
        return textTheme.bodySmall!;
      case AppTextType.labelLarge:
        return textTheme.labelLarge!;
      case AppTextType.labelMedium:
        return textTheme.labelMedium!;
      case AppTextType.labelSmall:
        return textTheme.labelSmall!;
    }
  }

  @override
  Widget build(BuildContext context) {
    final themeStyle = _getThemeStyle(context);

    // Merge overrides
    final effectiveStyle = themeStyle.copyWith(
      color: color ?? style?.color ?? themeStyle.color,
      fontSize: fontSize ?? style?.fontSize ?? themeStyle.fontSize,
      fontWeight: fontWeight ?? style?.fontWeight ?? themeStyle.fontWeight,
      letterSpacing: letterSpacing ?? style?.letterSpacing ?? themeStyle.letterSpacing,
      height: lineHeight ?? style?.height ?? themeStyle.height,
      decoration: decoration ?? style?.decoration ?? themeStyle.decoration,
      fontFamily: fontFamily ?? style?.fontFamily ?? themeStyle.fontFamily,
      
    ).merge(style); // style parameter takes highest priority

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
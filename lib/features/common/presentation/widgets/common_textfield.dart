import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:tabriklar/assets/colors/app_colors.dart';
import 'package:tabriklar/assets/constants/app_icons.dart';

import 'common_scale_animation.dart';

class CommonTextField extends StatefulWidget {
  final bool? hasSearch;
  final bool? hasBorderColor;
  final AutovalidateMode? autoValidateMode;
  final String? Function(String?)? validate;
  final bool? hasClearButton;
  final String title;
  final Color? disabledBorderColor;
  final double borderRadius;
  final TextStyle? titleTextStyle;
  final TextStyle? textStyle;
  final TextStyle? counterStyle;
  final String? hintText;
  final TextStyle? prefixStyle;
  final TextStyle? hintTextStyle;
  final String prefixText;
  final bool? hideCounterText;
  final Widget? prefix;
  final EdgeInsets? prefixPadding;
  final double? width;
  final double? height;
  final double? topPrefixPadding;
  final int? maxLength;
  final TextInputType? keyBoardType;
  final bool? isObscure;
  final Widget? suffix;
  final String? suffixIcon;
  final EdgeInsets? suffixPadding;
  final TextCapitalization textCapitalization;
  final ValueChanged<String> onChanged;
  final TextEditingController? controller;
  final List<TextInputFormatter>? textInputFormatters;
  final EdgeInsets? contentPadding;
  final bool hasError;
  final double sizeBetweenFieldTitle;
  final Color? errorColor;
  final Color? fillColor;
  final EdgeInsets? margin;
  final VoidCallback? onEyeTap;
  final FocusNode? focusNode;
  final TextAlign textAlign;
  final TextInputAction textInputAction;
  final Function? onObscure;
  final Function? onTapSuffix;
  final Function()? onEditCompleted;
  final Function()? onTap;
  final bool autoFocus;
  final Color? disabledColor;
  final double? suffixRightPosition;
  final double? suffixSize;
  final int? maxLines;
  final Color? borderColor;
  final Color? enabledBorderColor;
  final Color? focusColor;
  final BorderRadius? detailedBorderRadius;
  final bool readOnly;
  final Widget? suffixTitleWidget;
  final String hintNextToTitle;
  final String? initial;
  final TextStyle? hintNextToTitleStyle;
  final Color? cursorColor;
  final List<BoxShadow>? boxShadow;
  final Widget? Function(BuildContext, {required int currentLength, required bool isFocused, required int? maxLength})?
      buildCounter;

  const CommonTextField({
    this.controller,
    required this.onChanged,
    this.hasBorderColor,
    this.topPrefixPadding,
    this.readOnly = false,
    this.disabledColor,
    this.validate,
    this.boxShadow,
    this.autoValidateMode,
    this.hideCounterText,
    this.autoFocus = false,
    this.borderRadius = 8,
    this.prefixStyle,
    this.disabledBorderColor,
    this.hasClearButton,
    this.textAlign = TextAlign.start,
    this.width,
    this.fillColor,
    this.title = '',
    this.titleTextStyle,
    this.textStyle,
    this.hintText,
    this.hintTextStyle,
    this.contentPadding = const EdgeInsets.all(12),
    this.prefixText = '',
    this.prefix,
    this.prefixPadding = const EdgeInsets.all(2),
    this.suffix,
    this.suffixIcon,
    this.suffixPadding = const EdgeInsets.all(8),
    this.isObscure,
    this.onEyeTap,
    this.margin,
    this.sizeBetweenFieldTitle = 8,
    this.errorColor,
    this.hasError = false,
    this.textInputFormatters,
    this.textCapitalization = TextCapitalization.none,
    this.keyBoardType,
    this.maxLength,
    this.focusNode,
    this.textInputAction = TextInputAction.done,
    this.height,
    this.onObscure,
    this.onTapSuffix,
    super.key,
    this.onEditCompleted,
    this.onTap,
    this.suffixRightPosition,
    this.suffixSize,
    this.maxLines = 1,
    this.borderColor,
    this.enabledBorderColor,
    this.detailedBorderRadius,
    this.focusColor = AppColors.white,
    this.suffixTitleWidget,
    this.hintNextToTitle = '',
    this.hasSearch,
    this.cursorColor = AppColors.black,
    this.hintNextToTitleStyle,
    this.counterStyle,
    this.buildCounter,
    this.initial,
  });

  @override
  State<CommonTextField> createState() => _CommonTextFieldState();
}

class _CommonTextFieldState extends State<CommonTextField> with SingleTickerProviderStateMixin {
  late FocusNode focusNode;
  bool focused = false;
  bool hasText = false;
  bool isObscure = false;
  bool showStroke = false;
  late AnimationController animationController;

  @override
  void initState() {
    animationController = AnimationController(vsync: this, duration: const Duration(milliseconds: 200));
    super.initState();
    if (widget.isObscure != null) {
      isObscure = widget.isObscure!;
    }
    focusNode = FocusNode();

    focusNode.addListener(
      () => setState(() {
        log('focused');
        focused = !focused;
      }),
    );
  }

  @override
  void dispose() {
    focusNode.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: widget.margin,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (widget.title.isNotEmpty)
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Text(
                      widget.title,
                      style: widget.titleTextStyle ??
                          Theme.of(context).textTheme.displaySmall!.copyWith(
                                fontSize: 14,
                                fontWeight: FontWeight.w400,
                              ),
                    ),
                    Text(
                      ' ${widget.hintNextToTitle}',
                      style: widget.hintNextToTitleStyle ??
                          Theme.of(context).textTheme.labelLarge!.copyWith(
                                fontSize: 15,
                                fontWeight: FontWeight.w500,
                              ),
                    ),
                  ],
                ),
                if (widget.suffixTitleWidget != null) widget.suffixTitleWidget!,
              ],
            )
          else
            const SizedBox(),
          SizedBox(
            height: widget.title.isNotEmpty ? widget.sizeBetweenFieldTitle : null,
          ),
          Container(
            height: widget.height ?? 44,
            width: widget.width,
            decoration: BoxDecoration(
              borderRadius: widget.detailedBorderRadius ?? BorderRadius.circular(6),
              color: Colors.transparent,
              boxShadow: widget.boxShadow,
            ),
            child: Stack(
              children: [
                ClipRRect(
                  borderRadius: widget.detailedBorderRadius ?? BorderRadius.circular(widget.borderRadius),
                  child: TextFormField(
                    cursorWidth: 1,
                    buildCounter: widget.buildCounter,
                    cursorRadius: const Radius.circular(1),
                    autovalidateMode: widget.autoValidateMode,
                    validator: widget.validate,
                    maxLines: widget.maxLines,
                    onTap: widget.onTap,
                    initialValue: widget.initial,
                    readOnly: widget.readOnly,
                    textAlign: widget.textAlign,
                    inputFormatters: widget.textInputFormatters,
                    textInputAction: widget.textInputAction,
                    textCapitalization: widget.textCapitalization,
                    obscureText: isObscure,
                    keyboardType: widget.keyBoardType,
                    maxLength: widget.maxLength,
                    controller: widget.controller,
                    autofocus: widget.autoFocus,
                    cursorColor: widget.cursorColor,
                    obscuringCharacter: '●',
                    cursorHeight: 18,
                    onEditingComplete: widget.onEditCompleted,
                    onChanged: (s) {
                      if (s.length == 1 || s.isEmpty) {
                        setState(() => hasText = s.isNotEmpty);
                      }
                      widget.onChanged(s);
                    },
                    focusNode: widget.focusNode ?? focusNode,
                    style: widget.textStyle ??
                        Theme.of(context)
                            .textTheme
                            .titleSmall
                            ?.copyWith(color: AppColors.black, fontSize: 14, fontWeight: FontWeight.w500),
                    decoration: InputDecoration(
                      suffix: widget.suffix != null ? SizedBox(width: widget.suffixSize) : null,
                      border: OutlineInputBorder(
                        borderRadius: widget.detailedBorderRadius ?? BorderRadius.circular(widget.borderRadius),
                        borderSide: BorderSide(
                          width: 1,
                          color: widget.hasError
                              ? Theme.of(context).colorScheme.error
                              : widget.enabledBorderColor ?? AppColors.white,
                        ),
                      ),
                      // counterText: widget.hideCounterText != null && widget.hideCounterText!
                      //     ? widget.controller?.text.length.toString()
                      //     : null,
                      counterStyle: widget.counterStyle,
                      hintText: widget.hintText,
                      hintStyle: widget.hintTextStyle ?? Theme.of(context).textTheme.bodyLarge,
                      filled: true,
                      // prefixIconConstraints:
                      // const BoxConstraints(maxWidth: 20, maxHeight: 20),
                      prefixIcon: widget.hasSearch != null && widget.hasSearch!
                          ? const Padding(
                              padding: EdgeInsets.symmetric(horizontal: 12, vertical: 10),
                              child: Icon(Icons.search),
                            )
                          : widget.prefix,
                      fillColor: focused
                          ? widget.focusColor
                          : widget.disabledColor != null
                              ? widget.controller != null && widget.controller!.text.isNotEmpty
                                  ? widget.fillColor ?? AppColors.black
                                  : widget.disabledColor
                              : widget.fillColor,
                      contentPadding: widget.contentPadding,
                      disabledBorder: OutlineInputBorder(
                        borderRadius: widget.detailedBorderRadius ?? BorderRadius.circular(widget.borderRadius),
                        borderSide: BorderSide(
                          width: 1,
                          color: widget.hasBorderColor != null && widget.hasBorderColor!
                              ? widget.borderColor ?? Colors.transparent
                              : widget.hasError
                                  ? Theme.of(context).colorScheme.error
                                  : widget.disabledBorderColor ?? widget.borderColor ?? Colors.transparent,
                        ),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: widget.detailedBorderRadius ?? BorderRadius.circular(widget.borderRadius),
                        borderSide: BorderSide(
                          width: 1,
                          color: widget.hasBorderColor != null && widget.hasBorderColor!
                              ? widget.borderColor ?? Colors.transparent
                              : widget.hasError
                                  ? Theme.of(context).colorScheme.error
                                  : widget.disabledBorderColor ?? widget.enabledBorderColor ?? Colors.transparent,
                        ),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: widget.detailedBorderRadius ?? BorderRadius.circular(widget.borderRadius),
                        borderSide: BorderSide(
                          width: 1,
                          color: widget.hasBorderColor != null && !widget.hasBorderColor!
                              ? widget.borderColor ?? Colors.transparent
                              : widget.hasError
                                  ? Theme.of(context).colorScheme.error
                                  : widget.borderColor ?? AppColors.black,
                        ),
                      ),
                    ),
                  ),
                ),
                if (widget.prefixText.isNotEmpty)
                  Positioned(
                    top: widget.topPrefixPadding ?? 11,
                    left: 12,
                    child: Padding(
                      padding: widget.prefixPadding ?? EdgeInsets.zero,
                      child: Text(
                        widget.prefixText,
                        style: widget.prefixStyle ?? Theme.of(context).textTheme.displayLarge!.copyWith(fontSize: 15),
                      ),
                    ),
                  )
                else
                  const SizedBox(),
                Positioned(
                  top: 0,
                  bottom: 0,
                  right: widget.suffixRightPosition ?? 0,
                  child: widget.hasClearButton != null && widget.hasClearButton!
                      ? widget.controller != null && widget.controller!.text.isNotEmpty
                          ? GestureDetector(
                              onTap: () {
                                setState(() {});
                                widget.controller!.clear();
                              },
                              child: Padding(
                                padding: const EdgeInsets.symmetric(horizontal: 8),
                                child: SvgPicture.asset(AppIcons.xBack),
                              ),
                            )
                          : const SizedBox()
                      : Padding(
                          padding: widget.suffixPadding ?? const EdgeInsets.all(8.0),
                          child: widget.suffix ?? const SizedBox(),
                        ),
                ),
                Positioned(
                  right: 8,
                  child: widget.isObscure == null
                      ? widget.suffixIcon != null
                          ? ButtonScaleAnimation(
                              onTap: () {},
                              child: Padding(
                                padding: widget.suffixPadding!,
                                child: SvgPicture.asset(
                                  widget.suffixIcon!,
                                ),
                              ),
                            )
                          : const SizedBox()
                      : GestureDetector(),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

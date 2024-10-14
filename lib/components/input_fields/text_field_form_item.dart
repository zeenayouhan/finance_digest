import 'package:finance_digest/utils/text_style_helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../constants/theme/app_colors.dart';

class TextFieldFormItem extends StatelessWidget {
  const TextFieldFormItem({
    super.key,
    this.onTap,
    this.hintText,
    this.labelText,
    this.errorText,
    this.isError = false,
    this.validator,
    this.controller,
    this.keyboardType,
    this.initialValue,
    this.inputFormatters,
    this.textInputAction,
    this.isFilled = false,
    this.focusNode,
    this.iconButton,
    this.handleFocusChange,
    this.scrollPadding,
    this.contentPadding = const EdgeInsets.all(0),
    this.innerKey,
    this.onFieldSubmitted,
    this.onChanged,
    this.style,
    this.maxLength,
    this.enabled = true,
    this.fillColor,
  });

  final void Function()? onTap;
  final GlobalKey<FormFieldState<String>>? innerKey;
  final String? hintText;
  final String? labelText;
  final String? errorText;
  final bool isError;
  final String? Function(String?)? validator;
  final TextEditingController? controller;
  final TextInputType? keyboardType;
  final String? initialValue;
  final bool? enabled;
  final List<TextInputFormatter>? inputFormatters;
  final TextInputAction? textInputAction;
  final bool isFilled;
  final EdgeInsets contentPadding;
  final TextStyle? style;
  final FocusNode? focusNode;
  final IconButton? iconButton;
  final EdgeInsets? scrollPadding;
  final int? maxLength;
  final Color? fillColor;
  final void Function(String)? onFieldSubmitted;
  final void Function(String)? onChanged;
  final void Function(bool)? handleFocusChange;

  @override
  Widget build(BuildContext context) {
    final appColors = Theme.of(context).extension<AppColors>();
    final hasErrorText = errorText != null;

    return Focus(
      onFocusChange: (hasFocus) {
        if (!hasFocus) {
          innerKey?.currentState?.validate();
        }
        handleFocusChange?.call(hasFocus);
      },
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          TextFormField(
            key: innerKey,
            style: style ?? reusableTextStyle(context: context),
            onTap: onTap,
            scrollPadding: scrollPadding ?? const EdgeInsets.all(16),
            focusNode: focusNode,
            validator: validator,
            controller: controller,
            initialValue: initialValue,
            maxLength: maxLength,
            decoration: InputDecoration(
              suffixIcon: iconButton,
              contentPadding: contentPadding,
              errorStyle: const TextStyle(height: 0, fontSize: 0),
              focusedErrorBorder: UnderlineInputBorder(
                borderSide:
                    BorderSide(color: appColors?.redErrors ?? Colors.red),
              ),
              filled: isFilled,
              fillColor: fillColor ?? appColors?.white,
              border: UnderlineInputBorder(
                borderSide: BorderSide(
                    color: isError || hasErrorText
                        ? appColors?.redErrors ?? Colors.red
                        : appColors?.grey ?? Colors.grey),
              ),
              focusedBorder: UnderlineInputBorder(
                borderSide: BorderSide(
                    color: isError || hasErrorText
                        ? appColors?.redErrors ?? Colors.red
                        : appColors?.grey ?? Colors.grey),
              ),
              hintText: hintText,
              labelText: labelText,
              hintStyle: reusableTextStyle(
                context: context,
                color: appColors?.grey,
                fontSize: 20,
              ),
            ),
            textInputAction: textInputAction,
            onFieldSubmitted: onFieldSubmitted,
            onChanged: onChanged,
            keyboardType: keyboardType,
            inputFormatters: inputFormatters,
            enabled: enabled,
          ),
          Visibility(
            visible: hasErrorText,
            child: Text(
              errorText ?? '',
              maxLines: 3,
              style: reusableTextStyle(
                context: context,
                color: appColors?.redErrors,
              ),
            ),
          )
        ],
      ),
    );
  }
}

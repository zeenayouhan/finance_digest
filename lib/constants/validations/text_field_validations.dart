import 'package:flutter/services.dart';

import 'regular_expressions.dart';

class TextFieldValidator {
  bool validateName(String? value) {
    if (value == null || value.isEmpty) return false;

    final newValue = value.trim();

    if (newValue.isNotEmpty && newValue.contains(RegExp(nameValidation))) {
      return true;
    }
    return false;
  }

  FilteringTextInputFormatter preferredNameFormatter() {
    return FilteringTextInputFormatter.allow(
      RegExp(nameInputFormatter),
    );
  }
}

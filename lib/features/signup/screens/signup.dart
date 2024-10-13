import 'package:finance_digest/features/signup/screens/notifications.dart';
import 'package:finance_digest/features/signup/services/auth_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../../components/input_fields/text_field_form_item.dart';
import '../../../constants/theme/app_colors.dart';
import '../../../constants/validations/text_field_validations.dart';
import '../../../utils/text_style_helper.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  String? _firstNameErrorText;
  String? _lastNameErrorText;
  bool isFilledFirstName = false;
  bool isFilledLastName = false;

  final TextEditingController _firstNameController = TextEditingController();
  final TextEditingController _lastNameController = TextEditingController();

  final _firstNameFocusNode = FocusNode();
  final _lastNameFocusNode = FocusNode();

  final _formFieldKeyFirstName = GlobalKey<FormFieldState<String>>();
  final _formFieldKeyLastName = GlobalKey<FormFieldState<String>>();

  TextFieldValidator textFieldValidator = TextFieldValidator();

  AuthService authService = AuthService();

  Future<void> onPress() async {
    try {
      await authService.signUp(
        _firstNameController.text.trim(),
        _lastNameController.text.trim(),
      );
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => const NotificationsScreen()),
      );
    } catch (e) {
      debugPrint("Failed to sign up: $e");
    }
  }

  @override
  void dispose() {
    _firstNameController.dispose();
    _lastNameController.dispose();
    _firstNameFocusNode.dispose();
    _lastNameFocusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final appColors = Theme.of(context).extension<AppColors>();

    return Scaffold(
      floatingActionButton: _buildFloatingActionButton(appColors),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.only(top: 10.0, left: 24, right: 24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildHeaderText(context),
              _buildDescriptionText(context, appColors),
              _buildFirstNameField(appColors),
              const SizedBox(height: 35),
              _buildLastNameField(appColors),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildHeaderText(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: Text(
        "Your legal name",
        style: reusableTextStyle(
          context: context,
          fontWeight: FontWeight.w700,
          fontSize: 30,
        ),
      ),
    );
  }

  Widget _buildDescriptionText(BuildContext context, AppColors? appColors) {
    return Padding(
      padding: const EdgeInsets.only(top: 16, bottom: 32),
      child: Text(
        'We need to know a bit about you so that we can create your account.',
        style: reusableTextStyle(
          context: context,
          fontSize: 16,
          color: appColors?.darkGrey,
        ),
      ),
    );
  }

  Widget _buildFirstNameField(AppColors? appColors) {
    return TextFieldFormItem(
      innerKey: _formFieldKeyFirstName,
      controller: _firstNameController,
      focusNode: _firstNameFocusNode,
      hintText: 'First name',
      style: reusableTextStyle(
        context: context,
        fontSize: 20,
        color: appColors?.black2,
      ),
      validator: (value) => _validateName(value, isFirstName: true),
      onChanged: (value) => _updateFieldState(isFirstName: true),
      onFieldSubmitted: (_) {
        _updateFieldState(isFirstName: true);
        FocusScope.of(context).requestFocus(_lastNameFocusNode);
      },
      textInputAction: TextInputAction.next,
      errorText: _firstNameErrorText,
      inputFormatters: [
        textFieldValidator.preferredNameFormatter(),
      ],
    );
  }

  Widget _buildLastNameField(AppColors? appColors) {
    return TextFieldFormItem(
      innerKey: _formFieldKeyLastName,
      controller: _lastNameController,
      focusNode: _lastNameFocusNode,
      hintText: 'Last name',
      style: reusableTextStyle(
        context: context,
        fontSize: 20,
        color: appColors?.black2,
      ),
      validator: (value) => _validateName(value, isFirstName: false),
      onChanged: (value) => _updateFieldState(isFirstName: false),
      onFieldSubmitted: (_) => _updateFieldState(isFirstName: false),
      errorText: _lastNameErrorText,
      inputFormatters: [
        textFieldValidator.preferredNameFormatter(),
      ],
    );
  }

  String? _validateName(String? value, {required bool isFirstName}) {
    String? errorText = value == null || !textFieldValidator.validateName(value)
        ? '${isFirstName ? 'First' : 'Last'} name cannot be empty'
        : null;

    if (isFirstName) {
      _firstNameErrorText = errorText;
    } else {
      _lastNameErrorText = errorText;
    }

    return errorText;
  }

  void _updateFieldState({required bool isFirstName}) {
    setState(() {
      if (isFirstName) {
        isFilledFirstName = _formFieldKeyFirstName.currentState!.validate();
      } else {
        isFilledLastName = _formFieldKeyLastName.currentState!.validate();
      }
    });
  }

  Widget _buildFloatingActionButton(AppColors? appColors) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: FloatingActionButton(
        onPressed: isFilledFirstName && isFilledLastName ? onPress : null,
        backgroundColor: isFilledFirstName && isFilledLastName
            ? appColors?.primary
            : appColors?.primary.withOpacity(0.5),
        elevation: 0,
        shape: const CircleBorder(),
        child: SvgPicture.asset('lib/assets/icons/right_arrow.svg'),
      ),
    );
  }
}

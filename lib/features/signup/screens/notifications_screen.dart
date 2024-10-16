import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import '../../../constants/routes/routes.dart';
import '../../../constants/theme/app_colors.dart';
import '../services/auth_service.dart';
import '../services/notification_service.dart';
import '../../../utils/text_style_helper.dart';

class NotificationsScreen extends StatefulWidget {
  const NotificationsScreen({super.key});

  @override
  State<NotificationsScreen> createState() => _NotificationsScreenState();
}

class _NotificationsScreenState extends State<NotificationsScreen> {
  final NotificationService _notificationService = NotificationService();
  AuthService authService = AuthService();
  late String firstName;
  late String lastName;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final args =
        ModalRoute.of(context)!.settings.arguments as Map<String, String>;
    firstName = args['firstName'] ?? '';
    lastName = args['lastName'] ?? '';
  }

  Future<void> onPress() async {
    try {
      await _notificationService.init();
      await _notificationService.requestPermissions();

      await authService.signUp(
        firstName,
        lastName,
      );

      Navigator.pushNamedAndRemoveUntil(
        context,
        Routes.home,
        (Route<dynamic> route) => false,
      );
    } catch (e) {
      debugPrint("Failed to authenticate: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    final appColors = Theme.of(context).extension<AppColors>();

    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24),
        child: Column(
          children: [
            Expanded(
              child: _buildContent(context, appColors),
            ),
            _buildContinueButton(context, appColors),
            const SizedBox(height: 34), // Spacing from bottom
          ],
        ),
      ),
    );
  }

  Widget _buildContent(BuildContext context, AppColors? appColors) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        SvgPicture.asset('lib/assets/icons/notification.svg'),
        const SizedBox(height: 24),
        Text(
          'Get the most out of Blott ✅',
          style: reusableTextStyle(
            context: context,
            fontWeight: FontWeight.bold,
            fontSize: 24,
          ),
        ),
        const SizedBox(height: 16),
        Text(
          'Allow notifications to stay in the loop with your payments, requests, and groups.',
          textAlign: TextAlign.center,
          style: reusableTextStyle(
            context: context,
            color: appColors?.darkGrey,
            fontSize: 16,
          ),
        ),
      ],
    );
  }

  Widget _buildContinueButton(BuildContext context, AppColors? appColors) {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        onPressed: onPress,
        style: ElevatedButton.styleFrom(
          backgroundColor: appColors?.primary,
          padding: const EdgeInsets.symmetric(vertical: 12),
        ),
        child: Text(
          'Continue',
          style: reusableTextStyle(
            context: context,
            fontWeight: FontWeight.w500,
            color: appColors?.white,
            fontSize: 16,
          ),
        ),
      ),
    );
  }
}

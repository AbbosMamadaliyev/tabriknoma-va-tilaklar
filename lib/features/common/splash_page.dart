import 'package:flutter/material.dart';
import 'package:tabriklar/assets/colors/app_colors.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({Key? key}) : super(key: key);

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  @override
  void initState() {
    super.initState();

    Future.delayed(const Duration(seconds: 1)).then((val) {
      Navigator.pushNamedAndRemoveUntil(context, '/mainScreen', (route) => false);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.surface,
      // Matches the Android 12+ system splash (round icon, 160dp) so the
      // hand-off from the native splash to Flutter is seamless.
      body: Center(
        child: ClipOval(
          child: Image.asset(
            'assets/images/app_icon.png',
            width: 160,
            height: 160,
            filterQuality: FilterQuality.medium,
          ),
        ),
      ),
    );
  }
}

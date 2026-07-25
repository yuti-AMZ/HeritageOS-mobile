import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'constants/app_colors.dart';
import 'screens/splash_screen.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
    statusBarColor: Colors.transparent,
    statusBarIconBrightness: Brightness.light,
  ));
  runApp(const HeritageOSApp());
}

class HeritageOSApp extends StatelessWidget {
  const HeritageOSApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'HeritageOS',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: const ColorScheme.light(
          primary: AppColors.green,
          secondary: AppColors.gold,
          surface: AppColors.white,
        ),
        primaryColor: AppColors.green,
        scaffoldBackgroundColor: AppColors.white,
        canvasColor: AppColors.white,
        fontFamily: 'SF Pro Display',
      ),
      home: const SplashScreen(),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_conf_web/core/themes/themes.dart';
import 'package:flutter_conf_web/feature/landing/presentation/view/landing_page.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(360, 690),
      minTextAdapt: true,
      child: MaterialApp(
        title: 'Flutter Demo',
        debugShowCheckedModeBanner: false,
        theme: AppTheme.appThemeData,
        home: LandingPage(),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_conf_web/core/router/router.dart';
import 'package:flutter_conf_web/core/themes/colors.dart';
import 'package:flutter_conf_web/feature/landing/presentation/view/landing_page.dart';
import 'package:flutter_conf_web/feature/landing/presentation/view/team_view.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp({super.key});

  final _router = GoRouter(
    routes: [
      GoRoute(
        path: '/',
        builder: (context, state) => LandingPage(),
      ),
      GoRoute(
        path: '/team',
        builder: (context, state) => const TeamView(),
      ),
    ],
    errorBuilder: (context, state) => Scaffold(
      body: Center(
        child: Text(
          'Page not found',
          style: Theme.of(context).textTheme.headline1,
        ),
      ),
    ),
    initialLocation: '/',
  );

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(360, 690),
      minTextAdapt: true,
      child: MaterialApp.router(
        routerConfig: _router,
        title: 'Flutter Demo',
        debugShowCheckedModeBanner: false,
        theme: _buildTheme(Brightness.light),
        localizationsDelegates: AppLocalizations.localizationsDelegates,
        supportedLocales: const [
          Locale('en'),
          Locale('es'),
        ],
      ),
    );
  }

  ThemeData _buildTheme(brightness) {
    var baseTheme = ThemeData(brightness: brightness);

    return baseTheme.copyWith(
      textTheme: GoogleFonts.latoTextTheme(baseTheme.textTheme),
      colorScheme: ColorScheme.fromSeed(seedColor: AppColors.primaryColor),
      useMaterial3: true,
    );
  }
}

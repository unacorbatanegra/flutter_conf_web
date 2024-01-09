import 'package:flutter/material.dart';
import 'package:flutter_conf_web/app/widgets/leyends_widget.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lottie/lottie.dart';

class SplashAnimation extends StatelessWidget {
  const SplashAnimation({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height,
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.centerLeft,
          end: Alignment.centerRight,
          colors: [
            Color(0xFF3F4E61),
            Color(0xFF072436),
          ],
        ),
      ),
      child: Stack(
        children: [
          const Positioned.fill(
            top: 80,
            child: Align(
              alignment: Alignment.topCenter,
              child: LeyendsWidget(),
            ),
          ),
          Positioned.fill(
            child: Align(
              alignment: Alignment.center,
              child: Lottie.asset(
                'assets/animation/loading_flutter_logo.json',
                height: 20.sw,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

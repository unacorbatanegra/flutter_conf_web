import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter_conf_web/core/themes/colors.dart';
import 'package:flutter_conf_web/gen/assets.gen.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class AnimatedBannerWidget extends StatelessWidget {
  const AnimatedBannerWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppColors.secondaryColor,
      child: SizedBox(
        width: MediaQuery.of(context).size.width,
        height: 90.dm,
        child: Stack(
          children: [
            Positioned(
              left: 2.w,
              child: Align(
                alignment: Alignment.center,
                child: Assets.animation.bubblesSides.lottie(
                  height: 90.dm,
                  fit: BoxFit.cover,
                ),
              ),
            ),
            Positioned(
              right: 2.w,
              child: Align(
                alignment: Alignment.center,
                child: Assets.animation.bubblesSides.lottie(
                  fit: BoxFit.cover,
                  height: 90.dm,
                ),
              ),
            ),
            Positioned(
              left: 1,
              top: -45.dm,
              right: 1,
              child: const _RotateWheelAnimation(),
            ),
            Positioned(
              bottom: 40.dm,
              left: 90.dm,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    AppLocalizations.of(context)!.eventDate,
                    style: GoogleFonts.inter(
                      color: Colors.white,
                      fontSize: 10.dm,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(
                    height: 2,
                  ),
                  Text(
                    AppLocalizations.of(context)!.eventPlace,
                    style: GoogleFonts.inter(
                      color: Colors.white,
                      fontSize: 7.dm,
                      fontWeight: FontWeight.w200,
                    ),
                  ),
                ],
              ),
            ),
            Positioned(
              bottom: 40.dm,
              right: 90.dm,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Text(
                        AppLocalizations.of(context)!.eventNameTitle,
                        style: GoogleFonts.inter(
                          color: Colors.white,
                          fontSize: 10.dm,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        AppLocalizations.of(context)!.eventNameSubtitle,
                        style: GoogleFonts.inter(
                          color: Colors.white,
                          fontSize: 10.dm,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ],
                  ),
                  Text(
                    AppLocalizations.of(context)!.eventCountry,
                    style: GoogleFonts.inter(
                      color: Colors.white,
                      fontSize: 7.dm,
                      fontWeight: FontWeight.w200,
                    ),
                  ),
                ],
              ),
            ),
            Positioned(
              top: 25.dm,
              bottom: 25.dm,
              left: 90.dm,
              right: 90.dm,
              child: Assets.animation.flutterHeartbeat.lottie(),
            ),
            Positioned(
              top: 37.dm,
              left: 100.dm,
              child: Align(
                alignment: Alignment.center,
                child: Assets.animation.flagStripes
                    .lottie(height: 90.dm, width: 40.dm),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _RotateWheelAnimation extends StatefulWidget {
  const _RotateWheelAnimation();

  @override
  State<_RotateWheelAnimation> createState() => __RotateWheelAnimationState();
}

class __RotateWheelAnimationState extends State<_RotateWheelAnimation>
    with TickerProviderStateMixin {
  late AnimationController _controller;
  late Animation animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 100),
    )..repeat();
  }

  @override
  Widget build(BuildContext context) {
    return RotationTransition(
      turns: Tween(begin: 0.0, end: 1.0).animate(_controller),
      child: DottedBorder(
        borderType: BorderType.Circle,
        color: Colors.white,
        strokeWidth: 4.dm,
        strokeCap: StrokeCap.round,
        dashPattern: [11.dm, 20.dm],
        child: Container(
          height: 215.dm,
          width: 215.dm,
          decoration: const BoxDecoration(
            shape: BoxShape.circle,
          ),
        ),
      ),
    );
  }
}

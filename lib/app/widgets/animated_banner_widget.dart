import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter_conf_web/core/constants/constants.dart';
import 'package:flutter_conf_web/core/themes/colors.dart';
import 'package:flutter_conf_web/gen/assets.gen.dart';
import 'package:flutter_conf_web/l10n/l10n.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class AnimatedBannerWidget extends StatelessWidget {
  const AnimatedBannerWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Container(
      color: AppColors.secondaryColor,
      child: size.width > kBreakPoint
          ? const _AnimationDesktop()
          : const _AnimationMobile(),
    );
  }
}

class _AnimationDesktop extends StatelessWidget {
  const _AnimationDesktop();

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final size = MediaQuery.of(context).size;
    return Row(
      children: [
        Assets.animation.bubblesSides.lottie(),
        const Spacer(),
        if (size.width > 1400)
          WideBanner(l10n: l10n)
        else
          LongBanner(l10n: l10n),
        const Spacer(),
        Assets.animation.bubblesSides.lottie(),
      ],
    );
  }
}

class LongBanner extends StatelessWidget {
  const LongBanner({
    super.key,
    required this.l10n,
  });

  final AppLocalizations l10n;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          l10n.eventDate,
          style: GoogleFonts.inter(
            fontWeight: FontWeight.bold,
            color: Colors.white,
            fontSize: 12.sp,
          ),
        ),
        Text(
          l10n.eventPlace,
          style: GoogleFonts.inter(
            fontWeight: FontWeight.w200,
            color: Colors.white,
            fontSize: 8.sp,
          ),
          textAlign: TextAlign.end,
        ),
        const SizedBox(width: 20),
        Assets.animation.flutterHeartbeat.lottie(),
        const SizedBox(width: 20),
        Text(
          '${l10n.eventNameTitle} ${l10n.eventNameSubtitle}',
          style: GoogleFonts.inter(
            fontWeight: FontWeight.bold,
            color: Colors.white,
            fontSize: 12.sp,
          ),
        ),
        Text(
          l10n.eventCountry,
          style: GoogleFonts.inter(
            fontWeight: FontWeight.w200,
            color: Colors.white,
            fontSize: 8.sp,
          ),
          textAlign: TextAlign.start,
        ),
      ],
    );
  }
}

class WideBanner extends StatelessWidget {
  const WideBanner({
    super.key,
    required this.l10n,
  });

  final AppLocalizations l10n;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Column(
          children: [
            Text(
              l10n.eventDate,
              style: GoogleFonts.inter(
                fontWeight: FontWeight.bold,
                color: Colors.white,
                fontSize: 12.sp,
              ),
            ),
            Text(
              l10n.eventPlace,
              style: GoogleFonts.inter(
                fontWeight: FontWeight.w200,
                color: Colors.white,
                fontSize: 8.sp,
              ),
              textAlign: TextAlign.end,
            ),
          ],
        ),
        const SizedBox(width: 20),
        Assets.animation.flutterHeartbeat.lottie(),
        const SizedBox(width: 20),
        Column(
          children: [
            Text(
              '${l10n.eventNameTitle} ${l10n.eventNameSubtitle}',
              style: GoogleFonts.inter(
                fontWeight: FontWeight.bold,
                color: Colors.white,
                fontSize: 12.sp,
              ),
            ),
            Text(
              l10n.eventCountry,
              style: GoogleFonts.inter(
                fontWeight: FontWeight.w200,
                color: Colors.white,
                fontSize: 8.sp,
              ),
              textAlign: TextAlign.start,
            ),
          ],
        ),
      ],
    );
  }
}

class _AnimationMobile extends StatelessWidget {
  const _AnimationMobile();

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      mainAxisSize: MainAxisSize.min,
      children: [
        SizedBox(
          height: 100.h,
          width: size.width,
          child: Assets.animation.bubblesSides.lottie(),
        ),
        Column(
          children: [
            Column(
              children: [
                Text(
                  context.l10n.eventDate,
                  style: GoogleFonts.inter(
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                    fontSize: 12.sp,
                  ),
                ),
                Text(
                  context.l10n.eventPlace,
                  style: GoogleFonts.inter(
                    fontWeight: FontWeight.w200,
                    color: Colors.white,
                    fontSize: 8.sp,
                  ),
                  textAlign: TextAlign.end,
                ),
              ],
            ),
            SizedBox(
              child: Assets.animation.flutterHeartbeat.lottie(
                width: 200.w,
                height: 200.h,
              ),
            ),
            Column(
              children: [
                Text(
                  '${context.l10n.eventNameTitle} ${context.l10n.eventNameSubtitle}',
                  style: GoogleFonts.inter(
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                    fontSize: 12.sp,
                  ),
                ),
                Text(
                  context.l10n.eventCountry,
                  style: GoogleFonts.inter(
                    fontWeight: FontWeight.w200,
                    color: Colors.white,
                    fontSize: 8.sp,
                  ),
                  textAlign: TextAlign.start,
                ),
              ],
            ),
          ],
        ),
        SizedBox(
          height: 100.h,
          child: Assets.animation.bubblesSides.lottie(),
        ),
      ],
    );
  }
}

class _RotateWheelAnimation extends StatefulWidget {
  final double? height;
  final double? width;

  const _RotateWheelAnimation({
    this.height,
    this.width,
  });

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
    final size = MediaQuery.of(context).size;
    return RotationTransition(
      turns: Tween(begin: 0.0, end: 1.0).animate(_controller),
      child: DottedBorder(
        borderType: BorderType.Circle,
        color: Colors.white,
        strokeWidth: 4.dm,
        strokeCap: StrokeCap.round,
        dashPattern: [11.dm, 20.dm],
        child: Container(
          height: widget.height,
          width: widget.width,
          decoration: const BoxDecoration(
            shape: BoxShape.circle,
          ),
        ),
      ),
    );
  }
}

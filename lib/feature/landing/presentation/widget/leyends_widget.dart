import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

class LeyendsWidget extends StatelessWidget {
  const LeyendsWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return AnimatedTextKit(
      repeatForever: true,
      animatedTexts: [
        RotateAnimatedText(
          'Flutter conf Paraguay is comming...',
          textStyle: GoogleFonts.nunito(
            color: Colors.white,
            fontSize: 15.sp,
            fontWeight: FontWeight.w300,
          ),
        ),
        RotateAnimatedText(
          'Coding features...',
          textStyle: GoogleFonts.nunito(
              color: Colors.white,
              fontSize: 15.sp,
              fontWeight: FontWeight.w300,
              textStyle: TextStyle(overflow: TextOverflow.ellipsis)),
        ),
        RotateAnimatedText(
          'Making coffee...',
          textStyle: GoogleFonts.nunito(
            color: Colors.white,
            fontSize: 15.sp,
            fontWeight: FontWeight.w300,
          ),
        ),
        RotateAnimatedText(
          'Inviting speakers...',
          textStyle: GoogleFonts.nunito(
            color: Colors.white,
            fontSize: 15.sp,
            fontWeight: FontWeight.w300,
          ),
        ),
      ],
    );
  }
}

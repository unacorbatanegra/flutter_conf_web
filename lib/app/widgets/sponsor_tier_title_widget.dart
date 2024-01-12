import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_conf_web/app/sections/sponsor_section.dart';
import 'package:google_fonts/google_fonts.dart';

class SponsorTiertitle extends StatelessWidget {
  const SponsorTiertitle({
    super.key,
    required this.sponsorTier,
  });
  final SponsorTier sponsorTier;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(5),
      decoration: BoxDecoration(
        borderRadius: const BorderRadius.all(
          Radius.circular(100),
        ),
        border: Border.all(
          color: sponsorTier.tierColor,
          style: BorderStyle.solid,
        ),
      ),
      child: Container(
        padding: const EdgeInsets.symmetric(
          horizontal: 20,
          vertical: 10,
        ),
        decoration: BoxDecoration(
          color: sponsorTier.tierColor,
          borderRadius: const BorderRadius.all(
            Radius.circular(100),
          ),
        ),
        child: Text(
          sponsorTier.title,
          style: GoogleFonts.inter(
            fontSize: 24,
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}

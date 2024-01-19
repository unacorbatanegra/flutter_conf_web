import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_conf_web/app/widgets/sponsor_tier_title_widget.dart';
import 'package:flutter_conf_web/core/themes/colors.dart';
import 'package:flutter_conf_web/gen/assets.gen.dart';
import 'package:flutter_conf_web/l10n/l10n.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:url_launcher/url_launcher.dart';

enum SponsorTier {
  gold,
  silver,
  bronce;

  double get tierSize {
    return switch (this) {
      SponsorTier.gold => 3,
      SponsorTier.silver => 4,
      SponsorTier.bronce => 5,
    };
  }

  Color get tierColor {
    return switch (this) {
      SponsorTier.gold => AppColors.goldColor,
      SponsorTier.silver => AppColors.silverColor,
      SponsorTier.bronce => AppColors.bronceColor,
    };
  }

  String get title {
    return switch (this) {
      SponsorTier.gold => "Gold",
      SponsorTier.silver => "Silver",
      SponsorTier.bronce => "Bronce",
    };
  }
}

class SponsorSection extends StatelessWidget {
  const SponsorSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 40),
      width: MediaQuery.of(context).size.width,
      color: AppColors.secondaryColor,
      child: Column(
        children: [
          const SizedBox(
            height: 40,
          ),
          Container(
            padding: const EdgeInsets.all(
              20,
            ),
            decoration: const BoxDecoration(
              color: Color.fromRGBO(220, 237, 249, 0.38),
              borderRadius: BorderRadius.all(
                Radius.circular(100),
              ),
            ),
            child: Text(
              textAlign: TextAlign.center,
              context.l10n.thanksSponsorsLegend,
              style: GoogleFonts.inter(
                fontSize: 28,
                color: Colors.white,
                fontWeight: FontWeight.w300,
              ),
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          _SponsorTier(sponsorTier: SponsorTier.gold, sponsorAssetList: [
            (Assets.images.sponsors.ucomLogo, 'https://ucom.edu.py/'),
            (
              Assets.images.sponsors.mentormateLogo,
              'https://mentormate.com/es/'
            ),
          ]),
          const SizedBox(
            height: 20,
          ),
          _SponsorTier(sponsorTier: SponsorTier.silver, sponsorAssetList: [
            (Assets.images.sponsors.plubLogo, 'https://plub.com/'),
          ]),
          const SizedBox(
            height: 20,
          ),
        ],
      ),
    );
  }
}

class _SponsorTier extends StatelessWidget {
  const _SponsorTier({
    super.key,
    required this.sponsorTier,
    required this.sponsorAssetList,
  });
  final SponsorTier sponsorTier;
  final List<(AssetGenImage, String)> sponsorAssetList;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        SponsorTiertitle(
          sponsorTier: sponsorTier,
        ),
        Wrap(
          direction: Axis.horizontal,
          alignment: WrapAlignment.center,
          children: sponsorAssetList
              .map(
                (asset) => InkWell(
                  child: Padding(
                    padding: const EdgeInsets.only(
                      top: 20,
                    ),
                    child: asset.$1.image(
                      scale: sponsorTier.tierSize,
                    ),
                  ),
                  onTap: () {
                    launchUrl(
                      Uri.parse(asset.$2),
                      mode: LaunchMode.platformDefault,
                    );
                  },
                ),
              )
              .toList(),
        ),
      ],
    );
  }
}

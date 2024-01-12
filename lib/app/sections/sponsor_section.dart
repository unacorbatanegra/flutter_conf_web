import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_conf_web/app/widgets/sponsor_tier_title_widget.dart';
import 'package:flutter_conf_web/core/themes/colors.dart';
import 'package:flutter_conf_web/gen/assets.gen.dart';
import 'package:flutter_conf_web/l10n/l10n.dart';
import 'package:google_fonts/google_fonts.dart';

enum SponsorTier {
  gold,
  silver,
  bronce;

  double get tierSize {
    return switch (this) {
      SponsorTier.gold => 2,
      SponsorTier.silver => 3,
      SponsorTier.bronce => 4,
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
              context.l10n.thanksSponsorsLegend,
              style: GoogleFonts.inter(
                fontSize: 24,
                color: Colors.white,
              ),
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          _SponsorTier(sponsorTier: SponsorTier.gold, sponsorAssetList: [
            Assets.images.sponsors.ucomLogo,
            Assets.images.sponsors.ucomLogo,
            Assets.images.sponsors.ucomLogo,
            Assets.images.sponsors.ucomLogo,
          ]),
          const SizedBox(
            height: 20,
          ),
          _SponsorTier(
            sponsorTier: SponsorTier.silver,
            sponsorAssetList: [
              Assets.images.sponsors.ucomLogo,
            ],
          ),
          const SizedBox(
            height: 20,
          ),
          _SponsorTier(
            sponsorTier: SponsorTier.bronce,
            sponsorAssetList: [
              Assets.images.sponsors.ucomLogo,
            ],
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
  final List<AssetGenImage> sponsorAssetList;

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
          children: sponsorAssetList
              .map(
                (asset) => asset.image(
                  scale: sponsorTier.tierSize,
                ),
              )
              .toList(),
        ),
      ],
    );
  }
}

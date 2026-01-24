import 'package:flutter/material.dart';
import 'package:flutter_conf_web/app/models/conference_config.dart';
import 'package:flutter_conf_web/app/models/sponsor_model.dart';
import 'package:flutter_conf_web/app/services/url_service.dart';
import 'package:flutter_conf_web/core/constants/constants.dart';
import 'package:flutter_conf_web/l10n/l10n.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class SponsorSection extends StatelessWidget {
  final ConferenceConfig config;

  const SponsorSection({
    super.key,
    required this.config,
  });

  List<({SponsorModel sponsor, String tier})> _getAllSponsors() {
    final allSponsors = <({SponsorModel sponsor, String tier})>[];

    for (var sponsor in config.goldSponsors) {
      allSponsors.add((sponsor: sponsor, tier: 'gold'));
    }
    for (var sponsor in config.silverSponsors) {
      allSponsors.add((sponsor: sponsor, tier: 'silver'));
    }
    for (var sponsor in config.bronzeSponsors) {
      allSponsors.add((sponsor: sponsor, tier: 'bronze'));
    }

    return allSponsors;
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final l10n = context.l10n;
    final allSponsors = _getAllSponsors();
    final isDesktop = size.width > kBreakPoint;

    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(
        horizontal: isDesktop ? 80 : 20,
        vertical: isDesktop ? 100 : 60,
      ),
      decoration: const BoxDecoration(
        color: Color(0xFF1C2541),
      ),
      child: Column(
        children: [
          // Title
          Text(
            l10n.sponsors,
            style: GoogleFonts.lato(
              fontSize: isDesktop ? 48 : 36,
              fontWeight: FontWeight.w700,
              color: Colors.white,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 60),

          // Sponsor Display
          if (allSponsors.isEmpty)
            _EmptySponsorsState(isDesktop: isDesktop)
          else
            LayoutBuilder(
              builder: (context, constraints) {
                return SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: ConstrainedBox(
                    constraints: BoxConstraints(
                      minWidth: constraints.maxWidth,
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      mainAxisSize: MainAxisSize.min,
                      children: allSponsors.map((item) {
                        return Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 20),
                          child: _SponsorCard(
                            sponsor: item.sponsor,
                            tier: item.tier,
                          ),
                        );
                      }).toList(),
                    ),
                  ),
                );
              },
            ),
        ],
      ),
    );
  }
}

class _SponsorCard extends StatelessWidget {
  final SponsorModel sponsor;
  final String tier;

  const _SponsorCard({
    required this.sponsor,
    required this.tier,
  });

  String _getTierLabel(BuildContext context, String tier) {
    final l10n = context.l10n;
    switch (tier) {
      case 'gold':
        return l10n.goldTier;
      case 'silver':
        return l10n.silverTier;
      case 'bronze':
        return l10n.bronzeTier;
      default:
        return tier;
    }
  }

  Color _getTierColor(String tier) {
    switch (tier) {
      case 'gold':
        return const Color(0xFFFFD700); // Gold color
      case 'silver':
        return const Color(0xFFC0C0C0); // Silver color
      case 'bronze':
        return const Color(0xFFCD7F32); // Bronze color
      default:
        return Colors.grey;
    }
  }

  @override
  Widget build(BuildContext context) {
    final urlService = context.read<UrlService>();
    final tierLabel = _getTierLabel(context, tier);
    final tierColor = _getTierColor(tier);

    return Stack(
      clipBehavior: Clip.none,
      children: [
        MouseRegion(
          cursor: sponsor.websiteUrl != null
              ? SystemMouseCursors.click
              : SystemMouseCursors.basic,
          child: GestureDetector(
            onTap: sponsor.websiteUrl != null
                ? () => urlService.openUrl(sponsor.websiteUrl!)
                : null,
            child: Container(
              width: 180,
              height: 180,
              padding: const EdgeInsets.all(24),
              decoration: BoxDecoration(
                color: const Color(0xFFFFFFFF),
                borderRadius: BorderRadius.circular(20),
                border: Border.all(
                  color: Colors.grey.withOpacity(0.3),
                  width: 1.5,
                ),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.15),
                    blurRadius: 20,
                    offset: const Offset(0, 5),
                  ),
                ],
              ),
              child: Center(
                child: Semantics(
                  label: '${sponsor.name} logo',
                  image: true,
                  child: ConstrainedBox(
                    constraints: const BoxConstraints(
                      maxWidth: 120,
                      maxHeight: 120,
                    ),
                    child: _SponsorLogo(
                      logoPath: sponsor.logoPath,
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
        // Tier Badge
        Positioned(
          top: -10,
          right: -10,
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
            decoration: BoxDecoration(
              color: tierColor,
              borderRadius: BorderRadius.circular(20),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.2),
                  blurRadius: 8,
                  offset: const Offset(0, 2),
                ),
              ],
            ),
            child: Text(
              tierLabel,
              style: GoogleFonts.lato(
                fontSize: 12,
                fontWeight: FontWeight.w700,
                color: Colors.white,
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class _SponsorLogo extends StatelessWidget {
  final String logoPath;

  const _SponsorLogo({
    required this.logoPath,
  });

  @override
  Widget build(BuildContext context) {
    final isSvg = logoPath.toLowerCase().endsWith('.svg');

    if (isSvg) {
      return SvgPicture.asset(
        logoPath,
        fit: BoxFit.contain,
      );
    } else {
      return Image.asset(
        logoPath,
        fit: BoxFit.contain,
      );
    }
  }
}

class _EmptySponsorsState extends StatelessWidget {
  final bool isDesktop;

  const _EmptySponsorsState({required this.isDesktop});

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;

    return SizedBox(
      height: isDesktop ? 400 : 300,
      child: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.business_outlined,
                size: isDesktop ? 80 : 60,
                color: Colors.white.withOpacity(0.3),
              ),
              const SizedBox(height: 24),
              Text(
                l10n.comingSoon,
                style: GoogleFonts.lato(
                  fontSize: isDesktop ? 32 : 24,
                  fontWeight: FontWeight.w700,
                  color: Colors.white,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 16),
              Text(
                l10n.sponsorsComingSoonDescription,
                style: GoogleFonts.lato(
                  fontSize: isDesktop ? 16 : 14,
                  fontWeight: FontWeight.w400,
                  color: Colors.white.withOpacity(0.7),
                  height: 1.5,
                ),
                textAlign: TextAlign.center,
                maxLines: 2,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
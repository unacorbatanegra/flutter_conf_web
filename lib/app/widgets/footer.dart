import 'package:flutter/material.dart';
import 'package:flutter_conf_web/app/models/conference_config.dart';
import 'package:flutter_conf_web/app/services/url_service.dart';
import 'package:flutter_conf_web/core/constants/constants.dart';
import 'package:flutter_conf_web/gen/assets.gen.dart';
import 'package:flutter_conf_web/l10n/l10n.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class Footer extends StatelessWidget {
  final ConferenceConfig config;

  const Footer({
    super.key,
    required this.config,
  });

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final isDesktop = size.width > kBreakPoint;

    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(
        horizontal: isDesktop ? 80 : 20,
        vertical: isDesktop ? 40 : 30,
      ),
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            Color(0xFF1C2541),
            Color(0xFF0B1929),
          ],
        ),
      ),
      child: isDesktop
          ? _FooterDesktop(config: config)
          : _FooterMobile(config: config),
    );
  }
}

class _FooterDesktop extends StatelessWidget {
  final ConferenceConfig config;

  const _FooterDesktop({
    required this.config,
  });

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;

    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        RichText(
          text: TextSpan(
            children: [
              TextSpan(
                text: l10n.madeWith,
                style: GoogleFonts.lato(
                  color: Colors.white,
                  fontSize: 14,
                ),
              ),
              TextSpan(
                text: ' 💙 ',
                style: GoogleFonts.lato(
                  color: Colors.red,
                  fontSize: 14,
                ),
              ),
              TextSpan(
                text: l10n.by,
                style: GoogleFonts.lato(
                  color: Colors.white,
                  fontSize: 14,
                ),
              ),
              TextSpan(
                text: ' FlutterConf Paraguay',
                style: GoogleFonts.lato(
                  color: const Color(0xFF5983F8),
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
        ),
        const SizedBox(width: 20),
        _SocialMediaLinks(config: config),
      ],
    );
  }
}

class _FooterMobile extends StatelessWidget {
  final ConferenceConfig config;

  const _FooterMobile({
    required this.config,
  });

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;

    return Column(
      children: [
        _SocialMediaLinks(config: config),
        const SizedBox(height: 16),
        RichText(
          textAlign: TextAlign.center,
          text: TextSpan(
            children: [
              TextSpan(
                text: l10n.madeWith,
                style: GoogleFonts.lato(
                  color: Colors.white,
                  fontSize: 14,
                ),
              ),
              TextSpan(
                text: ' 💙 ',
                style: GoogleFonts.lato(
                  color: Colors.red,
                  fontSize: 14,
                ),
              ),
              TextSpan(
                text: l10n.by,
                style: GoogleFonts.lato(
                  color: Colors.white,
                  fontSize: 14,
                ),
              ),
              TextSpan(
                text: ' FlutterConf Paraguay ${config.year}',
                style: GoogleFonts.lato(
                  color: const Color(0xFF5983F8),
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class _SocialMediaLinks extends StatelessWidget {
  final ConferenceConfig config;

  const _SocialMediaLinks({
    required this.config,
  });

  @override
  Widget build(BuildContext context) {
    final urlService = context.read<UrlService>();
    final availableLinks = config.availableSocialLinks;

    if (availableLinks.isEmpty) {
      return const SizedBox.shrink();
    }

    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: availableLinks.map((entry) {
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8),
          child: IconButton(
            tooltip: _getTooltip(entry.key),
            onPressed: () => urlService.openUrl(entry.value),
            icon: _getSocialIcon(entry.key),
            iconSize: 20,
            constraints: const BoxConstraints(
              minWidth: 40,
              minHeight: 40,
            ),
          ),
        );
      }).toList(),
    );
  }

  String _getTooltip(String platform) {
    switch (platform) {
      case 'github':
        return 'GitHub';
      case 'twitter':
        return 'X (Twitter)';
      case 'linkedin':
        return 'LinkedIn';
      case 'instagram':
        return 'Instagram';
      default:
        return '';
    }
  }

  Widget _getSocialIcon(String platform) {
    switch (platform) {
      case 'github':
        return Assets.icons.github.svg(
          width: 20,
          height: 20,
          colorFilter: const ColorFilter.mode(
            Colors.white,
            BlendMode.srcIn,
          ),
        );
      case 'twitter':
        return Assets.icons.x.svg(
          width: 20,
          height: 20,
          colorFilter: const ColorFilter.mode(
            Colors.white,
            BlendMode.srcIn,
          ),
        );
      case 'linkedin':
        return Assets.icons.linkedin.svg(
          width: 20,
          height: 20,
          colorFilter: const ColorFilter.mode(
            Colors.white,
            BlendMode.srcIn,
          ),
        );
      case 'instagram':
        return Assets.icons.instagram.svg(
          width: 20,
          height: 20,
          colorFilter: const ColorFilter.mode(
            Colors.white,
            BlendMode.srcIn,
          ),
        );
      default:
        return const SizedBox.shrink();
    }
  }
}

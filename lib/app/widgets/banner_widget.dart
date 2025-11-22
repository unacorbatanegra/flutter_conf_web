import 'package:flutter/material.dart';
import 'package:flutter_conf_web/app/models/conference_config.dart';
import 'package:flutter_conf_web/app/widgets/countdown_timer.dart';
import 'package:flutter_conf_web/core/constants/constants.dart';
import 'package:flutter_conf_web/gen/assets.gen.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

class BannerWidget extends StatefulWidget {
  final ConferenceConfig config;

  const BannerWidget({
    super.key,
    required this.config,
  });

  @override
  State<BannerWidget> createState() => _BannerWidgetState();
}

class _BannerWidgetState extends State<BannerWidget> {
  late String _formattedEventInfo;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _formattedEventInfo = _formatEventInfo();
  }

  String _formatEventInfo() {
    final locale = Localizations.localeOf(context);
    final isSpanish = locale.languageCode == 'es';
    final format = isSpanish
        ? DateFormat('d \'de\' MMMM \'de\' y', 'es')
        : DateFormat('MMMM d, y', 'en');
    final eventDate = format.format(widget.config.eventDate);
    return '${eventDate.toUpperCase()} | ${widget.config.venue.toUpperCase()}, ${widget.config.location.toUpperCase()}';
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final isDesktop = size.width > kBreakPoint;

    return Container(
      width: double.infinity,
      constraints: BoxConstraints(
        minHeight: isDesktop ? 700 : 600,
      ),
      decoration: const BoxDecoration(
        color: Color(0xFF1a1d3a),
      ),
      child: Stack(
        children: [
          // Background Image
          Positioned.fill(
            child: Assets.images.backgroundImageBannerJpg.image(
              fit: BoxFit.cover,
            ),
          ),
          // Gradient Overlay
          Positioned.fill(
            child: Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    Colors.black.withOpacity(0.3),
                    Colors.black.withOpacity(0.6),
                  ],
                ),
              ),
            ),
          ),
          // Content
          Center(
            child: Padding(
              padding: EdgeInsets.symmetric(
                horizontal: isDesktop ? 80 : 20,
                vertical: 60,
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // Flutter Logo
                  Assets.images.fullLogoSvg.svg(
                    height: isDesktop ? 200 : 150,
                  ),
                  const SizedBox(height: 40),

                  // Event Date and Location
                  _EventInfo(eventInfo: _formattedEventInfo),
                  const SizedBox(height: 30),

                  // Description
                  _Description(config: widget.config),
                  const SizedBox(height: 50),

                  // Countdown Timer
                  CountdownTimer(eventDate: widget.config.eventDate),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _EventInfo extends StatelessWidget {
  final String eventInfo;

  const _EventInfo({
    required this.eventInfo,
  });

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Text(
      eventInfo,
      style: GoogleFonts.lato(
        fontSize: size.width > kBreakPoint ? 28 : 20,
        fontWeight: FontWeight.w700,
        color: Colors.white,
        letterSpacing: 1.2,
      ),
      textAlign: TextAlign.center,
    );
  }
}

class _Description extends StatelessWidget {
  final ConferenceConfig config;

  const _Description({
    required this.config,
  });

  String _getBannerDescription(Locale locale) {
    return locale.languageCode == 'es'
        ? config.bannerDescriptionEs
        : config.bannerDescriptionEn;
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final locale = Localizations.localeOf(context);
    final description = _getBannerDescription(locale);

    return Container(
      constraints: const BoxConstraints(maxWidth: 900),
      child: Text(
        description,
        style: GoogleFonts.lato(
          fontSize: size.width > kBreakPoint ? 16 : 14,
          fontWeight: FontWeight.w400,
          color: Colors.white.withOpacity(0.9),
          height: 1.6,
        ),
        textAlign: TextAlign.center,
      ),
    );
  }
}

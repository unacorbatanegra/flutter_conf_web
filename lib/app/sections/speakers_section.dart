import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_conf_web/app/models/speaker_model.dart';
import 'package:flutter_conf_web/app/services/url_service.dart';
import 'package:flutter_conf_web/core/constants/constants.dart';
import 'package:flutter_conf_web/gen/assets.gen.dart';
import 'package:flutter_conf_web/l10n/l10n.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:seo_renderer/seo_renderer.dart';

class SpeakersSection extends StatefulWidget {
  final List<SpeakerModel> speakers;

  const SpeakersSection({
    super.key,
    required this.speakers,
  });

  @override
  State<SpeakersSection> createState() => _SpeakersSectionState();
}

class _SpeakersSectionState extends State<SpeakersSection> {
  int _currentPage = 0;
  Timer? _timer;

  @override
  void initState() {
    super.initState();
    _startAutoPlay();
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  void _startAutoPlay() {
    _timer = Timer.periodic(const Duration(seconds: 5), (timer) {
      if (mounted) {
        final isDesktop = MediaQuery.of(context).size.width > kBreakPoint;
        final pageCount = _getPageCount(isDesktop);

        if (pageCount > 1) {
          setState(() {
            _currentPage = (_currentPage + 1) % pageCount;
          });
        }
      }
    });
  }

  void _resetTimer() {
    _timer?.cancel();
    _startAutoPlay();
  }

  int _getPageCount(bool isDesktop) {
    if (widget.speakers.isEmpty) return 0;
    return isDesktop ? (widget.speakers.length / 3).ceil() : widget.speakers.length;
  }

  void _onPrevious() {
    if (_currentPage > 0) {
      setState(() {
        _currentPage--;
      });
      _resetTimer();
    }
  }

  void _onNext(bool isDesktop) {
    if (_currentPage < _getPageCount(isDesktop) - 1) {
      setState(() {
        _currentPage++;
      });
      _resetTimer();
    }
  }

  List<SpeakerModel> _getCurrentPageSpeakers() {
    final startIndex = _currentPage * 3;
    final endIndex = (startIndex + 3).clamp(0, widget.speakers.length);
    return widget.speakers.sublist(startIndex, endIndex);
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final isDesktop = size.width > kBreakPoint;
    final l10n = context.l10n;

    final pageCount = _getPageCount(isDesktop);
    if (_currentPage >= pageCount && pageCount > 0) {
      _currentPage = pageCount - 1;
    }

    return Container(
      width: double.infinity,
      constraints: BoxConstraints(
        minHeight: isDesktop ? 900 : 800,
      ),
      decoration: const BoxDecoration(
        color: Color(0xFF1C2541),
      ),
      child: Stack(
        children: [
          // Background Image
          Positioned.fill(
            child: Assets.images.speakerBackground1.svg(
              fit: BoxFit.cover,
            ),
          ),
          // Content
          Padding(
            padding: EdgeInsets.symmetric(
              horizontal: isDesktop ? 80 : 20,
              vertical: isDesktop ? 100 : 60,
            ),
            child: Column(
              children: [
                // Title
                TextRenderer(
                  child: Text(
                    l10n.ourSpeakers,
                    style: GoogleFonts.lato(
                      fontSize: isDesktop ? 48 : 32,
                      fontWeight: FontWeight.w700,
                      color: Colors.white,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
                const SizedBox(height: 60),

                // Speaker Display
                if (widget.speakers.isNotEmpty)
                  SizedBox(
                    height: isDesktop ? 600 : 550,
                    child: isDesktop
                        ? _DesktopSpeakerLayout(
                            speakers: _getCurrentPageSpeakers(),
                          )
                        : _MobileSpeakerLayout(
                            speaker: widget.speakers[_currentPage.clamp(0, widget.speakers.length - 1)],
                          ),
                  )
                else
                  _EmptySpeakersState(isDesktop: isDesktop),

                const SizedBox(height: 40),

                // Navigation Controls
                if (widget.speakers.isNotEmpty)
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      IconButton(
                        onPressed: _currentPage > 0 ? _onPrevious : null,
                        tooltip: 'Previous speakers',
                        icon: Icon(
                          Icons.arrow_back_ios,
                          color: _currentPage > 0
                              ? Colors.white
                              : Colors.white.withOpacity(0.3),
                        ),
                      ),
                      const SizedBox(width: 20),
                      _CarouselIndicators(
                        currentPage: _currentPage,
                        itemCount: pageCount,
                      ),
                      const SizedBox(width: 20),
                      IconButton(
                        onPressed: _currentPage < pageCount - 1
                            ? () => _onNext(isDesktop)
                            : null,
                        tooltip: 'Next speakers',
                        icon: Icon(
                          Icons.arrow_forward_ios,
                          color: _currentPage < pageCount - 1
                              ? Colors.white
                              : Colors.white.withOpacity(0.3),
                        ),
                      ),
                    ],
                  ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _DesktopSpeakerLayout extends StatelessWidget {
  final List<SpeakerModel> speakers;

  const _DesktopSpeakerLayout({
    required this.speakers,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: speakers.map((speaker) {
        return Flexible(
          child: Container(
            constraints: const BoxConstraints(maxWidth: 400),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15),
              child: _SpeakerCard(speaker: speaker),
            ),
          ),
        );
      }).toList(),
    );
  }
}

class _MobileSpeakerLayout extends StatelessWidget {
  final SpeakerModel speaker;

  const _MobileSpeakerLayout({
    required this.speaker,
  });

  @override
  Widget build(BuildContext context) {
    return _SpeakerCard(speaker: speaker);
  }
}

class _SpeakerCard extends StatelessWidget {
  final SpeakerModel speaker;

  const _SpeakerCard({
    required this.speaker,
  });

  String _getTalkTitle(Locale locale) {
    return locale.languageCode == 'es'
        ? (speaker.talkTitleEs ?? speaker.profession)
        : (speaker.talkTitleEn ?? speaker.profession);
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final isMobile = size.width <= kBreakPoint;
    final locale = Localizations.localeOf(context);
    final talkTitle = _getTalkTitle(locale);

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        // Speaker Image
        Semantics(
          label: '${speaker.name} headshot',
          image: true,
          child: AspectRatio(
            aspectRatio: 4 / 3,
            child: Container(
              width: isMobile ? size.width * 0.8 : double.infinity,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16),
                image: DecorationImage(
                  image: AssetImage(speaker.imagePath),
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),
        ),
        const SizedBox(height: 24),

        // Speaker Name with Country Emoji
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextRenderer(
              child: Text(
                speaker.name,
                style: GoogleFonts.lato(
                  fontSize: 20,
                  fontWeight: FontWeight.w700,
                  color: Colors.white,
                ),
                textAlign: TextAlign.center,
              ),
            ),
            const SizedBox(width: 8),
            Text(
              speaker.countryEmoji,
              style: const TextStyle(fontSize: 20),
            ),
          ],
        ),
        const SizedBox(height: 12),

        // GDE Badge (if applicable)
        if (speaker.gdeCategory != null) ...[
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
            decoration: BoxDecoration(
              color: const Color(0xFF5983F8),
              borderRadius: BorderRadius.circular(20),
            ),
            child: Text(
              'GDE ${speaker.gdeCategory}',
              style: GoogleFonts.lato(
                fontSize: 12,
                fontWeight: FontWeight.w600,
                color: Colors.white,
              ),
            ),
          ),
          const SizedBox(height: 12),
        ],

        // Talk Description
        TextRenderer(
          child: Text(
            talkTitle,
            style: GoogleFonts.lato(
              fontSize: 14,
              fontWeight: FontWeight.w400,
              color: Colors.white.withOpacity(0.8),
              height: 1.5,
            ),
            textAlign: TextAlign.center,
            maxLines: 6,
            overflow: TextOverflow.ellipsis,
          ),
        ),
        const SizedBox(height: 16),

        // Social Media Links
        _SocialMediaLinks(speaker: speaker),
      ],
    );
  }
}

class _SocialMediaLinks extends StatelessWidget {
  final SpeakerModel speaker;

  const _SocialMediaLinks({
    required this.speaker,
  });

  @override
  Widget build(BuildContext context) {
    final urlService = context.read<UrlService>();
    final availableLinks = speaker.availableSocialLinks;

    if (availableLinks.isEmpty) {
      return const SizedBox.shrink();
    }

    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: availableLinks.map((entry) {
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8),
          child: Semantics(
            label: "Open ${speaker.name}'s ${_getPlatformName(entry.key)} profile",
            button: true,
            child: InkWell(
              onTap: () => urlService.openUrl(entry.value),
              borderRadius: BorderRadius.circular(20),
              child: Container(
                width: 40,
                height: 40,
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.1),
                  shape: BoxShape.circle,
                ),
                child: Center(
                  child: _getSocialIcon(entry.key),
                ),
              ),
            ),
          ),
        );
      }).toList(),
    );
  }

  Widget _getSocialIcon(String platform) {
    switch (platform) {
      case 'linkedin':
        return Assets.icons.linkedin.svg(
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
      case 'youtube':
        return Assets.icons.youtube.svg(
          width: 20,
          height: 20,
          colorFilter: const ColorFilter.mode(
            Colors.white,
            BlendMode.srcIn,
          ),
        );
      case 'facebook':
        return Assets.icons.facebook.svg(
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

  String _getPlatformName(String platform) {
    switch (platform) {
      case 'linkedin':
        return 'LinkedIn';
      case 'twitter':
        return 'X (Twitter)';
      case 'youtube':
        return 'YouTube';
      case 'facebook':
        return 'Facebook';
      default:
        return platform;
    }
  }
}

class _CarouselIndicators extends StatelessWidget {
  final int currentPage;
  final int itemCount;

  const _CarouselIndicators({
    required this.currentPage,
    required this.itemCount,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(
        itemCount,
        (index) => AnimatedContainer(
          duration: const Duration(milliseconds: 300),
          margin: const EdgeInsets.symmetric(horizontal: 4),
          width: currentPage == index ? 12 : 8,
          height: currentPage == index ? 12 : 8,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: currentPage == index
                ? const Color(0xFF5983F8)
                : Colors.white.withOpacity(0.4),
          ),
        ),
      ),
    );
  }
}

class _EmptySpeakersState extends StatelessWidget {
  final bool isDesktop;

  const _EmptySpeakersState({required this.isDesktop});

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
                Icons.mic_outlined,
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
                l10n.speakersComingSoonDescription,
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

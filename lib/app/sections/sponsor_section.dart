import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_conf_web/app/models/conference_config.dart';
import 'package:flutter_conf_web/app/services/url_service.dart';
import 'package:flutter_conf_web/core/constants/constants.dart';
import 'package:flutter_conf_web/l10n/l10n.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class SponsorSection extends StatefulWidget {
  final ConferenceConfig config;

  const SponsorSection({
    super.key,
    required this.config,
  });

  @override
  State<SponsorSection> createState() => _SponsorSectionState();
}

class _SponsorSectionState extends State<SponsorSection> {
  int _goldSponsorIndex = 0;
  int _silverSponsorIndex = 0;
  Timer? _goldTimer;
  Timer? _silverTimer;

  @override
  void initState() {
    super.initState();
    _startAutoPlay();
  }

  @override
  void dispose() {
    _goldTimer?.cancel();
    _silverTimer?.cancel();
    super.dispose();
  }

  void _startAutoPlay() {
    final goldSponsors = widget.config.goldSponsors;
    final silverSponsors = widget.config.silverSponsors;

    // Auto-play for gold sponsors
    if (goldSponsors.length > 1) {
      _goldTimer = Timer.periodic(const Duration(seconds: 5), (timer) {
        if (mounted) {
          setState(() {
            _goldSponsorIndex = (_goldSponsorIndex + 1) % goldSponsors.length;
          });
        }
      });
    }

    // Auto-play for silver sponsors
    if (silverSponsors.length > 1) {
      _silverTimer = Timer.periodic(const Duration(seconds: 5), (timer) {
        if (mounted) {
          setState(() {
            _silverSponsorIndex =
                (_silverSponsorIndex + 1) % silverSponsors.length;
          });
        }
      });
    }
  }

  void _resetGoldTimer() {
    _goldTimer?.cancel();
    final goldSponsors = widget.config.goldSponsors;
    if (goldSponsors.length > 1) {
      _goldTimer = Timer.periodic(const Duration(seconds: 5), (timer) {
        if (mounted) {
          setState(() {
            _goldSponsorIndex = (_goldSponsorIndex + 1) % goldSponsors.length;
          });
        }
      });
    }
  }

  void _resetSilverTimer() {
    _silverTimer?.cancel();
    final silverSponsors = widget.config.silverSponsors;
    if (silverSponsors.length > 1) {
      _silverTimer = Timer.periodic(const Duration(seconds: 5), (timer) {
        if (mounted) {
          setState(() {
            _silverSponsorIndex =
                (_silverSponsorIndex + 1) % silverSponsors.length;
          });
        }
      });
    }
  }

  void _onGoldPrevious() {
    if (_goldSponsorIndex > 0) {
      setState(() {
        _goldSponsorIndex--;
      });
      _resetGoldTimer();
    }
  }

  void _onGoldNext() {
    final goldSponsors = widget.config.goldSponsors;
    if (_goldSponsorIndex < goldSponsors.length - 1) {
      setState(() {
        _goldSponsorIndex++;
      });
      _resetGoldTimer();
    }
  }

  void _onSilverPrevious() {
    if (_silverSponsorIndex > 0) {
      setState(() {
        _silverSponsorIndex--;
      });
      _resetSilverTimer();
    }
  }

  void _onSilverNext() {
    final silverSponsors = widget.config.silverSponsors;
    if (_silverSponsorIndex < silverSponsors.length - 1) {
      setState(() {
        _silverSponsorIndex++;
      });
      _resetSilverTimer();
    }
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final l10n = context.l10n;

    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(
        horizontal: size.width > kBreakPoint ? 80 : 20,
        vertical: size.width > kBreakPoint ? 100 : 60,
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
              fontSize: size.width > kBreakPoint ? 48 : 36,
              fontWeight: FontWeight.w700,
              color: Colors.white,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 60),

          // Sponsor Tiers
          if (size.width > kBreakPoint)
            _DesktopLayout(
              config: widget.config,
              goldSponsorIndex: _goldSponsorIndex,
              silverSponsorIndex: _silverSponsorIndex,
              onGoldPrevious: _onGoldPrevious,
              onGoldNext: _onGoldNext,
              onSilverPrevious: _onSilverPrevious,
              onSilverNext: _onSilverNext,
            )
          else
            _MobileLayout(
              config: widget.config,
              goldSponsorIndex: _goldSponsorIndex,
              silverSponsorIndex: _silverSponsorIndex,
              onGoldPrevious: _onGoldPrevious,
              onGoldNext: _onGoldNext,
              onSilverPrevious: _onSilverPrevious,
              onSilverNext: _onSilverNext,
            ),
        ],
      ),
    );
  }
}

class _DesktopLayout extends StatelessWidget {
  final ConferenceConfig config;
  final int goldSponsorIndex;
  final int silverSponsorIndex;
  final VoidCallback onGoldPrevious;
  final VoidCallback onGoldNext;
  final VoidCallback onSilverPrevious;
  final VoidCallback onSilverNext;

  const _DesktopLayout({
    required this.config,
    required this.goldSponsorIndex,
    required this.silverSponsorIndex,
    required this.onGoldPrevious,
    required this.onGoldNext,
    required this.onSilverPrevious,
    required this.onSilverNext,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Gold Sponsors
        Expanded(
          child: _GoldTier(
            config: config,
            currentIndex: goldSponsorIndex,
            onPrevious: onGoldPrevious,
            onNext: onGoldNext,
          ),
        ),
        const SizedBox(width: 60),

        // Silver Sponsors
        Expanded(
          child: _SilverTier(
            config: config,
            currentIndex: silverSponsorIndex,
            onPrevious: onSilverPrevious,
            onNext: onSilverNext,
          ),
        ),
      ],
    );
  }
}

class _MobileLayout extends StatelessWidget {
  final ConferenceConfig config;
  final int goldSponsorIndex;
  final int silverSponsorIndex;
  final VoidCallback onGoldPrevious;
  final VoidCallback onGoldNext;
  final VoidCallback onSilverPrevious;
  final VoidCallback onSilverNext;

  const _MobileLayout({
    required this.config,
    required this.goldSponsorIndex,
    required this.silverSponsorIndex,
    required this.onGoldPrevious,
    required this.onGoldNext,
    required this.onSilverPrevious,
    required this.onSilverNext,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        _GoldTier(
          config: config,
          currentIndex: goldSponsorIndex,
          onPrevious: onGoldPrevious,
          onNext: onGoldNext,
        ),
        const SizedBox(height: 40),
        _SilverTier(
          config: config,
          currentIndex: silverSponsorIndex,
          onPrevious: onSilverPrevious,
          onNext: onSilverNext,
        ),
      ],
    );
  }
}

class _GoldTier extends StatelessWidget {
  final ConferenceConfig config;
  final int currentIndex;
  final VoidCallback onPrevious;
  final VoidCallback onNext;

  const _GoldTier({
    required this.config,
    required this.currentIndex,
    required this.onPrevious,
    required this.onNext,
  });

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final urlService = context.read<UrlService>();
    final goldSponsors = config.goldSponsors;

    if (goldSponsors.isEmpty) return const SizedBox.shrink();

    final currentSponsor = goldSponsors[currentIndex];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Tier Title
        Text(
          l10n.goldTier,
          style: GoogleFonts.lato(
            fontSize: 36,
            fontWeight: FontWeight.w700,
            color: Colors.white,
          ),
        ),
        const SizedBox(height: 32),

        // Single Sponsor Display
        Column(
          children: [
            // Large Sponsor Box
            MouseRegion(
              cursor: currentSponsor.websiteUrl != null
                  ? SystemMouseCursors.click
                  : SystemMouseCursors.basic,
              child: GestureDetector(
                onTap: currentSponsor.websiteUrl != null
                    ? () => urlService.openUrl(currentSponsor.websiteUrl!)
                    : null,
                child: Container(
                  height: 280,
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
                      label: '${currentSponsor.name} logo',
                      image: true,
                      child: Image.asset(
                        currentSponsor.logoPath,
                        height: 120,
                        fit: BoxFit.contain,
                      ),
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 24),

            // Description
            Text(
              currentSponsor.description,
              style: GoogleFonts.lato(
                fontSize: 14,
                fontWeight: FontWeight.w400,
                color: Colors.white.withOpacity(0.8),
                height: 1.6,
              ),
            ),
            const SizedBox(height: 24),
          ],
        ),

        // Carousel Controls
        if (goldSponsors.length > 1)
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              _CarouselDots(
                totalItems: goldSponsors.length,
                currentIndex: currentIndex,
              ),
              Row(
                children: [
                  IconButton(
                    onPressed: currentIndex > 0 ? onPrevious : null,
                    tooltip: 'Previous gold sponsor',
                    icon: const Icon(Icons.arrow_back_ios, color: Colors.white),
                  ),
                  IconButton(
                    onPressed:
                        currentIndex < goldSponsors.length - 1 ? onNext : null,
                    tooltip: 'Next gold sponsor',
                    icon:
                        const Icon(Icons.arrow_forward_ios, color: Colors.white),
                  ),
                ],
              ),
            ],
          ),
      ],
    );
  }
}

class _SilverTier extends StatelessWidget {
  final ConferenceConfig config;
  final int currentIndex;
  final VoidCallback onPrevious;
  final VoidCallback onNext;

  const _SilverTier({
    required this.config,
    required this.currentIndex,
    required this.onPrevious,
    required this.onNext,
  });

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final urlService = context.read<UrlService>();
    final silverSponsors = config.silverSponsors;

    if (silverSponsors.isEmpty) return const SizedBox.shrink();

    final currentSponsor = silverSponsors[currentIndex];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Tier Title
        Text(
          l10n.silverTier,
          style: GoogleFonts.lato(
            fontSize: 36,
            fontWeight: FontWeight.w700,
            color: Colors.white,
          ),
        ),
        const SizedBox(height: 32),

        // Single Sponsor Display
        Column(
          children: [
            // Silver Sponsor Box
            MouseRegion(
              cursor: currentSponsor.websiteUrl != null
                  ? SystemMouseCursors.click
                  : SystemMouseCursors.basic,
              child: GestureDetector(
                onTap: currentSponsor.websiteUrl != null
                    ? () => urlService.openUrl(currentSponsor.websiteUrl!)
                    : null,
                child: Container(
                  height: 140,
                  padding: const EdgeInsets.all(20),
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
                      label: '${currentSponsor.name} logo',
                      image: true,
                      child: Image.asset(
                        currentSponsor.logoPath,
                        height: 60,
                        fit: BoxFit.contain,
                      ),
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 16),

            // Description
            Text(
              currentSponsor.description,
              style: GoogleFonts.lato(
                fontSize: 14,
                fontWeight: FontWeight.w400,
                color: Colors.white.withOpacity(0.8),
                height: 1.6,
              ),
            ),
            const SizedBox(height: 24),
          ],
        ),

        // Carousel Controls
        if (silverSponsors.length > 1)
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              _CarouselDots(
                totalItems: silverSponsors.length,
                currentIndex: currentIndex,
              ),
              Row(
                children: [
                  IconButton(
                    onPressed: currentIndex > 0 ? onPrevious : null,
                    tooltip: 'Previous silver sponsor',
                    icon: const Icon(Icons.arrow_back_ios, color: Colors.white),
                  ),
                  IconButton(
                    onPressed: currentIndex < silverSponsors.length - 1
                        ? onNext
                        : null,
                    tooltip: 'Next silver sponsor',
                    icon:
                        const Icon(Icons.arrow_forward_ios, color: Colors.white),
                  ),
                ],
              ),
            ],
          ),
      ],
    );
  }
}

class _CarouselDots extends StatelessWidget {
  final int totalItems;
  final int currentIndex;

  const _CarouselDots({
    required this.totalItems,
    required this.currentIndex,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: List.generate(
        totalItems,
        (index) => Container(
          margin: const EdgeInsets.symmetric(horizontal: 4),
          width: index == currentIndex ? 10 : 8,
          height: index == currentIndex ? 10 : 8,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: index == currentIndex
                ? const Color(0xFF5983F8)
                : Colors.white.withOpacity(0.3),
          ),
        ),
      ),
    );
  }
}

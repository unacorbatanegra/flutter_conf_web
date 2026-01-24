import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_conf_web/app/models/conference_config.dart';
import 'package:flutter_conf_web/app/services/url_service.dart';
import 'package:flutter_conf_web/core/constants/constants.dart';
import 'package:flutter_conf_web/l10n/l10n.dart';
import 'package:flutter_svg/flutter_svg.dart';
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
  int _bronzeSponsorIndex = 0;
  Timer? _goldTimer;
  Timer? _silverTimer;
  Timer? _bronzeTimer;

  @override
  void initState() {
    super.initState();
    _startAutoPlay();
  }

  @override
  void dispose() {
    _goldTimer?.cancel();
    _silverTimer?.cancel();
    _bronzeTimer?.cancel();
    super.dispose();
  }

  void _startAutoPlay() {
    final goldSponsors = widget.config.goldSponsors;
    final silverSponsors = widget.config.silverSponsors;
    final bronzeSponsors = widget.config.bronzeSponsors;

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

    // Auto-play for bronze sponsors
    if (bronzeSponsors.length > 1) {
      _bronzeTimer = Timer.periodic(const Duration(seconds: 5), (timer) {
        if (mounted) {
          setState(() {
            _bronzeSponsorIndex =
                (_bronzeSponsorIndex + 1) % bronzeSponsors.length;
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

  void _resetBronzeTimer() {
    _bronzeTimer?.cancel();
    final bronzeSponsors = widget.config.bronzeSponsors;
    if (bronzeSponsors.length > 1) {
      _bronzeTimer = Timer.periodic(const Duration(seconds: 5), (timer) {
        if (mounted) {
          setState(() {
            _bronzeSponsorIndex =
                (_bronzeSponsorIndex + 1) % bronzeSponsors.length;
          });
        }
      });
    }
  }

  void _onBronzePrevious() {
    if (_bronzeSponsorIndex > 0) {
      setState(() {
        _bronzeSponsorIndex--;
      });
      _resetBronzeTimer();
    }
  }

  void _onBronzeNext() {
    final bronzeSponsors = widget.config.bronzeSponsors;
    if (_bronzeSponsorIndex < bronzeSponsors.length - 1) {
      setState(() {
        _bronzeSponsorIndex++;
      });
      _resetBronzeTimer();
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
          if (widget.config.goldSponsors.isEmpty &&
              widget.config.silverSponsors.isEmpty &&
              widget.config.bronzeSponsors.isEmpty)
            _EmptySponsorsState(isDesktop: size.width > kBreakPoint)
          else if (size.width > kBreakPoint)
            _DesktopLayout(
              config: widget.config,
              goldSponsorIndex: _goldSponsorIndex,
              silverSponsorIndex: _silverSponsorIndex,
              bronzeSponsorIndex: _bronzeSponsorIndex,
              onGoldPrevious: _onGoldPrevious,
              onGoldNext: _onGoldNext,
              onSilverPrevious: _onSilverPrevious,
              onSilverNext: _onSilverNext,
              onBronzePrevious: _onBronzePrevious,
              onBronzeNext: _onBronzeNext,
            )
          else
            _MobileLayout(
              config: widget.config,
              goldSponsorIndex: _goldSponsorIndex,
              silverSponsorIndex: _silverSponsorIndex,
              bronzeSponsorIndex: _bronzeSponsorIndex,
              onGoldPrevious: _onGoldPrevious,
              onGoldNext: _onGoldNext,
              onSilverPrevious: _onSilverPrevious,
              onSilverNext: _onSilverNext,
              onBronzePrevious: _onBronzePrevious,
              onBronzeNext: _onBronzeNext,
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
  final int bronzeSponsorIndex;
  final VoidCallback onGoldPrevious;
  final VoidCallback onGoldNext;
  final VoidCallback onSilverPrevious;
  final VoidCallback onSilverNext;
  final VoidCallback onBronzePrevious;
  final VoidCallback onBronzeNext;

  const _DesktopLayout({
    required this.config,
    required this.goldSponsorIndex,
    required this.silverSponsorIndex,
    required this.bronzeSponsorIndex,
    required this.onGoldPrevious,
    required this.onGoldNext,
    required this.onSilverPrevious,
    required this.onSilverNext,
    required this.onBronzePrevious,
    required this.onBronzeNext,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Gold Sponsors
        if (config.goldSponsors.isNotEmpty)
          Expanded(
            child: _GoldTier(
              config: config,
              currentIndex: goldSponsorIndex,
              onPrevious: onGoldPrevious,
              onNext: onGoldNext,
            ),
          ),
        if (config.goldSponsors.isNotEmpty && config.silverSponsors.isNotEmpty)
          const SizedBox(width: 40),

        // Silver Sponsors
        if (config.silverSponsors.isNotEmpty)
          Expanded(
            child: _SilverTier(
              config: config,
              currentIndex: silverSponsorIndex,
              onPrevious: onSilverPrevious,
              onNext: onSilverNext,
            ),
          ),
        if (config.silverSponsors.isNotEmpty && config.bronzeSponsors.isNotEmpty)
          const SizedBox(width: 40),

        // Bronze Sponsors
        if (config.bronzeSponsors.isNotEmpty)
          Expanded(
            child: _BronzeTier(
              config: config,
              currentIndex: bronzeSponsorIndex,
              onPrevious: onBronzePrevious,
              onNext: onBronzeNext,
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
  final int bronzeSponsorIndex;
  final VoidCallback onGoldPrevious;
  final VoidCallback onGoldNext;
  final VoidCallback onSilverPrevious;
  final VoidCallback onSilverNext;
  final VoidCallback onBronzePrevious;
  final VoidCallback onBronzeNext;

  const _MobileLayout({
    required this.config,
    required this.goldSponsorIndex,
    required this.silverSponsorIndex,
    required this.bronzeSponsorIndex,
    required this.onGoldPrevious,
    required this.onGoldNext,
    required this.onSilverPrevious,
    required this.onSilverNext,
    required this.onBronzePrevious,
    required this.onBronzeNext,
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
        if (config.bronzeSponsors.isNotEmpty) ...[
          const SizedBox(height: 40),
          _BronzeTier(
            config: config,
            currentIndex: bronzeSponsorIndex,
            onPrevious: onBronzePrevious,
            onNext: onBronzeNext,
          ),
        ],
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
      crossAxisAlignment: CrossAxisAlignment.center,
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
                      label: '${currentSponsor.name} logo',
                      image: true,
                      child: ConstrainedBox(
                        constraints: const BoxConstraints(
                          maxWidth: 120,
                          maxHeight: 120,
                        ),
                        child: _SponsorLogo(
                          logoPath: currentSponsor.logoPath,
                        ),
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
              textAlign: TextAlign.center,
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
                    icon: const Icon(Icons.arrow_forward_ios,
                        color: Colors.white),
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
      crossAxisAlignment: CrossAxisAlignment.center,
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
                      label: '${currentSponsor.name} logo',
                      image: true,
                      child: ConstrainedBox(
                        constraints: const BoxConstraints(
                          maxWidth: 120,
                          maxHeight: 120,
                        ),
                        child: _SponsorLogo(
                          logoPath: currentSponsor.logoPath,
                        ),
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
                    icon: const Icon(Icons.arrow_forward_ios,
                        color: Colors.white),
                  ),
                ],
              ),
            ],
          ),
      ],
    );
  }
}

class _BronzeTier extends StatelessWidget {
  final ConferenceConfig config;
  final int currentIndex;
  final VoidCallback onPrevious;
  final VoidCallback onNext;

  const _BronzeTier({
    required this.config,
    required this.currentIndex,
    required this.onPrevious,
    required this.onNext,
  });

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final urlService = context.read<UrlService>();
    final bronzeSponsors = config.bronzeSponsors;

    if (bronzeSponsors.isEmpty) return const SizedBox.shrink();

    final currentSponsor = bronzeSponsors[currentIndex];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        // Tier Title
        Text(
          l10n.bronzeTier,
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
            // Bronze Sponsor Box
            MouseRegion(
              cursor: currentSponsor.websiteUrl != null
                  ? SystemMouseCursors.click
                  : SystemMouseCursors.basic,
              child: GestureDetector(
                onTap: currentSponsor.websiteUrl != null
                    ? () => urlService.openUrl(currentSponsor.websiteUrl!)
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
                      label: '${currentSponsor.name} logo',
                      image: true,
                      child: ConstrainedBox(
                        constraints: const BoxConstraints(
                          maxWidth: 120,
                          maxHeight: 120,
                        ),
                        child: _SponsorLogo(
                          logoPath: currentSponsor.logoPath,
                        ),
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
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 24),
          ],
        ),

        // Carousel Controls
        if (bronzeSponsors.length > 1)
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              _CarouselDots(
                totalItems: bronzeSponsors.length,
                currentIndex: currentIndex,
              ),
              Row(
                children: [
                  IconButton(
                    onPressed: currentIndex > 0 ? onPrevious : null,
                    tooltip: 'Previous bronze sponsor',
                    icon: const Icon(Icons.arrow_back_ios, color: Colors.white),
                  ),
                  IconButton(
                    onPressed: currentIndex < bronzeSponsors.length - 1
                        ? onNext
                        : null,
                    tooltip: 'Next bronze sponsor',
                    icon: const Icon(Icons.arrow_forward_ios,
                        color: Colors.white),
                  ),
                ],
              ),
            ],
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

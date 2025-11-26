import 'package:flutter/material.dart';
import 'package:flutter_conf_web/app/config/conference_constants.dart';
import 'package:flutter_conf_web/app/models/conference_config.dart';
import 'package:flutter_conf_web/app/sections/agenda_section.dart';
import 'package:flutter_conf_web/app/sections/speakers_section.dart';
import 'package:flutter_conf_web/app/sections/sponsor_section.dart';
import 'package:flutter_conf_web/app/sections/team_section.dart';
import 'package:flutter_conf_web/app/services/conference_config_service.dart';
import 'package:flutter_conf_web/app/widgets/banner_widget.dart';
import 'package:flutter_conf_web/app/widgets/custom_drawer.dart';
import 'package:flutter_conf_web/app/widgets/error_state.dart';
import 'package:flutter_conf_web/app/widgets/footer.dart';
import 'package:flutter_conf_web/app/widgets/loading_state.dart';
import 'package:flutter_conf_web/app/widgets/navigation_bar.dart';
import 'package:flutter_conf_web/core/constants/constants.dart';

class LandingPage extends StatefulWidget {
  const LandingPage({super.key});

  @override
  State<LandingPage> createState() => _LandingPageState();
}

class _LandingPageState extends State<LandingPage> {
  final scaffoldKey = GlobalKey<ScaffoldState>();
  late final ScrollController scrollController;
  final speakersKey = GlobalKey();
  final agendaKey = GlobalKey();
  final sponsorsKey = GlobalKey();
  final teamKey = GlobalKey();

  final _configService = ConferenceConfigService();
  ConferenceConfig? _config;
  bool _isLoading = true;
  bool _showFAB = false;
  bool _isScrolled = false;

  @override
  void initState() {
    super.initState();
    scrollController = ScrollController();
    scrollController.addListener(_onScroll);
    _loadConfig();
  }

  void _onScroll() {
    final shouldShowFAB = scrollController.offset > 500;
    final hasScrolled = scrollController.offset > 0;

    if (shouldShowFAB != _showFAB || hasScrolled != _isScrolled) {
      setState(() {
        _showFAB = shouldShowFAB;
        _isScrolled = hasScrolled;
      });
    }
  }

  Future<void> _loadConfig() async {
    try {
      await _configService.loadConfig(year: ConferenceConstants.currentYear);
      setState(() {
        _config = _configService.config;
        _isLoading = false;
      });
    } catch (e) {
      debugPrint('Error loading config: $e');
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  void dispose() {
    scrollController.dispose();
    super.dispose();
  }

  void scrollToKey(GlobalKey key) {
    Scrollable.ensureVisible(
      key.currentContext!,
      duration: const Duration(milliseconds: 500),
      curve: Curves.easeInOut,
    );
  }

  void scrollToTop() {
    scrollController.animateTo(
      0,
      duration: const Duration(milliseconds: 500),
      curve: Curves.easeInOut,
    );
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    if (_isLoading) {
      return const LoadingState();
    }

    if (_config == null) {
      return ErrorState(
        onRetry: _loadConfig,
      );
    }

    return Scaffold(
      key: scaffoldKey,
      floatingActionButton: size.width > kBreakPoint || !_showFAB
          ? null
          : AnimatedOpacity(
              opacity: _showFAB ? 1.0 : 0.0,
              duration: const Duration(milliseconds: 300),
              child: FloatingActionButton(
                onPressed: () {
                  scrollToTop();
                },
                child: const Icon(Icons.arrow_upward),
              ),
            ),
      endDrawer: CustomDrawer(
        scaffoldKey: scaffoldKey,
        onScrollToHome: () {
          scrollToTop();
        },
        onScrollToSpeakers: () {
          scrollToKey(speakersKey);
        },
        onScollToAgenda: () {
          scrollToKey(agendaKey);
        },
        onScrollToSponsors: () {
          scrollToKey(sponsorsKey);
        },
        onScrollToTeam: () {
          scrollToKey(teamKey);
        },
        config: _config,
      ),
      body: size.width > kBreakPoint
          ? Column(
              children: [
                // Sticky Navigation Bar for Desktop
                AnimatedContainer(
                  duration: const Duration(milliseconds: 200),
                  decoration: BoxDecoration(
                    boxShadow: _isScrolled
                        ? [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.1),
                              blurRadius: 8,
                              offset: const Offset(0, 2),
                            ),
                          ]
                        : [],
                  ),
                  child: CustomNavigationBar(
                    scaffoldKey: scaffoldKey,
                    onScrollToHome: scrollToTop,
                    onScrollToSpeakers: () => scrollToKey(speakersKey),
                    onScollToAgenda: () => scrollToKey(agendaKey),
                    onScrollToSponsors: () => scrollToKey(sponsorsKey),
                    onScrollToTeam: () => scrollToKey(teamKey),
                    config: _config,
                  ),
                ),
                // Scrollable content
                Expanded(
                  child: SingleChildScrollView(
                    controller: scrollController,
                    child: Column(
                      children: [
                        BannerWidget(config: _config!),
                        _LandingContent(
                          speakersKey: speakersKey,
                          agendaKey: agendaKey,
                          sponsorsKey: sponsorsKey,
                          teamKey: teamKey,
                          config: _config!,
                        ),
                        Footer(config: _config!),
                      ],
                    ),
                  ),
                ),
              ],
            )
          : Column(
              children: [
                CustomNavigationBar(
                  scaffoldKey: scaffoldKey,
                  onScrollToHome: scrollToTop,
                  onScrollToSpeakers: () => scrollToKey(speakersKey),
                  onScollToAgenda: () => scrollToKey(agendaKey),
                  onScrollToSponsors: () => scrollToKey(sponsorsKey),
                  onScrollToTeam: () => scrollToKey(teamKey),
                  config: _config,
                ),
                Expanded(
                  child: SingleChildScrollView(
                    controller: scrollController,
                    child: Column(
                      children: [
                        BannerWidget(config: _config!),
                        _LandingContent(
                          speakersKey: speakersKey,
                          agendaKey: agendaKey,
                          sponsorsKey: sponsorsKey,
                          teamKey: teamKey,
                          config: _config!,
                        ),
                      ],
                    ),
                  ),
                ),
                Footer(config: _config!),
              ],
            ),
    );
  }
}

class _LandingContent extends StatelessWidget {
  const _LandingContent({
    required this.speakersKey,
    required this.agendaKey,
    required this.sponsorsKey,
    required this.teamKey,
    required this.config,
  });

  final GlobalKey<State<StatefulWidget>> speakersKey;
  final GlobalKey<State<StatefulWidget>> agendaKey;
  final GlobalKey<State<StatefulWidget>> sponsorsKey;
  final GlobalKey<State<StatefulWidget>> teamKey;
  final ConferenceConfig config;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SpeakersSection(
          key: speakersKey,
          speakers: config.speakers,
        ),
        AgendaSection(
          key: agendaKey,
          config: config,
        ),
        SponsorSection(
          key: sponsorsKey,
          config: config,
        ),
        TeamSection(
          key: teamKey,
          config: config,
        ),
      ],
    );
  }
}

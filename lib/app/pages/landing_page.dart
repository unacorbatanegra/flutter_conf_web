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
import 'package:flutter_conf_web/app/widgets/footer.dart';
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

  @override
  void initState() {
    super.initState();
    scrollController = ScrollController();
    _loadConfig();
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
      return const Scaffold(
        body: Center(
          child: CircularProgressIndicator(),
        ),
      );
    }

    if (_config == null) {
      return const Scaffold(
        body: Center(
          child: Text('Error loading conference data'),
        ),
      );
    }

    return Scaffold(
      key: scaffoldKey,
      floatingActionButton: size.width > kBreakPoint
          ? null
          : FloatingActionButton(
              onPressed: () {
                scrollToTop();
              },
              child: const Icon(Icons.arrow_upward),
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
      body: Column(
        children: [
          CustomNavigationBar(
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

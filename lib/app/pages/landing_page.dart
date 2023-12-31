import 'package:flutter/material.dart';
import 'package:flutter_conf_web/app/models/speaker_model.dart';
import 'package:flutter_conf_web/app/sections/speakers_section.dart';
import 'package:flutter_conf_web/app/widgets/about_section.dart';
import 'package:flutter_conf_web/app/widgets/animated_banner_widget.dart';
import 'package:flutter_conf_web/app/widgets/custom_drawer.dart';
import 'package:flutter_conf_web/app/widgets/footer.dart';
import 'package:flutter_conf_web/app/widgets/navigation_bar.dart';
import 'package:flutter_conf_web/l10n/l10n.dart';

class LandingPage extends StatelessWidget {
  final scaffoldKey = GlobalKey<ScaffoldState>();
  final scrollController = ScrollController();
  final homeKey = GlobalKey();
  final aboutKey = GlobalKey();
  final speakersKey = GlobalKey();
  final sponsorsKey = GlobalKey();

  LandingPage({super.key});

  void scrollToKey(GlobalKey key) {
    final RenderBox? renderBox =
        key.currentContext?.findRenderObject() as RenderBox?;
    final position = renderBox?.localToGlobal(Offset.zero);
    scrollController.animateTo(
      position?.dy ?? 0,
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
    final l10n = context.l10n;

    return Scaffold(
      key: scaffoldKey,
      endDrawer: CustomDrawer(
        scaffoldKey: scaffoldKey,
        onScrollToHome: () {
          scrollToTop();
        },
        onScrollToAbout: () {
          scrollToKey(aboutKey);
        },
        onScrollToSpeakers: () {
          scrollToKey(speakersKey);
        },
        // onScollToSponsors: () {
        // scrollToKey(sponsorsKey);
        // },
      ),
      body: Column(
        children: [
          CustomNavigationBar(
            scaffoldKey: scaffoldKey,
            onScrollToHome: () {
              scrollToTop();
            },
            onScrollToAbout: () {
              scrollToKey(aboutKey);
            },
            onScrollToSpeakers: () {
              scrollToKey(speakersKey);
            },
            // onScollToSponsors: () {
            // scrollToKey(sponsorsKey);
            // },
          ),
          Expanded(
            child: ListView(
              controller: scrollController,
              children: [
                const AnimatedBannerWidget(),
                const SizedBox(height: 50),
                AboutSection(
                  key: aboutKey,
                ),
                const SizedBox(height: 50),
                Text(
                  l10n.speakers,
                  key: speakersKey,
                  style: const TextStyle(
                    fontSize: 36,
                    fontWeight: FontWeight.bold,
                  ),
                  textAlign: TextAlign.center,
                ),
                const SpeakersSection(speakers: speakers),
                const SizedBox(height: 50),
              ],
            ),
          ),
          const Footer(),
        ],
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_conf_web/app/models/speaker_model.dart';
import 'package:flutter_conf_web/app/sections/agenda_section.dart';
import 'package:flutter_conf_web/app/sections/speakers_section.dart';
import 'package:flutter_conf_web/app/sections/about_section.dart';
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
  final agendaKey = GlobalKey();

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
    final size = MediaQuery.of(context).size;

    return Scaffold(
      key: scaffoldKey,
      floatingActionButton: size.width > 900
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
        onScrollToAbout: () {
          scrollToKey(aboutKey);
        },
        onScrollToSpeakers: () {
          scrollToKey(speakersKey);
        },
        onScollToAgenda: () {
          scrollToKey(agendaKey);
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
            onScollToAgenda: () {
              scrollToKey(agendaKey);
            },
            // onScollToSponsors: () {
            // scrollToKey(sponsorsKey);
            // },
          ),
          Expanded(
            child: SingleChildScrollView(
              controller: scrollController,
              child: Column(
                children: [
                  const AnimatedBannerWidget(),
                  const SizedBox(height: 50),
                  AboutSection(
                    key: aboutKey,
                  ),
                  const SizedBox(height: 50),
                  Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: size.width > 900
                          ? MediaQuery.of(context).size.width * 0.06
                          : 0,
                    ),
                    child: Row(
                      mainAxisAlignment: size.width > 900
                          ? MainAxisAlignment.start
                          : MainAxisAlignment.center,
                      children: [
                        Text(
                          l10n.speakers,
                          key: speakersKey,
                          style: const TextStyle(
                            fontSize: 36,
                            fontWeight: FontWeight.bold,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ],
                    ),
                  ),
                  const SpeakersSection(speakers: speakers),
                  const SizedBox(height: 50),
                  AgendaSection(
                    key: agendaKey,
                  ),
                  const SizedBox(height: 50),
                ],
              ),
            ),
          ),
          const Footer(),
        ],
      ),
    );
  }
}

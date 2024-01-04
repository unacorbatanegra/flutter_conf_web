import 'package:flutter/material.dart';
import 'package:flutter_conf_web/feature/landing/models/speaker_model.dart';
import 'package:flutter_conf_web/feature/landing/presentation/view/about_view.dart';
import 'package:flutter_conf_web/feature/landing/presentation/widget/animated_banner_widget.dart';
import 'package:flutter_conf_web/feature/landing/presentation/widget/custom_drawer.dart';
import 'package:flutter_conf_web/feature/landing/presentation/widget/footer.dart';
import 'package:flutter_conf_web/feature/landing/presentation/widget/navigation_bar.dart';
import 'package:flutter_conf_web/feature/landing/presentation/widget/speaker_card.dart';
import 'package:flutter_conf_web/gen/assets.gen.dart';
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
    final size = MediaQuery.of(context).size;
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
        onScollToSponsors: () {
          // scrollToKey(sponsorsKey);
        },
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
            onScollToSponsors: () {
              // scrollToKey(sponsorsKey);
            },
          ),
          Expanded(
            child: ListView(
              controller: scrollController,
              children: [
                // Assets.images.bannerPrincipal.svg(
                //   key: homeKey,
                //   width: size.width,
                // ),
                const AnimatedBannerWidget(),
                const SizedBox(height: 50),
                AboutView(
                  key: aboutKey,
                ),
                const SizedBox(height: 50),
                Text(
                  l10n.speakers,
                  key: speakersKey,
                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 50),
                SizedBox(
                  height: 500,
                  child: GridView.count(
                    crossAxisCount: 1,
                    shrinkWrap: true,
                    mainAxisSpacing: 20,
                    scrollDirection: Axis.horizontal,
                    children: List.generate(
                      speakers.length,
                      (index) {
                        final speaker = speakers[index];
                        return SpeakerCard(
                          speaker: speaker,
                        );
                      },
                    ),
                  ),
                ),
                const SizedBox(height: 50),
                // Text(
                //   l10n.sponsors,
                //   key: sponsorsKey,
                //   style: const TextStyle(
                //     fontSize: 20,
                //     fontWeight: FontWeight.bold,
                //   ),
                //   textAlign: TextAlign.center,
                // ),
                // const SizedBox(height: 50),
                // SizedBox(
                //   height: 200,
                //   child: GridView.count(
                //     crossAxisCount: 1,
                //     shrinkWrap: true,
                //     mainAxisSpacing: 20,
                //     scrollDirection: Axis.horizontal,
                //     children: List.generate(
                //       5,
                //       (index) {
                //         return const FlutterLogo();
                //       },
                //     ),
                //   ),
                // ),
                // const SizedBox(height: 50),
              ],
            ),
          ),
          const Footer(),
        ],
      ),
    );
  }
}

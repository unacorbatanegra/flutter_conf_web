import 'package:flutter/material.dart';
import 'package:flutter_conf_web/feature/landing/models/speaker_model.dart';
import 'package:flutter_conf_web/feature/landing/presentation/view/about_view.dart';
import 'package:flutter_conf_web/feature/landing/presentation/widget/custom_drawer.dart';
import 'package:flutter_conf_web/feature/landing/presentation/widget/navigation_bar.dart';
import 'package:flutter_conf_web/feature/landing/presentation/widget/speaker_card.dart';
import 'package:flutter_conf_web/gen/assets.gen.dart';
import 'package:flutter_conf_web/l10n/l10n.dart';
import 'package:url_launcher/url_launcher.dart';

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

  Future<void> launchUrlSocialMedia(String link) async {
    final url = Uri.parse(link);
    if (!await launchUrl(url)) {
      throw Exception('Could not launch $url');
    }
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
          scrollToKey(sponsorsKey);
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
              scrollToKey(sponsorsKey);
            },
          ),
          Expanded(
            child: ListView(
              controller: scrollController,
              children: [
                Assets.images.bannerPrincipal.svg(
                  key: homeKey,
                  width: size.width,
                ),
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
                        return SizedBox(
                          width: 300,
                          child: SpeakerCard(
                            speaker: speaker,
                          ),
                        );
                      },
                    ),
                  ),
                ),
                const SizedBox(height: 50),
                Text(
                  l10n.sponsors,
                  key: sponsorsKey,
                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 50),
                SizedBox(
                  height: 200,
                  child: GridView.count(
                    crossAxisCount: 1,
                    shrinkWrap: true,
                    mainAxisSpacing: 20,
                    scrollDirection: Axis.horizontal,
                    children: List.generate(
                      5,
                      (index) {
                        return const FlutterLogo();
                      },
                    ),
                  ),
                ),
                const SizedBox(height: 50),
              ],
            ),
          ),
          Container(
            color: Colors.black,
            height: 50,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                RichText(
                  text: TextSpan(
                    children: [
                      TextSpan(
                        text: l10n.madeWith,
                        style: const TextStyle(
                          color: Colors.white,
                        ),
                      ),
                      const TextSpan(
                        text: ' 💙 ',
                        style: TextStyle(
                          color: Colors.red,
                        ),
                      ),
                      TextSpan(
                        text: l10n.by,
                        style: const TextStyle(
                          color: Colors.white,
                        ),
                      ),
                      const TextSpan(
                        text: ' Flutter Conf Paraguay',
                        style: TextStyle(
                          color: Colors.blue,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(width: 10),
                IconButton(
                  onPressed: () {
                    launchUrlSocialMedia(
                        'https://github.com/unacorbatanegra/flutter_conf_web');
                  },
                  icon: Assets.icons.github.image(
                    width: 20,
                    height: 20,
                    color: Colors.white,
                  ),
                ),
                const SizedBox(width: 10),
                IconButton(
                  onPressed: () {
                    launchUrlSocialMedia('https://twitter.com/flutter_py');
                  },
                  icon: Assets.icons.twitter.image(
                    width: 20,
                    height: 20,
                    color: Colors.white,
                  ),
                ),
                IconButton(
                  onPressed: () {
                    launchUrlSocialMedia(
                        'https://www.linkedin.com/company/flutter-conf-paraguay-2024/');
                  },
                  icon: Assets.icons.linkedin.image(
                    width: 20,
                    height: 20,
                    color: Colors.white,
                  ),
                ),
                // Add instagram
                IconButton(
                  onPressed: () {
                    launchUrlSocialMedia(
                        'https://www.instagram.com/flutterconfpy/');
                  },
                  icon: Assets.icons.instagram.image(
                    width: 20,
                    height: 20,
                    color: Colors.white,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

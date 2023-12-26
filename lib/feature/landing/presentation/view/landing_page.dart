import 'package:flutter/material.dart';
import 'package:flutter_conf_web/feature/landing/models/speaker_model.dart';
import 'package:flutter_conf_web/feature/landing/presentation/view/about_view.dart';
import 'package:flutter_conf_web/feature/landing/presentation/widget/custom_drawer.dart';
import 'package:flutter_conf_web/feature/landing/presentation/widget/navigation_bar.dart';
import 'package:flutter_conf_web/feature/landing/presentation/widget/speaker_card.dart';
import 'package:flutter_conf_web/gen/assets.gen.dart';

class LandingPage extends StatelessWidget {
  final scaffoldKey = GlobalKey<ScaffoldState>();
  LandingPage({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      key: scaffoldKey,
      endDrawer: const CustomDrawer(),
      body: Column(
        children: [
          CustomNavigationBar(
            scaffoldKey: scaffoldKey,
          ),
          Expanded(
            child: ListView(
              children: [
                Assets.images.banner1.svg(
                  width: size.width,
                ),
                const SizedBox(height: 50),
                const AboutView(),
                const SizedBox(height: 50),
                const Text(
                  'Speakers',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                  textAlign: TextAlign.center,
                ),
                SizedBox(
                  height: 400,
                  child: GridView.count(
                    crossAxisCount: 1,
                    shrinkWrap: true,
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
              ],
            ),
          ),
        ],
      ),
    );
  }
}

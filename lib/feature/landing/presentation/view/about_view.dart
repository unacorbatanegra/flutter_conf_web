import 'package:flutter/material.dart';
import 'package:flutter_conf_web/gen/assets.gen.dart';

class AboutView extends StatelessWidget {
  const AboutView({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    const aboutUsLabel = 'Sobre Flutter Conf Paraguay';

    const aboutUsText =
        'Flutter Conf Paraguay es una conferencia de tecnología que se realiza en Paraguay, con el objetivo de compartir conocimientos y experiencias sobre Flutter, el framework de Google para crear aplicaciones multiplataforma.';

    return Container(
      height: 300,
      child: size.width > 800
          ? Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        aboutUsLabel,
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(
                        height: 16,
                      ),
                      Text(
                        aboutUsText,
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: Assets.images.bannerConGdg.svg(
                    width: size.width,
                    height: 300,
                  ),
                ),
              ],
            )
          : Column(
              children: [
                Text(
                  aboutUsLabel,
                ),
                Text(
                  aboutUsText,
                ),
                const SizedBox(height: 16),
                Assets.images.bannerConGdg.svg(
                  width: size.width,
                ),
              ],
            ),
    );
  }
}

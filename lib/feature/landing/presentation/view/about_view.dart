import 'package:flutter/material.dart';
import 'package:flutter_conf_web/gen/assets.gen.dart';
import 'package:flutter_conf_web/l10n/l10n.dart';

class AboutView extends StatelessWidget {
  const AboutView({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final l10n = context.l10n;

    final aboutUsLabel = '${l10n.about} Flutter Conf Paraguay';

    final aboutUsText =
        'Flutter Conf Paraguay ${l10n.about_flutter_conf_paraguay}';

    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: 16,
        vertical: 32,
      ),
      height: 300,
      child: size.width > 800
          ? Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        aboutUsLabel,
                        style: const TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(
                        height: 16,
                      ),
                      Text(
                        aboutUsText,
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: Assets.images.dash.image(
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
                  style: const TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(
                  height: 16,
                ),
                Text(
                  aboutUsText,
                ),
                const SizedBox(height: 16),
                Expanded(
                  child: Assets.images.dash.image(
                    width: size.width,
                    height: 300,
                  ),
                ),
              ],
            ),
    );
  }
}

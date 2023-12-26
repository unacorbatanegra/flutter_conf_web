import 'package:flutter/material.dart';

class AboutView extends StatelessWidget {
  const AboutView({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return SizedBox(
      height: 300,
      child: size.width > 800
          ? const Row(
              children: [
                Expanded(
                  child: Column(
                    children: [
                      Text(
                        'Sobre Nosotros',
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(
                        height: 16,
                      ),
                      Text(
                        'Flutter Conf Paraguay es una conferencia de tecnología que se realiza en Paraguay, con el objetivo de compartir conocimientos y experiencias sobre Flutter, el framework de Google para crear aplicaciones multiplataforma.',
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: Column(
                    children: [
                      FlutterLogo(
                        size: 100,
                      ),
                    ],
                  ),
                ),
              ],
            )
          : const Column(
              children: [
                Column(
                  children: [
                    Text(
                      'Sobre Nosotros',
                    ),
                    Text(
                      'Flutter Conf Paraguay es una conferencia de tecnología que se realiza en Paraguay, con el objetivo de compartir conocimientos y experiencias sobre Flutter, el framework de Google para crear aplicaciones multiplataforma.',
                    ),
                  ],
                ),
                Column(
                  children: [
                    FlutterLogo(
                      size: 100,
                    ),
                  ],
                ),
              ],
            ),
    );
  }
}

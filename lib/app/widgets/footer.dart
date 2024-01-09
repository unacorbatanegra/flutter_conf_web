import 'package:flutter/material.dart';
import 'package:flutter_conf_web/app/services/url_service.dart';
import 'package:flutter_conf_web/gen/assets.gen.dart';
import 'package:flutter_conf_web/l10n/l10n.dart';
import 'package:provider/provider.dart';

class Footer extends StatelessWidget {
  const Footer({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Container(
      color: Colors.black,
      child: size.width > 600
          ? _FooterDesktop(
              launchUrlSocialMedia: context.read<UrlService>().openUrl,
            )
          : _FooterMobile(
              launchUrlSocialMedia: context.read<UrlService>().openUrl,
            ),
    );
  }
}

class _FooterDesktop extends StatelessWidget {
  final Future<void> Function(String) launchUrlSocialMedia;

  const _FooterDesktop({
    required this.launchUrlSocialMedia,
  });

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;

    return Row(
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
          tooltip: 'Github',
          onPressed: () {
            launchUrlSocialMedia(
                'https://github.com/unacorbatanegra/flutter_conf_web');
          },
          icon: Assets.icons.github.svg(
            width: 20,
            height: 20,
            color: Colors.white,
          ),
        ),
        const SizedBox(width: 10),
        IconButton(
          tooltip: 'Twitter',
          onPressed: () {
            launchUrlSocialMedia('https://twitter.com/flutter_py');
          },
          icon: Assets.icons.x.svg(
            width: 20,
            height: 20,
            color: Colors.white,
          ),
        ),
        IconButton(
          tooltip: 'Linkedin',
          onPressed: () {
            launchUrlSocialMedia(
                'https://www.linkedin.com/company/flutter-conf-paraguay-2024/');
          },
          icon: Assets.icons.linkedin.svg(
            width: 20,
            height: 20,
            color: Colors.white,
          ),
        ),
        // Add instagram
        IconButton(
          tooltip: 'Instagram',
          onPressed: () {
            launchUrlSocialMedia('https://www.instagram.com/flutterconfpy/');
          },
          icon: Assets.icons.instagram.svg(
            width: 20,
            height: 20,
          ),
        ),
      ],
    );
  }
}

class _FooterMobile extends StatelessWidget {
  final Future<void> Function(String) launchUrlSocialMedia;

  const _FooterMobile({
    required this.launchUrlSocialMedia,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(height: 10),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            IconButton(
              tooltip: 'Github',
              onPressed: () {
                launchUrlSocialMedia(
                    'https://github.com/unacorbatanegra/flutter_conf_web');
              },
              icon: Assets.icons.github.svg(
                width: 20,
                height: 20,
                color: Colors.white,
              ),
            ),
            IconButton(
              tooltip: 'Twitter',
              onPressed: () {
                launchUrlSocialMedia('https://twitter.com/flutter_py');
              },
              icon: Assets.icons.x.svg(
                width: 20,
                height: 20,
                color: Colors.white,
              ),
            ),
            IconButton(
              tooltip: 'Linkedin',
              onPressed: () {
                launchUrlSocialMedia(
                    'https://www.linkedin.com/company/flutter-conf-paraguay-2024/');
              },
              icon: Assets.icons.linkedin.svg(
                width: 20,
                height: 20,
                color: Colors.white,
              ),
            ),
            // Add instagram
            IconButton(
              tooltip: 'Instagram',
              onPressed: () {
                launchUrlSocialMedia(
                    'https://www.instagram.com/flutterconfpy/');
              },
              icon: Assets.icons.instagram.svg(
                width: 20,
                height: 20,
                color: Colors.white,
              ),
            ),
          ],
        ),
        const SizedBox(height: 10),
        RichText(
          text: const TextSpan(
            children: [
              TextSpan(
                text: 'Made with',
                style: TextStyle(
                  color: Colors.white,
                ),
              ),
              TextSpan(
                text: ' 💙 ',
                style: TextStyle(
                  color: Colors.red,
                ),
              ),
              TextSpan(
                text: 'by',
                style: TextStyle(
                  color: Colors.white,
                ),
              ),
              TextSpan(
                text: ' Flutter Conf Paraguay',
                style: TextStyle(
                  color: Colors.blue,
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 10),
      ],
    );
  }
}

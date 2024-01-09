import 'package:flutter/material.dart';
import 'package:flutter_conf_web/app/models/speaker_model.dart';
import 'package:flutter_conf_web/gen/assets.gen.dart';
import 'package:url_launcher/url_launcher.dart';

class SpeakerCard extends StatelessWidget {
  final SpeakerModel speaker;

  const SpeakerCard({
    super.key,
    required this.speaker,
  });

  Future<void> _launchUrl(String link) async {
    final url = Uri.parse(link);
    if (!await launchUrl(url)) {
      throw Exception('Could not launch $url');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5,
      clipBehavior: Clip.antiAlias,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      child: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Colors.blue[900]!,
              Colors.blue[800]!,
            ],
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Expanded(
              child: Image.asset(
                speaker.imagePath,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) {
                  return const Icon(
                    Icons.error,
                    color: Colors.white,
                  );
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    '${speaker.name}   ${speaker.countryEmoji}',
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 8),
                  Text(
                    speaker.profession,
                    style: const TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 8),
                  Text(
                    speaker.talkTitle,
                    style: const TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 8),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      if (speaker.twitterUrl != null) ...[
                        IconButton(
                          tooltip: 'Twitter',
                          onPressed: () {
                            try {
                              _launchUrl(speaker.twitterUrl!);
                            } catch (e) {
                              debugPrint(e.toString());
                            }
                          },
                          icon: Assets.icons.twitter.image(
                            width: 20,
                            height: 20,
                            color: Colors.white,
                          ),
                        ),
                      ] else
                        const _FakeIcon(),
                      if (speaker.linkedinUrl != null) ...[
                        IconButton(
                          tooltip: 'Linkedin',
                          onPressed: () {
                            try {
                              _launchUrl(speaker.linkedinUrl!);
                            } catch (e) {
                              debugPrint(e.toString());
                            }
                          },
                          icon: Assets.icons.linkedin.image(
                            width: 20,
                            height: 20,
                            color: Colors.white,
                          ),
                        ),
                      ] else
                        const _FakeIcon(),
                      if (speaker.youtubeUrl != null) ...[
                        IconButton(
                          tooltip: 'Youtube',
                          onPressed: () {
                            try {
                              _launchUrl(speaker.youtubeUrl!);
                            } catch (e) {
                              debugPrint(e.toString());
                            }
                          },
                          icon: Assets.icons.youtube.image(
                            width: 20,
                            height: 20,
                            color: Colors.white,
                          ),
                        )
                      ] else
                        const _FakeIcon(),
                      if (speaker.facebookUrl != null) ...[
                        IconButton(
                          tooltip: 'Facebook',
                          onPressed: () {
                            try {
                              _launchUrl(speaker.facebookUrl!);
                            } catch (e) {
                              debugPrint(e.toString());
                            }
                          },
                          icon: Assets.icons.facebook.image(
                            width: 20,
                            height: 20,
                            color: Colors.white,
                          ),
                        )
                      ] else
                        const _FakeIcon()
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _FakeIcon extends StatelessWidget {
  const _FakeIcon();

  @override
  Widget build(BuildContext context) {
    return const IconButton(
      onPressed: null,
      icon: Icon(
        Icons.info,
        color: Colors.transparent,
        size: 20,
      ),
    );
  }
}

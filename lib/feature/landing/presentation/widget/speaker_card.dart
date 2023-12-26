import 'package:flutter/material.dart';
import 'package:flutter_conf_web/feature/landing/models/speaker_model.dart';
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
      margin: const EdgeInsets.all(8),
      child: Column(
        children: [
          Image.network(
            speaker.imagePath,
            fit: BoxFit.cover,
            errorBuilder: (context, error, stackTrace) {
              return const Center(
                child: Icon(
                  Icons.error,
                  color: Colors.red,
                ),
              );
            },
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  Text(
                    speaker.name,
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    speaker.profession,
                    style: const TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    speaker.talkTitle,
                    style: const TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const Spacer(),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      IconButton(
                        tooltip: 'Twitter',
                        onPressed: () {
                          try {
                            _launchUrl(speaker.twitterUrl);
                          } catch (e) {
                            debugPrint(e.toString());
                          }
                        },
                        icon: Assets.icons.twitter.image(
                          width: 20,
                          height: 20,
                        ),
                      ),
                      IconButton(
                        tooltip: 'Linkedin',
                        onPressed: () {
                          try {
                            _launchUrl(speaker.linkedinUrl);
                          } catch (e) {
                            debugPrint(e.toString());
                          }
                        },
                        icon: Assets.icons.linkedin.image(
                          width: 20,
                          height: 20,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_conf_web/feature/landing/models/team_model.dart';
import 'package:flutter_conf_web/gen/assets.gen.dart';
import 'package:url_launcher/url_launcher.dart';

class TeamView extends StatelessWidget {
  const TeamView({super.key});

  Future<void> launchUrlSocialMedia(String link) async {
    final url = Uri.parse(link);
    if (!await launchUrl(url)) {
      throw Exception('Could not launch $url');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Container(
            height: 100,
            color: Colors.blue[900],
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                IconButton(
                  icon: const Icon(
                    Icons.arrow_back,
                    color: Colors.white,
                  ),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                ),
                const Text(
                  'Flutter Conf Paraguay Team 2024',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 24,
                  ),
                ),
                const IconButton(
                  icon: Icon(
                    Icons.search,
                    color: Colors.transparent,
                  ),
                  onPressed: null,
                ),
              ],
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          Expanded(
            child: GridView.count(
              crossAxisCount: 4,
              children: team.map((e) {
                return Column(
                  children: [
                    Expanded(
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(100),
                        child: Image.asset(
                          e.image,
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    const SizedBox(height: 10),
                    Text(
                      e.name,
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 10),
                    Text(
                      e.role,
                      style: const TextStyle(
                        fontSize: 14,
                      ),
                    ),
                    const SizedBox(height: 10),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        IconButton(
                          icon: Assets.icons.twitter.image(
                            color: Colors.blue,
                            width: 20,
                            height: 20,
                          ),
                          onPressed: () {
                            if (e.twitterUrl == null) return;
                            launchUrlSocialMedia(e.twitterUrl!);
                          },
                        ),
                        IconButton(
                          icon: Assets.icons.linkedin.image(
                            color: Colors.blue,
                            width: 20,
                            height: 20,
                          ),
                          onPressed: () {
                            if (e.linkedinUrl == null) return;
                            launchUrlSocialMedia(e.linkedinUrl!);
                          },
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                  ],
                );
              }).toList(),
            ),
          ),
        ],
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_conf_web/app/models/team_model.dart';
import 'package:flutter_conf_web/gen/assets.gen.dart';
import 'package:go_router/go_router.dart';
import 'package:url_launcher/url_launcher.dart';

class TeamView extends StatefulWidget {
  const TeamView({super.key});

  @override
  State<TeamView> createState() => _TeamViewState();
}

class _TeamViewState extends State<TeamView> {
  List<bool> _isHover = [];

  @override
  void initState() {
    super.initState();
    _isHover = List.generate(team.length, (index) => false);
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
    const breakpointSmallScreen = 600;
    const breakpointMediumScreen = 1000;

    return Scaffold(
      body: Column(
        children: [
          TeamNavigationBar(
            size: size,
            breakpointSmallScreen: breakpointSmallScreen,
          ),
          const SizedBox(
            height: 20,
          ),
          Expanded(
            child: GridView.count(
              crossAxisCount: _getResponsiveCrossAxisCount(
                size,
                breakpointSmallScreen,
                breakpointMediumScreen,
              ),
              children: team.map((e) {
                return MouseRegion(
                  onEnter: (_) {
                    setState(() {
                      _isHover[team.indexOf(e)] = true;
                    });
                  },
                  onExit: (_) {
                    setState(() {
                      _isHover[team.indexOf(e)] = false;
                    });
                  },
                  child: Card(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(40),
                    ),
                    margin: const EdgeInsets.all(10),
                    child: Stack(
                      fit: StackFit.expand,
                      children: [
                        Image.asset(
                          e.image,
                          fit: BoxFit.cover,
                        ),
                        if (_isHover[team.indexOf(e)] ||
                            size.width < breakpointSmallScreen)
                          OverlayTeamCard(
                            team: e,
                            launchUrlSocialMedia: launchUrlSocialMedia,
                          ),
                      ],
                    ),
                  ),
                );
              }).toList(),
            ),
          ),
        ],
      ),
    );
  }

  int _getResponsiveCrossAxisCount(
    Size size,
    int breakpointSmallScreen,
    int breakPointMediumScreen,
  ) {
    if (size.width < breakpointSmallScreen) {
      return 1;
    } else if (size.width < breakPointMediumScreen) {
      return 2;
    } else {
      return 4;
    }
  }
}

class TeamNavigationBar extends StatelessWidget {
  const TeamNavigationBar({
    super.key,
    required this.size,
    required this.breakpointSmallScreen,
  });

  final Size size;
  final int breakpointSmallScreen;

  @override
  Widget build(BuildContext context) {
    return Container(
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
              context.pop();
            },
          ),
          const Flexible(
            child: Text(
              'Flutter Conf Paraguay Team 2024',
              style: TextStyle(
                color: Colors.white,
                fontSize: 24,
              ),
            ),
          ),
          if (size.width > breakpointSmallScreen)
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Assets.images.dash.image(),
            )
          else
            const SizedBox.shrink(),
        ],
      ),
    );
  }
}

class OverlayTeamCard extends StatelessWidget {
  final Team team;
  final Future<void> Function(String link) launchUrlSocialMedia;

  const OverlayTeamCard({
    super.key,
    required this.team,
    required this.launchUrlSocialMedia,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
        color: Colors.black.withOpacity(0.5),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Text(
              team.name,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(
              team.role,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 18,
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                if (team.twitterUrl != null)
                  IconButton(
                    icon: Assets.icons.x.svg(
                      width: 20,
                      height: 20,
                    ),
                    onPressed: () {
                      launchUrlSocialMedia(team.twitterUrl!);
                    },
                  ),
                if (team.linkedinUrl != null)
                  IconButton(
                    icon: Assets.icons.linkedin.svg(
                      width: 20,
                      height: 20,
                    ),
                    onPressed: () {
                      launchUrlSocialMedia(team.linkedinUrl!);
                    },
                  ),
                if (team.githubUrl != null)
                  IconButton(
                    icon: Assets.icons.github.svg(
                      width: 20,
                      height: 20,
                    ),
                    onPressed: () {
                      launchUrlSocialMedia(team.githubUrl!);
                    },
                  ),
              ],
            ),
          ],
        ));
  }
}

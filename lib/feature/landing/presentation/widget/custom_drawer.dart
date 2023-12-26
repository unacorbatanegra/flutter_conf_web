import 'package:flutter/material.dart';
import 'package:flutter_conf_web/l10n/l10n.dart';

class CustomDrawer extends StatelessWidget {
  final GlobalKey<ScaffoldState> _scaffoldKey;
  final VoidCallback _onScrollToAbout;
  final VoidCallback _onScrollToHome;
  final VoidCallback _onScrollToSpeakers;

  const CustomDrawer({
    Key? key,
    required GlobalKey<ScaffoldState> scaffoldKey,
    required VoidCallback onScrollToAbout,
    required VoidCallback onScrollToHome,
    required VoidCallback onScrollToSpeakers,
  })  : _scaffoldKey = scaffoldKey,
        _onScrollToAbout = onScrollToAbout,
        _onScrollToHome = onScrollToHome,
        _onScrollToSpeakers = onScrollToSpeakers,
        super(key: key);

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;

    return Drawer(
      child: Container(
        color: Colors.blue[900],
        child: ListView(
          children: [
            ListTile(
              title: Text(
                l10n.home,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                ),
              ),
              onTap: () {
                _scaffoldKey.currentState?.closeEndDrawer();
                _onScrollToHome();
              },
            ),
            ListTile(
              title: Text(
                l10n.about_us,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                ),
              ),
              onTap: () {
                _scaffoldKey.currentState?.closeEndDrawer();
                _onScrollToAbout();
              },
            ),
            ListTile(
              title: Text(
                l10n.speakers,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                ),
              ),
              onTap: () {
                _scaffoldKey.currentState?.closeEndDrawer();
                _onScrollToSpeakers();
              },
            ),
            ListTile(
              title: Text(
                l10n.sponsors,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                ),
              ),
              onTap: () {
                _scaffoldKey.currentState?.closeEndDrawer();
              },
            ),
            ListTile(
              title: Text(
                l10n.team,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                ),
              ),
              onTap: () {
                _scaffoldKey.currentState?.closeEndDrawer();
              },
            ),
          ],
        ),
      ),
    );
  }
}

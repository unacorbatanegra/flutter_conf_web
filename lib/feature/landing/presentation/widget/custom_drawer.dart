import 'package:flutter/material.dart';

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
    return Drawer(
      child: Container(
        color: Colors.blue[900],
        child: ListView(
          children: [
            ListTile(
              title: const Text(
                'Home',
                style: TextStyle(
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
              title: const Text(
                'About',
                style: TextStyle(
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
              title: const Text(
                'Speakers',
                style: TextStyle(
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
              title: const Text(
                'Sponsors',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                ),
              ),
              onTap: () {
                _scaffoldKey.currentState?.closeEndDrawer();
              },
            ),
            ListTile(
              title: const Text(
                'Team',
                style: TextStyle(
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

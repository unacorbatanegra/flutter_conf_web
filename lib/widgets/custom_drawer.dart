import 'package:flutter/material.dart';
import 'package:flutter_conf_web/notifiers/language_change_notifier.dart';
import 'package:flutter_conf_web/widgets/language_switch.dart';
import 'package:flutter_conf_web/gen/assets.gen.dart';
import 'package:flutter_conf_web/l10n/l10n.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

class CustomDrawer extends StatelessWidget {
  final GlobalKey<ScaffoldState> _scaffoldKey;
  final VoidCallback _onScrollToAbout;
  final VoidCallback _onScrollToHome;
  final VoidCallback _onScrollToSpeakers;
  final VoidCallback _onScollToSponsors;

  const CustomDrawer({
    Key? key,
    required GlobalKey<ScaffoldState> scaffoldKey,
    required VoidCallback onScrollToAbout,
    required VoidCallback onScrollToHome,
    required VoidCallback onScrollToSpeakers,
    required VoidCallback onScollToSponsors,
  })  : _scaffoldKey = scaffoldKey,
        _onScrollToAbout = onScrollToAbout,
        _onScrollToHome = onScrollToHome,
        _onScrollToSpeakers = onScrollToSpeakers,
        _onScollToSponsors = onScollToSponsors,
        super(key: key);

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final localeLanguageChangeNotifier =
        context.watch<LanguageChangeNotifier>();

    return Drawer(
      child: Container(
        color: Colors.blue[900],
        child: ListView(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Assets.images.dashLogo.image(
                fit: BoxFit.contain,
              ),
            ),
            const SizedBox(
              height: 16,
            ),
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
            const Divider(),
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
            const Divider(),
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
            const Divider(),
            // ListTile(
            //   title: Text(
            //     l10n.sponsors,
            //     style: const TextStyle(
            //       color: Colors.white,
            //       fontSize: 18,
            //     ),
            //   ),
            //   onTap: () {
            //     _scaffoldKey.currentState?.closeEndDrawer();
            //     _onScollToSponsors();
            //   },
            // ),
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
                context.push('/team');
              },
            ),
            const Divider(),
            LanguageSwitch(
              localeLanguageChangeNotifier: localeLanguageChangeNotifier,
            ),
          ],
        ),
      ),
    );
  }
}

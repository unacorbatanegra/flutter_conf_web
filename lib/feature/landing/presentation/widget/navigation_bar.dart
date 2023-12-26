import 'package:flutter/material.dart';
import 'package:flutter_conf_web/gen/assets.gen.dart';
import 'package:flutter_conf_web/l10n/l10n.dart';

class CustomNavigationBar extends StatelessWidget {
  final GlobalKey<ScaffoldState> _scaffoldKey;
  final VoidCallback _onScrollToHome;
  final VoidCallback _onScrollToAbout;
  final VoidCallback _onScrollToSpeakers;
  final VoidCallback _onScollToSponsors;

  const CustomNavigationBar({
    Key? key,
    required GlobalKey<ScaffoldState> scaffoldKey,
    required VoidCallback onScrollToHome,
    required VoidCallback onScrollToAbout,
    required VoidCallback onScrollToSpeakers,
    required VoidCallback onScollToSponsors,
  })  : _scaffoldKey = scaffoldKey,
        _onScrollToHome = onScrollToHome,
        _onScrollToAbout = onScrollToAbout,
        _onScrollToSpeakers = onScrollToSpeakers,
        _onScollToSponsors = onScollToSponsors,
        super(key: key);

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final size = MediaQuery.of(context).size;
    const breakpoint = 1400;

    return Container(
      height: 100,
      color: Colors.blue[900],
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Assets.images.logo.svg(
            width: 100,
            height: 100,
          ),
          if (size.width < breakpoint)
            IconButton(
              icon: const Icon(
                Icons.menu,
                color: Colors.white,
              ),
              onPressed: () {
                _scaffoldKey.currentState?.openEndDrawer();
              },
            ),
          if (size.width > breakpoint)
            Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                _NavBarItem(
                  l10n.home,
                  onTap: () {
                    _onScrollToHome();
                  },
                ),
                const SizedBox(width: 60),
                _NavBarItem(
                  l10n.about_us,
                  onTap: () {
                    _onScrollToAbout();
                  },
                ),
                const SizedBox(width: 60),
                _NavBarItem(
                  l10n.speakers,
                  onTap: () {
                    _onScrollToSpeakers();
                  },
                ),
                const SizedBox(width: 60),
                _NavBarItem(
                  l10n.sponsors,
                  onTap: () {
                    _onScollToSponsors();
                  },
                ),
                const SizedBox(width: 60),
                _NavBarItem(
                  l10n.team,
                  onTap: () {},
                ),
              ],
            )
        ],
      ),
    );
  }
}

class _NavBarItem extends StatelessWidget {
  final String _title;
  final VoidCallback? _onTap;

  const _NavBarItem(
    this._title, {
    VoidCallback? onTap,
  }) : _onTap = onTap;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      child: TextButton(
        onPressed: _onTap,
        child: Text(
          _title,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 18,
          ),
        ),
      ),
    );
  }
}

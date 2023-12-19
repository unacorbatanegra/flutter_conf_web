import 'package:flutter/material.dart';
import 'package:flutter_conf_web/gen/assets.gen.dart';

class CustomNavigationBar extends StatelessWidget {
  final GlobalKey<ScaffoldState> _scaffoldKey;

  const CustomNavigationBar({
    super.key,
    required GlobalKey<ScaffoldState> scaffoldKey,
  }) : _scaffoldKey = scaffoldKey;

  @override
  Widget build(BuildContext context) {
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
            const Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                _NavBarItem('Home'),
                SizedBox(width: 60),
                _NavBarItem('About'),
                SizedBox(width: 60),
                _NavBarItem('Contact'),
                SizedBox(width: 60),
                _NavBarItem('Speakers'),
                SizedBox(width: 60),
                _NavBarItem('Agenda'),
                SizedBox(width: 60),
                _NavBarItem('Contact'),
                SizedBox(width: 60),
                _NavBarItem('Sponsors'),
                SizedBox(width: 60),
                _NavBarItem('Team'),
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
    return TextButton(
      onPressed: _onTap,
      child: Text(
        _title,
        style: const TextStyle(
          color: Colors.white,
          fontSize: 18,
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_conf_web/app/models/conference_config.dart';
import 'package:flutter_conf_web/app/notifiers/language_change_notifier.dart';
import 'package:flutter_conf_web/app/widgets/language_switch.dart';
import 'package:flutter_conf_web/core/constants/constants.dart';
import 'package:flutter_conf_web/gen/assets.gen.dart';
import 'package:flutter_conf_web/l10n/l10n.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

const Color _kBackgroundColor = Color(0xFF191C36);
const Color _kTextColor = Colors.white;
const Color _kButtonColor = Color(0xFF5983F8);

class CustomNavigationBar extends StatelessWidget {
  final GlobalKey<ScaffoldState> _scaffoldKey;
  final VoidCallback _onScrollToHome;
  final VoidCallback _onScrollToSpeakers;
  final VoidCallback _onScollToAgenda;
  final VoidCallback? _onScrollToSponsors;
  final VoidCallback _onScrollToTeam;
  final ConferenceConfig? config;

  const CustomNavigationBar({
    Key? key,
    required GlobalKey<ScaffoldState> scaffoldKey,
    required VoidCallback onScrollToHome,
    required VoidCallback onScrollToSpeakers,
    required VoidCallback onScollToAgenda,
    VoidCallback? onScrollToSponsors,
    required VoidCallback onScrollToTeam,
    this.config,
  })  : _scaffoldKey = scaffoldKey,
        _onScrollToHome = onScrollToHome,
        _onScrollToSpeakers = onScrollToSpeakers,
        _onScollToAgenda = onScollToAgenda,
        _onScrollToSponsors = onScrollToSponsors,
        _onScrollToTeam = onScrollToTeam,
        super(key: key);

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final size = MediaQuery.of(context).size;
    final localeLanguageChangeNotifier =
        context.watch<LanguageChangeNotifier>();

    return Container(
      color: _kBackgroundColor,
      padding: EdgeInsets.symmetric(
        horizontal: size.width >= kBreakpointLarge ? 150.0 : 24.0,
        vertical: 16.0,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          // Logo and Title Section
          _LogoAndTitle(onTap: _onScrollToHome),

          // Mobile menu button
          if (size.width < kBreakpointLarge)
            IconButton(
              icon: const Icon(
                Icons.menu,
                color: _kTextColor,
                size: 28,
              ),
              onPressed: () {
                _scaffoldKey.currentState?.openEndDrawer();
              },
            ),

          // Desktop navigation
          if (size.width >= kBreakpointLarge)
            Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                _NavBarItem(
                  l10n.speakers,
                  onTap: _onScrollToSpeakers,
                ),
                _NavBarItem(
                  l10n.agenda,
                  onTap: _onScollToAgenda,
                ),
                _NavBarItem(
                  l10n.sponsors,
                  onTap: _onScrollToSponsors,
                ),
                _NavBarItem(
                  l10n.team,
                  onTap: _onScrollToTeam,
                ),
                const SizedBox(width: 20),
                Flexible(
                  child: LanguageSwitch(
                    localeLanguageChangeNotifier: localeLanguageChangeNotifier,
                  ),
                ),
                const SizedBox(width: 20),
                _RegistrationButton(config: config),
              ],
            )
        ],
      ),
    );
  }
}

class _LogoAndTitle extends StatelessWidget {
  final VoidCallback onTap;

  const _LogoAndTitle({
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Assets.images.fullLogo.svg(),
    );
  }
}

class _RegistrationButton extends StatelessWidget {
  final ConferenceConfig? config;

  const _RegistrationButton({
    required this.config,
  });

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;

    return ElevatedButton(
      onPressed: () {
        if (config?.registrationUrl != null) {
          launchUrl(Uri.parse(config!.registrationUrl!));
        } else {
          debugPrint('Registration URL is null');
        }
      },
      style: ElevatedButton.styleFrom(
        backgroundColor: _kButtonColor,
        foregroundColor: _kTextColor,
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
        elevation: 0,
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            l10n.register,
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(width: 8),
          const Icon(
            Icons.arrow_forward_ios,
            size: 14,
          ),
        ],
      ),
    );
  }
}

class _NavBarItem extends StatefulWidget {
  final String _title;
  final VoidCallback? _onTap;

  const _NavBarItem(
    this._title, {
    VoidCallback? onTap,
  }) : _onTap = onTap;

  @override
  State<_NavBarItem> createState() => _NavBarItemState();
}

class _NavBarItemState extends State<_NavBarItem> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15.0),
      child: MouseRegion(
        cursor: SystemMouseCursors.click,
        onEnter: (_) => setState(() => _isHovered = true),
        onExit: (_) => setState(() => _isHovered = false),
        child: InkWell(
          onTap: widget._onTap,
          child: AnimatedDefaultTextStyle(
            duration: const Duration(milliseconds: 200),
            style: TextStyle(
              color: _isHovered ? _kButtonColor : _kTextColor,
              fontSize: 16,
              fontWeight: FontWeight.w500,
            ),
            child: Text(widget._title),
          ),
        ),
      ),
    );
  }
}

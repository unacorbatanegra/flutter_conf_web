import 'package:flutter/material.dart';
import 'package:flutter_conf_web/app/models/conference_config.dart';
import 'package:flutter_conf_web/app/notifiers/language_change_notifier.dart';
import 'package:flutter_conf_web/app/widgets/language_switch.dart';
import 'package:flutter_conf_web/gen/assets.gen.dart';
import 'package:flutter_conf_web/l10n/l10n.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

class CustomDrawer extends StatelessWidget {
  final GlobalKey<ScaffoldState> _scaffoldKey;
  final VoidCallback _onScrollToSpeakers;
  final VoidCallback _onScollToAgenda;
  final VoidCallback? _onScrollToSponsors;
  final VoidCallback _onScrollToTeam;
  final ConferenceConfig? config;

  const CustomDrawer({
    Key? key,
    required GlobalKey<ScaffoldState> scaffoldKey,
    required VoidCallback onScrollToHome,
    required VoidCallback onScrollToSpeakers,
    required VoidCallback onScollToAgenda,
    VoidCallback? onScrollToSponsors,
    required VoidCallback onScrollToTeam,
    this.config,
  })  : _scaffoldKey = scaffoldKey,
        _onScrollToSpeakers = onScrollToSpeakers,
        _onScollToAgenda = onScollToAgenda,
        _onScrollToSponsors = onScrollToSponsors,
        _onScrollToTeam = onScrollToTeam,
        super(key: key);

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final localeLanguageChangeNotifier = context.watch<LanguageChangeNotifier>();

    return Drawer(
      child: Container(
        color: const Color(0xFF191C36),
        child: SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Header with logo and title
              Padding(
                padding: const EdgeInsets.all(24.0),
                child: Row(
                  children: [
                    Assets.images.logo.svg(
                      height: 40,
                      width: 40,
                    ),
                    const SizedBox(width: 12),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          l10n.eventNameTitle,
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 18,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                        Text(
                          l10n.eventNameSubtitle,
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 14,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              const Divider(color: Color(0xFF2A2D4A), thickness: 1),
              const SizedBox(height: 16),

              // Navigation items
              _DrawerItem(
                title: l10n.speakers,
                onTap: () {
                  _scaffoldKey.currentState?.closeEndDrawer();
                  _onScrollToSpeakers();
                },
              ),
              _DrawerItem(
                title: l10n.agenda,
                onTap: () {
                  _scaffoldKey.currentState?.closeEndDrawer();
                  _onScollToAgenda();
                },
              ),
              _DrawerItem(
                title: l10n.sponsors,
                onTap: () {
                  _scaffoldKey.currentState?.closeEndDrawer();
                  if (_onScrollToSponsors != null) {
                    _onScrollToSponsors!();
                  }
                },
              ),
              _DrawerItem(
                title: l10n.team,
                onTap: () {
                  _scaffoldKey.currentState?.closeEndDrawer();
                  _onScrollToTeam();
                },
              ),

              const Spacer(),

              // Registration button
              Padding(
                padding: const EdgeInsets.all(24.0),
                child: SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () {
                      if (config?.registrationUrl != null) {
                        launchUrl(Uri.parse(config!.registrationUrl!));
                      } else {
                        debugPrint('Registration URL is null');
                      }
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF5983F8),
                      foregroundColor: Colors.white,
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          l10n.register,
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        const SizedBox(width: 8),
                        const Icon(Icons.arrow_forward, size: 18),
                      ],
                    ),
                  ),
                ),
              ),

              // Language switch
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 16.0),
                child: LanguageSwitch(
                  localeLanguageChangeNotifier: localeLanguageChangeNotifier,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _DrawerItem extends StatelessWidget {
  final String title;
  final VoidCallback onTap;

  const _DrawerItem({
    required this.title,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 16.0),
        child: Text(
          title,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 16,
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_conf_web/app/models/conference_config.dart';
import 'package:flutter_conf_web/app/models/team_model.dart';
import 'package:flutter_conf_web/app/services/url_service.dart';
import 'package:flutter_conf_web/core/constants/constants.dart';
import 'package:flutter_conf_web/gen/assets.gen.dart';
import 'package:flutter_conf_web/l10n/l10n.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:seo_renderer/seo_renderer.dart';

class TeamSection extends StatelessWidget {
  final ConferenceConfig config;

  const TeamSection({
    super.key,
    required this.config,
  });

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final l10n = context.l10n;

    int crossAxisCount;
    if (size.width > kBreakpointLarge) {
      crossAxisCount = 3;
    } else if (size.width > kBreakPoint) {
      crossAxisCount = 2;
    } else {
      crossAxisCount = 1;
    }

    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(
        horizontal: size.width > kBreakPoint ? 80 : 20,
        vertical: size.width > kBreakPoint ? 100 : 60,
      ),
      decoration: const BoxDecoration(
        color: Color(0xFFF5F5F5),
      ),
      child: Column(
        children: [
          // Title
          TextRenderer(
            child: Text(
              l10n.team,
              style: GoogleFonts.lato(
                fontSize: size.width > kBreakPoint ? 48 : 36,
                fontWeight: FontWeight.w700,
                color: const Color(0xFF1a1d3a),
              ),
              textAlign: TextAlign.center,
            ),
          ),
          const SizedBox(height: 60),

          // Team Grid
          Container(
            constraints: const BoxConstraints(maxWidth: 1200),
            child: GridView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: crossAxisCount,
                crossAxisSpacing: 30,
                mainAxisSpacing: 30,
                childAspectRatio: 0.75,
              ),
              itemCount: config.team.length,
              itemBuilder: (context, index) {
                return _TeamMemberCard(
                  member: config.team[index],
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

class _TeamMemberCard extends StatefulWidget {
  final Team member;

  const _TeamMemberCard({
    required this.member,
  });

  @override
  State<_TeamMemberCard> createState() => _TeamMemberCardState();
}

class _TeamMemberCardState extends State<_TeamMemberCard> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(
              color: _isHovered
                  ? Colors.black.withOpacity(0.3)
                  : Colors.black.withOpacity(0.15),
              blurRadius: _isHovered ? 20 : 10,
              offset: const Offset(0, 5),
            ),
          ],
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(20),
          child: Container(
            decoration: const BoxDecoration(
              color: Color(0xFF1C2541),
            ),
            child: Column(
              children: [
                // Header with name and role
                Padding(
                  padding: const EdgeInsets.all(20),
                  child: Column(
                    children: [
                      TextRenderer(
                        child: Text(
                          widget.member.name,
                          style: GoogleFonts.lato(
                            color: Colors.white,
                            fontSize: 16,
                            fontWeight: FontWeight.w700,
                          ),
                          textAlign: TextAlign.center,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      const SizedBox(height: 4),
                      if (widget.member.organizerRole != null) ...[
                        TextRenderer(
                          child: Text(
                            widget.member.organizerRole!,
                            style: GoogleFonts.lato(
                              color: Colors.white.withOpacity(0.9),
                              fontSize: 12,
                              fontWeight: FontWeight.w600,
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ),
                        const SizedBox(height: 2),
                      ],
                      TextRenderer(
                        child: Text(
                          widget.member.role,
                          style: GoogleFonts.lato(
                            color: Colors.white.withOpacity(0.8),
                            fontSize: 12,
                            fontWeight: FontWeight.w400,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ],
                  ),
                ),

                // Photo section
                Expanded(
                  child: Container(
                    margin: const EdgeInsets.symmetric(horizontal: 16),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(12),
                      child: Semantics(
                        label: '${widget.member.name} photo',
                        image: true,
                        child: Image.asset(
                          widget.member.image,
                          fit: BoxFit.cover,
                          width: double.infinity,
                        ),
                      ),
                    ),
                  ),
                ),

                // Social Media Links
                _SocialMediaLinks(member: widget.member),

                const SizedBox(height: 16),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _SocialMediaLinks extends StatelessWidget {
  final Team member;

  const _SocialMediaLinks({
    required this.member,
  });

  @override
  Widget build(BuildContext context) {
    final urlService = context.read<UrlService>();
    final availableLinks = member.availableSocialLinks;

    if (availableLinks.isEmpty) {
      return const SizedBox(height: 12);
    }

    return Padding(
      padding: const EdgeInsets.only(top: 12),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: availableLinks.map((entry) {
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 6),
            child: Semantics(
              label: "Open ${member.name}'s ${_getPlatformName(entry.key)} profile",
              button: true,
              child: InkWell(
                onTap: () => urlService.openUrl(entry.value),
                borderRadius: BorderRadius.circular(20),
                child: Container(
                  width: 32,
                  height: 32,
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.15),
                    shape: BoxShape.circle,
                  ),
                  child: Center(
                    child: _getSocialIcon(entry.key),
                  ),
                ),
              ),
            ),
          );
        }).toList(),
      ),
    );
  }

  Widget _getSocialIcon(String platform) {
    switch (platform) {
      case 'linkedin':
        return Assets.icons.linkedin.svg(
          width: 16,
          height: 16,
          colorFilter: const ColorFilter.mode(
            Colors.white,
            BlendMode.srcIn,
          ),
        );
      case 'twitter':
        return Assets.icons.x.svg(
          width: 16,
          height: 16,
          colorFilter: const ColorFilter.mode(
            Colors.white,
            BlendMode.srcIn,
          ),
        );
      case 'github':
        return Assets.icons.github.svg(
          width: 16,
          height: 16,
          colorFilter: const ColorFilter.mode(
            Colors.white,
            BlendMode.srcIn,
          ),
        );
      default:
        return const SizedBox.shrink();
    }
  }

  String _getPlatformName(String platform) {
    switch (platform) {
      case 'linkedin':
        return 'LinkedIn';
      case 'twitter':
        return 'X (Twitter)';
      case 'github':
        return 'GitHub';
      default:
        return platform;
    }
  }
}

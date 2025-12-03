import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:flutter_conf_web/app/models/conference_config.dart';
import 'package:flutter_conf_web/core/constants/constants.dart';
import 'package:flutter_conf_web/gen/assets.gen.dart';
import 'package:flutter_conf_web/l10n/l10n.dart';
import 'package:google_fonts/google_fonts.dart';

class AgendaSection extends StatefulWidget {
  final ConferenceConfig config;

  const AgendaSection({
    super.key,
    required this.config,
  });

  @override
  State<AgendaSection> createState() => _AgendaSectionState();
}

class _AgendaSectionState extends State<AgendaSection> {
  late String _eventInfo;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _eventInfo = _formatEventDate();
  }

  String _formatEventDate() {
    final locale = Localizations.localeOf(context);
    final isSpanish = locale.languageCode == 'es';
    final format = isSpanish
        ? DateFormat('d \'de\' MMMM \'de\' y', 'es')
        : DateFormat('MMMM d, y', 'en');
    return format.format(widget.config.eventDate).toUpperCase();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final isDesktop = size.width > kBreakPoint;
    final l10n = context.l10n;
    final eventInfo = _eventInfo;

    return Container(
      width: double.infinity,
      decoration: const BoxDecoration(
        color: Color(0xFFF5F5F5),
      ),
      child: Stack(
        children: [
          // Background Image - Top Right
          Positioned(
            top: 0,
            right: 0,
            child: Assets.images.agendaBackground1.image(
              width: 300,
              height: 300,
              fit: BoxFit.contain,
            ),
          ),
          // Content
          Padding(
            padding: EdgeInsets.symmetric(
              horizontal: isDesktop ? 80 : 20,
              vertical: isDesktop ? 100 : 60,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                // Title
                Text(
                  l10n.agenda,
                  style: GoogleFonts.lato(
                    fontSize: isDesktop ? 48 : 36,
                    fontWeight: FontWeight.w700,
                    color: const Color(0xFF1a1d3a),
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 60),

                // Date Header
                Container(
                  constraints: const BoxConstraints(maxWidth: 1200),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        eventInfo,
                        style: GoogleFonts.lato(
                          fontSize: isDesktop ? 32 : 24,
                          fontWeight: FontWeight.w700,
                          color: const Color(0xFF1a1d3a),
                        ),
                      ),
                      const SizedBox(height: 40),

                      // Schedule Grid
                      if (isDesktop)
                        _DesktopSchedule(config: widget.config)
                      else
                        _MobileSchedule(config: widget.config),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _DesktopSchedule extends StatelessWidget {
  final ConferenceConfig config;

  const _DesktopSchedule({
    required this.config,
  });

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final morningItems = config.morningAgenda;
    final afternoonItems = config.afternoonAgenda;

    // Show "Coming Soon" if both are empty
    if (morningItems.isEmpty && afternoonItems.isEmpty) {
      return const _EmptyAgendaState();
    }

    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Morning Column
        if (morningItems.isNotEmpty)
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  l10n.morning,
                  style: GoogleFonts.lato(
                    fontSize: 24,
                    fontWeight: FontWeight.w700,
                    color: const Color(0xFF1a1d3a),
                  ),
                ),
                const SizedBox(height: 24),
                ...morningItems.map((item) {
                  return Padding(
                    padding: const EdgeInsets.only(bottom: 24),
                    child: _AgendaItem(
                      time: item.time,
                      title: item.title ?? '',
                      speaker: item.speaker,
                      description: item.description,
                      isHighlighted: item.isHighlighted,
                    ),
                  );
                }),
              ],
            ),
          ),
        if (morningItems.isNotEmpty && afternoonItems.isNotEmpty)
          const SizedBox(width: 60),

        // Afternoon Column
        if (afternoonItems.isNotEmpty)
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  l10n.afternoon,
                  style: GoogleFonts.lato(
                    fontSize: 24,
                    fontWeight: FontWeight.w700,
                    color: const Color(0xFF1a1d3a),
                  ),
                ),
                const SizedBox(height: 24),
                ...afternoonItems.map((item) {
                  return Padding(
                    padding: const EdgeInsets.only(bottom: 24),
                    child: _AgendaItem(
                      time: item.time,
                      title: item.title ?? '',
                      speaker: item.speaker,
                      description: item.description,
                      isHighlighted: item.isHighlighted,
                    ),
                  );
                }),
              ],
            ),
          ),
      ],
    );
  }
}

class _MobileSchedule extends StatelessWidget {
  final ConferenceConfig config;

  const _MobileSchedule({
    required this.config,
  });

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final morningItems = config.morningAgenda;
    final afternoonItems = config.afternoonAgenda;

    // Show "Coming Soon" if both are empty
    if (morningItems.isEmpty && afternoonItems.isEmpty) {
      return const _EmptyAgendaState();
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Morning Section
        if (morningItems.isNotEmpty) ...[
          Text(
            l10n.morning,
            style: GoogleFonts.lato(
              fontSize: 20,
              fontWeight: FontWeight.w700,
              color: const Color(0xFF1a1d3a),
            ),
          ),
          const SizedBox(height: 20),
          ...morningItems.map((item) {
            return Padding(
              padding: const EdgeInsets.only(bottom: 20),
              child: _AgendaItem(
                time: item.time,
                title: item.title ?? '',
                speaker: item.speaker,
                description: item.description,
                isHighlighted: item.isHighlighted,
              ),
            );
          }),
          const SizedBox(height: 40),
        ],

        // Afternoon Section
        if (afternoonItems.isNotEmpty) ...[
          Text(
            l10n.afternoon,
            style: GoogleFonts.lato(
              fontSize: 20,
              fontWeight: FontWeight.w700,
              color: const Color(0xFF1a1d3a),
            ),
          ),
          const SizedBox(height: 20),
          ...afternoonItems.map((item) {
            return Padding(
              padding: const EdgeInsets.only(bottom: 20),
              child: _AgendaItem(
                time: item.time,
                title: item.title ?? '',
                speaker: item.speaker,
                description: item.description,
                isHighlighted: item.isHighlighted,
              ),
            );
          }),
        ],
      ],
    );
  }
}

class _AgendaItem extends StatelessWidget {
  final String time;
  final String title;
  final String? speaker;
  final String? description;
  final bool isHighlighted;

  const _AgendaItem({
    required this.time,
    required this.title,
    this.speaker,
    this.description,
    this.isHighlighted = false,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Time
        Text(
          time,
          style: GoogleFonts.lato(
            fontSize: 12,
            fontWeight: FontWeight.w600,
            color: const Color(0xFF666666),
            letterSpacing: 0.5,
          ),
        ),
        const SizedBox(height: 8),

        // Title
        Text(
          title,
          style: GoogleFonts.lato(
            fontSize: 18,
            fontWeight: FontWeight.w700,
            color: isHighlighted
                ? const Color(0xFF5983F8)
                : const Color(0xFF1a1d3a),
            decoration: isHighlighted ? TextDecoration.underline : null,
            decorationColor: const Color(0xFF5983F8),
            decorationThickness: 2,
          ),
        ),

        // Speaker
        if (speaker != null && speaker!.isNotEmpty) ...[
          const SizedBox(height: 8),
          Text(
            speaker!,
            style: GoogleFonts.lato(
              fontSize: 14,
              fontWeight: FontWeight.w600,
              color: const Color(0xFF5983F8),
              fontStyle: FontStyle.italic,
            ),
          ),
        ],

        // Description
        if (description != null && description!.isNotEmpty) ...[
          const SizedBox(height: 12),
          Text(
            description!,
            style: GoogleFonts.lato(
              fontSize: 14,
              fontWeight: FontWeight.w400,
              color: const Color(0xFF555555),
              height: 1.5,
            ),
            maxLines: 3,
            overflow: TextOverflow.ellipsis,
          ),
        ],
      ],
    );
  }
}

class _EmptyAgendaState extends StatelessWidget {
  const _EmptyAgendaState();

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final isDesktop = size.width > kBreakPoint;
    final l10n = context.l10n;

    return Center(
      child: Padding(
        padding: EdgeInsets.symmetric(
          vertical: isDesktop ? 80 : 60,
          horizontal: 20,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.calendar_month_outlined,
              size: isDesktop ? 80 : 60,
              color: const Color(0xFF5983F8).withOpacity(0.3),
            ),
            const SizedBox(height: 24),
            Text(
              l10n.comingSoon,
              style: GoogleFonts.lato(
                fontSize: isDesktop ? 32 : 24,
                fontWeight: FontWeight.w700,
                color: const Color(0xFF1a1d3a),
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 16),
            Text(
              l10n.agendaComingSoonDescription,
              style: GoogleFonts.lato(
                fontSize: isDesktop ? 16 : 14,
                fontWeight: FontWeight.w400,
                color: const Color(0xFF666666),
                height: 1.5,
              ),
              textAlign: TextAlign.center,
              maxLines: 2,
            ),
          ],
        ),
      ),
    );
  }
}

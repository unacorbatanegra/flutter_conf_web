import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_conf_web/gen/assets.gen.dart';
import 'package:flutter_conf_web/l10n/l10n.dart';

class AgendaSection extends StatelessWidget {
  const AgendaSection({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;

    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 32,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            "Agenda",
            style: TextStyle(
              fontSize: 48,
              fontWeight: FontWeight.w700,
            ),
          ),
          const SizedBox(height: 32),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _AgendaItem(
                      info: AgendaInfo(
                        time: "1:00 pm",
                        title: l10n.accreditation,
                        speaker: null,
                      ),
                    ),
                    const SizedBox(height: 12),
                    _AgendaItem(
                      info: AgendaInfo(
                        time: "2:30 pm",
                        title: l10n.performanceBestPractices,
                        speaker: "David Rios ",
                      ),
                    ),
                    const SizedBox(height: 12),
                    _AgendaItem(
                      info: AgendaInfo(
                        time: "3:15 pm",
                        title: l10n.whyFlutter,
                        speaker: "Diego Velázquez",
                      ),
                    ),
                    const SizedBox(height: 12),
                    _AgendaItem(
                      info: AgendaInfo(
                        time: "4:30 pm",
                        title: l10n.remoteParaguay,
                        speaker: "María Teresa Samudio",
                      ),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _AgendaItem(
                      info: AgendaInfo(
                        time: "5:15 pm",
                        title: l10n.gameDevelopment,
                        speaker: "Hansy Schmitt",
                      ),
                    ),
                    const SizedBox(height: 12),
                    _AgendaItem(
                      info: AgendaInfo(
                        time: "6:15 pm",
                        title: l10n.roadMap,
                        speaker: "Carlitos Vargas",
                      ),
                    ),
                    const SizedBox(height: 36),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Assets.images.dash.image(),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _AgendaItem extends StatelessWidget {
  final AgendaInfo info;

  const _AgendaItem({
    Key? key,
    required this.info,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          info.time,
          style: const TextStyle(
            fontSize: 24.4764404296875,
            fontWeight: FontWeight.w700,
            color: Color(0xFF2F80EB),
          ),
        ),
        const SizedBox(height: 12),
        Text(
          info.title,
          style: const TextStyle(
            fontSize: 24.4764404296875,
            fontWeight: FontWeight.w400,
          ),
        ),
        const SizedBox(height: 8),
        if (info.speaker != null)
          Text(
            info.speaker!,
            style: const TextStyle(
              fontSize: 22.251310348510742,
              fontWeight: FontWeight.w300,
            ),
          )
      ],
    );
  }
}

class AgendaInfo extends Equatable {
  final String time;
  final String title;
  final String? speaker;

  const AgendaInfo({
    required this.time,
    required this.title,
    required this.speaker,
  });

  @override
  List<Object?> get props => [time, title, speaker];
}

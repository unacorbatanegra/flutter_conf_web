import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_conf_web/gen/assets.gen.dart';

class AgendaSection extends StatelessWidget {
  const AgendaSection({super.key});

  @override
  Widget build(BuildContext context) {
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
              const Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _AgendaItem(
                      info: AgendaInfo(
                        time: "1:00 pm",
                        title: "Acreditaciones",
                        speaker: null,
                      ),
                    ),
                    SizedBox(height: 12),
                    _AgendaItem(
                      info: AgendaInfo(
                        time: "2:30 pm",
                        title: "Performance Best Practices",
                        speaker: "David Rios ",
                      ),
                    ),
                    SizedBox(height: 12),
                    _AgendaItem(
                      info: AgendaInfo(
                        time: "3:15 pm",
                        title: "¿Por qué uso Flutter en lugar de nativo?",
                        speaker: "Diego Velázquez",
                      ),
                    ),
                    SizedBox(height: 12),
                    _AgendaItem(
                      info: AgendaInfo(
                        time: "4:30 pm",
                        title:
                            'Rumbo a lo "Very Good" : Trabajando remoto desde Paraguay',
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
                    const _AgendaItem(
                      info: AgendaInfo(
                        time: "5:15 pm",
                        title: "Game Development Desde Cero con Flutter",
                        speaker: "Hansy Schmitt",
                      ),
                    ),
                    const SizedBox(height: 12),
                    const _AgendaItem(
                      info: AgendaInfo(
                        time: "6:15 pm",
                        title:
                            "Roadmap para convertirte de Junior a Senior con Flutter",
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

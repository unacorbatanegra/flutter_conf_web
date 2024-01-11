import 'package:flutter/material.dart';
import 'package:flutter_conf_web/app/models/speaker_model.dart';
import 'package:flutter_conf_web/app/services/url_service.dart';
import 'package:flutter_conf_web/gen/assets.gen.dart';
import 'package:flutter_conf_web/l10n/l10n.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

class SpeakersSection extends StatelessWidget {
  final List<SpeakerModel> speakers;

  const SpeakersSection({
    super.key,
    required this.speakers,
  });

  //[
//   {"id": "4", "name": "Carlitos Vargas"},
//   {"id": "2", "name": "María Teresa Samudio González"},
//   {"id": "1", "name": "Diego Velasquez"},
//   {"id": "3", "name": "Hansy Schmitt"},
//   {"id": "0", "name": "David Rios"}
// ]

  String _getTalkTitleL10n(
    BuildContext context, {
    required int id,
  }) {
    final l10n = context.l10n;
    return switch (id) {
      4 => l10n.carlitosCharla,
      2 => l10n.techiCharla,
      1 => l10n.diegoCharla,
      3 => l10n.hansyCharla,
      0 => l10n.davidCharla,
      _ => "Error",
    };
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(height: 32),
        for (final speaker in speakers) ...[
          _SpeakersView(
            speaker: speaker.copyWith(
                talkTitle: _getTalkTitleL10n(
              context,
              id: speaker.id,
            )),
          ),
          const SizedBox(height: 32),
        ],
      ],
    );
  }
}

class _SpeakersView extends StatelessWidget {
  final SpeakerModel speaker;

  const _SpeakersView({
    required this.speaker,
  });

  @override
  Widget build(BuildContext context) {
    final breakpoint = MediaQuery.of(context).size.width > 900;

    if (breakpoint) {
      return _SpeakersDesktop(speaker: speaker);
    } else {
      return _SpeakersMobile(speaker: speaker);
    }
  }
}

class _SpeakersMobile extends StatelessWidget {
  const _SpeakersMobile({
    required this.speaker,
  });

  final SpeakerModel speaker;

  @override
  Widget build(BuildContext context) {
    return Stack(
      clipBehavior: Clip.none,
      children: [
        if (speaker.id % 2 != 0)
          Positioned(
            top: 0,
            right: 0,
            child: Assets.images.xSpeaker.svg(
              width: 300.w,
              height: 300.h,
            ),
          )
        else
          Positioned(
            top: -50,
            left: 0,
            child: Assets.images.circleSpeaker.svg(
              width: 300.w,
              height: 300.h,
            ),
          ),
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            _SpeakerAvatar(
              speaker: speaker,
            ),
            const SizedBox(height: 20),
            _SpeakerInfo(
              speaker: speaker,
            ),
            const SizedBox(height: 20),
          ],
        ),
      ],
    );
  }
}

class _SpeakersDesktop extends StatelessWidget {
  const _SpeakersDesktop({
    required this.speaker,
  });

  final SpeakerModel speaker;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 0),
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          if (speaker.id % 2 == 0)
            Positioned(
              top: 0,
              left: 0,
              child: Assets.images.circleSpeaker.svg(
                width: 300.w,
                height: 300.h,
              ),
            )
          else
            Positioned(
              top: -50,
              right: 0,
              child: Assets.images.xSpeaker.svg(
                width: 300.w,
                height: 300.h,
              ),
            ),
          Padding(
            padding: EdgeInsets.symmetric(
              horizontal: MediaQuery.of(context).size.width * 0.06,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                if (speaker.id % 2 != 0) ...[
                  Expanded(
                    child: _SpeakerInfo(
                      speaker: speaker,
                    ),
                  ),
                  const SizedBox(width: 50),
                  Stack(
                    clipBehavior: Clip.none,
                    children: [
                      Positioned(
                        bottom: -30,
                        right: -20,
                        child: Assets.images.dotSpeaker.svg(
                          width: 300.w,
                          height: 300.h,
                        ),
                      ),
                      _SpeakerAvatar(speaker: speaker),
                    ],
                  ),
                ] else ...[
                  Stack(
                    clipBehavior: Clip.none,
                    children: [
                      Positioned(
                        bottom: -40,
                        left: -20,
                        child: Assets.images.dotSpeaker.svg(
                          width: 300.w,
                          height: 300.h,
                        ),
                      ),
                      _SpeakerAvatar(speaker: speaker),
                    ],
                  ),
                  const SizedBox(width: 50),
                  Expanded(
                    child: _SpeakerInfo(
                      speaker: speaker,
                    ),
                  ),
                ],
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _SpeakerAvatar extends StatelessWidget {
  final SpeakerModel speaker;

  const _SpeakerAvatar({
    required this.speaker,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 300,
      height: 300,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(25),
        child: Image.asset(
          speaker.imagePath,
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}

class _SpeakerInfo extends StatelessWidget {
  final SpeakerModel speaker;

  const _SpeakerInfo({
    required this.speaker,
  });

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Column(
      crossAxisAlignment: size.width > 900
          ? speaker.id % 2 == 0
              ? CrossAxisAlignment.start
              : CrossAxisAlignment.end
          : CrossAxisAlignment.center,
      children: [
        Text(
          '${speaker.name} ${speaker.countryEmoji}',
          style: const TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
          textAlign: size.width > 900 ? null : TextAlign.center,
        ),
        const SizedBox(height: 8),
        Text(
          speaker.profession,
          style: const TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
          textAlign: size.width > 900 ? null : TextAlign.center,
        ),
        const SizedBox(height: 8),
        Text(
          speaker.talkTitle!,
          style: const TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
          textAlign: size.width > 900 ? null : TextAlign.center,
        ),
        const SizedBox(height: 8),
        Row(
          mainAxisAlignment: size.width > 900
              ? speaker.id % 2 == 0
                  ? MainAxisAlignment.start
                  : MainAxisAlignment.end
              : MainAxisAlignment.center,
          children: [
            if (speaker.twitterUrl != null) ...[
              IconButton(
                tooltip: 'X',
                onPressed: () {
                  context.read<UrlService>().openUrl(speaker.twitterUrl!);
                },
                icon: Assets.icons.x.svg(
                  width: 40,
                  height: 40,
                ),
              ),
            ],
            if (speaker.linkedinUrl != null) ...[
              IconButton(
                tooltip: 'Linkedin',
                onPressed: () {
                  context.read<UrlService>().openUrl(speaker.linkedinUrl!);
                },
                icon: Assets.icons.linkedin.svg(
                  width: 40,
                  height: 40,
                ),
              ),
            ],
            if (speaker.youtubeUrl != null) ...[
              IconButton(
                tooltip: 'Youtube',
                onPressed: () {
                  context.read<UrlService>().openUrl(speaker.youtubeUrl!);
                },
                icon: Assets.icons.youtube.svg(
                  width: 40,
                  height: 40,
                ),
              )
            ],
            if (speaker.facebookUrl != null) ...[
              IconButton(
                tooltip: 'Facebook',
                onPressed: () {
                  context.read<UrlService>().openUrl(speaker.facebookUrl!);
                },
                icon: Assets.icons.facebook.svg(
                  width: 40,
                  height: 40,
                ),
              )
            ],
          ],
        ),
      ],
    );
  }
}

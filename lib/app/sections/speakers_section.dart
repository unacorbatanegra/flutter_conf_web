import 'package:flutter/material.dart';
import 'package:flutter_conf_web/app/models/speaker_model.dart';
import 'package:flutter_conf_web/app/services/url_service.dart';
import 'package:flutter_conf_web/gen/assets.gen.dart';
import 'package:flutter_conf_web/l10n/l10n.dart';
import 'package:provider/provider.dart';

class SpeakersSection extends StatelessWidget {
  final List<SpeakerModel> speakers;

  const SpeakersSection({
    super.key,
    required this.speakers,
  });

  //[
//   {"id": "1", "name": "Carlitos Vargas"},
//   {"id": "2", "name": "María Teresa Samudio González"},
//   {"id": "3", "name": "Diego Velasquez"},
//   {"id": "4", "name": "Hansy Schmitt"},
//   {"id": "5", "name": "David Nuñez"}
// ]

  String _getTalkTitleL10n(
    BuildContext context, {
    required int id,
  }) {
    final l10n = context.l10n;
    return switch (id) {
      0 => l10n.carlitosCharla,
      1 => l10n.techiCharla,
      2 => l10n.diegoCharla,
      3 => l10n.hansyCharla,
      4 => l10n.davidCharla,
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
    final breakpoint = MediaQuery.of(context).size.width > 800;

    if (breakpoint) {
      return _SpeakersDesktop(speaker: speaker);
    } else {
      return _SpeakersMobile(speaker: speaker);
    }
  }
}

class _SpeakersMobile extends StatelessWidget {
  const _SpeakersMobile({
    super.key,
    required this.speaker,
  });

  final SpeakerModel speaker;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        _SpeakerAvatar(
          speaker: speaker,
        ),
        const SizedBox(height: 20),
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: _SpeakerInfo(
            speaker: speaker,
          ),
        ),
      ],
    );
  }
}

class _SpeakersDesktop extends StatelessWidget {
  const _SpeakersDesktop({
    super.key,
    required this.speaker,
  });

  final SpeakerModel speaker;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        if (speaker.id % 2 == 0) ...[
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: _SpeakerInfo(
                speaker: speaker,
              ),
            ),
          ),
          const SizedBox(width: 50),
          Expanded(
            child: _SpeakerAvatar(speaker: speaker),
          ),
        ] else ...[
          Expanded(
            child: _SpeakerAvatar(
              speaker: speaker,
            ),
          ),
          const SizedBox(width: 50),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: _SpeakerInfo(
                speaker: speaker,
              ),
            ),
          ),
        ],
      ],
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
    return ClipRRect(
      borderRadius: BorderRadius.circular(16),
      child: Image.asset(
        speaker.imagePath,
        width: 300,
        height: 400,
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
    return Card(
      elevation: 5,
      clipBehavior: Clip.antiAlias,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      color: Colors.blue[900],
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              '${speaker.name} ${speaker.countryEmoji}',
              style: const TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 8),
            Text(
              speaker.profession,
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 8),
            Text(
              speaker.talkTitle!,
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 8),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                if (speaker.twitterUrl != null) ...[
                  IconButton(
                    tooltip: 'Twitter',
                    onPressed: () {
                      context.read<UrlService>().openUrl(speaker.twitterUrl!);
                    },
                    icon: Assets.icons.twitter.image(
                      width: 20,
                      height: 20,
                      color: Colors.white,
                    ),
                  ),
                ] else
                  const _FakeIcon(),
                if (speaker.linkedinUrl != null) ...[
                  IconButton(
                    tooltip: 'Linkedin',
                    onPressed: () {
                      context.read<UrlService>().openUrl(speaker.linkedinUrl!);
                    },
                    icon: Assets.icons.linkedin.image(
                      width: 20,
                      height: 20,
                      color: Colors.white,
                    ),
                  ),
                ] else
                  const _FakeIcon(),
                if (speaker.youtubeUrl != null) ...[
                  IconButton(
                    tooltip: 'Youtube',
                    onPressed: () {
                      context.read<UrlService>().openUrl(speaker.youtubeUrl!);
                    },
                    icon: Assets.icons.youtube.image(
                      width: 20,
                      height: 20,
                      color: Colors.white,
                    ),
                  )
                ] else
                  const _FakeIcon(),
                if (speaker.facebookUrl != null) ...[
                  IconButton(
                    tooltip: 'Facebook',
                    onPressed: () {
                      context.read<UrlService>().openUrl(speaker.facebookUrl!);
                    },
                    icon: Assets.icons.facebook.image(
                      width: 20,
                      height: 20,
                      color: Colors.white,
                    ),
                  )
                ] else
                  const _FakeIcon()
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class _FakeIcon extends StatelessWidget {
  const _FakeIcon();

  @override
  Widget build(BuildContext context) {
    return const IconButton(
      onPressed: null,
      icon: Icon(
        Icons.info,
        color: Colors.transparent,
        size: 20,
      ),
    );
  }
}

import 'package:equatable/equatable.dart';

class SpeakerModel extends Equatable {
  final String imagePath;
  final String name;
  final String profession;
  final String talkTitle;
  final String? linkedinUrl;
  final String? twitterUrl;
  final String? youtubeUrl;

  const SpeakerModel({
    required this.imagePath,
    required this.name,
    required this.profession,
    required this.talkTitle,
    required this.linkedinUrl,
    required this.twitterUrl,
    required this.youtubeUrl,
  });

  @override
  List<Object?> get props => [
        imagePath,
        name,
        profession,
        talkTitle,
        linkedinUrl,
        twitterUrl,
        youtubeUrl,
      ];
}

const List<SpeakerModel> speakers = [
  SpeakerModel(
    imagePath: 'assets/images/speakers/speaker_1.png',
    name: 'Diego Velasquez',
    profession: 'Software Engineer - Google Developer Expert',
    talkTitle:
        'Por qué uso Flutter en lugar de nativo?, Flutter, un mundo lleno de animaciones',
    linkedinUrl: 'https://www.linkedin.com/in/diegoveloper/',
    twitterUrl: 'https://twitter.com/diegoveloper',
    youtubeUrl: 'https://www.youtube.com/diegoveloper',
  ),
  SpeakerModel(
    imagePath: 'assets/images/speakers/speaker_2.jpg',
    name: 'Hansy Schmitt',
    profession: 'Full Stack Developer - Athenaworks',
    talkTitle:
        'Game Development with Flutter, Hardware hacking with Flutter,  IA Generation with Flutter',
    linkedinUrl: null,
    twitterUrl: null,
    youtubeUrl: null,
  ),
  SpeakerModel(
    imagePath: 'assets/images/speakers/speaker_3.jpg',
    name: 'Carlos Vargas',
    profession: 'Flutter Senior Developer - Banco Basa',
    talkTitle:
        "Me encantaría compartir con la comunidad un 'roadmap' que he ideado para guiar a juniors a convertirse en semi-seniors o seniors en menos de 1 año.",
    linkedinUrl: 'https://www.linkedin.com/in/kalitodev',
    twitterUrl: null,
    youtubeUrl: null,
  ),
  SpeakerModel(
    imagePath: 'assets/images/speakers/speaker_4.jpg',
    name: 'María Teresa Samudio González',
    profession: 'Software Engineer - Very Good Ventures',
    talkTitle:
        'Remotamente posible. Cómo llegué a Very Good Ventures desde Misiones - Paraguay',
    linkedinUrl: 'https://www.linkedin.com/in/maria-teresa-samudio/',
    twitterUrl: null,
    youtubeUrl: null,
  ),
];

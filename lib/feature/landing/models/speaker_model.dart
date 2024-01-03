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
    profession: 'Diegoveloper',
    talkTitle: 'Flutter en lugar de nativo',
    linkedinUrl: 'https://www.linkedin.com/in/diegoveloper/',
    twitterUrl: 'https://twitter.com/diegoveloper',
    youtubeUrl: 'https://www.youtube.com/diegoveloper',
  ),
  SpeakerModel(
    imagePath: 'assets/images/speakers/speaker_2.jpg',
    name: 'Hansy Schmitt',
    profession: 'Full Stack Developer - Athenaworks',
    talkTitle: 'Game Development with Flutter',
    linkedinUrl: null,
    twitterUrl: null,
    youtubeUrl: null,
  ),
  SpeakerModel(
    imagePath: 'assets/images/speakers/speaker_3.jpg',
    name: 'Carlos Vargas',
    profession: 'Flutter Senior Developer - Banco Basa',
    talkTitle: "Roadmap de Flutter. De junior a senior",
    linkedinUrl: 'https://www.linkedin.com/in/kalitodev',
    twitterUrl: null,
    youtubeUrl: null,
  ),
  SpeakerModel(
    imagePath: 'assets/images/speakers/speaker_4.jpg',
    name: 'María Teresa Samudio González',
    profession: 'Software Engineer - Very Good Ventures',
    talkTitle: 'Cómo llegué a Very Good Ventures desde Misiones - Paraguay',
    linkedinUrl: 'https://www.linkedin.com/in/maria-teresa-samudio/',
    twitterUrl: null,
    youtubeUrl: null,
  ),
];

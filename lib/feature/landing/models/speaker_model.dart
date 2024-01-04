import 'package:equatable/equatable.dart';

class SpeakerModel extends Equatable {
  final String imagePath;
  final String name;
  final String profession;
  final String talkTitle;
  final String? linkedinUrl;
  final String? twitterUrl;
  final String? youtubeUrl;
  final String countryEmoji;

  const SpeakerModel({
    required this.imagePath,
    required this.name,
    required this.profession,
    required this.talkTitle,
    required this.linkedinUrl,
    required this.twitterUrl,
    required this.youtubeUrl,
    required this.countryEmoji,
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
        countryEmoji,
      ];
}

const List<SpeakerModel> speakers = [
  SpeakerModel(
    imagePath: 'assets/images/speakers/speaker_1.png',
    name: 'Diego Velasquez',
    profession: 'Software Engineer | Google Developer Expert',
    talkTitle:
        '¿Por qué uso Flutter en lugar de nativo? Tomando decisiones que impactan el negocio',
    linkedinUrl: 'https://www.linkedin.com/in/diegoveloper/',
    twitterUrl: 'https://twitter.com/diegoveloper',
    youtubeUrl: 'https://www.youtube.com/diegoveloper',
    countryEmoji: '🇵🇪',
  ),
  SpeakerModel(
    imagePath: 'assets/images/speakers/speaker_2.jpg',
    name: 'Hansy Schmitt',
    profession: 'Senior Mobile/Backend Developer',
    talkTitle: 'Game Development Desde Cero: Mi primer videojuego con Flutter',
    linkedinUrl: null,
    twitterUrl: null,
    youtubeUrl: null,
    countryEmoji: '🇵🇪',
  ),
  SpeakerModel(
    imagePath: 'assets/images/speakers/speaker_3.jpg',
    name: 'Carlitos Vargas',
    profession: 'Senior Flutter Developer | Banco Basa',
    talkTitle:
        "Del Inicio al Éxito: El roadmap para convertirte de Junior a Senior con Flutter",
    linkedinUrl: 'https://www.linkedin.com/in/kalitodev',
    twitterUrl: null,
    youtubeUrl: null,
    countryEmoji: '🇵🇾',
  ),
  SpeakerModel(
    imagePath: 'assets/images/speakers/speaker_4.jpg',
    name: 'María Teresa Samudio González',
    profession: 'Software Engineer - Very Good Ventures',
    talkTitle: 'Rumbo a lo Very Good - Trabajando remoto desde Paraguay',
    linkedinUrl: 'https://www.linkedin.com/in/maria-teresa-samudio/',
    twitterUrl: null,
    youtubeUrl: null,
    countryEmoji: '🇵🇾',
  ),
];

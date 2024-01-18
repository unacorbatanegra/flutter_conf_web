import 'package:equatable/equatable.dart';

class SpeakerModel extends Equatable {
  final int id;
  final String imagePath;
  final String name;
  final String profession;
  final String? talkTitle;
  final String? linkedinUrl;
  final String? twitterUrl;
  final String? youtubeUrl;
  final String? facebookUrl;
  final String countryEmoji;

  const SpeakerModel({
    required this.id,
    required this.imagePath,
    required this.name,
    required this.profession,
    required this.talkTitle,
    required this.linkedinUrl,
    required this.twitterUrl,
    required this.youtubeUrl,
    required this.facebookUrl,
    required this.countryEmoji,
  });

  SpeakerModel copyWith({
    int? id,
    String? imagePath,
    String? name,
    String? profession,
    String? talkTitle,
    String? linkedinUrl,
    String? twitterUrl,
    String? youtubeUrl,
    String? facebookUrl,
    String? countryEmoji,
    String? l10nCode,
  }) {
    return SpeakerModel(
      id: id ?? this.id,
      imagePath: imagePath ?? this.imagePath,
      name: name ?? this.name,
      profession: profession ?? this.profession,
      talkTitle: talkTitle ?? this.talkTitle,
      linkedinUrl: linkedinUrl ?? this.linkedinUrl,
      twitterUrl: twitterUrl ?? this.twitterUrl,
      youtubeUrl: youtubeUrl ?? this.youtubeUrl,
      facebookUrl: facebookUrl ?? this.facebookUrl,
      countryEmoji: countryEmoji ?? this.countryEmoji,
    );
  }

  @override
  List<Object?> get props => [
        id,
        imagePath,
        name,
        profession,
        talkTitle,
        linkedinUrl,
        twitterUrl,
        youtubeUrl,
        facebookUrl,
        countryEmoji,
      ];
}

const List<SpeakerModel> speakers = [
  SpeakerModel(
    id: 0,
    imagePath: 'assets/images/speakers/speaker_5.jpeg',
    name: 'David Rios',
    profession: 'Senior Mobile Developer',
    talkTitle:
        'Performance Best Practices: Estrategias y Mejores Prácticas en Flutter',
    linkedinUrl: "https://www.linkedin.com/in/david-rios-dev/",
    twitterUrl: null,
    youtubeUrl: null,
    facebookUrl: "https://www.facebook.com/davidriosdev",
    countryEmoji: '🇧🇴',
  ),
  SpeakerModel(
    id: 1,
    imagePath: 'assets/images/speakers/speaker_1.png',
    name: 'Diego Velasquez',
    profession: 'Software Engineer | Google Developer Expert',
    talkTitle: null,
    linkedinUrl: 'https://www.linkedin.com/in/diegoveloper/',
    twitterUrl: 'https://twitter.com/diegoveloper',
    youtubeUrl: 'https://www.youtube.com/diegoveloper',
    facebookUrl: null,
    countryEmoji: '🇵🇪',
  ),
  SpeakerModel(
    id: 2,
    imagePath: 'assets/images/speakers/speaker_4.jpg',
    name: 'María Teresa Samudio González',
    profession: 'Software Engineer | Very Good Ventures',
    talkTitle: null,
    linkedinUrl: 'https://www.linkedin.com/in/maria-teresa-samudio/',
    twitterUrl: null,
    youtubeUrl: null,
    facebookUrl: null,
    countryEmoji: '🇵🇾',
  ),
  SpeakerModel(
    id: 3,
    imagePath: 'assets/images/speakers/speaker_2.jpg',
    name: 'Hansy Schmitt',
    profession: 'Senior Mobile/Backend Developer',
    talkTitle: null,
    linkedinUrl: null,
    twitterUrl: null,
    youtubeUrl: null,
    facebookUrl: null,
    countryEmoji: '🇵🇪',
  ),
  SpeakerModel(
    id: 4,
    imagePath: 'assets/images/speakers/speaker_3.jpg',
    name: 'Carlitos Vargas',
    profession: 'Senior Flutter Developer | Banco Basa',
    talkTitle: null,
    linkedinUrl: 'https://www.linkedin.com/in/kalitodev',
    twitterUrl: null,
    youtubeUrl: null,
    facebookUrl: null,
    countryEmoji: '🇵🇾',
  ),
];

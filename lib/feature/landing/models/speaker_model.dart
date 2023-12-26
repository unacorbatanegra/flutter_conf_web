import 'package:equatable/equatable.dart';

class SpeakerModel extends Equatable {
  final String imagePath;
  final String name;
  final String profession;
  final String talkTitle;
  final String linkedinUrl;
  final String twitterUrl;

  const SpeakerModel({
    required this.imagePath,
    required this.name,
    required this.profession,
    required this.talkTitle,
    required this.linkedinUrl,
    required this.twitterUrl,
  });

  @override
  List<Object?> get props => [
        imagePath,
        name,
        profession,
        talkTitle,
        linkedinUrl,
        twitterUrl,
      ];
}

const List<SpeakerModel> speakers = [
  SpeakerModel(
    imagePath: 'https://xsgames.co/randomusers/assets/avatars/male/46.jpg',
    name: 'Speaker 1',
    profession: 'Flutter Developer',
    talkTitle: 'Flutter Conf 2021',
    linkedinUrl: 'https://www.linkedin.com/',
    twitterUrl: 'https://twitter.com/',
  ),
  SpeakerModel(
    imagePath: 'https://xsgames.co/randomusers/assets/avatars/male/46.jpg',
    name: 'Speaker 2',
    profession: 'Flutter Developer',
    talkTitle: 'Flutter Conf 2021',
    linkedinUrl: 'https://www.linkedin.com/',
    twitterUrl: 'https://twitter.com/',
  ),
  SpeakerModel(
    imagePath: 'https://xsgames.co/randomusers/assets/avatars/male/46.jpg',
    name: 'Speaker 3',
    profession: 'Flutter Developer',
    talkTitle: 'Flutter Conf 2021',
    linkedinUrl: 'https://www.linkedin.com/',
    twitterUrl: 'https://twitter.com/',
  ),
  SpeakerModel(
    imagePath: 'https://xsgames.co/randomusers/assets/avatars/male/46.jpg',
    name: 'Speaker 4',
    profession: 'Flutter Developer',
    talkTitle: 'Flutter Conf 2021',
    linkedinUrl: 'https://www.linkedin.com/',
    twitterUrl: 'https://twitter.com/',
  ),
  SpeakerModel(
    imagePath: 'https://xsgames.co/randomusers/assets/avatars/male/46.jpg',
    name: 'Speaker 5',
    profession: 'Flutter Developer',
    talkTitle: 'Flutter Conf 2021',
    linkedinUrl: 'https://www.linkedin.com/',
    twitterUrl: 'https://twitter.com/',
  ),
  SpeakerModel(
    imagePath: 'https://xsgames.co/randomusers/assets/avatars/male/46.jpg',
    name: 'Speaker 6',
    profession: 'Flutter Developer',
    talkTitle: 'Flutter Conf 2021',
    linkedinUrl: 'https://www.linkedin.com/',
    twitterUrl: 'https://twitter.com/',
  ),
];

import 'package:equatable/equatable.dart';

class Team extends Equatable {
  final String name;
  final String role;
  final String image;
  final String? twitterUrl;
  final String? linkedinUrl;
  final String? githubUrl;

  const Team({
    required this.name,
    required this.role,
    required this.image,
    required this.twitterUrl,
    required this.linkedinUrl,
    required this.githubUrl,
  });

  @override
  List<Object?> get props => [
        name,
        role,
        image,
        twitterUrl,
        linkedinUrl,
        githubUrl,
      ];
}

const team = [
  Team(
    name: 'Miguel Belotto',
    role: 'Flutter Developer',
    image: 'assets/images/team/team_1.jpeg',
    twitterUrl: "https://twitter.com/MiguelBelotto00",
    linkedinUrl: null,
    githubUrl: null,
  ),
  Team(
    name: 'Jose Martinez',
    role: 'Flutter Developer',
    image: 'assets/images/team/team_2.png',
    twitterUrl: "https://twitter.com/JoseMLegal1",
    linkedinUrl: null,
    githubUrl: null,
  ),
  Team(
    name: 'María Teresa Samudio González',
    role: 'Flutter Developer',
    image: 'assets/images/team/team_3.jpg',
    twitterUrl: null,
    linkedinUrl: null,
    githubUrl: null,
  ),
  Team(
    name: 'Nicolas Lopez',
    role: 'Flutter Developer',
    image: 'assets/images/team/team_4.jpeg',
    twitterUrl: "https://twitter.com/unacorbatanegra",
    linkedinUrl: null,
    githubUrl: null,
  ),
  Team(
    name: 'Matias Ramirez',
    role: 'Flutter Developer',
    image: 'assets/images/team/team_5.jpeg',
    twitterUrl: "https://twitter.com/RamirezMatias03",
    linkedinUrl: null,
    githubUrl: null,
  ),
];

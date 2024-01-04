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
    githubUrl: "https://github.com/MiguelBelotto00",
  ),
  Team(
    name: 'Jose Martinez',
    role: 'Flutter Developer',
    image: 'assets/images/team/team_2.png',
    twitterUrl: "https://twitter.com/JoseMLegal1",
    linkedinUrl: null,
    githubUrl: "https://github.com/josemlegal",
  ),
  Team(
    name: 'María Teresa Samudio González',
    role: 'Software Engineer',
    image: 'assets/images/team/team_3.jpg',
    twitterUrl: null,
    linkedinUrl: "https://www.linkedin.com/in/maria-teresa-samudio/",
    githubUrl: null,
  ),
  Team(
    name: 'Nicolas Lopez',
    role: 'Flutter Developer',
    image: 'assets/images/team/team_4.jpeg',
    twitterUrl: "https://twitter.com/unacorbatanegra",
    linkedinUrl: null,
    githubUrl: "https://github.com/unacorbatanegra",
  ),
  Team(
    name: 'Matias Ramirez',
    role: 'Flutter Developer',
    image: 'assets/images/team/team_5.jpeg',
    twitterUrl: "https://twitter.com/RamirezMatias03",
    linkedinUrl:
        "https://www.linkedin.com/in/matias-sebastian-ramirez-brizuela-75b62a199/",
    githubUrl: null,
  ),
  Team(
    name: 'Doriham Russo',
    role: 'Flutter Developer',
    image: 'assets/images/team/team_6.jpeg',
    twitterUrl: "https://twitter.com/dorihamR",
    linkedinUrl: "https://www.linkedin.com/in/doriham-russo-340a40242/",
    githubUrl: null,
  ),
  Team(
    name: 'Matias Casco',
    role: 'Flutter Developer',
    image: 'assets/images/team/team_7.jpg',
    twitterUrl: null,
    linkedinUrl: "https://www.linkedin.com/in/matias-casco-lobos-b3b491177/",
    githubUrl: null,
  ),
  Team(
    name: 'Leonardo Paredes',
    role: 'Product Designer | UX/UI',
    image: 'assets/images/team/team_8.jpeg',
    twitterUrl: null,
    linkedinUrl: "https://www.linkedin.com/in/leo-paredest/",
    githubUrl: null,
  ),
];

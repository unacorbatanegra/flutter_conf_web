import 'package:equatable/equatable.dart';

class Team extends Equatable {
  final String name;
  final String role;
  final String? organizerRole;
  final String image;
  final String? twitterUrl;
  final String? linkedinUrl;
  final String? githubUrl;

  const Team({
    required this.name,
    required this.role,
    this.organizerRole,
    required this.image,
    this.twitterUrl,
    this.linkedinUrl,
    this.githubUrl,
  });

  factory Team.fromJson(Map<String, dynamic> json) {
    return Team(
      name: json['name'] as String,
      role: json['role'] as String,
      organizerRole: json['organizerRole'] as String?,
      image: json['image'] as String,
      twitterUrl: json['twitterUrl'] as String?,
      linkedinUrl: json['linkedinUrl'] as String?,
      githubUrl: json['githubUrl'] as String?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'role': role,
      'organizerRole': organizerRole,
      'image': image,
      'twitterUrl': twitterUrl,
      'linkedinUrl': linkedinUrl,
      'githubUrl': githubUrl,
    };
  }

  /// Get available social links (pre-filtered for performance)
  List<MapEntry<String, String>> get availableSocialLinks {
    final links = <String, String?>{
      'twitter': twitterUrl,
      'linkedin': linkedinUrl,
      'github': githubUrl,
    };
    return links.entries
        .where((entry) => entry.value != null)
        .map((entry) => MapEntry(entry.key, entry.value!))
        .toList();
  }

  @override
  List<Object?> get props => [
        name,
        role,
        organizerRole,
        image,
        twitterUrl,
        linkedinUrl,
        githubUrl,
      ];
}

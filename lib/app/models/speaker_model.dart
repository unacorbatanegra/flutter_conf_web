import 'package:equatable/equatable.dart';

class SpeakerModel extends Equatable {
  final int id;
  final String imagePath;
  final String name;
  final String profession;
  final String? gdeCategory;
  final String? talkTitleEs;
  final String? talkTitleEn;
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
    this.gdeCategory,
    this.talkTitleEs,
    this.talkTitleEn,
    required this.linkedinUrl,
    required this.twitterUrl,
    required this.youtubeUrl,
    required this.facebookUrl,
    required this.countryEmoji,
  });

  factory SpeakerModel.fromJson(Map<String, dynamic> json) {
    return SpeakerModel(
      id: json['id'] as int,
      imagePath: json['imagePath'] as String,
      name: json['name'] as String,
      profession: json['profession'] as String,
      gdeCategory: json['gdeCategory'] as String?,
      talkTitleEs: json['talkTitleEs'] as String?,
      talkTitleEn: json['talkTitleEn'] as String?,
      linkedinUrl: json['linkedinUrl'] as String?,
      twitterUrl: json['twitterUrl'] as String?,
      youtubeUrl: json['youtubeUrl'] as String?,
      facebookUrl: json['facebookUrl'] as String?,
      countryEmoji: json['countryEmoji'] as String,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'imagePath': imagePath,
      'name': name,
      'profession': profession,
      'gdeCategory': gdeCategory,
      'talkTitleEs': talkTitleEs,
      'talkTitleEn': talkTitleEn,
      'linkedinUrl': linkedinUrl,
      'twitterUrl': twitterUrl,
      'youtubeUrl': youtubeUrl,
      'facebookUrl': facebookUrl,
      'countryEmoji': countryEmoji,
    };
  }

  SpeakerModel copyWith({
    int? id,
    String? imagePath,
    String? name,
    String? profession,
    String? gdeCategory,
    String? talkTitleEs,
    String? talkTitleEn,
    String? linkedinUrl,
    String? twitterUrl,
    String? youtubeUrl,
    String? facebookUrl,
    String? countryEmoji,
  }) {
    return SpeakerModel(
      id: id ?? this.id,
      imagePath: imagePath ?? this.imagePath,
      name: name ?? this.name,
      profession: profession ?? this.profession,
      gdeCategory: gdeCategory ?? this.gdeCategory,
      talkTitleEs: talkTitleEs ?? this.talkTitleEs,
      talkTitleEn: talkTitleEn ?? this.talkTitleEn,
      linkedinUrl: linkedinUrl ?? this.linkedinUrl,
      twitterUrl: twitterUrl ?? this.twitterUrl,
      youtubeUrl: youtubeUrl ?? this.youtubeUrl,
      facebookUrl: facebookUrl ?? this.facebookUrl,
      countryEmoji: countryEmoji ?? this.countryEmoji,
    );
  }

  /// Get available social links (pre-filtered for performance)
  List<MapEntry<String, String>> get availableSocialLinks {
    final links = <String, String?>{
      'linkedin': linkedinUrl,
      'twitter': twitterUrl,
      'youtube': youtubeUrl,
      'facebook': facebookUrl,
    };
    return links.entries
        .where((entry) => entry.value != null)
        .map((entry) => MapEntry(entry.key, entry.value!))
        .toList();
  }

  @override
  List<Object?> get props => [
        id,
        imagePath,
        name,
        profession,
        gdeCategory,
        talkTitleEs,
        talkTitleEn,
        linkedinUrl,
        twitterUrl,
        youtubeUrl,
        facebookUrl,
        countryEmoji,
      ];
}

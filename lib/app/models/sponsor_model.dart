import 'package:equatable/equatable.dart';

class SponsorModel extends Equatable {
  final String name;
  final String logoPath;
  final String tier;
  final String description;
  final String? websiteUrl;

  const SponsorModel({
    required this.name,
    required this.logoPath,
    required this.tier,
    required this.description,
    this.websiteUrl,
  });

  factory SponsorModel.fromJson(Map<String, dynamic> json) {
    return SponsorModel(
      name: json['name'] as String,
      logoPath: json['logoPath'] as String,
      tier: json['tier'] as String,
      description: json['description'] as String,
      websiteUrl: json['websiteUrl'] as String?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'logoPath': logoPath,
      'tier': tier,
      'description': description,
      'websiteUrl': websiteUrl,
    };
  }

  @override
  List<Object?> get props => [name, logoPath, tier, description, websiteUrl];
}

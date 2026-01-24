import 'package:equatable/equatable.dart';
import 'package:flutter_conf_web/app/models/agenda_info.dart';
import 'package:flutter_conf_web/app/models/speaker_model.dart';
import 'package:flutter_conf_web/app/models/sponsor_model.dart';
import 'package:flutter_conf_web/app/models/team_model.dart';

class ConferenceConfig extends Equatable {
  final int year;
  final String eventDateString; // ISO 8601 format: "2025-02-01"
  final String location;
  final String venue;
  final String? registrationUrl;
  final String description;
  final String bannerDescriptionEs;
  final String bannerDescriptionEn;
  final String? githubUrl;
  final String? twitterUrl;
  final String? linkedinUrl;
  final String? instagramUrl;
  final List<SpeakerModel> speakers;
  final List<AgendaInfo> agendaItems;
  final List<SponsorModel> sponsors;
  final List<Team> team;

  // Pre-computed filtered lists for performance
  final List<AgendaInfo> morningAgenda;
  final List<AgendaInfo> afternoonAgenda;
  final List<SponsorModel> goldSponsors;
  final List<SponsorModel> silverSponsors;
  final List<SponsorModel> bronzeSponsors;

  const ConferenceConfig({
    required this.year,
    required this.eventDateString,
    required this.location,
    required this.venue,
    this.registrationUrl,
    required this.description,
    required this.bannerDescriptionEs,
    required this.bannerDescriptionEn,
    this.githubUrl,
    this.twitterUrl,
    this.linkedinUrl,
    this.instagramUrl,
    required this.speakers,
    required this.agendaItems,
    required this.sponsors,
    required this.team,
    required this.morningAgenda,
    required this.afternoonAgenda,
    required this.goldSponsors,
    required this.silverSponsors,
    required this.bronzeSponsors,
  });

  /// Get DateTime object for countdown timer
  DateTime get eventDate {
    return DateTime.parse(eventDateString);
  }

  /// Get available social links (pre-filtered for performance)
  List<MapEntry<String, String>> get availableSocialLinks {
    final links = <String, String?>{
      'github': githubUrl,
      'twitter': twitterUrl,
      'linkedin': linkedinUrl,
      'instagram': instagramUrl,
    };
    return links.entries
        .where((entry) => entry.value != null)
        .map((entry) => MapEntry(entry.key, entry.value!))
        .toList();
  }

  factory ConferenceConfig.fromJson(Map<String, dynamic> json) {
    final socialMedia = json['socialMedia'] as Map<String, dynamic>?;

    // Parse lists once
    final agendaItems = (json['agenda'] as List<dynamic>)
        .map((e) => AgendaInfo.fromJson(e as Map<String, dynamic>))
        .toList();

    final sponsors = (json['sponsors'] as List<dynamic>)
        .map((e) => SponsorModel.fromJson(e as Map<String, dynamic>))
        .toList();

    // Pre-compute filtered lists for performance
    final morningAgenda =
        agendaItems.where((item) => item.period == 'morning').toList();
    final afternoonAgenda =
        agendaItems.where((item) => item.period == 'afternoon').toList();
    final goldSponsors =
        sponsors.where((sponsor) => sponsor.tier == 'gold').toList();
    final silverSponsors =
        sponsors.where((sponsor) => sponsor.tier == 'silver').toList();
    final bronzeSponsors =
        sponsors.where((sponsor) => sponsor.tier == 'bronze').toList();

    return ConferenceConfig(
      year: json['year'] as int,
      eventDateString: json['eventDate'] as String,
      location: json['location'] as String,
      venue: json['venue'] as String,
      registrationUrl: json['registrationUrl'] as String?,
      description: json['description'] as String,
      bannerDescriptionEs: json['bannerDescriptionEs'] as String,
      bannerDescriptionEn: json['bannerDescriptionEn'] as String,
      githubUrl: socialMedia?['githubUrl'] as String?,
      twitterUrl: socialMedia?['twitterUrl'] as String?,
      linkedinUrl: socialMedia?['linkedinUrl'] as String?,
      instagramUrl: socialMedia?['instagramUrl'] as String?,
      speakers: (json['speakers'] as List<dynamic>)
          .map((e) => SpeakerModel.fromJson(e as Map<String, dynamic>))
          .toList(),
      agendaItems: agendaItems,
      sponsors: sponsors,
      team: (json['team'] as List<dynamic>)
          .map((e) => Team.fromJson(e as Map<String, dynamic>))
          .toList(),
      morningAgenda: morningAgenda,
      afternoonAgenda: afternoonAgenda,
      goldSponsors: goldSponsors,
      silverSponsors: silverSponsors,
      bronzeSponsors: bronzeSponsors,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'year': year,
      'eventDate': eventDateString,
      'location': location,
      'venue': venue,
      'registrationUrl': registrationUrl,
      'description': description,
      'bannerDescriptionEs': bannerDescriptionEs,
      'bannerDescriptionEn': bannerDescriptionEn,
      'socialMedia': {
        'githubUrl': githubUrl,
        'twitterUrl': twitterUrl,
        'linkedinUrl': linkedinUrl,
        'instagramUrl': instagramUrl,
      },
      'speakers': speakers.map((e) => e.toJson()).toList(),
      'agenda': agendaItems.map((e) => e.toJson()).toList(),
      'sponsors': sponsors.map((e) => e.toJson()).toList(),
      'team': team.map((e) => e.toJson()).toList(),
    };
  }

  @override
  List<Object?> get props => [
        year,
        eventDateString,
        location,
        venue,
        registrationUrl,
        description,
        bannerDescriptionEs,
        bannerDescriptionEn,
        githubUrl,
        twitterUrl,
        linkedinUrl,
        instagramUrl,
        speakers,
        agendaItems,
        sponsors,
        team,
      ];
}


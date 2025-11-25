import 'package:equatable/equatable.dart';

class AgendaInfo extends Equatable {
  final String time;
  final String? title;
  final String? speaker;
  final String? description;
  final String period; // 'morning' or 'afternoon'
  final bool isHighlighted;

  const AgendaInfo({
    required this.time,
    this.title,
    this.speaker,
    this.description,
    required this.period,
    this.isHighlighted = false,
  });

  factory AgendaInfo.fromJson(Map<String, dynamic> json) {
    return AgendaInfo(
      time: json['time'] as String,
      title: json['title'] as String?,
      speaker: json['speaker'] as String?,
      description: json['description'] as String?,
      period: json['period'] as String,
      isHighlighted: json['isHighlighted'] as bool? ?? false,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'time': time,
      'title': title,
      'speaker': speaker,
      'description': description,
      'period': period,
      'isHighlighted': isHighlighted,
    };
  }

  @override
  List<Object?> get props => [
        time,
        title,
        speaker,
        description,
        period,
        isHighlighted,
      ];
}

import 'package:equatable/equatable.dart';

class AgendaInfo extends Equatable {
  final String time;
  final String title;
  final String? speaker;

  const AgendaInfo({
    required this.time,
    required this.title,
    required this.speaker,
  });

  @override
  List<Object?> get props => [time, title, speaker];
}

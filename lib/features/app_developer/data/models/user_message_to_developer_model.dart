import 'package:equatable/equatable.dart';
import 'package:zad_almumin/core/extentions/dart_extention.dart';

class UserMessageToDeveloperModel extends Equatable {
  final String name;
  final String message;
  final String time;

  UserMessageToDeveloperModel({
    required this.name,
    required this.message,
  }) : time = DateTime.now().formattedDate;

  const UserMessageToDeveloperModel._({
    required this.name,
    required this.message,
    required this.time,
  });
  factory UserMessageToDeveloperModel.fromJson(Map<String, dynamic> json) {
    return UserMessageToDeveloperModel._(
      name: json['name'],
      message: json['message'],
      time: json['time'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'message': message,
      'time': time,
    };
  }

  @override
  List<Object?> get props => [
        name,
        message,
        time,
      ];
}

import 'dart:io';

import 'package:equatable/equatable.dart';

class RegisterParams extends Equatable {
  final String firstName;
  final String lastName;
  final String about;
  final List<int> skills;
  final List<String> favoriteSocialMedia;
  final int salary;
  final String password;
  final String passwordConfirmation;
  final String email;
  final String birthDate;
  final int? gender;
  final int userType;
  final File avatar;

  const RegisterParams({
    required this.firstName,
    required this.lastName,
    required this.about,
    required this.skills,
    required this.favoriteSocialMedia,
    required this.salary,
    required this.password,
    required this.passwordConfirmation,
    required this.email,
    required this.birthDate,
    required this.gender,
    required this.userType,
    required this.avatar,
  });

  @override
  List<Object?> get props => [
        firstName,
        lastName,
        about,
        skills,
        favoriteSocialMedia,
        salary,
        password,
        email,
        birthDate,
        gender,
        userType,
        avatar,
      ];
}

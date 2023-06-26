// Application programmed by Ryan Sumiantoro and Alyssa Hayman
// Copyright 2023 All Rights Reserved

enum UserType {
  student,
  parent,
  teacher,
}

class DistrictUser {
  final int idNumber;
  final String firstName;
  final String lastName;
  final String authID;
  UserType userType;

  DistrictUser({
    required this.idNumber,
    required this.firstName,
    required this.lastName,
    required this.authID,
    required this.userType,
  });

  Map<String, dynamic> toJson() => {
        'idNumber': idNumber,
        'firstName': firstName,
        'lastName': lastName,
        'userType': userType.toString(),
      };

  static DistrictUser fromJson(Map<String, dynamic> json) {
    DistrictUser districtUser = DistrictUser(
      authID: json['authID'],
      idNumber: json['idNumber'],
      firstName: json['firstName'],
      lastName: json['lastName'],
      userType: UserType.student,
    );
    if (json['userType'] == 'student') {
      districtUser.userType = UserType.student;
    } else if (json['userType'] == 'parent') {
      districtUser.userType = UserType.parent;
    } else if (json['userType'] == 'teacher') {
      districtUser.userType = UserType.teacher;
    }
    return districtUser;
  }
}

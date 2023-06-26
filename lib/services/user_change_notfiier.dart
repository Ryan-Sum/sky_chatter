// Application programmed by Ryan Sumiantoro and Alyssa Hayman
// Copyright 2023 All Rights Reserved

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:sky_chatter/services/models/user_model.dart';

class UserChangeNotifier extends ChangeNotifier {
  // Data about the currently logged in user
  DistrictUser districtUser = DistrictUser(
      idNumber: 0,
      firstName: '',
      lastName: '',
      userType: UserType.teacher,
      authID: '');

  // Signs up a user given an email and password
  Future<bool> signUp(String email, String password) async {
    UserCredential? userCredential;
    bool value = false;
    try {
      userCredential = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(email: email, password: password);
      await userCredential.user!.updateDisplayName(
          '${districtUser.firstName} ${districtUser.lastName}');
      FirebaseFirestore.instance
          .collection("Users")
          .doc(districtUser.idNumber.toString())
          .set({"authID": userCredential.user!.uid}, SetOptions(merge: true));
      value = true;
      userCredential.user!.sendEmailVerification();
      // ignore: unused_catch_clause
    } on FirebaseAuthException catch (e) {
      value = false;
    }
    return value;
  }

  // Gets the credentials of a user given an idNumber
  Future<String?> getUser(int idNumber) async {
    String? returnValue = 'Please enter valid ID number';
    districtUser = await FirebaseFirestore.instance
        .collection("Users")
        .doc("$idNumber")
        .get()
        .then((value) {
      if (value.data() != null) {
        returnValue = null;
        return DistrictUser.fromJson(value.data()!);
      }
      return DistrictUser(
          idNumber: 0,
          firstName: '',
          lastName: '',
          userType: UserType.student,
          authID: '');
    }).onError((error, stackTrace) {
      returnValue = 'Please enter valid ID number';
      return DistrictUser(
          idNumber: 0,
          firstName: '',
          lastName: '',
          userType: UserType.student,
          authID: '');
    });
    return returnValue;
  }

  // Gets the name og the currents user
  Future<String> getName() async {
    String name = '';
    await FirebaseFirestore.instance.collection("Users").get().then((value) {
      for (var element in value.docs) {
        DistrictUser user = DistrictUser.fromJson(element.data());
        if (user.authID == FirebaseAuth.instance.currentUser!.uid) {
          name = "${user.firstName} ${user.lastName}";
        }
      }
    });
    return name;
  }

  // Gets the userType of the current user
  Future<UserType> getUserType() async {
    UserType userType = UserType.student;
    await FirebaseFirestore.instance.collection("Users").get().then((value) {
      for (var element in value.docs) {
        DistrictUser user = DistrictUser.fromJson(element.data());
        if (user.authID == FirebaseAuth.instance.currentUser!.uid) {
          userType = user.userType;
        }
      }
    });
    return userType;
  }
}

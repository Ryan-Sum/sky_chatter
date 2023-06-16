import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:sky_chatter/services/models/conversation.dart';
import 'package:sky_chatter/services/models/user_model.dart';
import 'package:uuid/uuid.dart';

class MessageChangeNotifier extends ChangeNotifier {
  Future<List<DistrictUser>> getTeachers() async {
    List<DistrictUser> returnValue = [];
    await FirebaseFirestore.instance.collection('Users').get().then((value) {
      for (var element in value.docs) {
        DistrictUser user = DistrictUser.fromJson(element.data());
        if (user.userType == UserType.teacher) {
          returnValue.add(user);
        }
      }
    });
    return returnValue;
  }

  Future<List<DistrictUser>> getOthers() async {
    List<DistrictUser> returnValue = [];
    await FirebaseFirestore.instance.collection('Users').get().then((value) {
      for (var element in value.docs) {
        DistrictUser user = DistrictUser.fromJson(element.data());
        if (user.userType != UserType.teacher) {
          returnValue.add(user);
        }
      }
    });
    return returnValue;
  }

  void createConversation(String otherUserID) {
    String uuid = const Uuid().v4();
    FirebaseFirestore.instance.collection('messages').doc(uuid).set({
      "users": [FirebaseAuth.instance.currentUser!.uid, otherUserID],
      "messages": {},
      "id": uuid,
    });
  }

  Future<List<Conversation>> getConversations() async {
    List<Conversation> returnList = [];
    await FirebaseFirestore.instance.collection('messages').get().then((value) {
      for (var element in value.docs) {
        Conversation conversation = Conversation.fromJson(element.data());
        if (conversation.users
            .contains(FirebaseAuth.instance.currentUser!.uid)) {
          returnList.add(conversation);
        }
      }
    });
    return returnList;
  }

  Future<String> getUsername(String id) async {
    String returnValue = '';
    await FirebaseFirestore.instance.collection('Users').get().then((value) {
      for (var element in value.docs) {
        DistrictUser districtUser = DistrictUser.fromJson(element.data());
        if (districtUser.authID == id) {
          returnValue = ('${districtUser.firstName} ${districtUser.lastName}');
        }
      }
    });
    return returnValue;
  }
}

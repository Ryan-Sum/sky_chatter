import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:sky_chatter/services/models/post_model.dart';

class PostChangeNotifier extends ChangeNotifier {
  Future<List<Post>> getPost() async {
    return await FirebaseFirestore.instance.collection("Posts").get().then(
      (value) async {
        List<Post> post =
            value.docs.map((e) => Post.fromJson(e.data())).toList();
        for (var element in post) {
          element.link = (await getImage(element.link))!;
        }
        // ignore: avoid_function_literals_in_foreach_calls
        post.forEach(
          (element) async {
            element.link = (await getImage(element.link))!;
          },
        );
        return post;
      },
    );
  }

  Future<String?> getImage(String gsPath) async {
    final gsReference = FirebaseStorage.instance.refFromURL(gsPath);
    String? value;
    try {
      value = await gsReference.getDownloadURL();
    } on FirebaseException catch (e) {
      value = e.message;
    }
    return value;
  }
}

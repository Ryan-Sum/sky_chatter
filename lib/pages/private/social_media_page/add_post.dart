// Application programmed by Ryan Sumiantoro and Alyssa Hayman
// Copyright 2023 All Rights Reserved

// ignore_for_file: use_build_context_synchronously

import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';

import 'package:sky_chatter/global_widgets/custom_button.dart';
import 'package:sky_chatter/global_widgets/input_field.dart';
import 'package:sky_chatter/pages/private/social_media_page/image_helper.dart';
import 'package:sky_chatter/services/models/post_model.dart';

final imageHelper = ImageHelper();
final captionController = TextEditingController();

class AddPostScreen extends StatefulWidget {
  final String name;
  const AddPostScreen({
    Key? key,
    required this.name,
  }) : super(key: key);

  @override
  State<AddPostScreen> createState() => _AddPostScreenState();
}

class _AddPostScreenState extends State<AddPostScreen> {
  File? _image;
  double progress = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Add Post")),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              decoration:
                  BoxDecoration(color: Theme.of(context).colorScheme.surface),
              width: MediaQuery.sizeOf(context).width,
              height: MediaQuery.sizeOf(context).width,
              child: _image != null ? Image.file(_image!) : null,
            ),
            const SizedBox(
              height: 32,
            ),
            CustomButton(
              text: 'Select Photo',
              color: Theme.of(context).colorScheme.surface,
              function: () async {
                final newFile = await imageHelper.pickImage();
                if (newFile != null) {
                  final croppedFile = await imageHelper.crop(file: newFile);
                  if (croppedFile != null) {
                    setState(() {
                      _image = File(croppedFile.path);
                    });
                  }
                }
              },
            ),
            const SizedBox(
              height: 16,
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: InputField(
                controller: captionController,
                keyboardType: TextInputType.text,
                isObscured: false,
                label: 'Caption',
                validator: (text) {
                  return;
                },
              ),
            ),
            const SizedBox(
              height: 64,
            ),
            CustomButton(
              text: "Post",
              color: Theme.of(context).colorScheme.primary,
              function: () async {
                if ((_image != null) &&
                    (captionController.text.trim().isNotEmpty)) {
                  showDialog(
                    context: context,
                    barrierDismissible: false,
                    builder: (context) => const Center(
                      child: CircularProgressIndicator(),
                    ),
                  );
                  final id = const Uuid().v1();
                  final storageRef = FirebaseStorage.instance.ref("posts/");
                  final uploadTask = storageRef.child(id).putFile(_image!);

                  uploadTask.snapshotEvents.listen(
                    (TaskSnapshot taskSnapshot) async {
                      switch (taskSnapshot.state) {
                        case TaskState.canceled:
                          Navigator.pop(context);

                          break;
                        case TaskState.error:
                          Navigator.pop(context);
                          // Handle unsuccessful uploads
                          break;
                        case TaskState.success:
                          final url =
                              await storageRef.child(id).getDownloadURL();
                          await FirebaseFirestore.instance
                              .collection("Posts")
                              .add(Post(
                                      author: widget.name,
                                      caption: captionController.text.trim(),
                                      link: url,
                                      id: id,
                                      likes: [],
                                      date: DateTime.now())
                                  .toJson());
                          Navigator.pop(context);
                          Navigator.pop(context);

                          break;
                        case TaskState.paused:
                        case TaskState.running:
                      }
                    },
                  );
                }
              },
            )
          ],
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sky_chatter/main.dart';
import 'package:sky_chatter/pages/private/social_media_page/add_post.dart';
import 'package:sky_chatter/pages/private/social_media_page/local_widgets/post_ui.dart';
import 'package:sky_chatter/services/models/post_model.dart';
import 'package:sky_chatter/services/post_change_notifier.dart';

final postProvider = ChangeNotifierProvider((ref) => PostChangeNotifier());

class ImageSharing extends ConsumerWidget {
  const ImageSharing({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    Future<List<Post>> posts = ref.read(postProvider).getPost();

    return Stack(
      children: [
        FutureBuilder(
          future: posts,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              snapshot.data!.sort(
                (a, b) {
                  return b.date.compareTo(a.date);
                },
              );
              if (!(snapshot.data!.last.link.contains('gs://'))) {
                return ListView.builder(
                  itemCount: snapshot.data!.length,
                  itemBuilder: (context, index) {
                    Post data = snapshot.data!.elementAt(index);
                    return PostUI(
                      author: data.author,
                      caption: data.caption,
                      likes: data.likes,
                      link: data.link,
                      id: data.id,
                    );
                  },
                );
              } else {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }
            } else {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
          },
        ),
        SafeArea(
            child: Column(
          children: [
            const Spacer(),
            Row(
              children: [
                const Spacer(),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: FloatingActionButton(
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => FutureBuilder(
                                  future: ref.read(userProvider).getName(),
                                  builder: (context, snapshot) {
                                    if (snapshot.hasData) {
                                      return AddPostScreen(
                                          name: snapshot.data!);
                                    } else {
                                      return const Center(
                                        child: CircularProgressIndicator(),
                                      );
                                    }
                                  })));
                    },
                    child: const Icon(Icons.add_rounded),
                  ),
                ),
              ],
            ),
          ],
        )),
      ],
    );
  }
}

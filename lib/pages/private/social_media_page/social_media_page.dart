import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:sky_chatter/pages/private/social_media_page/image_sharing.dart';
import 'package:webview_flutter/webview_flutter.dart';

class SocialMediaPage extends StatefulWidget {
  const SocialMediaPage({super.key});

  @override
  State<SocialMediaPage> createState() => _SocialMediaPageState();
}

class _SocialMediaPageState extends State<SocialMediaPage> {
  @override
  Widget build(BuildContext context) {
    final Set<Factory<OneSequenceGestureRecognizer>> gestureRecognizers = {
      Factory(() => EagerGestureRecognizer())
    };
// Twitter WebView
    final WebViewController controllerTwitter = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setBackgroundColor(const Color(0x00000000))
      ..setNavigationDelegate(NavigationDelegate())
      ..loadRequest(Uri.parse('https://twitter.com/gshswarriors'));
// Facebook WebView
    final WebViewController controllerInstagram = WebViewController()
      ..setNavigationDelegate
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setBackgroundColor(const Color(0x00000000))
      ..setNavigationDelegate(NavigationDelegate())
      ..loadRequest(
          Uri.parse('https://www.facebook.com/SteinbrennerWarriorFootball'));

    return DefaultTabController(
      length: 3,
      child: Scaffold(
        body: Column(
          children: [
            // Creates tab bar
            TabBar(
              labelPadding: const EdgeInsets.all(16.0),
              indicatorColor: Theme.of(context).primaryColor,
              tabs: const [
                Text('Your School'),
                Text('Twitter'),
                Text('Facebook')
              ],
            ),
            Expanded(
              child: TabBarView(
                children: [
                  const ImageSharing(),
                  // First tab bar item
                  WebViewWidget(
                    controller: controllerTwitter,
                    gestureRecognizers: gestureRecognizers,
                  ),
                  // Second tab bar item
                  WebViewWidget(
                    controller: controllerInstagram,
                    gestureRecognizers: gestureRecognizers,
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}

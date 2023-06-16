import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sky_chatter/pages/private/home_page/home_page.dart';
import 'package:sky_chatter/pages/private/verify_email/verify_email.dart';
import 'package:sky_chatter/pages/public/onboarding_page/welcome_page.dart';
import 'package:sky_chatter/services/auth_change_notifier.dart';
import 'package:sky_chatter/services/user_change_notfiier.dart';
import 'package:sky_chatter/theme/theme_constants.dart';

import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  GoogleFonts.config.allowRuntimeFetching = false;

  runApp(const ProviderScope(child: MyApp()));
}

final authProvider = ChangeNotifierProvider((ref) => AuthChangeNotifier());
final userProvider = ChangeNotifierProvider((ref) => UserChangeNotifier());

class MyApp extends ConsumerWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return MaterialApp(
      title: 'SkyChatter',
      theme: lightThem,
      darkTheme: darkTheme,
      themeMode: ThemeMode.system,
      // home: ElevatedButton(
      //     child: Text(''),
      //     onPressed: () {
      //       FirebaseAuth.instance.signOut();
      //     }),
      home: StreamBuilder(
        stream: ref.read(authProvider).auth.userChanges(),
        builder: (context, snapshot) {
          Widget value = const WelcomePage();
          if (snapshot.data != null) {
            if (snapshot.data!.emailVerified == true) {
              value = const HomePage();
            } else {
              value = const VerifyEmail();
            }
          } else {
            value = const WelcomePage();
          }
          return value;
        },
      ),
    );
  }
}

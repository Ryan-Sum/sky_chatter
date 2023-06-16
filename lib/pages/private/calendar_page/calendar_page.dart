import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sky_chatter/pages/private/calendar_page/local_widgets/calendar_widget.dart';
import 'package:sky_chatter/services/event_change_notifier.dart';

final eventProvider = ChangeNotifierProvider((ref) => EventChangeNotifier());

class CalendarPage extends ConsumerWidget {
  const CalendarPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return FutureBuilder(
      future: ref.read(eventProvider).getEvents(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return CalendarWidget(
            events: snapshot.data!,
          );
        } else {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
      },
    );
  }
}

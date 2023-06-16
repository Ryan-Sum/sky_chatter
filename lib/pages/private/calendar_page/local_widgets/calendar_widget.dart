// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:table_calendar/table_calendar.dart';

import 'package:sky_chatter/services/models/event.dart';

class CalendarWidget extends StatefulWidget {
  final List<Event> events;

  const CalendarWidget({
    Key? key,
    required this.events,
  }) : super(key: key);

  @override
  State<CalendarWidget> createState() => _CalendarWidgetState();
}

DateTime _selectedDay = DateTime.now();
DateTime _focusedDay = DateTime.now();
CalendarFormat _calendarFormat = CalendarFormat.month;
List<Event> _selectedEvents = [];

class _CalendarWidgetState extends State<CalendarWidget> {
  CalendarStyle _calendarStyle() {
    return CalendarStyle(
        selectedDecoration: BoxDecoration(
            color: Theme.of(context).colorScheme.primary,
            shape: BoxShape.circle),
        todayDecoration: BoxDecoration(
          shape: BoxShape.circle,
          border: Border.all(
              color: Theme.of(context).colorScheme.primary, width: 3.0),
        ),
        todayTextStyle:
            TextStyle(color: Theme.of(context).colorScheme.onSurface));
  }

  @override
  void initState() {
    super.initState();

    _selectedEvents = getEventsForDay(DateTime.now(), widget.events);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TableCalendar(
          firstDay: DateTime.utc(2010, 10, 16),
          lastDay: DateTime.utc(2030, 3, 14),
          focusedDay: _focusedDay,
          calendarFormat: _calendarFormat,
          calendarStyle: _calendarStyle(),
          daysOfWeekHeight: 24,
          selectedDayPredicate: (day) {
            return isSameDay(_selectedDay, day);
          },
          onDaySelected: (selectedDay, focusedDay) {
            setState(() {
              _selectedDay = selectedDay;
              _focusedDay = focusedDay;
              _selectedEvents = getEventsForDay(_selectedDay, widget.events);
            });
          },
          onFormatChanged: (format) {
            setState(() {
              _calendarFormat = format;
            });
          },
          onPageChanged: (focusedDay) {
            _focusedDay = focusedDay;
          },
          eventLoader: (day) {
            List<Event> daysEvents = [];
            for (var element in widget.events) {
              if (isSameDay(element.date, day)) {
                daysEvents.add(element);
              }
            }
            return daysEvents;
          },
        ),
        const Divider(),
        SizedBox(
          height: MediaQuery.of(context).size.height * 0.25,
          child: ListView.separated(
            separatorBuilder: (context, index) => const Divider(),
            itemCount: _selectedEvents.length,
            itemBuilder: (context, index) {
              return ListTile(
                title: Text(
                  _selectedEvents.elementAt(index).name +
                      (_selectedEvents.elementAt(index).isWeek
                          ? ' (All Week)'
                          : ''),
                  style: TextStyle(
                      color: Theme.of(context).colorScheme.onBackground),
                ),
                trailing: Text(
                  DateFormat('EEEE, MMM d, yyyy')
                      .format(_selectedEvents.elementAt(index).date),
                  style: TextStyle(
                      color: Theme.of(context).colorScheme.onBackground),
                ),
                onTap: () => showModalBottomSheet(
                  context: context,
                  builder: (context) => buildSheet(
                    _selectedEvents.elementAt(index).imageUrl,
                    _selectedEvents.elementAt(index),
                  ),
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}

Widget buildSheet(String url, Event data) {
  return Container(
    decoration: const BoxDecoration(
        borderRadius: BorderRadius.only(
            topLeft: Radius.circular(16), topRight: Radius.circular(16))),
    child: Padding(
      padding: const EdgeInsets.all(32.0),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              data.name,
              style: const TextStyle(fontSize: 32, fontWeight: FontWeight.bold),
            ),
            Text(
                '${(data.isWeek ? 'The week of' : 'On')} ${DateFormat('EEEE, MMM d, yyyy').format(data.date)}'),
            Padding(
              padding: const EdgeInsets.fromLTRB(0, 16, 0, 0),
              child: Text(
                data.content,
                textAlign: TextAlign.center,
              ),
            ),
            FutureBuilder(
              future: getImage(url),
              builder: (context, snapshot) {
                if (snapshot.hasData == true) {
                  return Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(top: 16.0),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(8.0),
                          child: Image.network(
                            snapshot.data!,
                          ),
                        ),
                      ),
                    ],
                  );
                } else {
                  return const CircularProgressIndicator();
                }
              },
            ),
          ],
        ),
      ),
    ),
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

List<Event> getEventsForDay(DateTime day, List<Event> events) {
  List<Event> daysEvents = [];
  for (var element in events) {
    if (isSameDay(element.date, day)) {
      daysEvents.add(element);
    }
  }
  return daysEvents;
}

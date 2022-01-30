import 'package:flutter/material.dart';
import 'dart:collection';
import 'package:table_calendar/table_calendar.dart';

const String habitNameKey = 'habit_name';
const String triggerEventKey = 'trigger_event';
const String reminderTimeKey = 'reminder_time';
const String frequencyKey = 'frequency';
const String habitIdKey = 'habit_id';

List<String> dayList = [
  'Sunday',
  'Monday',
  'Tuesday',
  'Wednesday',
  'Thursday',
  'Friday',
  'Saturday',
];

class RipetoTextField extends StatelessWidget {
  RipetoTextField(
      {@required this.onChanged,
      @required this.labelText,
      this.isEmail = false,
      this.obscureText = false,
      this.initialValue = ''});

  final Function(String) onChanged;
  final bool obscureText;
  final String labelText;
  final bool isEmail;
  final String initialValue;

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: TextEditingController(text: initialValue),
      onChanged: onChanged,
      obscureText: obscureText,
      keyboardType: isEmail ? TextInputType.emailAddress : TextInputType.text,
      decoration: InputDecoration(
        border: OutlineInputBorder(),
        labelText: labelText,
      ),
    );
  }
}

Text mainScreenTitle(String title) {
  return Text(
    title,
    style: TextStyle(
      fontWeight: FontWeight.bold,
      fontSize: 25,
    ),
  );
}

TimeOfDay convertStringToTimeOfDay(String timeOfDayString) {
  return TimeOfDay(
    hour: int.parse(timeOfDayString.substring(
        10, 12)), //Substring from hour in "TimeOfDay(XX:00)"
    minute: int.parse(timeOfDayString.substring(
        13, 15)), //Substring from minute in "TimeOfDay(00:XX)"
  );
}

List<bool> convertFrequencyFromFirebaseToBoolList(String boolListFromFirebase) {
  String boolListFromFirebaseCropped = boolListFromFirebase.substring(1,
      boolListFromFirebase.length - 1); //This line of code removes '[' and ']'.

  List boolListString = boolListFromFirebaseCropped.split(',');

  List<bool> boolList = [];

  boolListString.forEach((element) {
    if (element.toString().contains('true'))
      boolList.add(true);
    else
      boolList.add(false);
  });

  return boolList;
}

String convertReminderTimeFirebaseToReminderTimeString(
    String firebaseReminderTime) {
  return firebaseReminderTime.substring(
      10, 15); //Extract XX:XX from "TimeOfDay(XX:XX)".
}

List<String> convertFrequencyFirebaseDataToDayList(String firebaseFrequency) {
  List<bool> boolDayList =
      convertFrequencyFromFirebaseToBoolList(firebaseFrequency);
  List<String> trueDayList = [];

  for (var i = 0; i < boolDayList.length; i++) {
    if (boolDayList[i]) {
      trueDayList.add(dayList[i]);
    }
  }

  return trueDayList;
}

Widget buildChipForHabitCard(String firebaseFrequency) {
  List<bool> boolDayList =
      convertFrequencyFromFirebaseToBoolList(firebaseFrequency);
  List<Widget> dayChipList = [];

  for (var i = 0; i < boolDayList.length; i++) {
    if (boolDayList[i]) {
      dayChipList.add(
        Chip(
          label: Text(dayList[i]),
        ),
      );
    }
  }

  return Wrap(
    spacing: 10.0,
    children: dayChipList,
  );
}

/// Example event class.
class Event {
  final String title;

  const Event(this.title);

  @override
  String toString() => title;
}

/// Example events.
///
/// Using a [LinkedHashMap] is highly recommended if you decide to use a map.
final kEvents = LinkedHashMap<DateTime, List<Event>>(
  equals: isSameDay,
  hashCode: getHashCode,
)..addAll(_kEventSource);

final _kEventSource = Map.fromIterable(List.generate(50, (index) => index),
    key: (item) => DateTime.utc(kFirstDay.year, kFirstDay.month, item * 5),
    value: (item) => List.generate(
        item % 4 + 1, (index) => Event('Event $item | ${index + 1}')))
  ..addAll({
    kToday: [
      Event('Today\'s Event 1'),
      Event('Today\'s Event 2'),
    ],
  });

int getHashCode(DateTime key) {
  return key.day * 1000000 + key.month * 10000 + key.year;
}

/// Returns a list of [DateTime] objects from [first] to [last], inclusive.
List<DateTime> daysInRange(DateTime first, DateTime last) {
  final dayCount = last.difference(first).inDays + 1;
  return List.generate(
    dayCount,
    (index) => DateTime.utc(first.year, first.month, first.day + index),
  );
}

final kToday = DateTime.now();
final kFirstDay = DateTime(kToday.year, kToday.month - 3, kToday.day);
final kLastDay = DateTime(kToday.year, kToday.month + 3, kToday.day);

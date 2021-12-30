import 'package:day_picker/day_picker.dart';
import 'package:flutter/material.dart';

class RipetoTextField extends StatelessWidget {
  RipetoTextField(
      {@required this.onChanged,
      @required this.labelText,
      this.isEmail = false,
      this.obscureText = false});

  final Function(String) onChanged;
  final bool obscureText;
  final String labelText;
  final bool isEmail;

  @override
  Widget build(BuildContext context) {
    return TextField(
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

List<DayInWeek> kDayList = [
  DayInWeek(
    "Sun",
  ),
  DayInWeek(
    "Mon",
  ),
  DayInWeek(
    "Tue",
  ),
  DayInWeek(
    "Wed",
  ),
  DayInWeek(
    "Thu",
  ),
  DayInWeek(
    "Fri",
  ),
  DayInWeek(
    "Sat",
  ),
];

const String habitNameKey = 'habit_name';
const String triggerEventKey = 'trigger_event';
const String reminderTimeKey = 'reminder_time';
const String frequencyKey = 'frequency';

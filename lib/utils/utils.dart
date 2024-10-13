import 'package:intl/intl.dart';

String formattedDate(int timestamp) {
  DateTime date = DateTime.fromMillisecondsSinceEpoch(timestamp * 1000);
  return DateFormat('d MMMM yyyy').format(date);
}

import 'package:intl/intl.dart';

String theDate() {
  var date = new DateTime.now();
  var format = new DateFormat.yMMMMd("en_US").add_jm();
  return format.format(date);
}
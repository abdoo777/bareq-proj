
import 'package:intl/intl.dart';

String formatDate({DateTime ? datetime}){
  return DateFormat.yMMMMd().format(datetime ?? DateTime.now());
}


String formatTime(){
  return DateFormat.jms().format(DateTime.now());
}
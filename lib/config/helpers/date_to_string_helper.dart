import 'package:director_app_tfg/config/constants.dart';

class DateToString {
  String dateString(DateTime date) {
    String minuteString = date.minute.toString().padLeft(2, '0');
    return "Día ${date.day} de ${Constants.MONTHS[date.month - 1]} de ${date.year} a las ${date.hour}:$minuteString";
  }
}

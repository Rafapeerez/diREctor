class DurationToString {
  static String durationToString(Duration value) {
    int hours = value.inHours % 24;
    int minutes = value.inMinutes % 60;

    if (hours > 1) {
      if (minutes != 0) {
        return "$hours horas y $minutes minutos";
      } else {
        return "$hours horas";
      }
    } else if (hours == 1) {
      if (minutes != 0) {
        return "$hours hora y $minutes minutos";
      } else {
        return "$hours hora";
      }
    } else {
      if (minutes != 0) {
        return "$minutes minutos";
      } else {
        return "0 minutos";
      }
    }
  }
}

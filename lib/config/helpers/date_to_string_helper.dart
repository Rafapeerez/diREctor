class DateToString {
  String dateString(DateTime date) {
    return "Día ${date.day} de ${date.month} del ${date.year} a las ${date.hour}:${date.minute}";
  }
}

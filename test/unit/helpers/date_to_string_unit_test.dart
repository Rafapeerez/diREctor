import 'package:director_app_tfg/config/helpers/date_to_string_helper.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test("should convert a date to string format", () {
    
    //GIVEN
    DateTime value = DateTime(2003, 4, 5, 12, 30); // Year, month, day, hour, minute 
    String result = "Día 5 de 4 del 2003 a las 12:30";
    
    //WHEN
    String dateToString = DateToString().dateString(value);

    //THEN
    expect(dateToString, result);
  });
}

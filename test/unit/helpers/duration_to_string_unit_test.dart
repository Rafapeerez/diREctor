import 'package:director_app_tfg/config/helpers/duration_to_string_helper.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test("should convert a duration to string format", () {
    
    //GIVEN
    Duration value = const Duration(hours: 2); 
    String result = "2 horas";
    
    //WHEN
    String durationToString = DurationToString.durationToString(value);

    //THEN
    expect(durationToString, result);
  });

  test("should convert a duration to string format", () {
    
    //GIVEN
    Duration value = const Duration(hours: 1); 
    String result = "1 hora";
    
    //WHEN
    String durationToString = DurationToString.durationToString(value);

    //THEN
    expect(durationToString, result);
  });

  test("should convert a duration to string format", () {
    
    //GIVEN
    Duration value = const Duration(hours: 3, minutes: 59); 
    String result = "3 horas y 59 minutos";
    
    //WHEN
    String durationToString = DurationToString.durationToString(value);

    //THEN
    expect(durationToString, result);
  });
}

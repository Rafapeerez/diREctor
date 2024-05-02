import 'package:director_app_tfg/config/helpers/capitalize_string_helper.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test("should capitalize string and convert the first letter to upper case", () {
    
    //GIVEN
    String value = "esto es una prueba";
    String result = "Esto es una prueba";
    
    //WHEN
    String capitalizeString = CapitalizeString().capitalizeString(value);

    //THEN
    expect(capitalizeString, result);
  });
}

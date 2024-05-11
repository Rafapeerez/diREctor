import 'package:director_app_tfg/config/helpers/get_first_letter_from_each_word_of_string_helper.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test("should get first letter of each word and convert it to upper case", () {
    
    //GIVEN
    String value = "Marcha real";
    String result = "MR";
    
    //WHEN
    String letters = GetFirstLetterFromEachWordOfString.getFirstLetterFromEachWordOfString(value);

    //THEN
    expect(letters, result);
  });

  test("should get first letter of each word with at least 4 letters and convert it to upper case", () {
    
    //GIVEN
    String value = "Orando al padre";
    String result = "OP";
    
    //WHEN
    String letters = GetFirstLetterFromEachWordOfString.getFirstLetterFromEachWordOfString(value);

    //THEN
    expect(letters, result);
  });

  test("should get first letter of each word with at least 4 letters and convert it to upper case", () {
    
    //GIVEN
    String value = "Sangre en tus clavos";
    String result = "SC";
    
    //WHEN
    String letters = GetFirstLetterFromEachWordOfString.getFirstLetterFromEachWordOfString(value);

    //THEN
    expect(letters, result);
  });
}

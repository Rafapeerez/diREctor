import 'package:director_app_tfg/config/helpers/check_counts_helper.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test("should check if the counts are less than 100", () {
    
    //GIVEN
    int value = 99;
    String result = "99";
    
    //WHEN
    String countString = CheckCounts.execute(value);

    //THEN
    expect(countString, result);
  });

  test("should check if the counts are more than 100", () {
    
    //GIVEN
    int value = 100;
    String result = "+99";
    
    //WHEN
    String countString = CheckCounts.execute(value);

    //THEN
    expect(countString, result);
  });
}


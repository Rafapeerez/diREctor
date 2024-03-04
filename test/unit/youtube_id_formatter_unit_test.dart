import 'package:flutter_test/flutter_test.dart';
import 'package:director_app_tfg/config/helpers/youtube_id_formats_helper.dart';

void main() {
  test("should format the link video into youtubeID", () {
    String videoLink = "https://www.youtube.com/watch?v=thisIsAeXAmPlE_IK.;'[]";
    String youtubeId = YoutubeIdFormats().getYoutubeId(videoLink);

    expect(youtubeId, "thisIsAeXAmPlE_IK.;'[]");
  });
}

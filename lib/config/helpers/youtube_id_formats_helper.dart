class YoutubeIdFormats {

  int findSeparator(String input) {
    return input.indexOf("v=");
  }

  String getYoutubeId( String videoLink ) {
    final firstVIndex = findSeparator(videoLink);
    if (firstVIndex != -1) {
      return videoLink.substring(firstVIndex + 2);
    }
    return 'null'; 
  }
}

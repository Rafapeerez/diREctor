import 'package:director_app_tfg/config/helpers/youtube_id_formats_helper.dart';
import 'package:flutter/material.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';


class MarchVideo extends StatefulWidget {

  final String youtubeLink;
  final String name;

  const MarchVideo({
    super.key,  
    required this.youtubeLink, 
    required this.name 
  });

  @override
  State<MarchVideo> createState() => _YouTubeVideoPlayerState();
}

class _YouTubeVideoPlayerState extends State<MarchVideo> {

  late YoutubePlayerController _controller;  
  late String youtubeId; 

  @override
  void initState() {
    super.initState();
    youtubeId = YoutubeIdFormats().getYoutubeId(widget.youtubeLink);
    
    _controller = YoutubePlayerController(
      initialVideoId: youtubeId,
      flags: const YoutubePlayerFlags(
        hideThumbnail: true,
        showLiveFullscreenButton: false,
        mute: false,
        autoPlay: false,
        disableDragSeek: true,
        loop: false,
        isLive: false,
        forceHD: false,
        enableCaption: false,
      ),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(widget.name),
          YoutubePlayer(controller: _controller)
        ],
      )
    );
  }
}
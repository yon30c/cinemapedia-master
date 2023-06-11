import 'package:cinemapedia/presentation/providers/movies/movies_providers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

import '../../../domain/domain.dart';

class MovieTrailer extends ConsumerStatefulWidget {
  final int movieId;
  const MovieTrailer({super.key, required this.movieId});

  @override
  MovieTrailerState createState() => MovieTrailerState();
}

class MovieTrailerState extends ConsumerState<MovieTrailer> {
  @override
  Widget build(BuildContext context) {
    final AsyncValue<List<Video>> videos =
        ref.watch(trailerProvider(widget.movieId));

    return videos.when(
      data: (data) => _VideoList(videos: data),
      error: (_, __) =>
          const Center(child: Text('No se pudo cargar los videos')),
      loading: () =>
          const Center(child: CircularProgressIndicator(strokeWidth: 2)),
    );
  }
}

class _VideoList extends StatelessWidget {
  final List<Video> videos;

  const _VideoList({required this.videos});

  @override
  Widget build(BuildContext context) {
    int? index = videos.indexWhere((element) => element.type == 'Trailer');
    if (videos.isEmpty) {
      return const SizedBox();
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Padding(
          padding: EdgeInsets.symmetric(horizontal: 10),
          child: Text(
            'Videos',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
        ),

        if(index != -1) 

        _YoutubeVideoPlayer(
            youtubeId: videos[index].youtubeKey, name: videos[index].name),

        if(index == -1)
        _YoutubeVideoPlayer(
            youtubeId: videos.first.youtubeKey, name: videos.first.name),
        // ...videos.map((video) {
        //   if (video.type == 'Trailer') {
        //     return _YoutubeVideoPlayer(
        //         youtubeId: videos.first.youtubeKey, name: video.name);
        //   }
        //   return _YoutubeVideoPlayer(
        //       youtubeId: video.youtubeKey, name: video.name);
        // }).toList()
      ],
    );
  }
}

class _YoutubeVideoPlayer extends StatefulWidget {
  const _YoutubeVideoPlayer({required this.youtubeId, required this.name});

  final String youtubeId;
  final String name;

  @override
  State<_YoutubeVideoPlayer> createState() => __YoutubeVideoPlayerState();
}

class __YoutubeVideoPlayerState extends State<_YoutubeVideoPlayer> {
  late YoutubePlayerController _controller;

  @override
  void initState() {
    super.initState();
    _controller = YoutubePlayerController(
        initialVideoId: widget.youtubeId,
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
          
        ));
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
        children: [Text(widget.name), YoutubePlayer(controller: _controller)],
      ),
    );
  }
}

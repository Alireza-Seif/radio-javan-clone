import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:radio_javan/models/music/music_model.dart';

class MusicsRow extends StatelessWidget {
  final VoidCallback callback;
  final MusicModel music;

  const MusicsRow({super.key, required this.callback, required this.music});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: callback,
      child: CachedNetworkImage(
        height: 164,
        width: 164,
        imageUrl: '${music.mp3_thumbnail_b}',
        imageBuilder: (context, imageProvider) => Container(
          margin: const EdgeInsets.all(8),
          height: 164,
          width: 164,
          decoration: BoxDecoration(
            image: DecorationImage(
              image: imageProvider,
              fit: BoxFit.cover,
            ),
          ),
          child: Stack(
            children: [
              Positioned(
                bottom: 5,
                left: 0,
                right: 0,
                child: Container(
                  decoration: const BoxDecoration(
                    gradient: LinearGradient(
                      colors: [
                        Colors.blueAccent,
                        Colors.purpleAccent,
                        Colors.redAccent
                      ],
                    ),
                  ),
                  child: Center(
                    child: Text(
                      '${music.mp3_artist}',
                      style: const TextStyle(
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
        placeholder: (context, url) => Container(
          height: 20,
          width: 20,
          margin: const EdgeInsets.all(10),
          child: const Center(
            child: CircularProgressIndicator(),
          ),
        ),
      ),
    );
  }
}

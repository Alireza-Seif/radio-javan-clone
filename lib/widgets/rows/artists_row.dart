import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:radio_javan/models/artist/artist_model.dart';

class ArtistsRow extends StatelessWidget {
  final ArtistModel artists;

  const ArtistsRow({super.key, required this.artists});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(left: 10),
      child: Column(
        children: [
          CircleAvatar(
            radius: 60,
            child: ClipOval(
              child: CachedNetworkImage(
                imageUrl: '${artists.artist_image}',
                imageBuilder: (context, imageProvider) => Container(
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: imageProvider,
                      fit: BoxFit.cover,
                    ),
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
            ),
          ),
          Text(
            '${artists.artist_name}',
            style: const TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontSize: 18,
            ),
          ),
        ],
      ),
    );
  }
}

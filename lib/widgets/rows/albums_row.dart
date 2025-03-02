import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:radio_javan/models/album/album_model.dart';

class AlbumsRow extends StatelessWidget {
  final AlbumModel albums;
  const AlbumsRow({super.key, required this.albums});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(right: 5),
      child: CachedNetworkImage(
        width: 180,
        height: 190,
        imageUrl:
        '${albums.album_image}',
        imageBuilder:
            (context, imageProvider) =>
            Container(
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
                      right: 0,
                      left: 0,
                      child: Container(
                        decoration:
                        const BoxDecoration(
                          gradient:
                          LinearGradient(
                            colors: [
                              Colors.green,
                              Colors
                                  .deepPurpleAccent,
                              Colors.orange,
                            ],
                          ),
                        ),
                        child: Center(
                          child: Text(
                            '${albums.album_name}',
                            style:
                            const TextStyle(
                              color: Colors.white,
                              fontSize: 18,
                            ),
                          ),
                        ),
                      ))
                ],
              ),
            ),
        placeholder: (context, url) =>
        const CircularProgressIndicator(),
      ),
    );
  }
}

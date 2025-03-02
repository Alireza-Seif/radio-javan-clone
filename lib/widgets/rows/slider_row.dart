import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_image_slideshow/flutter_image_slideshow.dart';
import 'package:radio_javan/models/play%20list/play_list_model.dart';

class SliderRow extends StatelessWidget {
  final List<PlayListModel> playList;
  const SliderRow({super.key, required this.playList});

  @override
  Widget build(BuildContext context) {
    List<Widget> imagesList = [];
    for (int i = 0;
    i <playList.length;
    i++) {
      imagesList.add(
        CachedNetworkImage(
          imageUrl:
          '${playList.elementAt(i).playlist_image}',
          width: double.infinity,
          height: 200,
          fit: BoxFit.cover,
          placeholder: (context, url) =>
          const Center(
              child: CircularProgressIndicator()),
        ),
      );
    }
    return SizedBox(
      height: 200,
      child: ImageSlideshow(
        width: double.infinity,
        height: 200,
        initialPage: 0,
        indicatorColor: Colors.blueAccent,
        indicatorBackgroundColor: Colors.grey,
        autoPlayInterval: 3000,
        isLoop: true,
        children: imagesList,
      ),
    );
  }
}

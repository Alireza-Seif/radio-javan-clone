import 'dart:ui';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_image_slideshow/flutter_image_slideshow.dart';
import 'package:miniplayer/miniplayer.dart';
import 'package:radio_javan/models/album/album_base_model.dart';
import 'package:radio_javan/models/artist/artist_base_model.dart';
import 'package:radio_javan/models/latest%20music/latest_music_model.dart';
import 'package:radio_javan/models/music/music_model.dart';
import 'package:radio_javan/network/rest_client.dart';

import '../../models/play list/play_list_base_model.dart';
import 'package:just_audio/just_audio.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final dio = Dio();
  late RestClient restClient;
  late Future<LatestMusicModel> getLatestMusics;
  late Future<AlbumBaseModel> getAlbums;
  late Future<PlayListBaseModel> getPlayList;
  late Future<ArtistBaseModel> getArtistList;

  bool isPlayed = false;

  late MusicModel currentMusic;

  bool currentStatePlay = false;
  final player = AudioPlayer();

  @override
  void initState() {
    // TODO: implement initState
    restClient = RestClient(dio);
    getLatestMusics = restClient.getLatestMusic();
    getAlbums = restClient.getAlbums();
    getPlayList = restClient.getPlayLists();
    getArtistList = restClient.getRecentArtists();
  }

  loadMusic() async {
    await player.setUrl('${currentMusic.mp3_url}');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Stack(
        children: [
          Container(
            margin: const EdgeInsets.only(bottom: 80),
            child: SingleChildScrollView(
              child: Center(
                child: Column(
                  children: [
                    FutureBuilder<PlayListBaseModel>(
                      future: getPlayList,
                      builder: (context, snapshot) {
                        if (snapshot.hasData) {
                          List<Widget> imagesList = [];
                          for (int i = 0;
                              i < snapshot.data!.playlists!.length;
                              i++) {
                            imagesList.add(
                              CachedNetworkImage(
                                imageUrl:
                                    '${snapshot.data!.playlists![i].playlist_image}',
                                width: double.infinity,
                                height: 200,
                                fit: BoxFit.cover,
                                placeholder: (context, url) => const Center(
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
                        } else if (snapshot.hasError) {
                          return Center(child: Text(snapshot.error.toString()));
                        } else {
                          return const Center(
                              child: CircularProgressIndicator());
                        }
                      },
                    ),
                    FutureBuilder<LatestMusicModel>(
                      future: getLatestMusics,
                      builder: (context, snapshot) {
                        if (snapshot.hasData) {
                          return SizedBox(
                            width: MediaQuery.of(context).size.width,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Container(
                                  margin: const EdgeInsets.all(8),
                                  child: const Text(
                                    'The latest',
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 16,
                                      fontFamily: 'BYekanBold',
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  height: 180,
                                  child: ListView.builder(
                                    itemCount: snapshot.data!.music!.length,
                                    scrollDirection: Axis.horizontal,
                                    shrinkWrap: true,
                                    itemBuilder: (context, index) {
                                      return InkWell(
                                        onTap: () {
                                          setState(() {
                                            isPlayed = true;
                                            currentStatePlay = true;
                                            currentMusic =
                                                snapshot.data!.music![index];
                                          });
                                        },
                                        child: CachedNetworkImage(
                                          height: 164,
                                          width: 164,
                                          imageUrl:
                                              '${snapshot.data!.music![index].mp3_thumbnail_b}',
                                          imageBuilder:
                                              (context, imageProvider) =>
                                                  Container(
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
                                                    decoration:
                                                        const BoxDecoration(
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
                                                        '${snapshot.data!.music![index].mp3_artist}',
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
                                          placeholder: (context, url) =>
                                              Container(
                                            height: 20,
                                            width: 20,
                                            margin: const EdgeInsets.all(10),
                                            child: const Center(
                                              child:
                                                  CircularProgressIndicator(),
                                            ),
                                          ),
                                        ),
                                      );
                                    },
                                  ),
                                )
                              ],
                            ),
                          );
                        } else if (snapshot.hasError) {
                          return Center(child: Text(snapshot.error.toString()));
                        } else {
                          return const Center(
                              child: CircularProgressIndicator());
                        }
                      },
                    ),
                    FutureBuilder<AlbumBaseModel>(
                      future: getAlbums,
                      builder: (context, snapshot) {
                        if (snapshot.hasData) {
                          return SizedBox(
                            width: MediaQuery.of(context).size.width,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Container(
                                  margin: const EdgeInsets.all(8),
                                  child: const Text(
                                    'Latest albums',
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 16,
                                      fontFamily: 'BYekanBold',
                                    ),
                                  ),
                                ),
                                Container(
                                  height: 160,
                                  margin: const EdgeInsets.all(10),
                                  child: ListView.builder(
                                    scrollDirection: Axis.horizontal,
                                    shrinkWrap: true,
                                    itemCount: snapshot.data!.albums!.length,
                                    itemBuilder: (context, index) {
                                      return Container(
                                        margin: const EdgeInsets.only(right: 5),
                                        child: CachedNetworkImage(
                                          width: 180,
                                          height: 190,
                                          imageUrl:
                                              '${snapshot.data!.albums![index].album_image}',
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
                                                          '${snapshot.data!.albums![index].album_name}',
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
                                    },
                                  ),
                                ),
                              ],
                            ),
                          );
                        } else if (snapshot.hasError) {
                          return Center(child: Text(snapshot.error.toString()));
                        } else {
                          return const Center(
                              child: CircularProgressIndicator());
                        }
                      },
                    ),
                    FutureBuilder<ArtistBaseModel>(
                      future: getArtistList,
                      builder: (context, snapshot) {
                        if (snapshot.hasData) {
                          return Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                margin: const EdgeInsets.all(8),
                                child: const Text(
                                  'Latest artists',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 16,
                                    fontFamily: 'BYekanBold',
                                  ),
                                ),
                              ),
                              SizedBox(
                                height: 190,
                                child: ListView.builder(
                                  scrollDirection: Axis.horizontal,
                                  itemCount: snapshot.data!.artists.length,
                                  itemBuilder: (context, index) {
                                    return Container(
                                      margin: const EdgeInsets.only(left: 10),
                                      child: Column(
                                        children: [
                                          CircleAvatar(
                                            radius: 60,
                                            child: ClipOval(
                                              child: CachedNetworkImage(
                                                imageUrl:
                                                    '${snapshot.data!.artists[index].artist_image}',
                                                imageBuilder:
                                                    (context, imageProvider) =>
                                                        Container(
                                                  decoration: BoxDecoration(
                                                    image: DecorationImage(
                                                      image: imageProvider,
                                                      fit: BoxFit.cover,
                                                    ),
                                                  ),
                                                ),
                                                placeholder: (context, url) =>
                                                    Container(
                                                  height: 20,
                                                  width: 20,
                                                  margin:
                                                      const EdgeInsets.all(10),
                                                  child: const Center(
                                                    child:
                                                        CircularProgressIndicator(),
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ),
                                          Text(
                                            '${snapshot.data!.artists[index].artist_name}',
                                            style: const TextStyle(
                                              color: Colors.white,
                                              fontWeight: FontWeight.bold,
                                              fontSize: 18,
                                            ),
                                          ),
                                        ],
                                      ),
                                    );
                                  },
                                ),
                              ),
                            ],
                          );
                        } else if (snapshot.hasError) {
                          return Center(child: Text(snapshot.error.toString()));
                        } else {
                          return const Center(
                            child: CircularProgressIndicator(),
                          );
                        }
                      },
                    )
                  ],
                ),
              ),
            ),
          ),
          if (isPlayed)
            Container(
              margin: const EdgeInsets.only(bottom: 110),
              child: Miniplayer(
                minHeight: 70,
                maxHeight: MediaQuery.of(context).size.height,
                builder: (height, percentage) {
                  loadMusic();

                  if (height == 70) {
                    return Container(
                      decoration: BoxDecoration(
                        color: Colors.black.withOpacity(0.9),
                      ),
                      child: Container(
                        margin: const EdgeInsets.symmetric(horizontal: 10),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            CachedNetworkImage(
                              imageUrl: '${currentMusic.mp3_thumbnail_s}',
                              height: 48,
                              width: 48,
                            ),
                            const SizedBox(width: 10),
                            Text(
                              '${currentMusic.mp3_title}',
                              style: const TextStyle(color: Colors.white),
                            ),
                            const SizedBox(width: 5),
                            Row(
                              children: [
                                IconButton(
                                  onPressed: () {},
                                  icon: const Icon(
                                    Icons.skip_previous,
                                    color: Colors.white,
                                  ),
                                ),
                                IconButton(
                                  onPressed: () async {
                                    setState(() {
                                      currentStatePlay = !currentStatePlay;
                                    });
                                    if (currentStatePlay == true) {
                                      await player.play();
                                    } else {
                                      await player.pause();
                                    }
                                  },
                                  icon: currentStatePlay == true
                                      ? const Icon(
                                          Icons.pause,
                                          color: Colors.white,
                                        )
                                      : const Icon(
                                          Icons.play_arrow,
                                          color: Colors.white,
                                        ),
                                ),
                                IconButton(
                                  onPressed: () {},
                                  icon: const Icon(
                                    Icons.skip_next,
                                    color: Colors.white,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    );
                  } else {
                    return Container(
                      width: MediaQuery.of(context).size.width,
                      decoration: BoxDecoration(
                        color: Colors.black.withOpacity(0.9),
                      ),
                      child: Stack(
                        children: [
                          Positioned(
                            right: 0,
                            left: 0,
                            top: 0,
                            bottom: 0,
                            child: ImageFiltered(
                              imageFilter:
                                  ImageFilter.blur(sigmaX: 5, sigmaY: 5),
                              child: CachedNetworkImage(
                                width: 280.0,
                                height: 190.0,
                                imageUrl: '${currentMusic.mp3_thumbnail_s}',
                                imageBuilder: (context, imageProvider) =>
                                    Container(
                                  decoration: BoxDecoration(
                                    image: DecorationImage(
                                      image: imageProvider,
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                          Positioned(
                            left: MediaQuery.of(context).size.width * 0.2,
                            right: MediaQuery.of(context).size.width * 0.2,
                            top: MediaQuery.of(context).size.height * 0.2,
                            bottom: MediaQuery.of(context).size.height * 0.2,
                            child: Container(
                              width: MediaQuery.of(context).size.width / 1.5,
                              height: MediaQuery.of(context).size.height / 2.5,
                              decoration: BoxDecoration(
                                color: Colors.white.withOpacity(0.9),
                                borderRadius:
                                    const BorderRadius.all(Radius.circular(10)),
                              ),
                              child: Center(
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    CachedNetworkImage(
                                      width: 144.0,
                                      height: 144.0,
                                      imageUrl:
                                          '${currentMusic.mp3_thumbnail_b}',
                                      imageBuilder: (context, imageProvider) =>
                                          Container(
                                        decoration: BoxDecoration(
                                          borderRadius: const BorderRadius.all(
                                            Radius.circular(10),
                                          ),
                                          image: DecorationImage(
                                            image: imageProvider,
                                            fit: BoxFit.cover,
                                          ),
                                        ),
                                      ),
                                    ),
                                    const SizedBox(height: 10),
                                    Text(
                                      '${currentMusic.mp3_title}',
                                      style: const TextStyle(
                                        color: Colors.black,
                                        fontWeight: FontWeight.bold,
                                        fontFamily: 'BYekanBold',
                                        fontSize: 18,
                                      ),
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        IconButton(
                                          onPressed: () {},
                                          icon: const Icon(
                                            Icons.skip_previous,
                                            color: Colors.black,
                                            size: 38,
                                          ),
                                        ),
                                        IconButton(
                                          onPressed: () async {
                                            setState(() {
                                              currentStatePlay =
                                                  !currentStatePlay;
                                            });
                                            if (currentStatePlay == true) {
                                              await player.play();
                                            } else {
                                              await player.pause();
                                            }
                                          },
                                          icon: currentStatePlay == true
                                              ? const Icon(
                                                  Icons.pause,
                                                  color: Colors.black,
                                                  size: 38,
                                                )
                                              : const Icon(
                                                  Icons.play_arrow,
                                                  color: Colors.black,
                                                  size: 38,
                                                ),
                                        ),
                                        IconButton(
                                          onPressed: () {},
                                          icon: const Icon(
                                            Icons.skip_next,
                                            color: Colors.black,
                                            size: 38,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    );
                  }
                },
              ),
            )
        ],
      ),
    );
  }
}

import 'dart:ui';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:miniplayer/miniplayer.dart';
import 'package:radio_javan/models/album/album_base_model.dart';
import 'package:radio_javan/models/artist/artist_base_model.dart';
import 'package:radio_javan/models/latest%20music/latest_music_model.dart';
import 'package:radio_javan/models/music/music_model.dart';
import 'package:radio_javan/network/rest_client.dart';
import 'package:radio_javan/widgets/messages/show_messges.dart';
import 'package:radio_javan/widgets/rows/albums_row.dart';
import 'package:radio_javan/widgets/rows/artists_row.dart';
import 'package:radio_javan/widgets/rows/musics_row.dart';
import 'package:radio_javan/widgets/rows/slider_row.dart';

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
                          return SliderRow(
                            playList: snapshot.data!.playlists!,
                          );
                        } else if (snapshot.hasError) {
                          return Center(
                            child: showError(
                              text: snapshot.error.toString(),
                            ),
                          );
                        } else {
                          return showProgressBar(context);
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
                                      return MusicsRow(
                                        callback: () {
                                          setState(() {
                                            isPlayed = true;
                                            currentStatePlay = true;
                                            currentMusic =
                                                snapshot.data!.music![index];
                                          });
                                        },
                                        music: snapshot.data!.music![index],
                                      );
                                    },
                                  ),
                                )
                              ],
                            ),
                          );
                        } else if (snapshot.hasError) {
                          return Center(
                            child: showError(
                              text: snapshot.error.toString(),
                            ),
                          );
                        } else {
                          return showProgressBar(context);
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
                                      return AlbumsRow(
                                          albums:
                                              snapshot.data!.albums![index]);
                                    },
                                  ),
                                ),
                              ],
                            ),
                          );
                        } else if (snapshot.hasError) {
                          return Center(
                              child: showError(
                            text: snapshot.error.toString(),
                          ));
                        } else {
                          return showProgressBar(context);
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
                                    return ArtistsRow(
                                      artists: snapshot.data!.artists[index],
                                    );
                                  },
                                ),
                              ),
                            ],
                          );
                        } else if (snapshot.hasError) {
                          return Center(
                              child: showError(
                            text: snapshot.error.toString(),
                          ));
                        } else {
                          return showProgressBar(context);
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
                            Text(
                              '${currentMusic.mp3_artist}',
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
                                  onPressed: () async {
                                    if (player.hasNext) ;
                                    await player.nextIndex;
                                  },
                                  icon: const Icon(
                                    Icons.skip_next,
                                    color: Colors.white,
                                  ),
                                ),
                                IconButton(
                                  onPressed: () async {
                                    await player.shuffle();
                                  },
                                  icon: const Icon(
                                    Icons.shuffle,
                                    color: Colors.white,
                                    size: 38,
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
                                        fontSize: 28,
                                      ),
                                    ),
                                    Text(
                                      '${currentMusic.mp3_artist}',
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
                                          onPressed: () async {
                                            if (player.hasNext) ;
                                            await player.nextIndex;
                                          },
                                          icon: const Icon(
                                            Icons.skip_next,
                                            color: Colors.black,
                                            size: 38,
                                          ),
                                        ),
                                        IconButton(
                                          onPressed: () async {
                                            await player.shuffle();
                                          },
                                          icon: const Icon(
                                            Icons.shuffle,
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

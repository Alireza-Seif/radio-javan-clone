import 'package:cached_network_image/cached_network_image.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:radio_javan/models/latest_music_model.dart';
import 'package:radio_javan/network/rest_client.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final dio = Dio();
  late RestClient restClient;
  late Future<LatestMusicModel> getLatestMusics;

  @override
  void initState() {
    // TODO: implement initState
    restClient = RestClient(dio);
    getLatestMusics = restClient.getLatestMusic();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black54,
      body: Column(
        children: [
          FutureBuilder<LatestMusicModel>(
            future: getLatestMusics,
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return SizedBox(
                  width: MediaQuery.of(context).size.width,
                  child: Column(
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
                      Container(
                        height: 180,
                        child: ListView.builder(
                          itemCount: snapshot.data!.music!.length,
                          scrollDirection: Axis.horizontal,
                          shrinkWrap: true,
                          itemBuilder: (context, index) {
                            return CachedNetworkImage(
                              height: 164,
                              width: 164,
                              imageUrl:
                                  '${snapshot.data!.music![index].mp3_thumbnail_b}',
                              imageBuilder: (context, imageProvider) =>
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
                                        decoration: BoxDecoration(
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
                                            style: TextStyle(
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
                            );
                          },
                        ),
                      )
                    ],
                  ),
                );
              } else if (snapshot.hasError) {
                return Text(snapshot.error.toString());
              } else {
                return const CircularProgressIndicator();
              }
            },
          ),
        ],
      ),
    );
  }
}

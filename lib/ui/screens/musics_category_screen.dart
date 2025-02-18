import 'package:cached_network_image/cached_network_image.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:radio_javan/models/category/category_model.dart';
import 'package:radio_javan/models/latest%20music/latest_music_model.dart';
import 'package:radio_javan/network/rest_client.dart';

class MusicsCategoryScreen extends StatefulWidget {
  final CategoryModel category;

  const MusicsCategoryScreen({super.key, required this.category});

  @override
  State<MusicsCategoryScreen> createState() => _MusicsCategoryScreenState();
}

class _MusicsCategoryScreenState extends State<MusicsCategoryScreen> {
  final dio = Dio();
  late RestClient restClient;
  late Future<LatestMusicModel> getMusics;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    restClient = RestClient(dio);
    getMusics = restClient.getMusicsByCategory(widget.category.cid!);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: Text('${widget.category.category_name}'),
      ),
      body: Container(child:
        FutureBuilder<LatestMusicModel>(future: getMusics, builder: (context, snapshot) {
          if (snapshot.hasData) {
            return GridView.builder(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2),
              itemCount: snapshot.data!.music!.length,
              itemBuilder: (context, index) {
                return GestureDetector(
                  onTap: () {

                  },
                  child: CachedNetworkImage(
                    height: 164,
                    width: 164,
                    imageUrl:
                    '${snapshot.data!.music![index].category_image}',
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
                                  '${snapshot.data!.music![index].category_name}',
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
              },
            );
          } else if (snapshot.hasError) {
            return Center(child: Text(snapshot.error.toString()));
          } else {
            return const Center(child: CircularProgressIndicator());
          }
        },),),
    );
  }
}

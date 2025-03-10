import 'package:cached_network_image/cached_network_image.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:radio_javan/models/category/category_base_model.dart';
import 'package:radio_javan/network/rest_client.dart';
import 'package:radio_javan/ui/screens/musics_category_screen.dart';

class CategoryScreen extends StatefulWidget {
  const CategoryScreen({super.key});

  @override
  State<CategoryScreen> createState() => _CategoryScreenState();
}

class _CategoryScreenState extends State<CategoryScreen> {
  final dio = Dio();
  late RestClient restClient;

  late Future<CategoryBaseModel> getCategories;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    restClient = RestClient(dio);
    getCategories = restClient.getCategories();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: FutureBuilder<CategoryBaseModel>(
        future: getCategories,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return GridView.builder(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2),
              itemCount: snapshot.data!.categories!.length,
              itemBuilder: (context, index) {
                return GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => MusicsCategoryScreen(
                          category: snapshot.data!.categories![index],
                        ),
                      ),
                    );
                  },
                  child: CachedNetworkImage(
                    height: 164,
                    width: 164,
                    imageUrl:
                        '${snapshot.data!.categories![index].category_image}',
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
                                  '${snapshot.data!.categories![index].category_name}',
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
        },
      ),
    );
  }
}

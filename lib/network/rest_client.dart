import 'package:dio/dio.dart';
import 'package:radio_javan/models/album/album_base_model.dart';
import 'package:radio_javan/models/artist/artist_base_model.dart';
import 'package:radio_javan/models/category/category_base_model.dart';
import 'package:radio_javan/models/play%20list/play_list_base_model.dart';
import 'package:retrofit/retrofit.dart';

import '../models/latest music/latest_music_model.dart';

part 'rest_client.g.dart';

@RestApi(baseUrl: 'http://mobilemasters.ir/apps/radiojavan/')
abstract class RestClient {
  factory RestClient(Dio dio, {String baseUrl}) = _RestClient;

  @GET('api.php?latest')
  Future<LatestMusicModel> getLatestMusic();

  @GET('api.php?album_list')
  Future<AlbumBaseModel> getAlbums();

  @GET('api.php?playlist')
  Future<PlayListBaseModel> getPlayLists();

  @GET('api.php?recent_artist_list')
  Future<ArtistBaseModel> getRecentArtists();

  @GET('api.php?cat_list')
  Future<CategoryBaseModel> getCategories();

  @GET('api.php')
  Future<LatestMusicModel> getMusicsByCategory(@Query('cat_id') String id);
}

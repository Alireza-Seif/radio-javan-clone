import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';

import '../models/latest_music_model.dart';
import '../models/music_model.dart';


 part 'rest_client.g.dart';

@RestApi(baseUrl: 'http://mobilemasters.ir/apps/radiojavan/')
abstract class RestClient {
  factory RestClient(Dio dio, {String baseUrl}) = _RestClient;

  @GET('api.php?latest')
  Future<LatestMusicModel> getLatestMusic();
}

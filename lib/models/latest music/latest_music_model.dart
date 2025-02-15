import 'package:json_annotation/json_annotation.dart';
import 'package:radio_javan/models/music/music_model.dart';

part 'latest_music_model.g.dart';

@JsonSerializable()
class LatestMusicModel {
  @JsonKey(name: 'ONLINE_MP3')
  List<MusicModel>? music;

  LatestMusicModel(this.music);


  factory LatestMusicModel.fromJson(Map<String, dynamic> json) => _$LatestMusicModelFromJson(json);
  Map<String, dynamic> toJson() => _$LatestMusicModelToJson(this);
}

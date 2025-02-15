import 'package:json_annotation/json_annotation.dart';
import 'package:radio_javan/models/play%20list/play_list_model.dart';


part 'play_list_base_model.g.dart';

@JsonSerializable()
class PlayListBaseModel {
  @JsonKey(name: 'ONLINE_MP3')
  List<PlayListModel>? playlists;

  PlayListBaseModel(this.playlists);

  factory PlayListBaseModel.fromJson(Map<String, dynamic> json) =>
      _$PlayListBaseModelFromJson(json);

  Map<String, dynamic> toJson() => _$PlayListBaseModelToJson(this);
}

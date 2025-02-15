import 'package:json_annotation/json_annotation.dart';

part 'play_list_model.g.dart';

@JsonSerializable()
class PlayListModel {
  String? pid;
  String? playlist_name;
  String? playlist_image;
  String? playlist_image_thumb;

  PlayListModel(
    this.pid,
    this.playlist_name,
    this.playlist_image,
    this.playlist_image_thumb,
  );

  factory PlayListModel.fromJson(Map<String, dynamic> json) =>
      _$PlayListModelFromJson(json);

  Map<String, dynamic> toJson() => _$PlayListModelToJson(this);
}

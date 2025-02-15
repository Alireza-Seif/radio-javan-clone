import 'package:json_annotation/json_annotation.dart';
part 'album_model.g.dart';

@JsonSerializable()
class AlbumModel {
  String? aid;
  String? album_name;
  String? album_image;
  String? album_image_thumb;

  AlbumModel(this.aid, this.album_name, this.album_image,
      this.album_image_thumb);

  factory AlbumModel.fromJson(Map<String, dynamic> json) => _$AlbumModelFromJson(json);
  Map<String, dynamic> toJson() => _$AlbumModelToJson(this);
}

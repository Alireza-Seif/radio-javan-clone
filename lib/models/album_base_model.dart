import 'package:json_annotation/json_annotation.dart';
import 'package:radio_javan/models/album_model.dart';
part 'album_base_model.g.dart';


@JsonSerializable()
class AlbumBaseModel{
@JsonKey(name: 'ONLINE_MP3')
List<AlbumModel>? albums;


AlbumBaseModel(this.albums);

  factory AlbumBaseModel.fromJson(Map<String, dynamic> json) => _$AlbumBaseModelFromJson(json);
  Map<String, dynamic> toJson() => _$AlbumBaseModelToJson(this);
}
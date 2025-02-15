import 'package:json_annotation/json_annotation.dart';

part 'artist_model.g.dart';

@JsonSerializable()
class ArtistModel {
  String? id;
  String? artist_name;
  String? artist_image;
  String? artist_image_thumb;

  ArtistModel(
      this.id, this.artist_name, this.artist_image, this.artist_image_thumb);

  factory ArtistModel.fromJson(Map<String, dynamic> json) =>
      _$ArtistModelFromJson(json);

  Map<String, dynamic> toJson() => _$ArtistModelToJson(this);
}

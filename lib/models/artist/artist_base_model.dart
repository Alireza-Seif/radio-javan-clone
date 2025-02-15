import 'package:radio_javan/models/artist/artist_model.dart';
import 'package:json_annotation/json_annotation.dart';

part 'artist_base_model.g.dart';

@JsonSerializable()
class ArtistBaseModel {
  @JsonKey(name: 'ONLINE_MP3')
  List<ArtistModel> artists;

  ArtistBaseModel(this.artists);

  factory ArtistBaseModel.fromJson(Map<String, dynamic> json) =>
      _$ArtistBaseModelFromJson(json);

  Map<String, dynamic> toJson() => _$ArtistBaseModelToJson(this);
}

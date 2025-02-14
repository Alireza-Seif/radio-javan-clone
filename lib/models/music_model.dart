import 'package:json_annotation/json_annotation.dart';

part 'music_model.g.dart';

@JsonSerializable()
class MusicModel {
  String? id;
  String? cat_id;
  String? mp3_title;
  String? mp3_url;
  String? mp3_thumbnail_b;
  String? mp3_thumbnail_s;
  String? mp3_duration;
  String? mp3_artist;
  String? mp3_description;
  String? total_rate;
  String? rate_avg;
  String? total_views;
  String? total_downloads;
  String? cid;
  String? category_name;
  String? category_image;
  String? category_image_thumb;

  MusicModel(
      this.id,
      this.cat_id,
      this.mp3_title,
      this.mp3_url,
      this.mp3_thumbnail_b,
      this.mp3_thumbnail_s,
      this.mp3_duration,
      this.mp3_artist,
      this.mp3_description,
      this.total_rate,
      this.rate_avg,
      this.total_views,
      this.total_downloads,
      this.cid,
      this.category_name,
      this.category_image,
      this.category_image_thumb);

  factory MusicModel.fromJson(Map<String, dynamic> json) => _$MusicModelFromJson(json);
  Map<String, dynamic> toJson() => _$MusicModelToJson(this);
}

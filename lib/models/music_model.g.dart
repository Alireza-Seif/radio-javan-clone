// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'music_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MusicModel _$MusicModelFromJson(Map<String, dynamic> json) => MusicModel(
      json['id'] as String?,
      json['cat_id'] as String?,
      json['mp3_title'] as String?,
      json['mp3_url'] as String?,
      json['mp3_thumbnail_b'] as String?,
      json['mp3_thumbnail_s'] as String?,
      json['mp3_duration'] as String?,
      json['mp3_artist'] as String?,
      json['mp3_description'] as String?,
      json['total_rate'] as String?,
      json['rate_avg'] as String?,
      json['total_views'] as String?,
      json['total_downloads'] as String?,
      json['cid'] as String?,
      json['category_name'] as String?,
      json['category_image'] as String?,
      json['category_image_thumb'] as String?,
    );

Map<String, dynamic> _$MusicModelToJson(MusicModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'cat_id': instance.cat_id,
      'mp3_title': instance.mp3_title,
      'mp3_url': instance.mp3_url,
      'mp3_thumbnail_b': instance.mp3_thumbnail_b,
      'mp3_thumbnail_s': instance.mp3_thumbnail_s,
      'mp3_duration': instance.mp3_duration,
      'mp3_artist': instance.mp3_artist,
      'mp3_description': instance.mp3_description,
      'total_rate': instance.total_rate,
      'rate_avg': instance.rate_avg,
      'total_views': instance.total_views,
      'total_downloads': instance.total_downloads,
      'cid': instance.cid,
      'category_name': instance.category_name,
      'category_image': instance.category_image,
      'category_image_thumb': instance.category_image_thumb,
    };

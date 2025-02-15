// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'play_list_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PlayListModel _$PlayListModelFromJson(Map<String, dynamic> json) =>
    PlayListModel(
      json['pid'] as String?,
      json['playlist_name'] as String?,
      json['playlist_image'] as String?,
      json['playlist_image_thumb'] as String?,
    );

Map<String, dynamic> _$PlayListModelToJson(PlayListModel instance) =>
    <String, dynamic>{
      'pid': instance.pid,
      'playlist_name': instance.playlist_name,
      'playlist_image': instance.playlist_image,
      'playlist_image_thumb': instance.playlist_image_thumb,
    };

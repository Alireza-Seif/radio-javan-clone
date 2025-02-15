// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'album_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AlbumModel _$AlbumModelFromJson(Map<String, dynamic> json) => AlbumModel(
      json['aid'] as String?,
      json['album_name'] as String?,
      json['album_image'] as String?,
      json['album_image_thumb'] as String?,
    );

Map<String, dynamic> _$AlbumModelToJson(AlbumModel instance) =>
    <String, dynamic>{
      'aid': instance.aid,
      'album_name': instance.album_name,
      'album_image': instance.album_image,
      'album_image_thumb': instance.album_image_thumb,
    };

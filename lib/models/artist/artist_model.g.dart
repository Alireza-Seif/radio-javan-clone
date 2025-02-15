// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'artist_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ArtistModel _$ArtistModelFromJson(Map<String, dynamic> json) => ArtistModel(
      json['id'] as String?,
      json['artist_name'] as String?,
      json['artist_image'] as String?,
      json['artist_image_thumb'] as String?,
    );

Map<String, dynamic> _$ArtistModelToJson(ArtistModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'artist_name': instance.artist_name,
      'artist_image': instance.artist_image,
      'artist_image_thumb': instance.artist_image_thumb,
    };

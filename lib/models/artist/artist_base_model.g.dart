// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'artist_base_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ArtistBaseModel _$ArtistBaseModelFromJson(Map<String, dynamic> json) =>
    ArtistBaseModel(
      (json['ONLINE_MP3'] as List<dynamic>)
          .map((e) => ArtistModel.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$ArtistBaseModelToJson(ArtistBaseModel instance) =>
    <String, dynamic>{
      'ONLINE_MP3': instance.artists,
    };

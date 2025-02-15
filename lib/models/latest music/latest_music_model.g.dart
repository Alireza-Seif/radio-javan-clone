// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'latest_music_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

LatestMusicModel _$LatestMusicModelFromJson(Map<String, dynamic> json) =>
    LatestMusicModel(
      (json['ONLINE_MP3'] as List<dynamic>?)
          ?.map((e) => MusicModel.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$LatestMusicModelToJson(LatestMusicModel instance) =>
    <String, dynamic>{
      'ONLINE_MP3': instance.music,
    };

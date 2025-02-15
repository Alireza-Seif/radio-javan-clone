// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'play_list_base_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PlayListBaseModel _$PlayListBaseModelFromJson(Map<String, dynamic> json) =>
    PlayListBaseModel(
      (json['ONLINE_MP3'] as List<dynamic>?)
          ?.map((e) => PlayListModel.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$PlayListBaseModelToJson(PlayListBaseModel instance) =>
    <String, dynamic>{
      'ONLINE_MP3': instance.playlists,
    };

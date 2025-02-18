// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'category_base_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CategoryBaseModel _$CategoryBaseModelFromJson(Map<String, dynamic> json) =>
    CategoryBaseModel(
      (json['ONLINE_MP3'] as List<dynamic>?)
          ?.map((e) => CategoryModel.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$CategoryBaseModelToJson(CategoryBaseModel instance) =>
    <String, dynamic>{
      'ONLINE_MP3': instance.categories,
    };

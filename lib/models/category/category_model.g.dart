// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'category_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CategoryModel _$CategoryModelFromJson(Map<String, dynamic> json) =>
    CategoryModel(
      json['cid'] as String?,
      json['category_name'] as String?,
      json['category_image'] as String?,
      json['category_image_thumb'] as String?,
    );

Map<String, dynamic> _$CategoryModelToJson(CategoryModel instance) =>
    <String, dynamic>{
      'cid': instance.cid,
      'category_name': instance.category_name,
      'category_image': instance.category_image,
      'category_image_thumb': instance.category_image_thumb,
    };

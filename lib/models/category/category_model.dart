import 'package:json_annotation/json_annotation.dart';

part 'category_model.g.dart';

@JsonSerializable()
class CategoryModel{
String? cid;
String? category_name;
String? category_image;
String? category_image_thumb;

CategoryModel(this.cid, this.category_name, this.category_image,
      this.category_image_thumb);


factory CategoryModel.fromJson(Map<String, dynamic> json) =>
    _$CategoryModelFromJson(json);

Map<String, dynamic> toJson() => _$CategoryModelToJson(this);
}
import 'package:json_annotation/json_annotation.dart';
import 'package:radio_javan/models/category/category_model.dart';

part 'category_base_model.g.dart';

@JsonSerializable()
class CategoryBaseModel{
  @JsonKey(name: 'ONLINE_MP3')
  List<CategoryModel>?  categories;

  CategoryBaseModel(this.categories);

  factory CategoryBaseModel.fromJson(Map<String, dynamic> json) =>
      _$CategoryBaseModelFromJson(json);

  Map<String, dynamic> toJson() => _$CategoryBaseModelToJson(this);
}
import 'categories_model.dart';

class HomeCategoriesModel {
  List<CategoriesModel>? categories;

  HomeCategoriesModel({this.categories});

  HomeCategoriesModel.fromJson(Map<String, dynamic> json) {
    if (json['data'] != null) {
      categories = <CategoriesModel>[];
      json['data'].forEach((v) {
        categories!.add(new CategoriesModel.fromJson(v));
      });
    }
  }
}

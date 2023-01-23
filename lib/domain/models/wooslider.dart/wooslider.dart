// class WooMobileSlider {
//   String? name;
//   int? id;
//   String? slug;
//   Images? images;

//   WooMobileSlider({this.name, this.id, this.slug, this.images});

//   WooMobileSlider.fromJson(Map<String, dynamic> json) {
//     name = json['name'];
//     id = json['id'];
//     slug = json['slug'];
//     images =
//         json['images'] != null ? new Images.fromJson(json['images']) : null;
//   }

//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     data['name'] = this.name;
//     data['id'] = this.id;
//     data['slug'] = this.slug;
//     if (this.images != null) {
//       data['images'] = this.images!.toJson();
//     }
//     return data;
//   }
// }

// class Images {
//   String? guid;

//   Images({this.guid});

//   Images.fromJson(Map<String, dynamic> json) {
//     guid = json['guid'];
//   }

//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     data['guid'] = this.guid;
//     return data;
//   }
// TODO }

class WooMobileSlider {
  String? name;
  int? id;
  String? description;
  String? date;
  String? slug;
  String? images;
  String? feature;

  WooMobileSlider(
      {this.name,
      this.id,
      this.description,
      this.date,
      this.slug,
      this.images,
      this.feature});

  WooMobileSlider.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    id = json['id'];
    description = json['description'];
    date = json['date'];
    slug = json['slug'];
    images = json['images'];

    feature = json['feature'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['id'] = this.id;
    data['description'] = this.description;
    data['date'] = this.date;
    data['slug'] = this.slug;
    data['images'] = this.images;

    data['feature'] = this.feature;
    return data;
  }
}

class SliderImages {
  String? guid;

  SliderImages({this.guid});

  SliderImages.fromJson(Map<String, dynamic> json) {
    guid = json['guid'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['guid'] = this.guid;
    return data;
  }
}

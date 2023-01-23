class WooProductCategory {
  int? id;
  String? name;
  int? parent;
  Image? image;
  int? count;

  WooProductCategory({this.id, this.name, this.parent, this.image, this.count});

  WooProductCategory.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    parent = json['parent'];
    image = json['image'] != null ? new Image.fromJson(json['image']) : null;
    count = json['count'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['parent'] = this.parent;
    if (this.image != null) {
      data['image'] = this.image!.toJson();
    }
    data['count'] = this.count;
    return data;
  }
}

class Image {
  String? guid;

  Image({this.guid});

  Image.fromJson(Map<String, dynamic> json) {
    guid = json['guid'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['guid'] = this.guid;
    return data;
  }
}

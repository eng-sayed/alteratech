import 'dart:convert';

class ProductSearchSuggestion {
  String? postTitle;
  int? postId;
  ProductSearchSuggestion({
    this.postTitle,
    this.postId,
  });

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};

    if (postTitle != null) {
      result.addAll({'post_title': postTitle});
    }
    if (postId != null) {
      result.addAll({'ID': postId});
    }

    return result;
  }

  factory ProductSearchSuggestion.fromMap(Map<String, dynamic> map) {
    return ProductSearchSuggestion(
      postTitle: map['post_title'],
      postId: map['ID'],
    );
  }

  String toJson() => json.encode(toMap());

  factory ProductSearchSuggestion.fromJson(String source) =>
      ProductSearchSuggestion.fromMap(json.decode(source));
}

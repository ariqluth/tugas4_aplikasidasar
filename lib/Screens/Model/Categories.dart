// ignore_for_file: public_member_api_docs, sort_constructors_first
class Categories {
  int? id;
  String? name;

  Categories({
    required this.id,
    required this.name,
  });

  Categories.fromJson(Map json)
      : id = json['id'],
        name = json['name'];
}

// class Category {
//   final String categoryId;
//   final String categoryname;
//   final String categorydescription;
//   final String categoryimage;

//   Category({
//     required this.categoryId,
//     required this.categoryname,
//     required this.categorydescription,
//     required this.categoryimage,
//   });

//  factory Category.fromMap(Map<String, dynamic> json) {
//   return Category(
//     categoryId:json['categoryId'],
//     categoryname: json['categoryname'],
//     categorydescription: json['categorydescription'],
//     categoryimage: json['categoryimage'],
//   );
// }
// }
class Category {
  final String id;
  final String categoryname;
  final String categorydescription;
  final String categoryimage;

  Category({
    required this.id,
    required this.categoryname,
    required this.categorydescription,
    required this.categoryimage,
  });

   // Constructor that takes only the ID
  Category.withId(String id)
      : id = id,
        categoryname = '',
        categorydescription = '',
        categoryimage = '';

  factory Category.fromMap(Map<String, dynamic> json) {
    return Category(
      id: json['_id'] as String,
      categoryname: json['categoryname'] as String,
      categorydescription: json['categorydescription'] as String,
      categoryimage: json['categoryimage'] as String,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      '_id': id,
      'categoryname': categoryname,
      'categorydescription': categorydescription,
      'categoryimage': categoryimage,
    };
  }
}

class TeachersCoursesResData {
  int key;
  String name;
  String slug;
  int price;
  String level;
  int discountPrice;
  String category;


  TeachersCoursesResData(
      {this.key,
        this.name,
        this.slug,
        this.price,
        this.level,
        this.discountPrice,
        this.category});

  TeachersCoursesResData.fromJson(Map<String, dynamic> json) {
    key = json['key'];
    name = json['name'];
    slug = json['slug'];
    price = json['price'];
    level = json['level'];
    discountPrice = json['discountPrice'];
    category = json['category'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['key'] = this.key;
    data['name'] = this.name;
    data['slug'] = this.slug;
    data['price'] = this.price;
    data['level'] = this.level;
    data['discountPrice'] = this.discountPrice;
    data['category'] = this.category;
    return data;
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is TeachersCoursesResData &&
          runtimeType == other.runtimeType &&
          key == other.key &&
          name == other.name &&
          slug == other.slug &&
          price == other.price &&
          level == other.level &&
          discountPrice == other.discountPrice &&
          category == other.category;

  @override
  int get hashCode =>
      key.hashCode ^
      name.hashCode ^
      slug.hashCode ^
      price.hashCode ^
      level.hashCode ^
      discountPrice.hashCode ^
      category.hashCode;
}
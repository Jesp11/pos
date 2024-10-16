class Category {
  final String name;
  final String description;

  Category({required this.name, required this.description});

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'description': description,
    };
  }

  static Category fromMap(Map<String, dynamic> map) {
    return Category(
      name: map['name'],
      description: map['description'],
    );
  }
}

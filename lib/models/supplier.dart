class Supplier {
  final String company;
  final String contact;

  Supplier({required this.company, required this.contact});

  Map<String, dynamic> toMap() {
    return {
      'company': company,
      'contact': contact,
    };
  }

  static Supplier fromMap(Map<String, dynamic> map) {
    return Supplier(
      company: map['company'],
      contact: map['contact'],
    );
  }
}

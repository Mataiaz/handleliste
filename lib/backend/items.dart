class Item {
  int id;
  int antall;
  String tittel;

  Item({required this.id, required this.antall, required this.tittel});

  factory Item.fromJson(Map<String, dynamic> json) {
    return Item(
      id: json['id'] as int,
      antall: json['antall'] as int,
      tittel: json['tittel'] as String,
    );
  }
}
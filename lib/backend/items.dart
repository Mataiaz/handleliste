class Item {
  String id;
  String amount;
  String title;
  

  Item({required this.id, required this.amount, required this.title});

  factory Item.fromJson(Map<String, dynamic> json) {
    return Item(
      id: json['id'] as String,
      amount: json['amount'] as String,
      title: json['title'] as String,
    );
  }
}
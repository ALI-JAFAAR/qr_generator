class CartItem {
  String name, img, id;
  int price,qty;
  CartItem({
    required this.name,
    required this.img,
    required this.id,
    required this.price,
    required this.qty
  });

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "price": price,
        "img": img,
        "qty": qty
      };
}
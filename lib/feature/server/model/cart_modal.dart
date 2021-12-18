
class CartProductModel {
   int productId;
  String tradeId;
  String productName;
  String price;
  int quantity;
  String image;


  CartProductModel(
      {
      this.productName,
      this.productId,
      this.tradeId,
      this.price,
      this.quantity,
      this.image,});

  CartProductModel.fromJson(Map<String, dynamic> json) {
    productId = json['id'];
    tradeId = json['tradeId'];
    productName = json['name'];
    price = json['price'];
    quantity = json['quantity'];
    image = json['image'];

  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.productId;
    data['tradeId'] = this.tradeId;

    data['name'] = this.productName;
    data['price'] = this.price;
    data['quantity'] = this.quantity;
    data['image'] = this.image;
    return data;
  }

 
}

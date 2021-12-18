import 'package:belleza/feature/server/model/cart_modal.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get_state_manager/get_state_manager.dart';

import 'helper/sql_table.dart';

class GetCart extends GetxController {
  ValueNotifier<bool> _loading = ValueNotifier(false);
  ValueNotifier<bool> get loading => _loading;

  List<CartProductModel> _cartProductModel = [];
  List<CartProductModel> get cartProductModel => _cartProductModel;

  double _totalPrice = 0.0;
  double get totalPrice => _totalPrice;

  int count = 1;

  GetCart() {
    getAllProduct();
  }
  getAllProduct() async {
    _cartProductModel = await DBHelper.dbClint.getAllProductDB();
    getTotalPrice();
    update();
  }

  addProduct(CartProductModel cartProductModel) async {
    for (var i = 0; i < _cartProductModel.length; i++) {
      if (_cartProductModel[i].productId == cartProductModel.productId) {
        return;
      }
    }
    await DBHelper.dbClint.insertDB(cartProductModel);
    _cartProductModel.add(cartProductModel);

    _totalPrice +=
        (double.parse(cartProductModel.price) * cartProductModel.quantity);
    // setToast("تم اضافة للسة ");
    update();
  }

  getTotalPrice() async {
    for (var i = 0; i < _cartProductModel.length; i++) {
      _totalPrice += (double.parse(_cartProductModel[i].price) *
          _cartProductModel[i].quantity);
    }

    update();
  }

  incrementCount(int index) async {
    _cartProductModel[index].quantity++;
    _totalPrice += (double.parse(_cartProductModel[index].price));
    await DBHelper.dbClint.updateProduct(_cartProductModel[index]);
    update();
  }

  decrementCount(int index) async {
    if (_cartProductModel[index].quantity > 1) {
      _cartProductModel[index].quantity--;
      _totalPrice -= (double.parse(_cartProductModel[index].price));
      await DBHelper.dbClint.updateProduct(_cartProductModel[index]);
    }

    update();
  }

  deleteproduct(CartProductModel cartProductModel) async {
    await DBHelper.dbClint.deleteproduct(cartProductModel);
    for (var i = 0; i < _cartProductModel.length; i++) {
      _totalPrice -= (double.parse(_cartProductModel[i].price) *
          _cartProductModel[i].quantity);
    }
    getAllProduct();

    update();
  }

  deleteAllProduct() async {
    await DBHelper.dbClint.deleteproductAll();
    _totalPrice = 0;
    getAllProduct();

    update();
  }
}

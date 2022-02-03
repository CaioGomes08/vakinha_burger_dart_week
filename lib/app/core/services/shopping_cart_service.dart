import 'package:get/get.dart';
import 'package:vakinha_burger/app/models/product_model.dart';
import 'package:vakinha_burger/app/models/shopping_cart_model.dart';

class ShoppingCartService extends GetxService {
  final _shoppingCart = <int, ShoppingCartModel>{}.obs;

  List<ShoppingCartModel> get product => _shoppingCart.values.toList();

  int get totalProducts => _shoppingCart.values.length;

  ShoppingCartModel? getById(int id) => _shoppingCart[id];

  void addAndRemoveProductInShoppingCart(ProductModel product,
      {required int quantity}) {
    if (quantity == 0) {
      _shoppingCart.remove(product.id);
    } else {
      _shoppingCart.update(product.id, (product) {
        product.quantity = quantity;
        return product;
      }, ifAbsent: () {
        return ShoppingCartModel(quantity: quantity, product: product);
      });
    }
  }
}

import 'package:vakinha_burger/app/models/order_pix.dart';

import '../../models/order.dart';

abstract class OrderRepository {
  Future<OrderPix> createOrder(Order order);
}

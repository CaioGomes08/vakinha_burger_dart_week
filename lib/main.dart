import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:vakinha_burger/app/core/bindings/application_binding.dart';
import 'package:vakinha_burger/app/core/ui/vakinha_ui.dart';
import 'package:vakinha_burger/app/routes/auth_routers.dart';
import 'package:vakinha_burger/app/routes/home_routers.dart';
import 'package:vakinha_burger/app/routes/order_routers.dart';
import 'package:vakinha_burger/app/routes/product_routers.dart';
import 'package:vakinha_burger/app/routes/splash_routers.dart';

Future<void> main() async {
  await GetStorage.init();
  runApp(const VakinhaBurgerMainApp());
}

class VakinhaBurgerMainApp extends StatelessWidget {
  const VakinhaBurgerMainApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Vakinha Burger',
      theme: VakinhaUi.theme,
      initialBinding: ApplicationBinding(),
      debugShowCheckedModeBanner: false,
      getPages: [
        ...SplashRouters.routers,
        ...AuthRouters.routers,
        ...HomeRouters.routers,
        ...ProductRouters.routers,
        ...OrderRouters.routers,
      ],
    );
  }
}

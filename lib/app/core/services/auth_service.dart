import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:vakinha_burger/app/core/constants/constansts.dart';

class AuthService extends GetxService {
  final _isLogged = RxnBool();
  final _getStorage = GetStorage();

  Future<AuthService> init() async {
    _getStorage.listenKey(Constansts.USER_KEY, (value) {
      // if (value != null) {
      //   _isLogged(true);
      // } else {
      //   _isLogged(false);
      // }
      _isLogged(value != null);
    });

    ever<bool?>(_isLogged, (isLogged) {
      if (isLogged == null || !isLogged) {
        Get.offAllNamed('/auth/login');
      } else {
        Get.offAllNamed('/home');
      }
    });

    // final isLoggedData = getUserId() != null;
    _isLogged(getUserId() != null);
    return this;
  }

  void logout() => _getStorage.write(Constansts.USER_KEY, null);

  int? getUserId() => _getStorage.read(Constansts.USER_KEY);
}

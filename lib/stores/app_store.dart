
import 'package:rescue_army/services/auth/app_auth_provider.dart';
import '../models/user.dart';
import 'package:velocity_x/velocity_x.dart';


class AppStore extends VxStore {
  User? user;
}

class SetUser extends VxMutation<AppStore> {
  @override
  perform() {
    AppAuthProvider().currentUser.then((user) {
      store?.user = user;
    });
  }
}

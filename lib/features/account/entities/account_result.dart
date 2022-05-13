import 'package:daily/features/account/models/user_model.dart';

class AccountResult {
  UserModel? user;
  String? error;

  AccountResult(this.user, this.error);
}

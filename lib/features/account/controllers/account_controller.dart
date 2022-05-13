import 'dart:developer';

import 'package:appwrite/appwrite.dart';
import 'package:appwrite/models.dart';
import 'package:daily/features/account/entities/account_result.dart';
import 'package:daily/features/account/models/user_model.dart';
import 'package:daily/features/account/pages/signin_page.dart';
import 'package:get/get.dart';

const hostname = "http://localhost/v1";
const projectId = "627d5f220f8a0a4aedf8";

class AccountController extends GetxController {
  final Client _appwrite = Client();

  var user = UserModel().obs;

  Future<AccountResult> signUp({
    required String name,
    required String email,
    required String password,
  }) async {
    Account account = Account(_appwrite);
    _appwrite.setEndpoint(hostname).setProject(projectId);

    try {
      User newUser = await account.create(
        userId: "unique()",
        name: name,
        email: email,
        password: password,
      );

      UserModel user = UserModel(
        id: newUser.$id,
        name: newUser.name,
        email: newUser.email,
      );

      return AccountResult(user, null);
    } catch (e) {
      log("Error: $e");
      return AccountResult(null, e.toString());
    }
  }

  Future<AccountResult> signIn({
    required String email,
    required String password,
  }) async {
    Account account = Account(_appwrite);
    _appwrite.setEndpoint(hostname).setProject(projectId);

    try {
      final session =
          await account.createSession(email: email, password: password);

      if (!session.current) {
        return AccountResult(null, "Failed to loggedIn");
      }

      return await getAccount(session.$id);
    } catch (e) {
      log("Error: $e");
      return AccountResult(null, e.toString());
    }
  }

  void signOut(String sessionId) {
    Account account = Account(_appwrite);
    _appwrite.setEndpoint(hostname).setProject(projectId);

    account.deleteSession(sessionId: sessionId).then((value) {
      print(value);
      user.value = UserModel();
      Get.offAll(SignInPage());
    });
  }

  Future<AccountResult> getAccount(String sessionId) async {
    Account account = Account(_appwrite);
    _appwrite.setEndpoint(hostname).setProject(projectId);

    try {
      User loggedInUser = await account.get();

      UserModel user = UserModel(
        id: loggedInUser.$id,
        sessionId: sessionId,
        name: loggedInUser.name,
        email: loggedInUser.email,
      );

      return AccountResult(user, null);
    } catch (e) {
      log("Error: $e");
      return AccountResult(null, e.toString());
    }
  }
}

import 'package:daily/app_theme.dart';
import 'package:daily/features/account/controllers/account_controller.dart';
import 'package:daily/features/account/controllers/form_controller.dart';
import 'package:daily/features/account/pages/signup_page.dart';
import 'package:daily/features/account/widgets/google_btn.dart';
import 'package:daily/features/account/widgets/input_text.dart';
import 'package:daily/features/my_feed/pages/my_feed_page.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../widgets/my_button.dart';

class SignInPage extends StatelessWidget {
  SignInPage({Key? key}) : super(key: key);

  final _emailC = TextEditingController();
  final _passwordC = TextEditingController();
  final _state = Get.put(FormController());
  final _accountC = Get.put(AccountController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Daily.dev Clone",
        ),
        centerTitle: true,
        elevation: 1,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(30),
        child: SizedBox(
          height: MediaQuery.of(context).size.height * 0.75,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const SizedBox(height: 20),
              Text(
                "Hello there!",
                style: AppTextStyle.bigTitle.copyWith(
                  fontSize: 28,
                  color: Theme.of(context).primaryColor,
                ),
              ),
              const SizedBox(height: 10),
              Text(
                "Welcome back you have \nbeen missed!",
                style: AppTextStyle.normal.copyWith(
                  fontSize: 14,
                  color: Colors.grey,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 30),
              // Obx(
              //   () =>
              InputText(
                textController: _emailC,
                hintText: "Email",
                // errorText: _state.emailError.isNotEmpty
                //     ? _state.emailError.value
                //     : null,
                keyboardType: TextInputType.emailAddress,
                prefixIcon: Icon(
                  Icons.message,
                  color: Theme.of(context).primaryColor,
                ),
                onChanged: (v) {
                  _state.emailText(v);
                },
              ),
              // ),
              const SizedBox(height: 10),
              Obx(
                () => InputText(
                  textController: _passwordC,
                  hintText: "Password",
                  // errorText: _state.passwordError.isNotEmpty
                  //     ? _state.passwordError.value
                  //     : null,
                  prefixIcon: Icon(
                    Icons.password,
                    color: Theme.of(context).primaryColor,
                  ),
                  suffixIcon: IconButton(
                    onPressed: () => _state.isObscure(!_state.isObscure.value),
                    icon: Icon(
                      _state.isObscure.isTrue
                          ? Icons.remove_red_eye
                          : Icons.remove_red_eye,
                      color: Colors.grey,
                    ),
                  ),
                  obsureText: _state.isObscure.value,
                  onChanged: (v) {
                    if (v.isEmpty) {
                      _state.passwordError("");
                    }
                    _state.passwordText(v);
                  },
                ),
              ),
              const SizedBox(height: 30),
              Obx(
                () => MyButton(
                  width: MediaQuery.of(context).size.width,
                  text: "Sign In",
                  isLoading: _state.isLoading.value,
                  onPressed: () {
                    signIn();
                  },
                ),
              ),
              const SizedBox(height: 16),
              Text(
                "other options",
                style: AppTextStyle.normal.copyWith(
                  fontSize: 14,
                  color: Colors.grey,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 16),
              Obx(
                () => GoogleBtn1(
                  text: "Sign In",
                  isLoading: _state.isLoadingGoogle.value,
                  onPressed: () {
                    Get.snackbar("Opps...", "This feature can't be used yet.");
                  },
                ),
              ),
              const SizedBox(height: 70),
              Text(
                "Don't have an account?",
                style: AppTextStyle.normal.copyWith(
                  color: Colors.grey,
                ),
                textAlign: TextAlign.center,
              ),
              InkWell(
                onTap: () => Get.off(SignUpPage()),
                child: Text(
                  "Sign Up Now!",
                  style: AppTextStyle.normal.copyWith(
                    color: Theme.of(context).primaryColor,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void signIn() async {
    _state.isSubmitted(true);
    final email = _state.validateEmail();
    final pass = _state.validatePassword();
    if (email != null) {
      Get.snackbar("Opps...", email);
      _state.isSubmitted(false);
    } else if (pass != null) {
      Get.snackbar("Opps...", pass);
      _state.isSubmitted(false);
    } else {
      _state.isSubmitted(false);

      _state.isLoading(true);

      _accountC
          .signIn(email: _emailC.text, password: _passwordC.text)
          .then((result) {
        if (result.error != null) {
          _state.isLoading(false);

          Get.snackbar("Opps...", result.error.toString());
        } else {
          _state.isLoading(false);
          _accountC.user.value = result.user!;
          Get.off(MyFeedPage());
        }
      });
    }
  }
}

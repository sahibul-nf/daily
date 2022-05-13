import 'package:daily/app_theme.dart';
import 'package:daily/features/account/controllers/account_controller.dart';
import 'package:daily/features/account/controllers/form_controller.dart';
import 'package:daily/features/account/pages/signin_page.dart';
import 'package:daily/features/account/widgets/google_btn.dart';
import 'package:daily/features/account/widgets/input_text.dart';
import 'package:daily/features/my_feed/pages/my_feed_page.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../widgets/my_button.dart';

class SignUpPage extends StatelessWidget {
  SignUpPage({Key? key}) : super(key: key);

  final _emailC = TextEditingController();
  final _passwordC = TextEditingController();
  final _nameC = TextEditingController();
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
                "Let's go!",
                style: AppTextStyle.bigTitle.copyWith(
                  fontSize: 28,
                  color: Theme.of(context).primaryColor,
                ),
              ),
              const SizedBox(height: 10),
              Text(
                "Create your account and get \ninteresting insigh your activity \non this app",
                style: AppTextStyle.normal.copyWith(
                  fontSize: 14,
                  color: Colors.grey,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 30),
              InputText(
                textController: _nameC,
                hintText: "Name",
                // errorText:
                //     _state.isSubmitted.value ? _state.emailError.value : null,
                // keyboardType: TextInputType.emailAddress,
                prefixIcon: Icon(
                  Icons.person,
                  color: Theme.of(context).primaryColor,
                ),
                onChanged: (v) {
                  // _state.emailText(v);
                },
              ),
              const SizedBox(height: 10),
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
                  text: "Sign Up",
                  isLoading: _state.isLoading.value,
                  onPressed: () {
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

                      _state.isLoading(false);

                      _accountC
                          .signUp(
                              name: _nameC.text,
                              email: _emailC.text,
                              password: _passwordC.text)
                          .then((value) {
                        if (value.error != null) {
                          _state.isLoading(false);

                          Get.snackbar("Opps...", value.error.toString());
                        } else {
                          _accountC.user.value = value.user!;
                          Get.off(MyFeedPage());
                        }
                      });
                    }
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
                  text: "Sign Up",
                  isLoading: _state.isLoadingGoogle.value,
                  onPressed: () {
                    Get.snackbar("Opps...", "This feature can't be used yet.");
                  },
                ),
              ),
              const Flexible(child: SizedBox(height: 70)),
              Flexible(
                child: Text(
                  "Already have an account?",
                  style: AppTextStyle.normal.copyWith(
                    color: Colors.grey,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
              InkWell(
                onTap: () => Get.off(SignInPage()),
                child: Text(
                  "Sign In Now!",
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
}

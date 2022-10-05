import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:petilla_app_project/auth/auth_service/auth_service.dart';
import 'package:petilla_app_project/auth/auth_view/register_view.dart';
import 'package:petilla_app_project/constant/sizes/app_sized_box.dart';
import 'package:petilla_app_project/constant/sizes/project_button_sizes.dart';
import 'package:petilla_app_project/constant/sizes/project_card_sizes.dart';
import 'package:petilla_app_project/constant/sizes/project_padding.dart';
import 'package:petilla_app_project/constant/strings_constant/project_lottie_urls.dart';
import 'package:petilla_app_project/general/general_widgets/button.dart';
import 'package:petilla_app_project/general/general_widgets/textfields/auth_textfield.dart';
import 'package:petilla_app_project/main.dart';
import 'package:petilla_app_project/theme/light_theme/light_theme_colors.dart';

class LoginView extends StatefulWidget {
  const LoginView({Key? key}) : super(key: key);

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  final _formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    super.dispose();
    _emailController.dispose();
    _passwordController.dispose();
  }

  var mainSizedBox = AppSizedBoxs.mainHeightSizedBox;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(_ThisPageTexts.title),
        centerTitle: true,
      ),
      body: Form(
        key: _formKey,
        child: ListView(
          padding: ProjectPaddings.horizontalLargePadding,
          children: [
            Column(
              children: [
                _lottie(),
                _mailTextField(),
                mainSizedBox,
                _passwordTextField(),
                mainSizedBox,
                _loginButton(context),
                mainSizedBox,
                _dontHaveAnAccount(context),
                _registerButton(),
              ],
            ),
          ],
        ),
      ),
    );
  }

  LottieBuilder _lottie() {
    return Lottie.network(
      ProjectLottieUrls.loginLottie,
      width: ProjectCardSizes.bigLottieWidth,
      height: ProjectCardSizes.bigLottieHeight,
    );
  }

  AuthTextField _mailTextField() {
    return AuthTextField(
      isNext: true,
      false,
      controller: _emailController,
      hintText: _ThisPageTexts.mailHintText,
      prefixIcon: const Icon(
        Icons.mail_outlined,
        color: LightThemeColors.cherrywoord,
      ),
      keyboardType: TextInputType.emailAddress,
    );
  }

  AuthTextField _passwordTextField() {
    return AuthTextField(
      true,
      controller: _passwordController,
      hintText: _ThisPageTexts.passwordHintText,
      prefixIcon: const Icon(
        Icons.lock_outline,
        color: LightThemeColors.cherrywoord,
      ),
      keyboardType: TextInputType.visiblePassword,
      isNext: false,
    );
  }

  Text _dontHaveAnAccount(context) {
    return Text(
      _ThisPageTexts.dontHaveAccount,
      style: Theme.of(context).textTheme.titleMedium,
    );
  }

  TextButton _registerButton() {
    return TextButton(
      onPressed: () {
        Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(builder: (context) => const RegisterView()),
          (route) => false,
        );
      },
      child: Text(_ThisPageTexts.registerText),
    );
  }

  Button _loginButton(BuildContext context) {
    return Button(
      onPressed: _onLoginButton,
      width: ProjectButtonSizes.mainButtonWidth,
      height: ProjectButtonSizes.mainButtonHeight,
      text: _ThisPageTexts.title,
    );
  }

  void _onLoginButton() async {
    if (_formKey.currentState!.validate()) {
      await AuthService().login(_emailController.text.trim(), _passwordController.text.trim(), context).whenComplete(
            () => Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const Petilla(showHome: true),
              ),
            ),
          );
    }
  }
}

class _ThisPageTexts {
  static String title = "login".tr();
  static String mailHintText = "mail".tr();
  static String passwordHintText = "password".tr();
  static String dontHaveAccount = "dont_have_account".tr();
  static String registerText = "register".tr();
}

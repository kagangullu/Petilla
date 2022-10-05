import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:petilla_app_project/auth/auth_service/auth_service.dart';
import 'package:petilla_app_project/auth/auth_view/login_view.dart';
import 'package:petilla_app_project/constant/sizes/app_sized_box.dart';
import 'package:petilla_app_project/constant/sizes/project_button_sizes.dart';
import 'package:petilla_app_project/constant/sizes/project_card_sizes.dart';
import 'package:petilla_app_project/constant/sizes/project_padding.dart';
import 'package:petilla_app_project/constant/strings_constant/project_lottie_urls.dart';
import 'package:petilla_app_project/general/general_widgets/button.dart';
import 'package:petilla_app_project/general/general_widgets/textfields/auth_textfield.dart';
import 'package:petilla_app_project/main.dart';
import 'package:petilla_app_project/theme/light_theme/light_theme_colors.dart';

class RegisterView extends StatefulWidget {
  const RegisterView({Key? key}) : super(key: key);

  @override
  State<RegisterView> createState() => _RegisterViewState();
}

class _RegisterViewState extends State<RegisterView> {
  final _formKey = GlobalKey<FormState>();

  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

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
                _nameTextField(),
                mainSizedBox,
                _emailTextField(),
                mainSizedBox,
                _passwordTextField(),
                mainSizedBox,
                _registerButton(),
                mainSizedBox,
                _alreadyHaveAnAccount(),
                _logInButton(context),
              ],
            ),
          ],
        ),
      ),
    );
  }

  LottieBuilder _lottie() {
    return Lottie.network(
      ProjectLottieUrls.registerLottie,
      width: ProjectCardSizes.bigLottieWidth,
      height: ProjectCardSizes.bigLottieHeight,
    );
  }

  AuthTextField _passwordTextField() {
    return AuthTextField(
      true,
      controller: _passwordController,
      hintText: _ThisPageTexts.passwordHint,
      isNext: false,
      keyboardType: TextInputType.visiblePassword,
      prefixIcon: const Icon(Icons.lock_outline, color: LightThemeColors.cherrywoord),
    );
  }

  AuthTextField _emailTextField() {
    return AuthTextField(
      false,
      controller: _emailController,
      hintText: _ThisPageTexts.mailHint,
      isNext: true,
      keyboardType: TextInputType.emailAddress,
      prefixIcon: const Icon(Icons.mail_outlined, color: LightThemeColors.cherrywoord),
    );
  }

  AuthTextField _nameTextField() {
    return AuthTextField(
      false,
      controller: _nameController,
      hintText: _ThisPageTexts.nameHint,
      isNext: true,
      keyboardType: TextInputType.name,
      prefixIcon: const Icon(Icons.person, color: LightThemeColors.cherrywoord),
    );
  }

  Button _registerButton() {
    return Button(
      onPressed: _onRegister,
      width: ProjectButtonSizes.mainButtonWidth,
      height: ProjectButtonSizes.mainButtonHeight,
      text: _ThisPageTexts.title,
    );
  }

  void _onRegister() {
    if (_formKey.currentState!.validate()) {
      AuthService()
          .register(
            _emailController.text.trim(),
            _passwordController.text.trim(),
            _nameController.text.trim(),
            context,
          )
          .whenComplete(
            () => Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(
                builder: (context) => const Petilla(showHome: true),
              ),
              (route) => false,
            ),
          );
    }
  }

  Text _alreadyHaveAnAccount() {
    return Text(
      _ThisPageTexts.alreadyHaveAnAccount,
      style: Theme.of(context).textTheme.titleMedium,
    );
  }

  TextButton _logInButton(BuildContext context) {
    return TextButton(
      onPressed: () {
        Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(
              builder: (context) => const LoginView(),
            ),
            (route) => false);
      },
      child: Text(_ThisPageTexts.logIn),
    );
  }
}

class _ThisPageTexts {
  static String title = "register".tr();
  static String nameHint = "name".tr();
  static String mailHint = "mail".tr();
  static String passwordHint = "password".tr();
  static String alreadyHaveAnAccount = "already_have_an_account".tr();
  static String logIn = "login".tr();
}

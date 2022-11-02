import 'package:flutter/material.dart';
import 'package:petilla_app_project/constant/localization/localization.dart';
import 'package:petilla_app_project/general/general_widgets/button.dart';
import 'package:petilla_app_project/start/onboarding/onboarding_view_model.dart';
import 'package:petilla_app_project/start/onboarding/onboarding_views/onboarding_one/onboarding_one_view.dart';
import 'package:petilla_app_project/start/onboarding/onboarding_views/onboarding_three/onboarding_three_view.dart';
import 'package:petilla_app_project/start/onboarding/onboarding_views/onboarding_two/onboarding_two_view.dart';
import 'package:petilla_app_project/theme/light_theme/light_theme_colors.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class Onboarding extends StatefulWidget {
  const Onboarding({Key? key}) : super(key: key);

  @override
  State<Onboarding> createState() => _OnboardingState();
}

class _OnboardingState extends State<Onboarding> {
  final controller = PageController();
  bool isLastPage = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomSheet: _bottomSheet(),
      body: _body(context),
    );
  }

  Container _body(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(bottom: 80),
      child: _pageView(context),
    );
  }

  PageView _pageView(BuildContext context) {
    return PageView(
      onPageChanged: _onPageChangedMethod,
      controller: controller,
      children: [
        OnboardingOneView(),
        OnboardingTwoView(),
        OnboardingThreeView(),
      ],
    );
  }

  void _onPageChangedMethod(index) {
    setState(() {
      isLastPage = index == 2;
    });
  }

  _bottomSheet() {
    return isLastPage ? _getStartedButton(context) : _indicatorAndButtons();
  }

  Container _indicatorAndButtons() {
    return Container(
      color: LightThemeColors.scaffoldBackgroundColor,
      padding: const EdgeInsets.symmetric(horizontal: 40),
      height: 80,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          _backButton(),
          Center(
            child: _indicator(),
          ),
          _nextButton(),
        ],
      ),
    );
  }

  _getStartedButton(context) {
    return Button(
      onPressed: () {
        OnboardingViewModel().onGetStartedButton(context);
      },
      height: 75,
      text: _ThisPageTexts.start,
      noBorderRadius: true,
    );
  }

  // Next button
  TextButton _nextButton() {
    return TextButton(
      onPressed: _onNextButton,
      child: Text(_ThisPageTexts.continuePages),
    );
  }

  void _onNextButton() {
    controller.nextPage(
      duration: const Duration(milliseconds: 500),
      curve: Curves.easeInOut,
    );
  }

  // Indicator
  SmoothPageIndicator _indicator() {
    return SmoothPageIndicator(
      controller: controller,
      count: 3,
      effect: _pageIndicatorEffect(),
      onDotClicked: _onDotClicked,
    );
  }

  WormEffect _pageIndicatorEffect() {
    return const WormEffect(
      dotColor: LightThemeColors.grey,
      activeDotColor: LightThemeColors.miamiMarmalade,
      dotWidth: 15,
      dotHeight: 15,
      spacing: 16,
    );
  }

  void _onDotClicked(index) {
    controller.animateToPage(
      index,
      duration: const Duration(milliseconds: 500),
      curve: Curves.easeIn,
    );
  }

  // Back button
  TextButton _backButton() {
    return TextButton(
      onPressed: _onBackButton,
      child: _backTextButtons(),
    );
  }

  Text _backTextButtons() {
    return Text(
      _ThisPageTexts.backText,
      style: const TextStyle(color: LightThemeColors.miamiMarmalade),
    );
  }

  void _onBackButton() {
    controller.previousPage(
      duration: const Duration(milliseconds: 500),
      curve: Curves.easeInOut,
    );
  }
}

class _ThisPageTexts {
  static String backText = Localization.back;
  static String start = Localization.start;
  static String continuePages = Localization.continueText;
}
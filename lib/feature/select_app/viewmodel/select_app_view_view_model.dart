// ignore_for_file: library_private_types_in_public_api

import 'package:flutter/material.dart';
import 'package:mobx/mobx.dart';
import 'package:patily/core/base/model/base_viewmodel.dart';
import 'package:patily/core/base/view/profile_view.dart';

part 'select_app_view_view_model.g.dart';

class SelectAppViewViewModel = _SelectAppViewViewModelBase
    with _$SelectAppViewViewModel;

abstract class _SelectAppViewViewModelBase with Store, BaseViewModel {
  @override
  void setContext(BuildContext context) {
    viewModelContext = context;
  }

  @override
  void init() {}

  @action
  void callProfileView() {
    Navigator.push(viewModelContext,
        MaterialPageRoute(builder: (context) => const ProfileView()));
  }
}
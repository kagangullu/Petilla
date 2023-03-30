import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:mobx/mobx.dart';
import 'package:patily/core/base/model/base_view_model.dart';
import 'package:patily/core/constants/string_constant/project_firestore_collection_names.dart';
import 'package:patily/view/user/apps/patily_form/view/add_question_view.dart';

part 'patily_form_home_view_model.g.dart';

class PatilyFormHomeViewViewModel = PatilyFormHomeViewViewModelBase
    with _$PatilyFormHomeViewViewModel;

abstract class PatilyFormHomeViewViewModelBase with Store, BaseViewModel {
  @override
  void setContext(BuildContext context) {
    viewModelContext = context;
  }

  @override
  void init() {}

  @observable
  CollectionReference<Map<String, dynamic>> stream = FirebaseFirestore.instance
      .collection(AppFirestoreCollectionNames.patilyForm);

  @action
  void callAddQuestionView() {
    Navigator.push(
      viewModelContext,
      MaterialPageRoute(
        builder: (context) => const AddQuestionView(),
      ),
    );
  }
}
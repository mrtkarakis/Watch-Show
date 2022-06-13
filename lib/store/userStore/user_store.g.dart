// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$UserStore on _UserStoreBase, Store {
  late final _$signInDataAtom =
      Atom(name: '_UserStoreBase.signInData', context: context);

  @override
  CurrentUser? get signInData {
    _$signInDataAtom.reportRead();
    return super.signInData;
  }

  @override
  set signInData(CurrentUser? value) {
    _$signInDataAtom.reportWrite(value, super.signInData, () {
      super.signInData = value;
    });
  }

  late final _$userDataAtom =
      Atom(name: '_UserStoreBase.userData', context: context);

  @override
  CurrentUser? get userData {
    _$userDataAtom.reportRead();
    return super.userData;
  }

  @override
  set userData(CurrentUser? value) {
    _$userDataAtom.reportWrite(value, super.userData, () {
      super.userData = value;
    });
  }

  late final _$_UserStoreBaseActionController =
      ActionController(name: '_UserStoreBase', context: context);

  @override
  void setUser(User _user) {
    final _$actionInfo = _$_UserStoreBaseActionController.startAction(
        name: '_UserStoreBase.setUser');
    try {
      return super.setUser(_user);
    } finally {
      _$_UserStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setSignInData({required String key, required dynamic value}) {
    final _$actionInfo = _$_UserStoreBaseActionController.startAction(
        name: '_UserStoreBase.setSignInData');
    try {
      return super.setSignInData(key: key, value: value);
    } finally {
      _$_UserStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setUserData({required String key, required dynamic value}) {
    final _$actionInfo = _$_UserStoreBaseActionController.startAction(
        name: '_UserStoreBase.setUserData');
    try {
      return super.setUserData(key: key, value: value);
    } finally {
      _$_UserStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void addTotalToken(int _totalToken) {
    final _$actionInfo = _$_UserStoreBaseActionController.startAction(
        name: '_UserStoreBase.addTotalToken');
    try {
      return super.addTotalToken(_totalToken);
    } finally {
      _$_UserStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void clearTotalToken() {
    final _$actionInfo = _$_UserStoreBaseActionController.startAction(
        name: '_UserStoreBase.clearTotalToken');
    try {
      return super.clearTotalToken();
    } finally {
      _$_UserStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setTotalSteps(int? _totalSteps) {
    final _$actionInfo = _$_UserStoreBaseActionController.startAction(
        name: '_UserStoreBase.setTotalSteps');
    try {
      return super.setTotalSteps(_totalSteps);
    } finally {
      _$_UserStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
signInData: ${signInData},
userData: ${userData}
    ''';
  }
}

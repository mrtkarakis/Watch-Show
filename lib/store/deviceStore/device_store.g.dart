// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'device_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$DeviceStore on _DeviceStoreBase, Store {
  late final _$notificationAtom =
      Atom(name: '_DeviceStoreBase.notification', context: context);

  @override
  bool get notification {
    _$notificationAtom.reportRead();
    return super.notification;
  }

  @override
  set notification(bool value) {
    _$notificationAtom.reportWrite(value, super.notification, () {
      super.notification = value;
    });
  }

  late final _$loadingAtom =
      Atom(name: '_DeviceStoreBase.loading', context: context);

  @override
  bool get loading {
    _$loadingAtom.reportRead();
    return super.loading;
  }

  @override
  set loading(bool value) {
    _$loadingAtom.reportWrite(value, super.loading, () {
      super.loading = value;
    });
  }

  late final _$_DeviceStoreBaseActionController =
      ActionController(name: '_DeviceStoreBase', context: context);

  @override
  void setDeviceSize(BuildContext context) {
    final _$actionInfo = _$_DeviceStoreBaseActionController.startAction(
        name: '_DeviceStoreBase.setDeviceSize');
    try {
      return super.setDeviceSize(context);
    } finally {
      _$_DeviceStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void changeNotification(bool _notification) {
    final _$actionInfo = _$_DeviceStoreBaseActionController.startAction(
        name: '_DeviceStoreBase.changeNotification');
    try {
      return super.changeNotification(_notification);
    } finally {
      _$_DeviceStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void changeLoading(bool _loading) {
    final _$actionInfo = _$_DeviceStoreBaseActionController.startAction(
        name: '_DeviceStoreBase.changeLoading');
    try {
      return super.changeLoading(_loading);
    } finally {
      _$_DeviceStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
notification: ${notification},
loading: ${loading}
    ''';
  }
}

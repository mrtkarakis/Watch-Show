import 'package:flutter/material.dart';
import 'package:mobx/mobx.dart';
part 'device_store.g.dart';

class DeviceStore = _DeviceStoreBase with _$DeviceStore;

abstract class _DeviceStoreBase with Store {
  double height = 0.0, width = 0.0;

  @action
  void setDeviceSize(BuildContext context) {
    width = MediaQuery.of(context).size.width;
    height = MediaQuery.of(context).size.height;
  }

  @observable
  bool notification = false;

  @action
  void changeNotification(bool _notification) => notification = _notification;

  @observable
  bool loading = false;

  @action
  void changeLoading(bool _loading) => loading = _loading;
}

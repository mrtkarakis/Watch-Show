import 'package:mobx/mobx.dart';
import 'package:watch_and_show/models/channel.dart';
part 'channel_store.g.dart';

class ChannelStore = _ChannelStoreBase with _$ChannelStore;

abstract class _ChannelStoreBase with Store {
  Channel? channel;
  _HasDataFirebase hasDataFirebase = _HasDataFirebase();
}

class _HasDataFirebase {
  bool channels = false;
  bool videos = false;
}

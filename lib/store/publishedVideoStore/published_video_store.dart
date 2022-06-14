import 'package:mobx/mobx.dart';
part 'published_video_store.g.dart';

class PublishedVideoStore = _PublishedVideoStoreBase with _$PublishedVideoStore;

abstract class _PublishedVideoStoreBase with Store {
  int duration = 90;
  int viewer = 500;

  @observable
  int? totalCreditAmount;

  @action
  int setTotalCreditAmount() => totalCreditAmount = duration * viewer;
}

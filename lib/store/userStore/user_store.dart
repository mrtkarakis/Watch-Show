import 'package:firebase_auth/firebase_auth.dart';
import 'package:mobx/mobx.dart';
import 'package:watch_and_show/global.dart';
import 'package:watch_and_show/models/user.dart';
part 'user_store.g.dart';

class UserStore = _UserStoreBase with _$UserStore;

abstract class _UserStoreBase with Store {
  late User user;
  @action
  void setUser(User _user) => user = _user;

  @observable
  CurrentUser? signInData;

  @action
  void setSignInData({required String key, required dynamic value}) {
    Map<String, dynamic> a = signInData!.toMap();
    a[key] = value;
    signInData = CurrentUser.fromMap(a);
  }

  @observable
  CurrentUser? userData;

  @action
  void setUserData({required String key, required dynamic value}) {
    Map<String, dynamic> a = userData!.toMap();
    a[key] = value;
    userData = CurrentUser.fromMap(a);
  }

  int totalToken = 0;
  @action
  void addTotalToken(int _totalToken) => totalToken = totalToken + _totalToken;
  @action
  void clearTotalToken() => totalToken = 0;

  int? totalSteps = 0;
  @action
  void setTotalSteps(int? _totalSteps) => totalSteps = _totalSteps;

  Future<void> getUserData() async {
    // ignore: unnecessary_null_comparison
    if (user == null) {
      setUser(FirebaseAuth.instance.currentUser!);
    }
    try {
      await dbServices.usersDb.doc(user.uid).get().then((value) {
        if (value.data() != null) {
          userData = CurrentUser.fromMap(value as Map<String, dynamic>);
        }
      });
    } catch (e) {
      developerLog("", error: "$e", name: "getUserDataError");
    }
  }
}

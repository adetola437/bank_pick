

import 'package:shared_preferences/shared_preferences.dart';

import '../../constants/app_constants.dart';
import '../istorage.dart';

class SharedPreferenceImpl implements CacheStorage {

  Future<SharedPreferences> getPrefs() {
    return SharedPreferences.getInstance();
  }

  @override
  Future<bool> isLoggedIn() {
    return getPrefs()
        .then((value) => value.getBool(AppConstants.isLoggedIn) ?? false);
  }

  @override
  Future<void> setLoggedIn(bool status) {
    return getPrefs().then(
      (value) => value.setBool(AppConstants.isLoggedIn, status ),
    );
  }

  @override
  Future<bool> getFirstTime() {
    return getPrefs()
        .then((value) => value.getBool(AppConstants.firstTime) ?? true);
  }

  @override
  Future<bool> getSavingsFirstTime() {
    return getPrefs()
        .then((value) => value.getBool(AppConstants.savingsFirstTime) ?? true);
  }

  @override
  Future<bool> getOnboardingStatus() {
    return getPrefs()
        .then((value) => value.getBool(AppConstants.onboardingStatus) ?? false);
  }

  @override
  Future<void> setFirstTime() {
    return getPrefs().then(
      (value) => value.setBool(AppConstants.firstTime, false),
    );
  }

  @override
  Future<void> setSavingsFirstTime() {
    return getPrefs().then(
      (value) => value.setBool(AppConstants.savingsFirstTime, false),
    );
  }

  @override
  Future<void> setOnboardingStatus() {
    return getPrefs()
        .then((value) => value.setBool(AppConstants.onboardingStatus, true));
  }

   Future<void> setdisplayDetails(bool status) {
    return getPrefs().then(
      (value) => value.setBool('display_details', status ),
    );
  }

    Future<bool> getDisplayDetails() {
    return getPrefs()
        .then((value) => value.getBool('display_details') ?? false);
  }

}

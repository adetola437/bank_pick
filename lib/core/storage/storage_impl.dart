import 'istorage.dart';

class LocalStorageImpl implements LocalStorage{
  final DatabaseStorage databaseStorage;
  final CacheStorage cacheStorage;

  LocalStorageImpl({required this.databaseStorage, required this.cacheStorage});

  @override
  Future<List<String>> getAllSecurities() {
    return databaseStorage.getAllSecurities();
  }

  @override
  Future<bool> getFirstTime() {
    return cacheStorage.getFirstTime();
  }

  @override
  Future<bool> getOnboardingStatus() {
    return cacheStorage.getOnboardingStatus();
  }

  @override
  Future<bool> getSavingsFirstTime() {
    return cacheStorage.getSavingsFirstTime();
  }

  @override
  Future<bool> isLoggedIn() {
    return cacheStorage.isLoggedIn();
  }

  @override
  Future<void> setFirstTime() async {
    cacheStorage.setFirstTime();
  }

  @override
  Future<void> setLoggedIn(bool status) async {
    cacheStorage.setLoggedIn(status);
  }

  @override
  Future<void> setOnboardingStatus() async {
    cacheStorage.setOnboardingStatus();
  }

  @override
  Future<void> setSavingsFirstTime() async {
    cacheStorage.setSavingsFirstTime();
  }

}
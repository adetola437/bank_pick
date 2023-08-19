abstract class LocalStorage implements DatabaseStorage, CacheStorage{
  
  ///this function would be specific for cache only
  // Future<bool> isLoggedIn();
  // Future<void> setLoggedIn(bool status);
  // Future<void> setOnboardingStatus();
  // Future<bool> getOnboardingStatus();
  // Future<void> setFirstTime();
  // Future<bool> getFirstTime();
  // Future<void> setSavingsFirstTime();
  // Future<bool> getSavingsFirstTime();

  ///this function would be specific for database operations
 // Future<List<String>> getAllSecurities();
}

abstract class DatabaseStorage {
  ///this function would be specific for database operations
  Future<List<String>> getAllSecurities();
}

abstract class CacheStorage {
  ///this function would be specific for cache only
  Future<bool> isLoggedIn();
  Future<void> setLoggedIn(bool status);
  Future<void> setOnboardingStatus();
  Future<bool> getOnboardingStatus();
  Future<void> setFirstTime();
  Future<bool> getFirstTime();
  Future<void> setSavingsFirstTime();
  Future<bool> getSavingsFirstTime();
}

import '../network/error_handler.dart';
import '../response/response.dart';

const CACHE_HOME_KEY = "CACHE_HOME_KEY";
const CACHE_HOME_INTERVAL = 60 * 1000;

abstract class LocalDataSource {
  Future<HomeResponse> getHome();

  Future<DetailsResponse> getDetails();

  Future<void> saveCacheToHome(HomeResponse data);

  Future<void> saveCacheToDetails(DetailsResponse data);

  clearCache();

  removeFromCache(String key);
}

class LocalDataSourceImpl implements LocalDataSource {
  Map<String, CachedItem> cachMap = Map();

  @override
  Future<HomeResponse> getHome() async {
    CachedItem? casheditem = cachMap[CACHE_HOME_KEY];
    if (casheditem != null && casheditem.isValid(CACHE_HOME_INTERVAL)) {
      return casheditem.data;
    } else {
      throw ErrorHandler.handle(DataSource.CACHE_ERROR);
    }
  }

  @override
  Future<void> saveCacheToHome(HomeResponse data) async {
    cachMap[CACHE_HOME_KEY] = CachedItem(data);
  }

  @override
  Future<void> saveCacheToDetails(DetailsResponse data) async {
    cachMap[CACHE_HOME_KEY] = CachedItem(data);
  }



  @override
  clearCache() {
    cachMap.clear();
  }

  @override
  removeFromCache(String key) {
    cachMap.remove(key);
  }

  @override
  Future<DetailsResponse> getDetails() async {
    CachedItem? casheditem = cachMap[CACHE_HOME_KEY];
    if (casheditem != null && casheditem.isValid(CACHE_HOME_INTERVAL)) {
      return casheditem.data;
    } else {
      throw ErrorHandler.handle(DataSource.CACHE_ERROR);
    }
  }
}

class CachedItem {
  dynamic data;
  int cacheTime = DateTime.now().millisecondsSinceEpoch;

  CachedItem(this.data);
}

extension CachedItemExtension on CachedItem {
  bool isValid(int expirationTimeInMilliseconfs) {
    int currentTimeInMillisecond = DateTime.now().millisecondsSinceEpoch;
    bool isValid =
        currentTimeInMillisecond - cacheTime < expirationTimeInMilliseconfs;

    return isValid;
  }
}

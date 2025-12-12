import 'package:data/objectbox.g.dart';
import 'package:data/src/db/favorite/schema/schema.dart';

abstract interface class FavoriteInterface {
  Future<bool> clear();
  Future<bool> delete(int id);
  Future<List<Favorite>> query();
  Future<List<Favorite>> find(String name);
  Future<void> add(Favorite favorite);
}

class FavoriteCatDB implements FavoriteInterface {
  final Box<Favorite> _box;

  FavoriteCatDB({required Store store}) : _box = store.box<Favorite>();

  @override
  Future<List<Favorite>> query() async {
    try {
      return _box.getAll();
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<bool> delete(id) async {
    try {
      return _box.remove(id);
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<bool> clear() async {
    try {
      _box.removeAll();
      return true;
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<List<Favorite>> find(name) async {
    try {
      final Query<Favorite> query =
          _box.query(Favorite_.breedName.contains(name, caseSensitive: false)).build();
      List<Favorite> list = query.find();
      query.close();
      return list;
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<void> add(Favorite favorite) async {
    try {
      _box.put(favorite);
    } catch (e) {
      rethrow;
    }
  }
}

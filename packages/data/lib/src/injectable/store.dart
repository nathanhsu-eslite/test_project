import 'package:data/objectbox.g.dart';
import 'package:injectable/injectable.dart';

@module
abstract class RegisterModule {
  // 因為 Store 的初始化通常是 Future<Store>，所以使用 @preResolve
  @preResolve
  Future<Store> get store => openStore(); // 呼叫 ObjectBox 生成的 openStore()
}

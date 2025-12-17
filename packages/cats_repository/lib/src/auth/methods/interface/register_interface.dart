abstract interface class RegisterInterface {
  Future<void> handle({required String userName, required String password});
}

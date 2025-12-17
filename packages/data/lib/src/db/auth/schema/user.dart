import 'package:objectbox/objectbox.dart';

@Entity()
class UserEntity {
  @Id()
  int id = 0;
  @Unique()
  @Index()
  String username;
  String encryptedPassword;

  UserEntity({required this.encryptedPassword, required this.username});
}

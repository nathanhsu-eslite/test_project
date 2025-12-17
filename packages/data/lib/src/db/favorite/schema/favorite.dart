import 'package:objectbox/objectbox.dart';

@Entity(uid: 8734467388528399947)
class Favorite {
  @Id()
  int id = 0;
  @Unique()
  @Index()
  String imageId;
  String url;
  int urlHeight;
  int urlWidth;
  String breedName;
  Favorite({
    required this.imageId,
    required this.url,
    required this.urlHeight,
    required this.urlWidth,
    required this.breedName,
  });
}

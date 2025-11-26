// {
// "id": "a4j",
// "url": "https://cdn2.thecatapi.com/images/a4j.jpg",
// "width": 900,
// "height": 593
// }

class CatImage {

  final String id;
  final String url;
  final int width;
  final int height;

  CatImage(
      {required this.id, required this.url, required this.width, required this.height});

  factory CatImage.fromJson(Map<String, dynamic> json) {
    return CatImage(id: json["id"] as String,
      url: json["url"] as String,
      width: json["width"] as int,
      height: json["height"] as int,);
  }
}
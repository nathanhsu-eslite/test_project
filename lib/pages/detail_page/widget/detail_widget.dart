import 'package:flutter/material.dart';
import 'package:test_3_35_7/features/get_cat_detail/models/cat.dart';
import 'package:test_3_35_7/features/get_cat_images/models/my_image.dart';

class DetailWidget extends StatelessWidget {
  const DetailWidget({super.key, required this.image, required this.cat});
  final MyImage image;
  final Cat cat;
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,

            children: [
              const SizedBox(height: 8),
              Container(
                padding: EdgeInsets.all(8),
                width: 300,
                height: 300,

                decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey),
                  borderRadius: BorderRadius.circular(8.0),
                  image: DecorationImage(
                    image: NetworkImage(image.url),
                    fit: BoxFit.cover,
                  ),
                ),
              ),

              const SizedBox(height: 8),

              _listTile(
                title: 'Origin :',
                value: cat.origin,
                icon: Icons.location_on,
              ),
              const SizedBox(height: 8),

              _listTile(
                title: 'lifeSpan :',
                value: cat.lifeSpan,
                icon: Icons.timer,
              ),
              _listTile(
                title: 'temperament :',
                value: '',
                icon: Icons.favorite,
              ),
              Text(cat.temperament, maxLines: 3, style: TextStyle()),
              const SizedBox(height: 8),
              Container(
                padding: EdgeInsets.all(8),
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey),
                  borderRadius: BorderRadius.circular(8.0),
                ),
                child: Text(cat.description),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _listTile({
    required String title,
    required String value,
    required IconData icon,
  }) {
    return ListTile(
      leading: Icon(icon),
      title: Text(title, style: TextStyle(fontWeight: FontWeight.bold)),
      trailing: Text(value, style: TextStyle(fontWeight: FontWeight.bold)),
    );
  }
}

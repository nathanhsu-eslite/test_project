import 'package:flutter/material.dart';
import 'package:test_3_35_7/features/get_cat_detail/models/cat.dart';

class DetailProperty extends StatelessWidget {
  final Cat cat;
  const DetailProperty({super.key, required this.cat});

  @override
  Widget build(BuildContext context) {
    return Column(
      spacing: 0.5,
      children: [
        _listTile(
          title: 'Origin :',
          value: cat.origin,
          icon: Icons.location_on,
        ),
        const SizedBox(height: 8),

        _listTile(title: 'lifeSpan :', value: cat.lifeSpan, icon: Icons.timer),
        _listTile(title: 'temperament :', value: '', icon: Icons.favorite),

        Text(cat.temperament, maxLines: 3, style: TextStyle()),
      ],
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

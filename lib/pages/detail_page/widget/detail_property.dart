import 'package:flutter/material.dart';
import 'package:test_3_35_7/features/get_cat_detail/models/cat.dart';
import 'package:test_3_35_7/pages/detail_page/widget/list_tile.dart';

class DetailProperty extends StatelessWidget {
  final Cat cat;
  const DetailProperty({super.key, required this.cat});

  @override
  Widget build(BuildContext context) {
    return Column(
      spacing: 0.5,
      children: [
        DetailListTile(
          title: 'Origin :',
          value: cat.origin,
          icon: Icons.location_on,
        ),
        const SizedBox(height: 8),

        DetailListTile(
          title: 'lifeSpan :',
          value: cat.lifeSpan,
          icon: Icons.timer,
        ),
        DetailListTile(title: 'temperament :', value: '', icon: Icons.favorite),

        Text(cat.temperament, maxLines: 3, style: TextStyle()),
      ],
    );
  }
}

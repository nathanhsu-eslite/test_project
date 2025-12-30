import 'package:flutter/material.dart';

class DetailListTile extends StatelessWidget {
  final String title;
  final String value;
  final IconData icon;
  const DetailListTile({
    super.key,
    required this.title,
    required this.value,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Icon(icon),
      title: Text(title, style: TextStyle(fontWeight: FontWeight.bold)),
      trailing: Text(value, style: TextStyle(fontWeight: FontWeight.bold)),
    );
  }
}

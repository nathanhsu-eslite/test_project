import 'package:flutter/material.dart';
import 'package:test_3_35_7/pages/preference_form_page/widget/preference_form.dart';

class PreferenceFormPage extends StatelessWidget {
  const PreferenceFormPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Cat Breed Matcher')),
      body: const Padding(
        padding: EdgeInsets.all(16.0),
        child: PreferenceForm(),
      ),
    );
  }
}

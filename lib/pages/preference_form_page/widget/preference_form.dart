import 'package:cats_repository/cats_repository.dart';
import 'package:flutter/material.dart';
import 'package:test_3_35_7/pages/preference_form_page/widget/preference_slider.dart';
import 'package:test_3_35_7/routes/preference_form_route.dart';

class PreferenceForm extends StatefulWidget {
  const PreferenceForm({super.key});

  @override
  State<PreferenceForm> createState() => PreferenceFormState();
}

class PreferenceFormState extends State<PreferenceForm> {
  final Map<String, double> _preferences = {
    'Desired Energy Level': 3,
    'Desired Affection Level': 3,
    'Desired Child Friendly': 3,
    'Desired Stranger Friendly': 3,
    'Desired Grooming': 3,
    'Desired Dog Friendly': 3,
    'Desired Social Needs': 3,
  };

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          ..._preferences.keys.map((label) {
            return PreferenceSlider(
              label: label,
              value: _preferences[label]!,
              onChanged: (value) {
                setState(() {
                  _preferences[label] = value;
                });
              },
            );
          }),
          const SizedBox(height: 32),
          ElevatedButton(
            onPressed: () {
              final userPreference = UserPreference(
                desiredEnergyLevel: _preferences['Desired Energy Level']!
                    .toInt(),
                desiredAffectionLevel: _preferences['Desired Affection Level']!
                    .toInt(),
                desiredChildFriendly: _preferences['Desired Child Friendly']!
                    .toInt(),
                desiredStrangerFriendly:
                    _preferences['Desired Stranger Friendly']!.toInt(),
                desiredGrooming: _preferences['Desired Grooming']!.toInt(),
                desiredDogFriendly: _preferences['Desired Dog Friendly']!
                    .toInt(),
                desiredSocialNeeds: _preferences['Desired Social Needs']!
                    .toInt(),
              );
              MatchRoute(userPreference).push(context);
            },
            child: const Text('Find My Match'),
          ),
        ],
      ),
    );
  }
}

import 'package:flutter/material.dart';

import 'package:cats_repository/cats_repository.dart';
import 'package:test_3_35_7/routes/preference_form_route.dart';

class PreferenceFormPage extends StatefulWidget {
  const PreferenceFormPage({super.key});

  @override
  State<PreferenceFormPage> createState() => _PreferenceFormPageState();
}

class _PreferenceFormPageState extends State<PreferenceFormPage> {
  double _desiredEnergyLevel = 3;
  double _desiredAffectionLevel = 3;
  double _desiredChildFriendly = 3;
  double _desiredStrangerFriendly = 3;
  double _desiredGrooming = 3;
  double _desiredDogFriendly = 3;
  double _desiredSocialNeeds = 3;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Cat Breed Matcher')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          // Added SingleChildScrollView
          child: Column(
            children: [
              _buildSlider(
                label: 'Desired Energy Level',
                value: _desiredEnergyLevel,
                onChanged: (value) {
                  setState(() {
                    _desiredEnergyLevel = value;
                  });
                },
              ),
              _buildSlider(
                label: 'Desired Affection Level',
                value: _desiredAffectionLevel,
                onChanged: (value) {
                  setState(() {
                    _desiredAffectionLevel = value;
                  });
                },
              ),
              _buildSlider(
                label: 'Desired Child Friendly',
                value: _desiredChildFriendly,
                onChanged: (value) {
                  setState(() {
                    _desiredChildFriendly = value;
                  });
                },
              ),
              _buildSlider(
                label: 'Desired Stranger Friendly',
                value: _desiredStrangerFriendly,
                onChanged: (value) {
                  setState(() {
                    _desiredStrangerFriendly = value;
                  });
                },
              ),
              _buildSlider(
                label: 'Desired Grooming',
                value: _desiredGrooming,
                onChanged: (value) {
                  setState(() {
                    _desiredGrooming = value;
                  });
                },
              ),
              _buildSlider(
                label: 'Desired Dog Friendly',
                value: _desiredDogFriendly,
                onChanged: (value) {
                  setState(() {
                    _desiredDogFriendly = value;
                  });
                },
              ),
              _buildSlider(
                label: 'Desired Social Needs',
                value: _desiredSocialNeeds,
                onChanged: (value) {
                  setState(() {
                    _desiredSocialNeeds = value;
                  });
                },
              ),
              const SizedBox(height: 32),
              ElevatedButton(
                onPressed: () {
                  final userPreference = UserPreference(
                    desiredEnergyLevel: _desiredEnergyLevel.toInt(),
                    desiredAffectionLevel: _desiredAffectionLevel.toInt(),
                    desiredChildFriendly: _desiredChildFriendly.toInt(),
                    desiredStrangerFriendly: _desiredStrangerFriendly.toInt(),
                    desiredGrooming: _desiredGrooming.toInt(),
                    desiredDogFriendly: _desiredDogFriendly.toInt(),
                    desiredSocialNeeds: _desiredSocialNeeds.toInt(),
                  );
                  MatchRoute(userPreference).push(context);
                },
                child: const Text('Find My Match'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSlider({
    required String label,
    required double value,
    required ValueChanged<double> onChanged,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label),
        Slider(
          value: value,
          min: 1,
          max: 5,
          divisions: 4,
          label: value.round().toString(),
          onChanged: onChanged,
        ),
      ],
    );
  }
}

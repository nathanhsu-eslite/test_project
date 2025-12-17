import 'package:equatable/equatable.dart';

class UserPreference extends Equatable {
  final int desiredEnergyLevel; // 1-5
  final int desiredAffectionLevel; // 1-5
  final int desiredChildFriendly; // 1-5
  final int desiredStrangerFriendly;
  final int desiredGrooming; // 1-5
  final int desiredDogFriendly; // 1-5
  final int desiredSocialNeeds; //1-5

  const UserPreference({
    required this.desiredStrangerFriendly,
    required this.desiredDogFriendly,
    required this.desiredSocialNeeds,
    required this.desiredEnergyLevel,
    required this.desiredAffectionLevel,
    required this.desiredChildFriendly,
    required this.desiredGrooming,
  });

  @override
  List<Object?> get props => [
    desiredEnergyLevel,
    desiredAffectionLevel,
    desiredChildFriendly,
    desiredStrangerFriendly,
    desiredGrooming,
    desiredDogFriendly,
    desiredSocialNeeds,
  ];
}

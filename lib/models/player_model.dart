class PlayerModel {
  final String name;
  final String email;
  final String phone;
  final String sport;
  final String position;
  final int age;
  final double height;
  final double weight;
  final int score;
  final String image;
  final String club;
  final int experienceYears;
  final int violationsCount;
  final bool isBlocked;
  
  PlayerModel({
    required this.name,
    required this.email,
    required this.phone,
    required this.sport,
    required this.position,
    required this.age,
    required this.height,
    required this.weight,
    required this.score,
    required this.image,
    required this.club,
    required this.experienceYears,
    this.violationsCount = 0, 
    this.isBlocked = false,
  });
  PlayerModel copyWith({
    int? violationsCount,
    bool? isBlocked,
  }) {
    return PlayerModel(
      name: name,
      email: email,
      phone: phone,
      sport: sport,
      position: position,
      age: age,
      height: height,
      weight: weight,
      score: score,
      image: image,
      club: club,
      experienceYears: experienceYears,
      violationsCount: violationsCount ?? this.violationsCount,
      isBlocked: isBlocked ?? this.isBlocked,
    );
  }
}

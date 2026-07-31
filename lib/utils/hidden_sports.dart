class HiddenSportsConfig {
  static const Set<String> hiddenSports = {'Volleyball'};

  static bool isHidden(String sportName) => hiddenSports.contains(sportName);
}

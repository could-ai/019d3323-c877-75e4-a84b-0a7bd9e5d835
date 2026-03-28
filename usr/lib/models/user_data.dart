class UserData {
  String name;
  int xp;
  int streak;
  String level;
  int hearts;

  UserData({
    this.name = '',
    this.xp = 0,
    this.streak = 0,
    this.level = 'Basic',
    this.hearts = 5,
  });

  static final UserData _instance = UserData._internal();
  factory UserData.shared() => _instance;
  UserData._internal();
}

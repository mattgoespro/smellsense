class Feeling {
  String? name;
  String? emoji;

  Feeling({this.emoji});

  static final List<Feeling> feelings = [
    Feeling(emoji: 'assets/svg/emojis/angry.svg'),
    Feeling(emoji: 'assets/svg/emojis/nauseated.svg'),
    Feeling(emoji: 'assets/svg/emojis/frown.svg'),
    Feeling(emoji: 'assets/svg/emojis/neutral.svg'),
    Feeling(emoji: 'assets/svg/emojis/smile.svg'),
    Feeling(emoji: 'assets/svg/emojis/big_smile.svg'),
  ];
}

class Feeling {
  String name;
  String emoji;

  Feeling({this.emoji});

  static final List<Feeling> feelings = [
    Feeling(emoji: 'assets/images/emojis/angry.svg'),
    Feeling(emoji: 'assets/images/emojis/nauseated.svg'),
    Feeling(emoji: 'assets/images/emojis/frown.svg'),
    Feeling(emoji: 'assets/images/emojis/neutral.svg'),
    Feeling(emoji: 'assets/images/emojis/smile.svg'),
    Feeling(emoji: 'assets/images/emojis/big_smile.svg'),
  ];
}

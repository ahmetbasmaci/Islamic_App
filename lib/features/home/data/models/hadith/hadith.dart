class Hadith {
  final int hadithId;
  final String text;
  final String sanad;

  Hadith({
    required this.hadithId,
    required this.text,
    required this.sanad,
  });

  Hadith.empty({
    this.hadithId = 0,
    this.text = '',
    this.sanad = '',
  });

  factory Hadith.fromJson(dynamic json) {
    print('----$json');
    return Hadith(
      hadithId: int.parse(json['hadithId']),
      text: json['text'],
      sanad: json['sanad'],
    );
  }
}

class Pokemon {
  final int nummer;
  final String name;
  final String type1;
  final String type2;

  Pokemon({
    required this.nummer,
    required this.name,
    required this.type1,
    required this.type2,
  });

  factory Pokemon.fromJson(Map<String, dynamic> json) {
    return Pokemon(
      nummer: int.parse(json['nummer'].toString()),
      name: json['name'],
      type1: json['type1'],
      type2: json['type2'],
    );
  }

  String get imageUrl =>
      "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/$nummer.png";
}
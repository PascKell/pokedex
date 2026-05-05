import 'package:flutter/material.dart';

class DetailPage extends StatelessWidget {
  final dynamic pokemon;
  const DetailPage({super.key, required this.pokemon});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(pokemon['name']),
      ),
      body: Column(
        children: [
          SizedBox(
            height: 20,
          ),
          Hero(
            tag: "pokemon_${pokemon['nummer']}",
            child: Image.network(
              "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/${pokemon['nummer']}.png",
              width: 150,
              height: 150,
            ),
          ),
          SizedBox(
            height: 20,
          ),
          Text(
            pokemon['name'],
            style: TextStyle(
              fontSize: 28,
              fontWeight: FontWeight.bold,
            ),
          ),
          Text(
            "#${pokemon['nummer']}",
            style: TextStyle(
              fontSize: 18
            ),
          ),
          SizedBox(
            height: 20,
          ),
          Text(
            "Typ: ${pokemon['type1']} ${pokemon['type2'] ?? ''}",
          )
        ],
      ),
    );
  }
}

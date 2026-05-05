import 'package:flutter/material.dart';

class DetailPage extends StatelessWidget {
  final dynamic pokemon;
  final Color color1;

  const DetailPage({
    super.key,
    required this.pokemon,
    required this.color1
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: Text(
            pokemon['name'],
          style: TextStyle(
            color: Colors.white
          ),
        ),
        backgroundColor: Colors.black12,
      ),
      body: Center(
        child: Container(
          width: MediaQuery.of(context).size.width - 20,
          color: color1,
          child: Column(
            children: [
              SizedBox(
                height: 20,
              ),
              Hero(
                tag: "pokemon_${pokemon['nummer']}",
                child: Image.network(
                  "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/${pokemon['nummer']}.png",
                  width: MediaQuery.of(context).size.width,
                  height: 100,
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
        ),
      )
    );
  }
}

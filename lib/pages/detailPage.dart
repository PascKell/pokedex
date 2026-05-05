import 'package:flutter/material.dart';
import 'package:project_app/assets/pokemonColor.dart' as pokemon_color;

class DetailPage extends StatelessWidget {
  final dynamic pokemon;
  final Color color1;

  const DetailPage({
    super.key,
    required this.pokemon,
    required this.color1,
  });

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: pokemon_color.detailTypeGradient(
            pokemon['type1'],
            pokemon['type2']
          ),
        ),
        child: SafeArea(
          child: Stack(
            children: [
              Positioned(
                top: 10,
                left: 10,
                child: IconButton(
                  icon: Icon(Icons.arrow_back, color: Colors.white),
                  onPressed: () => Navigator.pop(context),
                ),
              ),
              Column(
                children: [
                  SizedBox(height: 40),

                  Text(
                    pokemon['name'],
                    style: TextStyle(
                      fontSize: 32,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),

                  Text(
                    "#${pokemon['nummer']}",
                    style: TextStyle(color: Colors.white70),
                  ),

                  SizedBox(height: 20),

                  Hero(
                    tag: "pokemon_${pokemon['nummer']}",
                    child: Image.network(
                      "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/${pokemon['nummer']}.png",
                      width: 180,
                      height: 180,
                    ),
                  ),

                  SizedBox(height: 30),

                  Expanded(
                    child: Container(
                      width: double.infinity,
                      padding: EdgeInsets.all(20),
                      decoration: BoxDecoration(
                        color: Colors.black38,
                        borderRadius: BorderRadius.vertical(
                          top: Radius.circular(30),
                        ),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              buildTypeChip(pokemon['type1']),
                              SizedBox(width: 10),
                              if (pokemon['type2'] != null)
                                buildTypeChip(pokemon['type2']),
                            ],
                          ),
                          SizedBox(height: 20),
                          Text(
                            "Pokémon Details",
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: Colors.white
                            ),
                          ),

                          SizedBox(height: 10),

                          Text(
                            "Nummer: ${pokemon['nummer']}",
                            style: TextStyle(
                              color: Colors.white
                            ),
                          ),
                          Text(
                            "Name: ${pokemon['name']}",
                            style: TextStyle(
                              color: Colors.white
                            ),
                          ),

                          SizedBox(height: 20),

                          Text(
                            "Weitere Infos folgen...",
                            style: TextStyle(color: Colors.grey),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildTypeChip(String type) {
    final color = pokemon_color.typeColor(type);

    return Container(
      padding: EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Text(
        type,
        style: TextStyle(color: Colors.white),
      ),
    );
  }
}
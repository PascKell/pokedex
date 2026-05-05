import 'package:flutter/material.dart';

import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:project_app/pages/detailPage.dart';

import 'package:project_app/assets/pokemonColor.dart' as pokemonColor;

Future<List<dynamic>> fetchPokemon() async {
  final response = await http.get(
    Uri.parse('https://pakeller.de/getPokedex.php'),
  );

  if (response.statusCode == 200) {
    print("Daten wurden erfolgreich geladen");
    print(response.body.toString());
    return json.decode(response.body);
  } else {
    throw Exception('Fehler beim Laden');
  }
}

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: Text(
            'Pokédex',
          style: TextStyle(
            color: Colors.white
          ),
        ),
        backgroundColor: Colors.black12,
      ),
      body: FutureBuilder<List<dynamic>>(
        future: fetchPokemon(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }

          if (snapshot.hasError) {
            return Center(child: Text('Fehler: ${snapshot.error}'));
          }

          final data = snapshot.data!;

          return ListView.builder(
            itemCount: data.length,
            itemBuilder: (context, index) {
              final pokemon = data[index];
              return GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (_) => DetailPage(pokemon: pokemon, color1: pokemonColor.typeColor(pokemon['type1']),)
                    )
                  );
                },
                child: Container(
                    margin: EdgeInsets.symmetric(vertical: 4, horizontal: 8),
                    padding: EdgeInsets.all(5),
                    decoration: BoxDecoration(
                      gradient: pokemonColor.typeGradient(
                          pokemon['type1'],
                          pokemon['type2']
                      ),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              pokemon['name'],
                              style: TextStyle(color: Colors.white, fontSize: 18),
                            ),
                            Text(
                              "#${pokemon['nummer']}",
                              style: TextStyle(color: Colors.white70),
                            ),
                          ],
                        ),
                        Hero(
                          tag: "pokemon_${pokemon['nummer']}",
                          child: Image.network(
                            "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/${pokemon['nummer']}.png",
                            width: 70,
                            height: 70,
                          ),
                        ),
                      ],
                    ),
                )
              );
            },
          );
        },
      ),
    );
  }
}
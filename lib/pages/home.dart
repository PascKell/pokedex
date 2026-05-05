import 'package:flutter/material.dart';

import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:project_app/pages/detailPage.dart';

import 'package:project_app/assets/pokemonColor.dart' as pokemon_color;

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

  List<dynamic> allPokemon = [];
  List<dynamic> filteredPokemon = [];
  bool isLoaded = false;
  String searchText = "";

  @override
  void initState() {
    super.initState();
    loadData();
  }

  Future<void> loadData() async {
    final data = await fetchPokemon();

    setState(() {
      allPokemon = data;
      filteredPokemon = data;
      isLoaded = true;
    });
  }

  void filterPokemon(String query) {
    setState(() {
      searchText = query;

      filteredPokemon = allPokemon.where((pokemon) {
        final name = pokemon['name'].toLowerCase();
        final nummer = pokemon['nummer'].toString();

        return name.contains(query.toLowerCase()) || nummer.contains(query);
      }).toList();
    });
  }

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
      body: !isLoaded
          ? Center(child: CircularProgressIndicator())
          : Column(
        children: [
          Padding(
            padding: EdgeInsets.all(8),
            child: TextField(
              style: TextStyle(color: Colors.white),
              decoration: InputDecoration(
                suffixIcon: IconButton(
                  icon: Icon(
                    Icons.clear,
                    color: Colors.white,
                  ),
                  onPressed: () {
                    filterPokemon("");
                  },
                ),
                hintText: "Pokémon suchen...",
                hintStyle: TextStyle(color: Colors.white54),
                prefixIcon: Icon(Icons.search, color: Colors.white),
                filled: true,
                fillColor: Colors.white10,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              onChanged: filterPokemon,
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: filteredPokemon.length,
              itemBuilder: (context, index) {
                final pokemon = filteredPokemon[index];

                return GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => DetailPage(
                          pokemon: pokemon,
                          color1: pokemon_color.typeColor(pokemon['type1']),
                        ),
                      ),
                    );
                  },
                  child: Container(
                    margin: EdgeInsets.symmetric(vertical: 4, horizontal: 8),
                    padding: EdgeInsets.all(5),
                    decoration: BoxDecoration(
                      gradient: pokemon_color.typeGradient(
                        pokemon['type1'],
                        pokemon['type2'],
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
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
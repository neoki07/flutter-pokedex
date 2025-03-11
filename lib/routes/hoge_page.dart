import 'package:auto_route/auto_route.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_pokedex/app_router.gr.dart';

@RoutePage()
class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<dynamic> _pokemons = [];
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _fetchPokemons();
  }

  Future<void> _fetchPokemons() async {
    try {
      final response = await Dio().get(
        "https://pokeapi.co/api/v2/pokemon?limit=9",
      );
      setState(() {
        _pokemons = response.data['results'];
        _isLoading = false;
      });
    } catch (e) {
      print('Error fetching Pokémon: $e');
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Home")),
      body:
          _isLoading
              ? Center(child: const CircularProgressIndicator())
              : ListView.builder(
                itemCount: _pokemons.length,
                itemBuilder: (_, index) {
                  final pokemon = _pokemons[index];
                  return ListTile(
                    title: Text(pokemon['name']),
                    onTap: () {
                      context.router.push(
                        PokemonDetailRoute(pokemonName: pokemon['name']),
                      );
                    },
                  );
                },
              ),
    );
  }
}

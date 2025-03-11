import 'package:auto_route/annotations.dart';
import 'package:flutter/material.dart';

@RoutePage()
class PokemonDetailPage extends StatelessWidget {
  const PokemonDetailPage({super.key, required this.pokemonName});

  final String pokemonName;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(pokemonName)),
      body: Center(child: Text('Detail of $pokemonName')),
    );
  }
}

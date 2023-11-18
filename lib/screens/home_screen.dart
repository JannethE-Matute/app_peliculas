
import 'package:apppeliculas_p63/providers/movies_provider.dart';
import 'package:apppeliculas_p63/search/search_delegate.dart';
import 'package:apppeliculas_p63/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final moviesProvider = Provider.of<MoviesProvider>(context);
    //print(moviesProvider.onDisplayMovies);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Peliculas en Cines'),
        elevation: 0,
        actions: [
          IconButton(
            onPressed: () =>showSearch(context: context, delegate: MovieSearchDelegate()), 
            icon: const Icon(Icons.search_outlined))
        ],
      ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              CardSwiper(movies:moviesProvider.onDisplayMovies),
              MovieSlider(
                movies: moviesProvider.popularMovies,
                title: 'POPULARES',
                onNextPage: () => moviesProvider.getPopularMovies(),
                ),
              ],
          ),
        ));
  }
}
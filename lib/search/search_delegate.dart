import 'package:apppeliculas_p63/Models/models.dart';
import 'package:apppeliculas_p63/providers/movies_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class MovieSearchDelegate extends SearchDelegate {
  List<Movie> moviesAll = [];
  @override
  // TODO: implement searchFieldLabel
  String? get searchFieldLabel => 'Buscar Pelicula-p63';

  @override
  List<Widget>? buildActions(BuildContext context) {
    return [
      IconButton(
        onPressed: () {
          query = '';
        }, 
        icon: const Icon(Icons.clear))
    ];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    // TODO: implement buildLeading
    return Text('Estoy en Build-Leading');
  }

  @override
  Widget buildResults(BuildContext context) {
    if (moviesAll.isEmpty) {
      return _emptyContainer();
    }
    return ListView.builder(
      itemCount: moviesAll.length,
      itemBuilder: (_, index) => _MovieItem(moviesAll[index]));
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    if (query.isEmpty) {
      return _emptyContainer();
    }
    final moviesProvider = Provider.of<MoviesProvider>(context, listen: false);
    return FutureBuilder(
      future: moviesProvider.searchMovies(query), 
      builder: (_, AsyncSnapshot<List<Movie>> snapshot) {
        if (!snapshot.hasData) {
          return _emptyContainer();
        }
        final movies = snapshot.data!;
        moviesAll = movies;
        return ListView.builder(
          itemCount: movies.length,
          itemBuilder: ((_, index) => _MovieItem(movies[index])));
      },
      );
  }

}

Widget _emptyContainer() {
  return const Center(
    child: Icon(
      Icons.movie_creation_outlined,
      color: Colors.black38, 
      size: 130,
      ),
    );
}

class _MovieItem extends StatelessWidget {
  final Movie movie;
  const _MovieItem(this.movie);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: FadeInImage(
        placeholder: const AssetImage('lib/assets/no-image.jpg'),
        image: NetworkImage(movie.FullPosterImg),
        width: 50,
        fit: BoxFit.contain,
      ),
      title: Text(movie.title),
      subtitle: Text(movie.originalTitle),
      onTap: (() {
        Navigator.pushNamed(context, 'details', arguments: movie);
      }),
    );
  }
}
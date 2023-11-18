import 'package:apppeliculas_p63/Models/models.dart';
import 'package:apppeliculas_p63/widgets/widgets.dart';
import 'package:flutter/material.dart';

class DetailsScreen extends StatelessWidget {
  const DetailsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    //final String movie = ModalRoute.of(context)?.settings.arguments.toString() ?? 'sin-pelicula';
    final Movie movie = ModalRoute.of(context)!.settings.arguments as Movie;
    return Scaffold(
        body: CustomScrollView(
          slivers: [
            _ClienteAppBar(movie),
            SliverList(
              delegate: SliverChildListDelegate([
                _PoserYTitulo(movie),
                _Overview(movie),
                _Overview(movie),
                _Overview(movie),
                CastingCards(movie.id)
              ]))
          ], 
    ));
  }
}

class _ClienteAppBar extends StatelessWidget {
  final Movie movie;
  const _ClienteAppBar(this.movie);

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      backgroundColor: Colors.indigo,
      expandedHeight: 200,
      floating: false,
      pinned: true,
      flexibleSpace: FlexibleSpaceBar(
        centerTitle: true,
        titlePadding: const EdgeInsets.all(0),
        title: Container(
          width: double.infinity,
          alignment: Alignment.bottomCenter,
          color: Colors.black12,
          padding: const EdgeInsets.only(bottom: 10, left: 10, right: 10),
          child: Text(movie.title, 
              style: const TextStyle(fontSize: 16))),
        background: FadeInImage(
          placeholder: const AssetImage('lib/assets/loading.gif'), 
          image: NetworkImage(movie.fullBackdropPath),
          fit: BoxFit.cover),
      ),
    );
  }
}

class _PoserYTitulo extends StatelessWidget {
  final Movie movie;
  const _PoserYTitulo(this.movie);

  @override
  Widget build(BuildContext context) {
    final textTheme= Theme.of(context).textTheme;
    final size = MediaQuery.of(context).size;
    return Container(
      margin: const EdgeInsets.only(top: 20),
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Row(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(20),
            child: FadeInImage(
              placeholder: const AssetImage('lib/assets/no-image.jpg'), 
              image: NetworkImage(movie.FullPosterImg),
              height: 150
            )),
            const SizedBox(width: 20,),
        ConstrainedBox(
          constraints: BoxConstraints(maxWidth: size.width-190),
          child: Column(
            children: [
              Text(
                movie.title,
                style: textTheme.headline6,
                overflow: TextOverflow.ellipsis,
                maxLines: 2,
                ),
              Text(
                movie.originalTitle,
                style: textTheme.headline6,
                overflow: TextOverflow.ellipsis,
                maxLines: 2,
                ),
                Row(
                  children: [
                    const Icon(Icons.star_outline, size: 15, color: Colors.grey),
                    const SizedBox(width: 5),
                    Text(
                      '${movie.voteAverage}', 
                    style: textTheme.caption,
                    )
                  ],
                )
            ],
          ),
        )
      ]),
    );
  }
}

class _Overview extends StatelessWidget {
  final Movie movie;
  const _Overview(this.movie);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 10),
      child: Text(
        movie.overview,
      textAlign: TextAlign.justify,
      style: Theme.of(context).textTheme.subtitle1,),
    );
  }
}

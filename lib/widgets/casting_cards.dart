import 'package:apppeliculas_p63/Models/models.dart';
import 'package:apppeliculas_p63/providers/movies_provider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CastingCards extends StatelessWidget {
  final int movieId;

  const CastingCards(this.movieId, {super.key});

  @override
  Widget build(BuildContext context) {
    final moviesProvider = Provider.of<MoviesProvider>(
      context, listen: false
    );
    return FutureBuilder(
      future: moviesProvider.getMovieCast(movieId), 
      builder: ((context, AsyncSnapshot snapshot) {
        if (!snapshot.hasData) {
          return Container(
            constraints: const BoxConstraints(maxWidth: 150),
            height: 180,
            child: const CupertinoActivityIndicator());
        }
        final List<Cast> cast = snapshot.data! as List<Cast>;
        return Container(
          margin: const EdgeInsets.only(bottom: 30),
          width: double.infinity,
          height: 180,
          //color: Colors.redAccent,
          child: ListView.builder(
            itemCount: cast.length,
            scrollDirection: Axis.horizontal,
            itemBuilder: (_, int index) => _CastCard(cast[index])));
      }));
  }
}

class _CastCard extends StatelessWidget {
  final Cast actor;
  const _CastCard(this.actor, {super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 10),
      width: 110,
      height: 100,
      //color: Colors.blueAccent,
      child: Column(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(20),
            child: FadeInImage(
              placeholder: const AssetImage('lib/assets/no-image.jpg'),
              image: NetworkImage(actor.fullProfilePath),
              height: 120,
              width: 100,
              fit: BoxFit.cover)),
          const SizedBox(height: 5),
          Text(
            actor.name,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            textAlign: TextAlign.center,
          )
        ]),
    );
  }
}
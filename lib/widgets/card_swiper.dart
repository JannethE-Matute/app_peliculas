import 'package:apppeliculas_p63/Models/movie.dart';
import 'package:card_swiper/card_swiper.dart';
import 'package:flutter/material.dart';

class CardSwiper extends StatelessWidget {
  final List<Movie> movies;
  const CardSwiper({Key? key, required this.movies}):super(key: key);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    if (movies.isEmpty) {
      return Container(
        width: double.infinity,
        height: size.height * 0.5,
        child: const Center(child: CircularProgressIndicator()),
      );
    }
    return Container(
      width: double.infinity,
      height: size.height*0.5,
      //color: Colors.red,
      child: Swiper(
        itemCount: movies.length,
        layout: SwiperLayout.STACK,
        itemWidth: size.width*0.60,
        itemHeight: size.height*0.90,
        itemBuilder: (context, index) {
          final movie = movies[index];
          //print(movie.posterPath);
          return GestureDetector(
            onTap: ()=>Navigator.pushNamed(context, 'details',
              arguments: movie),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(25),
              child: FadeInImage(
                placeholder: const AssetImage('lib/assets/no-image.jpg'), 
                image: NetworkImage(movie.FullPosterImg),
                fit: BoxFit.cover),
            ),
          );
        },
      ),
    );
  }
}
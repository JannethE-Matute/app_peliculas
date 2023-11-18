import 'package:apppeliculas_p63/Models/movie.dart';
import 'package:flutter/material.dart';

class MovieSlider extends StatefulWidget {
  final List<Movie> movies;
  final String? title;
  final Function onNextPage;

  const MovieSlider(
      {super.key, required this.movies, required this.onNextPage, this.title});

  @override
  State<MovieSlider> createState() => _MovieSliderState();
}

class _MovieSliderState extends State<MovieSlider> {
  final ScrollController scrollController = new ScrollController();

  @override
  void initState() {
    super.initState();
    scrollController.addListener(() {
      if(scrollController.position.pixels>=scrollController.position.maxScrollExtent){
        widget.onNextPage();
      }
      //print(scrollController.position.pixels);
      //print(scrollController.position.maxScrollExtent);
    });
  }

  @override
  void dispose(){
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 260,
      //color: Colors.red,
      child: Column(children: [
        if(widget.title!=null)
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Text('P63-${widget.title!}', 
              style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold))),
          Expanded(
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: widget.movies.length,
              controller: scrollController,
              itemBuilder: (BuildContext context, int index) => 
              _PeliculaPoster( widget.movies[index])),
          )
      ]),  
    );
  }
}

class _PeliculaPoster extends StatelessWidget {
  final Movie movie;

  const _PeliculaPoster(this.movie);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          GestureDetector(
            child: ClipRRect(
              borderRadius: BorderRadius.circular(20),
              child: FadeInImage(
                placeholder: const AssetImage('lib/assets/no-image.jpg'),
                image: NetworkImage(movie.FullPosterImg),
                width: 130,
                height: 190,
                fit: BoxFit.cover),
            ),
            onTap: () => Navigator.pushNamed(context, 'details',
            arguments: movie),
          ),
          const SizedBox(height: 10),
            Text(
              movie.title,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              textAlign: TextAlign.center,
            )
        ],
      ),
      width: 130,
      height: 200,
      margin: const EdgeInsets.symmetric(horizontal: 20));
  }
}
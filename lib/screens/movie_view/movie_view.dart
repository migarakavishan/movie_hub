import 'package:flutter/material.dart';
import 'package:movie_hub/models/movie_model.dart';
import 'package:movie_hub/services/api_service.dart';

class MovieView extends StatefulWidget {
  const MovieView({super.key, required this.movie});

  final MovieModel movie;

  @override
  State<MovieView> createState() => _MovieViewState();
}

class _MovieViewState extends State<MovieView> {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.sizeOf(context);
    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: size.width,
              height: size.height * 0.25,
              decoration: BoxDecoration(
                  color: Colors.grey.shade900,
                  image: DecorationImage(
                      fit: BoxFit.cover,
                      image: NetworkImage(widget.movie.backdropPath))),
              child: Stack(
                children: [
                  Positioned(
                      top: 8,
                      left: 8,
                      child: BackButton(
                        color: Colors.white,
                        style: ButtonStyle(
                            backgroundColor: MaterialStatePropertyAll(
                                Colors.black.withOpacity(0.5))),
                      )),
                ],
              ),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  widget.movie.title,
                  style: TextStyle(
                      color: Colors.grey.shade300,
                      fontSize: 20,
                      fontWeight: FontWeight.bold),
                ),
                FutureBuilder(
                  future: ApiServices().getMovieDetails(widget.movie.id),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {}
                    if (snapshot.hasData) {
                      MovieModel? movie = snapshot.data;
                      return movie!.tagline != null
                          ? Text(
                              movie.tagline!,
                              style: const TextStyle(
                                  color: Colors.grey,
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold),
                            )
                          : const SizedBox();
                    }
                    return const SizedBox();
                  },
                ),
                const SizedBox(height: 10),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                      child: Image.network(
                        widget.movie.posterPath,
                        fit: BoxFit.cover,
                        width: 110,
                        height: 170,
                      ),
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    Expanded(
                        child: Text(
                      widget.movie.overview,
                      textAlign: TextAlign.justify,
                      style:
                          TextStyle(color: Colors.grey.shade400, fontSize: 12),
                    ))
                  ],
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}

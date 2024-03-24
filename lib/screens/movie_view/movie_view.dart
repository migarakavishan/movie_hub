import 'package:flutter/material.dart';
import 'package:movie_hub/models/actor_model.dart';
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
        child: FutureBuilder(
            future: ApiServices().getMovieDetails(widget.movie.id),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }
              if (snapshot.hasError) {
                return const Center(
                  child: Text(
                    "Something went wrong",
                    style: TextStyle(color: Colors.white),
                  ),
                );
              }
              MovieModel? movie = snapshot.data;
              return SingleChildScrollView(
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
                        Text(
                          movie!.tagline!,
                          style: const TextStyle(
                              color: Colors.grey,
                              fontSize: 16,
                              fontWeight: FontWeight.bold),
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
                              style: TextStyle(
                                  color: Colors.grey.shade400, fontSize: 12),
                            ))
                          ],
                        ),
                        const SizedBox(
                          height: 8,
                        ),
                        const Text(
                          "Production Companies",
                          style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.w600,
                              fontSize: 18),
                        ),
                        const Divider(),
                        Column(
                          children: List.generate(
                            movie.companies!.length,
                            (index) {
                              return Padding(
                                padding:
                                    const EdgeInsets.symmetric(vertical: 5),
                                child: Container(
                                  decoration: BoxDecoration(
                                      color: Colors.grey.shade900,
                                      borderRadius: BorderRadius.circular(20)),
                                  child: ListTile(
                                    leading: Image(
                                        width: 60,
                                        height: 60,
                                        fit: BoxFit.contain,
                                        image: NetworkImage(movie
                                                    .companies![index].logo ==
                                                null
                                            ? 'https://icons.veryicon.com/png/o/business/oa-attendance-icon/company-27.png'
                                            : 'https://image.tmdb.org/t/p/w500${movie.companies![index].logo}')),
                                    title: Text(
                                      movie.companies![index].name,
                                      style:
                                          const TextStyle(color: Colors.grey),
                                    ),
                                  ),
                                ),
                              );
                            },
                          ),
                        ),
                        const SizedBox(
                          height: 8,
                        ),
                        const Text(
                          "Cast",
                          style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.w600,
                              fontSize: 18),
                        ),
                        const Divider(),
                        FutureBuilder(
                            future: ApiServices().getCast(widget.movie.id),
                            builder: (context, snapshot) {
                              if (snapshot.connectionState ==
                                  ConnectionState.waiting) {
                                return const Center(
                                  child: CircularProgressIndicator(),
                                );
                              }
                              if (snapshot.hasError) {
                                return const Text(
                                  "Something went wrong",
                                  style: TextStyle(color: Colors.white),
                                );
                              }

                              List<ActorModel> actors = snapshot.data!;
                              return Column(
                                children: List.generate(
                                  actors.length,
                                  (index) => Padding(
                                    padding:
                                        const EdgeInsets.symmetric(vertical: 4),
                                    child: Container(
                                      decoration: BoxDecoration(
                                          color: Colors.grey.shade900,
                                          borderRadius:
                                              BorderRadius.circular(20)),
                                      child: ListTile(
                                          leading: ClipRRect(
                                              borderRadius:
                                                  BorderRadius.circular(100),
                                              child: Image(
                                                  height: 60,
                                                  width: 60,
                                                  fit: BoxFit.cover,
                                                  image: NetworkImage(actors[
                                                                  index]
                                                              .image ==
                                                          null
                                                      ? 'https://cdn-icons-png.flaticon.com/512/475/475283.png'
                                                      : 'https://image.tmdb.org/t/p/w500${actors[index].image}'))),
                                          title: Text(
                                            actors[index].name,
                                            style: TextStyle(
                                                color: Colors.grey.shade300),
                                          ),
                                          subtitle:
                                              actors[index].character != null
                                                  ? Text(
                                                      actors[index].character!,
                                                      style: const TextStyle(
                                                          color: Colors.grey),
                                                    )
                                                  : null),
                                    ),
                                  ),
                                ),
                              );
                            }),
                      ],
                    )
                  ],
                ),
              );
            }),
      ),
    );
  }
}

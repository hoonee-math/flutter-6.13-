import 'package:flutter/material.dart';
import 'package:toonflix/models/webtoon_detail_model.dart';
import 'package:toonflix/models/webtoon_episode_model.dart';
import 'package:toonflix/services/api_services.dart';

/* #6.9강, #6.10강 (Detail Screen, Hero)

class DetailScreen extends StatelessWidget {
  final String title, thumb, id;
  const DetailScreen({
    super.key,
    required this.title,
    required this.thumb,
    required this.id,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 2,
        backgroundColor: Colors.white,
        foregroundColor: Colors.green,
        title: Text(
          title,
          style: const TextStyle(fontSize: 24),
        ),
      ),
      body: Column(
        children: [
          const SizedBox(height: 50),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Hero(
                tag: id,
                child: Container(
                  width: 250,
                  clipBehavior: Clip.hardEdge,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15),
                      boxShadow: [
                        BoxShadow(
                          blurRadius: 7,
                          offset: const Offset(10, 10),
                          color: Colors.red.withOpacity(0.5),
                        )
                      ]),
                  child: Image.network(thumb),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
*/

class DetailScreen extends StatefulWidget {
  final String title, thumb, id;

  const DetailScreen({
    super.key,
    required this.title,
    required this.thumb,
    required this.id,
  });

  @override
  State<DetailScreen> createState() => _DetailScreenState();
}

class _DetailScreenState extends State<DetailScreen> {
  late Future<WebtoonDetailModel> webtoon;
  late Future<List<WebtoonEpisodeModel>> episodes;

  @override
  void initState() {
    super.initState();
    webtoon = ApiService.getToonById(widget.id);
    episodes = ApiService.getLatestEpisodesById(widget.id);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 2,
        backgroundColor: Colors.white,
        foregroundColor: Colors.green,
        title: Text(
          widget.title,
          style: const TextStyle(fontSize: 24),
        ),
      ),
      body: Column(
        children: [
          const SizedBox(height: 50),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Hero(
                tag: widget.id,
                child: Container(
                  width: 250,
                  clipBehavior: Clip.hardEdge,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15),
                      boxShadow: [
                        BoxShadow(
                          blurRadius: 7,
                          offset: const Offset(10, 10),
                          color: Colors.red.withOpacity(0.5),
                        )
                      ]),
                  child: Image.network(widget.thumb),
                ),
              ),
            ],
          ),
          const SizedBox(
            height: 25,
          ),
          FutureBuilder(
            future: webtoon,
            builder: (context, AsyncSnapshot snapshot) {
              if (snapshot.hasData) {
                return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 50),
                  child: Column(
                    children: [
                      Text(
                        (snapshot.data as WebtoonDetailModel).about,
                        style: const TextStyle(fontSize: 18),
                      ),
                      Text(
                        '${(snapshot.data as WebtoonDetailModel).genre}/${(snapshot.data as WebtoonDetailModel).age}',
                        style: const TextStyle(fontSize: 18),
                      ),
                    ],
                  ),
                );
              }
              return const Text('...');
            },
          )
        ],
      ),
    );
  }
}

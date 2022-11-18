import 'package:counter_7/features/drawer.dart';
import 'package:counter_7/model/mywatchlist.dart';
import 'package:flutter/material.dart';
import 'package:counter_7/page/mywatchlist_page.dart';

class MyWatchDetail extends StatefulWidget {
  const MyWatchDetail({super.key, required this.myWatch});

  final MyWatchList myWatch;

  @override
  State<MyWatchDetail> createState() => _MyWatchDetailState();
}

class _MyWatchDetailState extends State<MyWatchDetail> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Detail'),
      ),
      drawer: const MyDrawer(),
      body: Container(
          padding: const EdgeInsets.all(20),
          height: 800,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    widget.myWatch.fields.title,
                    style: const TextStyle(
                        fontSize: 15, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 20),
                  RichText(
                    text: TextSpan(
                      style: const TextStyle(
                        fontSize: 14.0,
                        color: Colors.black,
                      ),
                      children: <TextSpan>[
                        const TextSpan(
                            text: 'Release date: ',
                            style: TextStyle(fontWeight: FontWeight.bold)),
                        TextSpan(
                            text: '${widget.myWatch.fields.releaseDate}\n'),
                        const TextSpan(
                            text: 'Rating: ',
                            style: TextStyle(fontWeight: FontWeight.bold)),
                        TextSpan(text: '${widget.myWatch.fields.rating}/5\n'),
                        const TextSpan(
                            text: 'Status: ',
                            style: TextStyle(fontWeight: FontWeight.bold)),
                        TextSpan(
                            text: (widget.myWatch.fields.watched)
                                ? "watched\n"
                                : "unwatched\n"),
                        const TextSpan(
                            text: 'Review: ',
                            style: TextStyle(fontWeight: FontWeight.bold)),
                        TextSpan(text: "${widget.myWatch.fields.review}\n"),
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                ],
              ),
              Column(crossAxisAlignment: CrossAxisAlignment.center, children: [
                TextButton(
                    style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all(Colors.blue),
                    ),
                    onPressed: () {
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const MyWatchListPage()),
                      );
                    },
                    child: const SizedBox(
                        height: 40,
                        width: 200,
                        child: Center(
                          child: Text(
                            "Back",
                            style: TextStyle(color: Colors.white),
                          ),
                        ))),
              ]),
            ],
          )),
    );
  }
}

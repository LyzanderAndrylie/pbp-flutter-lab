import 'package:flutter/material.dart';

import 'package:counter_7/model/mywatchlist.dart';
import 'package:counter_7/page/mywatchlist_detail.dart';
import 'package:counter_7/widgets/drawer.dart';
import 'package:counter_7/utilities/fetch_mywatchlist.dart';

class MyWatchListPage extends StatefulWidget {
  const MyWatchListPage({Key? key}) : super(key: key);

  @override
  MyWatchListPageState createState() => MyWatchListPageState();
}

class MyWatchListPageState extends State<MyWatchListPage> {
  late Future<List<MyWatchList>> myWatchList;

  @override
  void initState() {
    super.initState();
    myWatchList = fetchMyWatchList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('My Watch List'),
        ),
        drawer: const MyDrawer(),
        body: FutureBuilder(
            future: myWatchList,
            builder: (context, AsyncSnapshot snapshot) {
              if (snapshot.data == null) {
                return const Center(child: CircularProgressIndicator());
              } else {
                if (!snapshot.hasData) {
                  return Column(
                    children: const [
                      Text(
                        "Tidak ada MyWatchList :(",
                        style:
                            TextStyle(color: Color(0xff59A5D8), fontSize: 20),
                      ),
                      SizedBox(height: 8),
                    ],
                  );
                } else {
                  return ListView.builder(
                      itemCount: snapshot.data!.length,
                      itemBuilder: (_, index) => GestureDetector(
                            onTap: () {
                              Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => MyWatchDetail(
                                        myWatch: snapshot.data![index])),
                              );
                            },
                            child: Container(
                              margin: const EdgeInsets.symmetric(
                                  horizontal: 16, vertical: 12),
                              padding: const EdgeInsets.all(20.0),
                              decoration: BoxDecoration(
                                  border: Border.all(
                                      width: 1,
                                      color: ((snapshot
                                              .data![index].fields.watched)
                                          ? Colors.green
                                          : Colors.red)),
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(15.0),
                                  boxShadow: const [
                                    BoxShadow(
                                        color: Colors.grey, blurRadius: 0.5)
                                  ]),
                              child: Row(
                                children: [
                                  Expanded(
                                    child: Text(
                                      "${snapshot.data![index].fields.title}",
                                      style: const TextStyle(
                                        fontSize: 18.0,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    width: 30,
                                    child: CheckboxListTile(
                                        value: snapshot
                                            .data![index].fields.watched,
                                        onChanged: (bool? value) {
                                          setState(() {
                                            snapshot.data![index].fields
                                                    .watched =
                                                !snapshot.data![index].fields
                                                    .watched;
                                          });
                                        }),
                                  )
                                ],
                              ),
                            ),
                          ));
                }
              }
            }));
  }
}

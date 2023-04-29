import 'dart:async';

import 'package:flutter/material.dart';
import 'package:movie_display/movie_screen/DetailsOfMovie.dart';

import '../app_models/EmployeeModel.dart';
import '../connect/connectAPI/AppCollectionApi.dart';
import '../connect/connectDB/DBfunctions.dart';
import '../connect/connectDB/DatabaseHelper.dart';
import '../main.dart';

class MovieHomePage extends StatefulWidget {
  const MovieHomePage({super.key});

  @override
  State<MovieHomePage> createState() => _MovieHomePageState();
}

class _MovieHomePageState extends State<MovieHomePage>
    with SingleTickerProviderStateMixin {
  int tabIndex = 0;

  late Timer _timer;
  late TabController tabController;
  var empDetails = <EmployeeData>[];
  Future? futureEmpData;
  Future? futurePetData;

  List detailsOfMovies = [
    {
      "image":
          "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQaXhknhIexpRl8mM1nmlYtQqraoIB2pvh9qA&usqp=CAU",
      "Title": "GANAPATH",
      "Date": "12/12/2022",
      "PostSummery":
          "it revolves around Tanaji's attempts to recapture the Kondhana fortress once it passes on to Mughal emperor Aurangzeb who transfers its control to his trusted guard Udaybhan Singh Rathore"
    },
    {
      "image":
          "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQt0fLFSvnKH33tjjgIjc1B-LuL1DnmNBrbAA&usqp=CAU",
      "Title": "YODHA",
      "Date": "12/12/2022",
      "PostSummery":
          "it revolves around Tanaji's attempts to recapture the Kondhana fortress once it passes on to Mughal emperor Aurangzeb who transfers its control to his trusted guard Udaybhan Singh Rathore"
    },
    {
      "image":
          "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQaXhknhIexpRl8mM1nmlYtQqraoIB2pvh9qA&usqp=CAU",
      "Title": "TANHAJI",
      "Date": "12/12/2022",
      "PostSummery":
          "it revolves around Tanaji's attempts to recapture the Kondhana fortress once it passes on to Mughal emperor Aurangzeb who transfers its control to his trusted guard Udaybhan Singh Rathore"
    },
    {
      "image":
          "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQt0fLFSvnKH33tjjgIjc1B-LuL1DnmNBrbAA&usqp=CAU",
      "Title": "ANT-MEN",
      "Date": "12/12/2022",
      "PostSummery":
          "it revolves around Tanaji's attempts to recapture the Kondhana fortress once it passes on to Mughal emperor Aurangzeb who transfers its control to his trusted guard Udaybhan Singh Rathore"
    },
  ];

  @override
  void initState() {
    setState(() {});
    // futureEmpData = ApiCollection.getEmpDetails;
    futurePetData = ApiCollection.getPet();

    tabController = TabController(length: 2, vsync: this);
    super.initState();
    print("----database---${dbData}");
  }

  @override
  void dispose() {
    tabController.dispose();
    super.dispose();
  }

  Widget favListView() {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    List list = favMovieStore;

    return ListView.builder(
      padding: const EdgeInsets.all(0),
      itemCount: list.length,
      itemBuilder: (context, index) {
        return Dismissible(
          key: ObjectKey(list[index]),
          onDismissed: (direction) {
            setState(() {
              list.removeAt(index);
            });
          },
          child: InkWell(
            onTap: () {
              setState(
                () {
                  print(list);
                  Navigator.of(context)
                      .push(
                        MaterialPageRoute(
                          builder: (context) => DetailsOfMovies(
                            petDetails: list[index],
                            pageIndex: tabIndex,
                          ),
                        ),
                      )
                      .then((value) => setState(() {}));
                },
              );
            },
            child: Container(
              height: height / 6.2,
              width: width,
              margin: EdgeInsets.only(
                  bottom: height / 50,
                  left: height / 50,
                  right: height / 50,
                  top: height / 50),
              padding: EdgeInsets.all(height / 50),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(16),
                color: Colors.amber,
              ),
              child: Row(
                children: [
                  Container(
                    height: height / 8,
                    width: width / 5,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12),
                        color: Colors.teal
                        // image: DecorationImage(
                        //     image: NetworkImage(
                        //       list[index],
                        //     ),
                        //     fit: BoxFit.fill),
                        ),
                  ),
                  SizedBox(
                    width: height / 50,
                  ),
                  Expanded(
                      child: Container(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // SizedBox(
                        // height: height / 25,
                        // width: width / 3,
                        // child:
                        Text(
                          list[index].category!,
                          overflow: TextOverflow.ellipsis,

                          style: const TextStyle(
                              fontSize: 20, fontWeight: FontWeight.bold),
                          // ),
                        ),
                        SizedBox(
                          height: height / 70,
                        ),
                        // SizedBox(
                        //   height: height / 45,
                        //   width: width / 2,
                        //   child:
                        Text(
                          list[index].description!,
                          overflow: TextOverflow.ellipsis,
                          style: const TextStyle(
                              fontSize: 14, fontWeight: FontWeight.bold),
                        ),
                        // ),
                        SizedBox(
                          height: height / 105,
                        ),
                        // SizedBox(
                        //   height: height / 45,
                        //   width: width / 3,
                        // child:
                        Text(
                          list[index].cors!,
                          style: const TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                              color: Colors.blue),
                        ),
                        // ),
                      ],
                    ),
                  )),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  Widget commonListView() {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return FutureBuilder(
      future: futurePetData,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          if (snapshot.data!.isEmpty) {
            return Text("data is empty");
          } else {
            return ListView.builder(
              padding: const EdgeInsets.all(0),
              itemCount: snapshot.data!.length,
              itemBuilder: (context, index) {
                var list = snapshot.data!;
                return
                    // list == detailsOfMovies

                    InkWell(
                  onTap: () {
                    setState(
                      () {
                        print(favMovieStore);
                        Navigator.of(context)
                            .push(
                              MaterialPageRoute(
                                builder: (context) => DetailsOfMovies(
                                  petDetails: list[index],
                                  pageIndex: tabIndex,
                                ),
                              ),
                            )
                            .then((value) => setState(() {}));
                      },
                    );
                  },
                  child: Container(
                    height: height / 6.2,
                    width: width,
                    margin: EdgeInsets.only(
                        bottom: height / 50,
                        left: height / 50,
                        right: height / 50,
                        top: height / 50),
                    padding: EdgeInsets.all(height / 50),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(16),
                      color: Colors.amber,
                    ),
                    child: Row(
                      // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          height: height / 8,
                          width: width / 5,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(12),
                            color: Colors.teal,
                            // image: list[index].profileImage!.isNotEmpty
                            //     ? DecorationImage(
                            //         image: NetworkImage(
                            //           list[index].profileImage!,
                            //         ),
                            //         fit: BoxFit.fill)
                            //     : null,
                          ),
                        ),
                        SizedBox(
                          width: height / 50,
                        ),
                        Expanded(
                            child: Container(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              // SizedBox(
                              //   height: height / 25,
                              //   // width: width / 3,
                              //   child:
                              Text(
                                list[index].category!.toString(),
                                overflow: TextOverflow.ellipsis,
                                style: const TextStyle(
                                    fontSize: 20, fontWeight: FontWeight.bold),
                              ),
                              // ),
                              SizedBox(
                                height: height / 70,
                              ),
                              // Container(
                              //   // color: Colors.green,
                              //   height: height / 45,
                              //   width: width / 2,
                              // child:
                              Text(
                                list[index].description!.toString(),
                                overflow: TextOverflow.ellipsis,
                                style: const TextStyle(
                                    fontSize: 14, fontWeight: FontWeight.bold),
                              ),
                              // ),
                              SizedBox(
                                height: height / 105,
                              ),
                              // SizedBox(
                              //   height: height / 45,
                              //   width: width / 3,
                              //   child:
                              Text(
                                list[index].cors!.toString(),
                                style: const TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.blue),
                              ),
                              // ),
                            ],
                          ),
                        )),
                        Container(
                          width: 20,
                          // child:
                          //     TextButton(onPressed: () {}, child: Text("show")),
                        )
                      ],
                    ),
                  ),
                );
              },
            );
          }
        } else {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
      },
    );
    //     ),
    //   ],
    // );
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        // bottom: AppBar(
        automaticallyImplyLeading: false,
        // title: Row(
        //   mainAxisAlignment: MainAxisAlignment.spaceAround,
        //   children: [
        //     ElevatedButton(onPressed: () {}, child: Text("Insert")),
        //     ElevatedButton(onPressed: () {}, child: Text("Update")),
        //     ElevatedButton(onPressed: () {}, child: Text("Get Data")),
        //     ElevatedButton(onPressed: () {}, child: Text("Delete")),
        //   ],
        // ),
      ),
      // bottom: TabBar(
      //   controller: tabController,
      //   tabs: const [
      //     Tab(
      //       text: 'Movie List',
      //     ),
      //     Tab(text: 'Favourite Movie List'),
      //   ],
      // ),
      // ),
      body: Column(
        children: [
          Padding(
            padding: EdgeInsets.only(top: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                InkWell(
                  onTap: () {
                    setState(() {
                      tabIndex = 0;
                    });
                  },
                  child: Container(
                    height: 40,
                    width: width * 0.50,
                    decoration: BoxDecoration(
                      border: Border(
                        bottom: BorderSide(
                            width: tabIndex == 0 ? 3.0 : 1.0,
                            color: Colors.black),
                      ),
                      color: Colors.white,
                    ),
                    // color: Colors.white,
                    child: const Align(
                      alignment: Alignment.center,
                      child: Text(
                        "Movie List",
                        style: TextStyle(
                            fontSize: 16, fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                ),
                InkWell(
                  onTap: () {
                    setState(() {
                      tabIndex = 1;
                    });
                  },
                  child: Container(
                    height: 40,
                    width: width * 0.50,
                    decoration: BoxDecoration(
                      border: Border(
                        bottom: BorderSide(
                            width: tabIndex == 1 ? 3.0 : 1.0,
                            color: Colors.black),
                      ),
                      color: Colors.white,
                    ),
                    child: const Align(
                      alignment: Alignment.center,
                      child: Text(
                        "Favourite Movie List",
                        style: TextStyle(
                            fontSize: 16, fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          tabIndex == 0
              ? Expanded(
                  child: commonListView(),
                )
              : Expanded(
                  child: favListView(),
                )
        ],
      ),
    );

    // TabBarView(controller: tabController, children: [
    //   commonListView(detailsOfMovies),
    //   commonListView(favMovieStore),
    // ]));
  }
}

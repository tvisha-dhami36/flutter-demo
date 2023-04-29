import 'package:flutter/material.dart';
import 'package:get/get_navigation/src/extension_navigation.dart';
import 'package:movie_display/app_models/PetModel.dart';

class DetailsOfMovies extends StatefulWidget {
  Entries? petDetails;
  int pageIndex;
  // int passingindex;

  DetailsOfMovies({
    super.key,
    required this.petDetails,
    required this.pageIndex,
  });

  @override
  State<DetailsOfMovies> createState() => _DetailsOfMoviesState();
}

List<Entries> favMovieStore = [];

class _DetailsOfMoviesState extends State<DetailsOfMovies> {
  @override
  void initState() {
    super.initState();
    print("---petDetails--- ${widget.petDetails!.description}");
  }

  _addNdRemove() {
    if (!favMovieStore.contains(widget.petDetails)) {
      favMovieStore.add(widget.petDetails!);
    } else {
      favMovieStore.remove(widget.petDetails!);
    }
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
            onPressed: () {
              setState(() {
                Navigator.of(context).pop();
              });
            },
            icon: Icon(
              Icons.arrow_back,
              color: Colors.black,
            )),
        actions: [
          IconButton(
            onPressed: () async {
              await _addNdRemove();
              setState(() {});
              print(favMovieStore);
              widget.pageIndex == 1 ? Navigator.pop(context) : null;
            },
            icon: Icon(
              Icons.favorite,
              color: favMovieStore.contains(widget.petDetails)
                  ? Colors.red
                  : Colors.white,
            ),
          )
        ],
      ),
      body: Container(
        height: height * 100,
        width: width * 100,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              height: height * 0.60,
              width: width * 100,
              decoration: BoxDecoration(
                color: Colors.black,
                //   image: DecorationImage(
                //     image: NetworkImage(widget.passingImage),
                //     fit: BoxFit.fill,
                //   ),
              ),
            ),
            SizedBox(
              child: Padding(
                padding: const EdgeInsets.only(left: 10, top: 10),
                child: Text(
                  "Category : ${widget.petDetails!.category}",
                  style: const TextStyle(
                      fontSize: 20, fontWeight: FontWeight.bold),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 10, top: 10),
              child: Text(
                "Description : ${widget.petDetails!.description}",
                style:
                    const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 10, top: 10),
              child: Text(
                "${widget.petDetails!.link}",
                style:
                    const TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
              ),
            )
          ],
        ),
      ),
    );
  }
}

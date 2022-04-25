// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:rescue_army/models/event.dart';
import 'package:rescue_army/utils/routes.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:readmore/readmore.dart';

class EventInfoScreen extends StatelessWidget {
  EventInfoScreen({Key? key}) : super(key: key);
  final Event event = Event(
    title: "Flood rescue training",
    description:
        "Nulla pariatur fugiat est eu Lorem ea. Do sit irure ut et mollit labore. Elit sit qui sint aliquip aute aute qui proident magna aliqua. Nulla exercitation sit sint consequat id aliquip laborum.Mollit cillum elit duis officia do do. Adipisicing dolore excepteur pariatur do fugiat ea amet minim irure et consectetur anim. Eu enim id tempor anim culpa labore ea voluptate amet nostrud dolor excepteur Lorem deserunt. Aliquip incididunt magna officia exercitation est laborum. Voluptate aute ea aliqua non adipisicing mollit quis excepteur. Velit aute reprehenderit enim commodo commodo eu voluptate fugiat id.",
    imagesUrl:
        "https://newhorizonindia.edu/nhengineering/wp-content/uploads/2021/03/ncc.jpg",
    startDate: "April 6, 2022",
    eventVenue: "DKTE Ichalkaranji",
  );
  @override
  Widget build(BuildContext context) {
    // print(event);
    return Scaffold(
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
      BottomNavigationBarItem(
        icon: Icon(Icons.call),
        label: 'Calls',
      ),
      BottomNavigationBarItem(
        icon: Icon(Icons.free_breakfast),
        label: 'Calls',
      )]),
        
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text("Event",style: TextStyle(color: Colors.black),),
        leading: BackButton(
            onPressed: () => Navigator.popAndPushNamed(context, AppRoutes.home),
            color: Colors.black),
      ),
      body: SingleChildScrollView(
        child: SafeArea(
          child: Column(
            children: [
              Image.network(
                event.imagesUrl ?? "imagesUrl",
                fit: BoxFit.cover,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: 10,
                    ),
                    Text(
                      event.title ?? "Title",
                      style: TextStyle(
                        fontSize: 26,
                        fontWeight: FontWeight.bold,
                        fontFamily: GoogleFonts.lato().fontFamily,
                      ),
                      textAlign: TextAlign.left,
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    Row(
                      children: [
                        Align(
                          alignment: Alignment.topLeft,
                          child: Icon(
                            Icons.calendar_today_outlined,
                            color: Colors.black,
                          ),
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        Align(
                          alignment: Alignment.topLeft,
                          child: Text(
                            event.startDate ?? "Date",
                            style: TextStyle(
                              fontSize: 18,
                            ),
                            textAlign: TextAlign.left,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Divider(
                      height: 10,
                      thickness: 0.5,
                      indent: 20,
                      endIndent: 20,
                      color: Colors.black45,
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    Row(
                      children: [
                        Align(
                          alignment: Alignment.topLeft,
                          child: Icon(
                            Icons.location_on_outlined,
                            color: Colors.black,
                          ),
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        Align(
                          alignment: Alignment.topLeft,
                          child: Text(
                            event.eventVenue ?? "Venue",
                            style: TextStyle(
                              fontSize: 18,
                            ),
                            textAlign: TextAlign.left,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Divider(
                      height: 10,
                      thickness: 0.5,
                      indent: 20,
                      endIndent: 20,
                      color: Colors.black45,
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    Text(
                      "About",
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                      textAlign: TextAlign.left,
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    ReadMoreText(
                      event.description ?? "Description",
                      trimLines: 3,
                      colorClickableText: Colors.blue,
                      trimMode: TrimMode.Line,
                      trimCollapsedText: '...Read more',
                      trimExpandedText: ' Read less',
                      style: TextStyle(
                        fontSize: 18,
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

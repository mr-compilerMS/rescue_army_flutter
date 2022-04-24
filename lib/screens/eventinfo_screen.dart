// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:rescue_army/models/event.dart';
import 'package:rescue_army/utils/routes.dart';
import 'package:google_fonts/google_fonts.dart';

class EventInfoScreen extends StatelessWidget {
  EventInfoScreen({Key? key}) : super(key: key);
  final Event event = Event(
    title: "Chakra healling and meditaion Session",
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
      appBar: AppBar(
        title: Text("Event Info"),
        leading: BackButton(
            onPressed: () => Navigator.popAndPushNamed(context, AppRoutes.home),
            color: Colors.white),
      ),
      body: SingleChildScrollView(
        child: SafeArea(
          child: Column(
            children: [
              Image.network(
                event.imagesUrl ?? "imagesUrl",
                fit: BoxFit.cover,
              ),
              SizedBox(
                height: 10,
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 15),
                child: Text(
                  event.title ?? "Title",
                  style: TextStyle(
                    fontSize: 26,
                    fontWeight: FontWeight.bold,
                    fontFamily: "Water Brush",
                  ),
                  textAlign: TextAlign.left,
                ),
              ),
              SizedBox(
                height: 15,
              ),
              Row(
                children: [
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 15),
                    child: Align(
                      alignment: Alignment.topLeft,
                      child: Icon(
                        Icons.calendar_today_outlined,
                        color: Colors.black,
                      ),
                    ),
                  ),
                  Padding(
                      padding: EdgeInsets.symmetric(horizontal: 5),
                      child: Align(
                        alignment: Alignment.topLeft,
                        child: Text(
                          event.startDate ?? "Date",
                          style: TextStyle(
                            fontSize: 18,
                          ),
                          textAlign: TextAlign.left,
                        ),
                      )),
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
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 15),
                    child: Align(
                      alignment: Alignment.topLeft,
                      child: Icon(
                        Icons.location_on_outlined,
                        color: Colors.black,
                      ),
                    ),
                  ),
                  Padding(
                      padding: EdgeInsets.symmetric(horizontal: 15),
                      child: Align(
                        alignment: Alignment.topLeft,
                        child: Text(
                          event.eventVenue ?? "Venue",
                          style: TextStyle(fontSize: 18,),
                          textAlign: TextAlign.left,
                        ),
                      )),
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
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 15),
                child: Title(
                  color: Colors.black,
                  child: Text(
                    "About",
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    textAlign: TextAlign.left,
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 15),
                child: Text(
                  event.description ?? "Description",
                  style: TextStyle(fontSize: 18),
                  textAlign: TextAlign.justify,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

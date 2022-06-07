// ignore_for_file: prefer_const_constructors
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:rescue_army/models/event.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:readmore/readmore.dart';

class EventInfoScreen extends StatefulWidget {
  EventInfoScreen({Key? key}) : super(key: key);

  @override
  State<EventInfoScreen> createState() => _EventInfoScreenState();
}

class _EventInfoScreenState extends State<EventInfoScreen> {
  bool isGoing = false;
  Event? event;

  getEvent(Event event) async {
    await Event.fromAPI(event.id!).then((value) {
      setState(() {
        this.event = value;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    if (this.event == null)
      getEvent(ModalRoute.of(context)!.settings.arguments as Event);
    return Scaffold(
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          setState(() {
            isGoing = !isGoing;
          });
        },
        label: AnimatedContainer(
          alignment: Alignment.center,
          width: !isGoing ? 60 : 80,
          child: !isGoing ? Text('Going') : Text(' ✔️ Going'),
          duration: Duration(milliseconds: 300),
        ),
      ),
      appBar: AppBar(
        title: Text(
          "Event",
        ),
        leading: BackButton(
            onPressed: () => Navigator.pop(context), color: Colors.white),
      ),
      body: event == null
          ? Center(
              child: CircularProgressIndicator(),
            )
          : SingleChildScrollView(
              child: SafeArea(
                child: Column(
                  children: [
                    Image.network(
                      event!.images.first.imageThumbnail ??
                          event!.images.first.image!,
                      fit: BoxFit.fill,
                      height: 200,
                    ),
                    Divider(
                      height: 1,
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
                            event!.title ?? "Title",
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
                                  DateFormat('EEE, M/d/y')
                                          .format(event!.startTime!) +
                                      " - " +
                                      DateFormat('EEE, M/d/y')
                                          .format(event!.endTime!),
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
                                  event!.venues.first.city ?? "Venue",
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
                            style: TextStyle(
                                fontSize: 20, fontWeight: FontWeight.bold),
                            textAlign: TextAlign.left,
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          ReadMoreText(
                            event!.description ?? "Description",
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

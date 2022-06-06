import 'package:flutter/material.dart';

class CallScreen extends StatefulWidget {
  const CallScreen({Key? key}) : super(key: key);

  @override
  State<CallScreen> createState() => _CallScreenState();
}

class _CallScreenState extends State<CallScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 8, 1, 29),
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 100),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    width: 200,
                    height: 60,
                    child: Stack(
                      children: [
                        Positioned(
                            top: 10,
                            left: 40,
                            child: Container(
                              width: 100,
                              height: 40,
                              decoration: BoxDecoration(
                                color: Colors.lightBlueAccent,
                                shape: BoxShape.rectangle,
                                borderRadius: BorderRadius.circular(5),
                              ),
                              child: Center(child: _NoOfParticipants()),
                            )),
                        Positioned(
                          top: 0,
                          left: 0,
                          child: Container(
                            width: 60,
                            height: 60,
                            decoration: BoxDecoration(
                              color: Colors.lightBlueAccent,
                              shape: BoxShape.circle,
                              border: Border.all(
                                color: Color.fromARGB(87, 255, 255, 255),
                                width: 2,
                              ),
                            ),
                            child: const Icon(
                              Icons.person,
                              size: 50,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  ElevatedButton(
                    onPressed: () {},
                    child: const Text('Leave call'),
                    style: ElevatedButton.styleFrom(
                        fixedSize: const Size(140, 50),
                        primary: Colors.deepOrange),
                  ),
                ],
              ),
            ),
            const Padding(
              padding: EdgeInsets.only(top: 10),
              child: OrginizerName(),
            ),
            Padding(
              padding: const EdgeInsets.all(24.0),
              child: Center(
                child: GestureDetector(
                  onTapDown: (details) => {print(1)},
                  onTapCancel: () => {print(0)},
                  child: Ink(
                    width: 200,
                    height: 200,
                    decoration: const BoxDecoration(
                        shape: BoxShape.circle, color: Color(0xFF2196F3)),
                    child: InkWell(
                      onTap: () => {},
                      borderRadius: BorderRadius.circular(100),
                      child: const Center(
                        child: Icon(
                          Icons.mic,
                          color: Colors.white,
                          size: 50,
                        ),
                      ),
                      splashColor: const Color.fromARGB(255, 54, 244, 79),
                    ),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}

class _NoOfParticipants extends StatefulWidget {
  const _NoOfParticipants({Key? key}) : super(key: key);

  @override
  State<_NoOfParticipants> createState() => _NoOfParticipantsState();
}

class _NoOfParticipantsState extends State<_NoOfParticipants> {
  int noOfParticipents = 0;

  updatenoOfParticipents(int newNoOfparticipents) {
    setState(() {
      noOfParticipents = newNoOfparticipents;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Text(
      '$noOfParticipents',
      style: const TextStyle(
        fontSize: 18,
        color: Colors.white,
      ),
    );
  }
}

class OrginizerName extends StatefulWidget {
  const OrginizerName({Key? key}) : super(key: key);

  @override
  State<OrginizerName> createState() => _OrginizerNameState();
}

class _OrginizerNameState extends State<OrginizerName> {
  String orginizerName = 'Orginizer Name';

  updateOrganizer(String newOrganizer) {
    setState(() {
      orginizerName = newOrganizer;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Text(orginizerName,
        style: const TextStyle(
            fontSize: 30,
            fontWeight: FontWeight.bold,
            color: Color.fromARGB(255, 117, 103, 103)));
  }
}

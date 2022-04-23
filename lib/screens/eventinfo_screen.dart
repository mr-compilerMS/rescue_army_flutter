import 'package:flutter/material.dart';
import 'package:rescue_army/models/event.dart';
import 'package:rescue_army/utils/routes.dart';
class EventInfoScreen extends StatelessWidget {
   EventInfoScreen({ Key? key }) : super(key: key);
  final Event event=const Event(title: "Chakra healling and meditaion Session",description:"lorem",imagesUrl: "https://newhorizonindia.edu/nhengineering/wp-content/uploads/2021/03/ncc.jpg");
  @override
  Widget build(BuildContext context) {
    print(event);
    return Scaffold(
       appBar: AppBar(
        title: Text("Event Info"),
         leading: BackButton(
           onPressed: () => Navigator.popAndPushNamed(context, AppRoutes.home),
           color: Colors.white
         ),
      ),
      body: SingleChildScrollView(
        child: SafeArea(
          child: Column(
            children: [
              Image.network(event.imagesUrl??"imagesUrl",fit: BoxFit.cover,),
              Text(event.title??"Title",style: TextStyle(fontSize: 26,fontWeight: FontWeight.bold),textAlign: TextAlign.left,),
            ],
          ),
        ),
      ),
    );
  }
}
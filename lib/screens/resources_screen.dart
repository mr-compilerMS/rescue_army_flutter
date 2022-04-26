import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:velocity_x/velocity_x.dart';

class ResourcesScreen extends StatefulWidget {
  ResourcesScreen({Key? key}) : super(key: key);

  @override
  State<ResourcesScreen> createState() => _ResourcesScreenState();
}

class _ResourcesScreenState extends State<ResourcesScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Resources'),
        automaticallyImplyLeading: false,
        
      ),
      body: ListView(
        children: [
          ResourceTile(),
          ResourceTile(),
          ResourceTile(),
          ResourceTile(),
          ResourceTile(),
          ResourceTile(),
          ResourceTile(),
          ResourceTile(),
          ResourceTile(),
          ResourceTile(),
          ResourceTile(),
          ResourceTile(),
          ResourceTile(),
          ResourceTile(),
          ResourceTile(),
          ResourceTile(),
        ],
      ),
    );
  }
}

class ResourceTile extends StatefulWidget {
  const ResourceTile({Key? key}) : super(key: key);

  @override
  State<ResourceTile> createState() => _ResourceTileState();
}

class _ResourceTileState extends State<ResourceTile> {
  bool isSaved = false;
  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 1,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      color: Theme.of(context).backgroundColor,
      margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      child: ListTile(
        minVerticalPadding: 10,
        leading: Column(
          children: const [
            Text(
              "26",
              style: TextStyle(
                fontSize: 24,
              ),
            ),
            Text(
              "APR",
              style: TextStyle(fontSize: 18),
            ),
          ],
        ),
        // contentPadding: EdgeInsets.all(10),
        title: Text(
          "Handbook",
          style: TextStyle(
            fontFamily: GoogleFonts.lato().fontFamily,
            fontWeight: FontWeight.bold,
            fontSize: 20,
            letterSpacing: 1,
          ),
        ),
        subtitle: Text(
          'Description lorem hsdkhjhskdjaf hksdf hkdsh ah hfkahs hj fakjshdj sdhkafh hjksdafk fhfkdhhfd kshadkfj........',
          textAlign: TextAlign.left,
        ),
        trailing: IconButton(
          onPressed: () {
            setState(() {
              isSaved = !isSaved;
            });
          },
          icon: isSaved
              ? const Icon(
                  Icons.bookmark,
                  color: Colors.blueAccent,
                  size: 30,
                )
              : const Icon(
                  Icons.bookmark,
                  color: Colors.grey,
                ),
        ),
        onTap: () {},
      ),
    );
  }
}

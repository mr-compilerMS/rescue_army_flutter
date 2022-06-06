import 'package:flutter/material.dart';
import 'package:flutter_downloader/flutter_downloader.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:rescue_army/models/resource.dart';

class ResourcesScreen extends StatefulWidget {
  ResourcesScreen({Key? key}) : super(key: key);

  @override
  State<ResourcesScreen> createState() => _ResourcesScreenState();
}

class _ResourcesScreenState extends State<ResourcesScreen> {
  List<Resource> resources = [];

  @override
  void initState() {
    Resource.fetchResources().then((resources) {
      setState(() {
        this.resources = resources;
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Resources'),
        automaticallyImplyLeading: false,
      ),
      body: ListView.builder(
        itemCount: resources.length,
        itemBuilder: (context, index) {
          return Card(
            child: ResourceTile(
              resources[index],
              // title: Text(resources[index].title!),
              // subtitle: Text(resources[index].title!),
            ),
          );
        },
      ),
    );
  }
}

class ResourceTile extends StatefulWidget {
  ResourceTile(this.resource, {Key? key}) : super(key: key);
  final Resource resource;

  @override
  State<ResourceTile> createState() => _ResourceTileState();
}

checkPermissionAndGetDownloadPath() async {
  PermissionStatus status = await Permission.storage.status;
  if (status.isDenied) {
    status = await Permission.storage.request();
    if (status.isDenied) {
      return null;
    }
  }

  final dir = (await getExternalStorageDirectory());
  dir!.create();
  return dir.path;
}

class _ResourceTileState extends State<ResourceTile> {
  bool isSaved = false;
  @override
  Widget build(BuildContext context) {
    final resource = widget.resource;
    return Card(
      elevation: 1,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      color: Theme.of(context).backgroundColor,
      margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      child: ListTile(
        minVerticalPadding: 10,
        leading: Column(
          children: [
            Text(
              resource.uploadDate!.day.toString(),
              style: TextStyle(
                fontSize: 24,
              ),
            ),
            Text(
              DateFormat('MMM').format(resource.uploadDate!).toUpperCase(),
              // resource.uploadDate!.month.toString(),
              style: TextStyle(fontSize: 18),
            ),
          ],
        ),
        contentPadding: EdgeInsets.all(10),
        title: Text(
          resource.title!,
          style: TextStyle(
            fontFamily: GoogleFonts.lato().fontFamily,
            fontWeight: FontWeight.bold,
            fontSize: 20,
            letterSpacing: 1,
          ),
        ),
        subtitle: Text(
          resource.title!,
          textAlign: TextAlign.left,
        ),
        trailing: IconButton(
          onPressed: !isSaved
              ? () async {
                  setState(() {
                    isSaved = !isSaved;
                  });

                  final dir = await checkPermissionAndGetDownloadPath();

                  print(dir);
                  if (dir != null)
                    final taskId = await FlutterDownloader.enqueue(
                        url: resource.file!,
                        savedDir: '/storage/emulated/0/Downloads');
                }
              : null,
          icon: isSaved
              ? const Icon(
                  Icons.download_done,
                  color: Colors.blueAccent,
                  size: 30,
                )
              : const Icon(
                  Icons.download,
                  color: Colors.grey,
                ),
        ),
        onTap: () {},
      ),
    );
  }
}

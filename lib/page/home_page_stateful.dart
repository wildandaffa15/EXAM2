import 'package:flutter/material.dart';
import 'package:json_api/models/album.dart';
import 'package:json_api/service/album_service.dart';

class HomePageStateful extends StatefulWidget {
  const HomePageStateful({super.key});

  @override
  State<HomePageStateful> createState() => _HomePageStatefulState();
}

class _HomePageStatefulState extends State<HomePageStateful> {
  List<Album> album = [];

  void fetchAlbum() async {
    final result = await AlbumService.fetchAlbum();
    setState(() {
      album = result;
    });
  }

  @override
  void initState() {
    super.initState();
    fetchAlbum();
  }

  void deleteAlbum(int index) {
    setState(() {
      album.removeAt(index);
    });
  }

  void editAlbum(int index, String newTitle, String newUrl, String newThumbnailUrl) {
    setState(() {
      album[index].title = newTitle;
      album[index].url = newUrl;
      album[index].thumbnailUrl = newThumbnailUrl;
    });
  }

  void showEditDialog(BuildContext context, int index) {
  TextEditingController albumidController = TextEditingController(text: album[index].title.toString());
  TextEditingController urlController = TextEditingController(text: album[index].url);
  TextEditingController thumbnailUrlController = TextEditingController(text: album[index].thumbnailUrl);

  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text('Edit Album'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            TextField(
              controller: albumidController,
              decoration: InputDecoration(labelText: 'Title'),
            ),
            TextField(
              controller: urlController,
              decoration: InputDecoration(labelText: 'URL'),
            ),
            TextField(
              controller: thumbnailUrlController,
              decoration: InputDecoration(labelText: 'Thumbnail URL'),
            ),
          ],
        ),
        actions: <Widget>[
          ElevatedButton(
            child: Text('Cancel'),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
          ElevatedButton(
            child: Text('Save'),
            onPressed: () {
              editAlbum(index, albumidController.text, urlController.text, thumbnailUrlController.text);
              Navigator.of(context).pop();
            },
          ),
        ],
      );
    },
  );
}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.green,
      appBar: AppBar(
        title: const Text('EXAM 2'),
        backgroundColor: Colors.blueAccent,
      ),
      body: ListView.builder(
        itemCount: album.length,
        itemBuilder: (context, index) {
          final albumItem = album[index];
          Colors.black;
          return Card(
            child: ListTile(
              leading: CircleAvatar(
                backgroundImage: NetworkImage(albumItem.thumbnailUrl),
              ),
              title: Text('${albumItem.id}. ${albumItem.title}'),
              subtitle: Text(albumItem.url),
              trailing: Row(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  IconButton(
                    icon: Icon(Icons.edit),
                    color: Colors.blue,
                    onPressed: () {
                      showEditDialog(context, index);
                    },
                  ),
                  IconButton(
                    icon: Icon(Icons.delete),
                    color: Colors.red,
                    onPressed: () {
                      deleteAlbum(index);
                    },
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
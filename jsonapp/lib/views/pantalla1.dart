import 'package:flutter/material.dart';
import 'package:jsonapp/class/photoClass.dart';
import 'package:jsonapp/src/function/api_photo.dart';
import 'package:http/http.dart' as http;

class OnePage extends StatefulWidget {
  const OnePage({super.key, required this.title});

  final String title;

  @override
  State<OnePage> createState() => _OnePageState();
}

class _OnePageState extends State<OnePage> {
  Conexion photos = Conexion();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: FutureBuilder<List<Photo>>(
          future: photos.fetchPhoto(http.Client()),
          builder: (ctx, snapshot){
            if(snapshot.hasError){
              return const Center(child: Text("Error"));
            }else if(snapshot.hasData){
              return PhotosList(photos: snapshot.data!);
            }
            return const Center(child: CircularProgressIndicator());
          }
      ),
    );
  }
}

class PhotosList extends StatelessWidget {
  const PhotosList({super.key, required this.photos});

  final List<Photo> photos;

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
      ),
      itemCount: photos.length,
      itemBuilder: (context, index) {
        return Image.network(photos[index].thumbnailUrl);
      },
    );
  }
}

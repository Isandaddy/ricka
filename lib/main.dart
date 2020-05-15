import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Rick And Morty',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyWidget(),
    );
  }
}

class MyWidget extends StatelessWidget {
  String imageUrlByKey(int key) {
    return "https://rickandmortyapi.com/api/character/avatar/${key + 1}.jpeg";
  }

  @override
  Widget build(BuildContext context) {
    final gridBuilder = GridView.builder(
      itemCount: 200,
      itemBuilder: (BuildContext context, int position) {
        return GestureDetector(
            onTap: () {
              Navigator.push(context,
                  MaterialPageRoute<void>(builder: (BuildContext context) {
                return ImageDetailHome(imageUrlByKey(position));
              }));
            },
            child: Hero(
                tag: imageUrlByKey(position),
                child: Image.network(imageUrlByKey(position))));
      },
      gridDelegate:
          SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 3),
    );

    return Scaffold(
      appBar: AppBar(
        title: Center(child: Text("Rick And Morty")),
      ),
      body: Center(
        child: gridBuilder,
      ),
    );
  }
}

class ImageDetailHome extends StatelessWidget {
  final String imageUrl;
  ImageDetailHome(this.imageUrl);

  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
          child: GestureDetector(
        onTap: () {
          Navigator.pop(context);
        },
        child: Hero(
            child: Container(
              height: 500,
              // child: Image.network(imageUrl),
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: NetworkImage(imageUrl),
                  fit: BoxFit.contain,
                ),
                borderRadius: BorderRadius.circular(100),
              ),
            ),
            tag: imageUrl),
      )),
    );
  }
}

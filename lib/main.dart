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

class MyWidget extends StatefulWidget {
  @override
  _MyWidgetState createState() => _MyWidgetState();
}

class _MyWidgetState extends State<MyWidget> {
  String imageUrlByKey(int key) {
    return "https://rickandmortyapi.com/api/character/avatar/${key + 1}.jpeg";
  }

  TextEditingController _controller;
  Icon searchIcon = Icon(Icons.search);
  Widget title = Text("Rick And Morty");

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
        actions: <Widget>[
          IconButton(
              icon: searchIcon,
              onPressed: () {
                setState(() {
                  if (this.searchIcon.icon == Icons.search) {
                    this.searchIcon = Icon(Icons.cancel);
                    this.title = TextField(
                      controller: _controller,
                      onSubmitted: (String value) async {
                        await showDialog<void>(
                          context: context,
                          builder: (BuildContext context) {
                            return AlertDialog(
                              title: const Text('Thanks!'),
                              content: Text('You typed "$value".'),
                              actions: <Widget>[
                                FlatButton(
                                  onPressed: () {
                                    Navigator.pop(context);
                                  },
                                  child: const Text('OK'),
                                ),
                              ],
                            );
                          },
                        );
                      },
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 20.0,
                      ),
                    );
                  } else {
                    this.searchIcon = Icon(Icons.search);
                    this.title = Text("Rick And Morty");
                  }
                });
              })
        ],
        title: title,
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

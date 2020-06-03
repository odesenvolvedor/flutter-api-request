import 'package:api_request/details.dart';
import 'package:api_request/services/bloc_request.dart';
import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'API Request',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'API Request'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  BlocRequest blocRequest;

  @override
  void initState() {
    blocRequest = BlocRequest();
    blocRequest.buscar();
    super.initState();
  }

  Widget temporada(int temporada) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => Details(title: "Temporada $temporada")
          ),
        );
      },
      child: Container(
        height: 45.0,
        child: new Column(
          children: <Widget>[
            Container(
              padding: EdgeInsets.only(left: 15.0, right: 15.0, top: 15.0),
              child: new Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  new Container(
                    child: Text(
                      "Temporada $temporada",
                      textAlign: TextAlign.left,
                      style: TextStyle(fontSize: 16),
                      maxLines: 1,
                    ),
                  ),
                ],
              ),
            ),
            Container(
              padding: EdgeInsets.only(left: 15.0, right: 15.0, top: 0.0),
              child: Container(
                color: Theme.of(context).accentColor,
                height: 1.0,
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: blocRequest.saida,
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return Center(
            child: CircularProgressIndicator(),
          );
        } else {
          final totalSeasons = int.parse(snapshot.data["totalSeasons"]);
          return Scaffold(
            appBar: AppBar(
              title: Text(widget.title),
            ),
            body: Card(
              margin: EdgeInsets.all(20),
              elevation: 20,
              child: snapshot.hasData
                  ? Padding(
                      padding: EdgeInsets.all(20),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Image.network(snapshot.data["Poster"]),
                          SizedBox(height: 30),
                          Text(
                            snapshot.data["Title"],
                            style: Theme.of(context).textTheme.title,
                          ),
                          SizedBox(height: 15),
                          Text(
                            snapshot.data["Writer"],
                            style: Theme.of(context).textTheme.body1,
                          ),
                          SizedBox(height: 15),
                          Text(
                            "Temporadas",
                            style: Theme.of(context).textTheme.subhead,
                          ),
                          SizedBox(height: 15),
                          if (totalSeasons != null)
                            Expanded(
                              child: Container(
                                padding: EdgeInsets.fromLTRB(0, 10, 0, 10),
                                color: Colors.black12,
                                child: ListView.builder(
                                  itemCount: totalSeasons,
                                  itemBuilder:
                                      (BuildContext context, int index) {
                                    return temporada(index + 1);
                                  },
                                ),
                              ),
                            ),
                        ],
                      ),
                    )
                  : Text('Nenhum dado retornado'),
            ),
          );
        }
      },
    );
  }
}

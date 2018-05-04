import 'package:flutter/material.dart';
import 'package:redux/redux.dart';
import 'package:flutter_redux/flutter_redux.dart';


enum Actions {
  Increment
}

int reducer(int prev, action) {
  if (action == Actions.Increment) {
    return prev + 1;
  }
  return prev;
}

void main() {
  final store = new Store(reducer, initialState: 0);
  runApp(new MyHomePage(store: store,));
}


class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      title: "Redux Demo",
      theme: new ThemeData.dark(),
      debugShowCheckedModeBanner: false,
      home: new MyHomePage(),
    );
  }
}

class MyHomePage extends StatelessWidget {

  final Store<int> store;

  MyHomePage({Key key, this.store}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return new StoreProvider<int>(
        store: store,
        child: new MaterialApp(
          theme: ThemeData.dark(),
          title: "Redux Demo",
          home: new Scaffold(
            appBar: new AppBar(title: new Text("Redux App"),),
            body: new Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text("You have pushed the buttom this many times:"),
                  new StoreConnector<int,String>(builder: (context, counter) =>
                  new Text(counter, style: Theme
                      .of(context)
                      .textTheme
                      .display1,),
                    converter: (store) => store.state.toString(),),

                ],
              ),
            ),
            floatingActionButton: new StoreConnector<int, VoidCallback>(
                builder: (context, callback) =>
                new FloatingActionButton(
                    tooltip: "Increment",
                    child: new Icon(Icons.add),
                    onPressed: callback),
                converter: (store) {
                  return () => store.dispatch(Actions.Increment);
                }),
          ),
        ));
  }
}































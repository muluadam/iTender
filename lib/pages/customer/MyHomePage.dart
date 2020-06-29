import 'package:flutter/material.dart';


class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  List<bool> inputs = new List<bool>();
  @override
  void initState() {
    // TODO: implement initState
    setState(() {
      for(int i=0;i<20;i++){
        inputs.add(true);
      }
    });
  }

  void ItemChange(bool val,int index){
    setState(() {
      inputs[index] = val;
    });
  }
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return new Scaffold(
      appBar: new AppBar(
        title: new Text('Checked Listview'),
      ),
      body: new ListView.builder(
          itemCount: inputs.length,
          itemBuilder: (BuildContext context, int index){
            return new Card(
              child: new Container(
                padding: new EdgeInsets.all(10.0),
                child: new Column(
                  children: <Widget>[
                    new CheckboxListTile(
                        value: inputs[index],
                        title: new Text('item ${index}'),
                        controlAffinity: ListTileControlAffinity.leading,
                        onChanged:(bool val){ItemChange(val, index);}
                    )
                  ],
                ),
              ),
            );

          }
      ),
    );
  }
}
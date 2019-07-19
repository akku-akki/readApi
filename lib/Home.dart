import 'package:flutter/material.dart';
import 'dart:async';
import 'package:http/http.dart' as http;
import 'dart:convert';
class HomePage extends StatefulWidget {
  final String title;
  HomePage({
    Key key,

    @required this.title,

  }):super (key: key);
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final String url ="https://api.github.com/users";
  List data;
  var isLoding = true;
  @override
  void initState() {
    this.getJsondata();
    super.initState();
  }
  Future<String>  getJsondata()async{
  var res = await http.get(Uri.encodeFull(url));
   print(res.body);
   var convert = json.decode(res.body); 
   setState(() {
    
    data = convert;
    print(data);
    isLoding = false;
   });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
     body:  Container(
       child: Center(
         child: isLoding?CircularProgressIndicator():

          ListView.builder(
           itemCount: data.length,
           itemBuilder: (BuildContext context, index){
            return Card(
               child: Column(
                 crossAxisAlignment: CrossAxisAlignment.stretch,
                 children: <Widget>[
                  ListTile(
                    leading: Icon(Icons.people),
                    title: data.isEmpty ? Text("waiting") : Text(data[index]["login"],style: TextStyle(fontSize: 20.0),),
                    subtitle:data.isEmpty ? Text("waiting") : Text(data[index]["url"],style:TextStyle(fontSize: 15.0)),
                  )
                 ],

               ),
             );
           },
         ),
       ),
     ),
    );
  }
}
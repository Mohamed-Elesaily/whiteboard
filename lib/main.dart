import 'dart:io';

import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  var h;
  var w;
  var size=75;
  var colordot= Colors.black;

  TextEditingController dotSize =new TextEditingController();
  List<Positioned> dots = new List<Positioned>();
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'whiteboard',
      home: Scaffold(
          body: Stack(
        children: [
          for (var i in dots) i,
          GestureDetector(
            onTap: () => print('tapped!'),
            onPanUpdate: (details) => _onTapDown(details),
          ),
          Container(
            width: 80,
            color: Colors.grey[900],
            child: Column(children: [
              SizedBox(height: 10),
              Text(
                'Font Size',
                style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 10),
              ),
              SizedBox(height: 10),
              Container(
                decoration: BoxDecoration(
                    color: Colors.grey,
                    borderRadius: BorderRadius.all(Radius.circular(8))),
                height: 50,
                width: 50,
                child: TextField(
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.white,
                  ),
                  controller: dotSize,
                   onChanged: (dotsize) => {size = int.parse(dotsize)},
                ),
              ),
              SizedBox(height: 50),
              IconButton(
                  tooltip: 'Clear',
                  icon: Icon(
                    Icons.layers_clear,
                    size: 50,
                    color: Colors.white,
                  ),
                  onPressed: () {
                    setState(() {
                      dots.clear();
                      print(dots.length);
                    });
                  }),
                  SizedBox(
                    height:50
                  ),
                
              DropdownButton<Color>(
                 value: colordot,
                icon: Icon(Icons.arrow_downward),
                iconSize: 24,
                elevation: 2,
                style: TextStyle(color: Colors.white),
                underline: Container(
                  height: 5,
                  color: Colors.white,
                ),
                onChanged: (Color newValue) {
                  setState(() {
                
                    colordot = newValue;
                  });
                },
                items: <Color>[Colors.white, Colors.black, Colors.green, Colors.blue,Colors.red]
                    .map<DropdownMenuItem<Color>>((Color value) {
                  return DropdownMenuItem<Color>(
                    value: value,
                    child: colorBox(value),
                  ); 
                }).toList(),
              ),
              SizedBox(height: 250),
              IconButton(
                tooltip: 'Close App',
                  icon: Icon(
                    Icons.exit_to_app,
                    size: 50,
                    color: Colors.white,
                    
                  ),
                  onPressed: () {
                    exit(0);
                  }),
                 
            ]),
          ),
        ],
      )),
    );
  }

  _onTapDown(DragUpdateDetails details) {
    setState(() {
      w = details.globalPosition.dx;
      h = details.globalPosition.dy;
      dots.add(dot(w, h,size, colordot));
    });
 
    print("tap down " + w.toString() + ", " + h.toString());
  }

  Positioned dot(var horizontal, var vertical, var size, var color) {
    return Positioned(
        left: horizontal,
        top: vertical,
        child: Container(
          height: size / 1,
          width: size / 1,
          decoration: new BoxDecoration(
            color: color,
            shape: BoxShape.circle,
          ),
        ));
  }
  Container colorBox(var color){
    return Container(
      height: 25,
      width:25,
           decoration: BoxDecoration(
                    color: color,
                    
                    borderRadius: BorderRadius.all(Radius.circular(8)),
                    border: Border.all(color: Colors.black)
                    ),

    );
  }
}

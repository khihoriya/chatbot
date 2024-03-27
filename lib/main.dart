import 'package:chatbot/pages/home_page.dart';
import 'package:chatbot/pages/image_page.dart';
import 'package:flutter/material.dart';

void main(){
  runApp(MaterialApp(home: Myapp(),));
}

class Myapp extends StatelessWidget {
  const Myapp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(home: homepage(),);
  }
}

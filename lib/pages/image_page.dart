import 'package:flutter/material.dart';

class imagepage extends StatefulWidget {
  const imagepage({Key? key}) : super(key: key);

  @override
  State<imagepage> createState() => _imagepageState();
}

class _imagepageState extends State<imagepage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.grey,
        title: Center(child: Text("Generating Images 🚀")),
      ),
      body: Container(
        height: double.maxFinite,
        width: double.maxFinite,
        decoration: BoxDecoration(
            image: DecorationImage(
                image: AssetImage("image/i1.jpg"), fit: BoxFit.cover)),
        child: Column(
          children: [
            Expanded(
              child: Container(
                color: Colors.pinkAccent,
              ),
            ),
            Container(
              padding: EdgeInsets.symmetric(vertical: 10, horizontal: 16),
              child: Row(
                children: [
                  Expanded(
                      child: TextField(

                        cursorColor: Colors.black,
                        style: TextStyle(
                          color: Colors.black,
                        ),
                        decoration: InputDecoration(
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(100)),
                            fillColor: Colors.white,
                            hintText: 'Enter your prompt',
                            filled: true,
                            focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(100),
                                borderSide: BorderSide(color: Colors.white))),
                      )),
                  SizedBox(width: 20,),
                  InkWell(
                    onTap: () {
                      
                    },
                    child: CircleAvatar(
                      radius: 32,
                      backgroundColor: Colors.white,
                      child: CircleAvatar(
                        radius: 30,
                        backgroundColor: Colors.grey.shade900,
                        child: Center(
                            child: Icon(
                              Icons.generating_tokens,
                              color: Colors.white,
                            )),
                      ),
                    ),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}

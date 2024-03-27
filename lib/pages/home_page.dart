import 'package:chatbot/bloc/chat_bloc.dart';
import 'package:chatbot/bloc/chat_event.dart';
import 'package:chatbot/bloc/chat_state.dart';
import 'package:chatbot/models/chat_message_model.dart';
import 'package:chatbot/pages/image_page.dart';
import 'package:chatbot/walppapers.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:lottie/lottie.dart';
import 'package:shared_preferences/shared_preferences.dart';

class homepage extends StatefulWidget {
  const homepage({Key? key}) : super(key: key);

  @override
  State<homepage> createState() => _homepageState();
}

class _homepageState extends State<homepage> {
  final ChatBloc chatbloc = ChatBloc();

  TextEditingController txt1 = TextEditingController();

  TextEditingController personname = TextEditingController();

  String userName = "User";

  String default_background = "image/i1.jpg";

  @override
  void initState() {
    super.initState();
    _loadWallpaper();
  }

  Future<void> _loadWallpaper() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      default_background = prefs.getString('wallpaper') ?? "image/i1.jpg";
    });
  }

  @override
  Widget build(BuildContext context) {
    WallpaperCallback.registerCallback((String imagePath) {
      // Update the background image
      setState(() {
        default_background = imagePath;
      });
    });
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.teal,
          actions: [InkWell(
            onTap: () {
              showDialog(
                context: context,
                builder: (BuildContext context) {
                  return AlertDialog(
                    title: Text("Confirm Action"),
                    content: TextField(
                        controller: personname,
                        decoration: InputDecoration(
                            hintText: "Enter your name")),
                    actions: [
                      TextButton(
                        onPressed: () {
                          Navigator.of(context)
                              .pop(); // Close the dialog
                        },
                        child: Text("Cancel"),
                      ),
                      TextButton(
                        onPressed: () {
                          setState(() {
                            userName =
                            personname.text.isNotEmpty
                                ? personname.text
                                : "User";
                            personname.clear();
                          });
                          Navigator.of(context).pop();
                        },
                        child: Text("Submit"),
                      ),
                    ],
                  );
                },
              );
            },
            child: Icon(
              Icons.edit,
              color: Colors.black,
            ),
          ),
            InkWell(
              onTap: () {
                Navigator.push(context, MaterialPageRoute(
                  builder: (context) {
                    return Wallpaper();
                  },
                ));
              },
              child: Icon(
                Icons.image_search,
                color: Colors.black,
              ),
            )],
          title: Text(
            "Chat AI ",
            style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold),
          ),
        ),
        body: BlocConsumer<ChatBloc, ChatState>(
          bloc: chatbloc,
          listener: (context, state) {},
          builder: (context, state) {
            switch (state.runtimeType) {
              case ChatSucessState:
                List<ChatMessageModel> messages =
                    (state as ChatSucessState).messages;

                return Container(
                  width: double.maxFinite,
                  height: double.maxFinite,
                  decoration: BoxDecoration(
                      image: DecorationImage(
                          image: AssetImage(default_background),
                          fit: BoxFit.cover)),
                  child: Column(
                    children: [
                      Container(
                        padding: EdgeInsets.symmetric(horizontal: 16),
                        height: 30,
                      ),
                      Expanded(
                          child: ListView.builder(
                        itemCount: messages.length,
                        itemBuilder: (context, index) {
                          return Container(
                              margin: EdgeInsets.only(
                                  bottom: 12, right: 16, left: 16),
                              padding: EdgeInsets.all(16),
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(16)),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    messages[index].role == "user"
                                        ? userName
                                        : "Chat AI",
                                    style: TextStyle(
                                        fontSize: 15,
                                        color: messages[index].role == "user"
                                            ? Colors.amber
                                            : Colors.green),
                                  ),
                                  SizedBox(
                                    height: 12,
                                  ),
                                  InkWell(
                                    onTap: () {
                                      _copyToClipboard(
                                          messages[index].parts.first.text);
                                    },
                                    child: Text(
                                      messages[index].parts.first.text,
                                      style: TextStyle(
                                          height: 1.2, color: Colors.black),
                                    ),
                                  )
                                ],
                              ));
                        },
                      )),
                      if (chatbloc.generating)
                        Container(
                            height: 50,
                            width: 50,
                            color: Colors.white,
                            child: Lottie.asset(
                                "lottie/Animation - 1711536314076.json")),
                      Container(
                        padding:
                            EdgeInsets.symmetric(vertical: 10, horizontal: 16),
                        child: Row(
                          children: [
                            Expanded(
                                child: TextField(
                              controller: txt1,
                              cursorColor: Colors.black,
                              style: TextStyle(
                                color: Colors.black,
                              ),
                              decoration: InputDecoration(
                                  border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(100)),
                                  fillColor: Colors.white,
                                  hintText: 'Ask a question',
                                  filled: true,
                                  focusedBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(100),
                                      borderSide:
                                          BorderSide(color: Colors.white))),
                            )),
                            SizedBox(
                              width: 20,
                            ),
                            InkWell(
                              onTap: () {
                                if (txt1.text.isNotEmpty) {
                                  String text = txt1.text;
                                  txt1.clear();
                                  chatbloc.add(ChatGenerateNewTextMessageEVent(
                                      inputmessage: text));
                                }
                              },
                              child: CircleAvatar(
                                radius: 32,
                                backgroundColor: Colors.white,
                                child: CircleAvatar(
                                  radius: 30,
                                  backgroundColor: Colors.grey.shade900,
                                  child: Center(
                                      child: Icon(
                                    Icons.send,
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
                );

              default:
                return SizedBox(
                  child: Text("Something went wrong"),
                );
            }
          },
        ));
  }

  void _copyToClipboard(String text) {
    Clipboard.setData(ClipboardData(text: text));
    Fluttertoast.showToast(
      msg: 'Text copied to clipboard',
      toastLength: Toast.LENGTH_LONG,
      gravity: ToastGravity.TOP_RIGHT,
      timeInSecForIosWeb: 1,
      backgroundColor: Colors.orangeAccent,
      textColor: Colors.black,
    );
  }
}

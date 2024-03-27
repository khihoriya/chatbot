import 'package:chatbot/pages/home_page.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Wallpaper extends StatefulWidget {
  const Wallpaper({Key? key}) : super(key: key);

  @override
  State<Wallpaper> createState() => _WallpaperState();
}

class _WallpaperState extends State<Wallpaper> {
  List<String> image = [
    "image/wall7.jpg",
    "image/wall8.jpg",
    "image/wall9.jpg",
    "image/krishna5.jpg",
    "image/wall10.jpg",
    "image/krishna.jpg",
    "image/wall11.jpg",
    "image/wall12.jpg",
    "image/wall13.jpg",
    "image/krishna2.jpg",
    "image/krishna3.jpg",
    "image/wall14.jpg",
    "image/wall15.jpg",
    "image/krishna4.jpg",
    "image/krishna6.jpg",

    "image/wall16.jpg",
  ];

  late SharedPreferences _prefs;

  @override
  void initState() {
    super.initState();
    _initPrefs();
  }

  Future<void> _initPrefs() async {
    _prefs = await SharedPreferences.getInstance();
  }

  Future<void> _saveWallpaper(String imagePath) async {
    await _prefs.setString('wallpaper', imagePath);
  }

  String? _getWallpaper() {
    return _prefs.getString('wallpaper');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.teal,
        title: Text(
          "Choose Background",
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: GridView.builder(
        itemCount: image.length,
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
        ),
        itemBuilder: (context, index) {
          return GestureDetector(
            onTap: () async {
              WallpaperCallback.changeBackground!(image[index]);
              await _saveWallpaper(image[index]).then((value) {
                Navigator.pushReplacement(context, MaterialPageRoute(
                  builder: (context) {
                    return homepage();
                  },
                ));
              });
            },
            child: Container(
              margin: EdgeInsets.all(10),
              height: 200,
              width: 200,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage(image[index]),
                  fit: BoxFit.fill,
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}

// Define a callback function type
typedef void WallpaperChangeCallback(String imagePath);

class WallpaperCallback {
  // Callback function to change the background image
  static WallpaperChangeCallback? changeBackground;

  static void registerCallback(WallpaperChangeCallback callback) {
    changeBackground = callback;
  }
}

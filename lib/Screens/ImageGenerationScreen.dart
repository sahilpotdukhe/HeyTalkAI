import 'package:flutter/material.dart';
import 'package:heytalkai/Services/ApiService.dart';

class ImageGenerationScreen extends StatefulWidget {
  const ImageGenerationScreen({super.key});

  @override
  State<ImageGenerationScreen> createState() => _ImageGenerationScreenState();
}

class _ImageGenerationScreenState extends State<ImageGenerationScreen> {
  TextEditingController imageTextController = TextEditingController();
  String generatedImageurl = "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey,
      appBar: AppBar(
        title: Text("DALL-E"),
      ),
      body: ListView(
        children: [
          Text("Please enter text to generate AI Image"),
          Padding(
            padding: const EdgeInsets.all(18.0),
            child: TextField(
              controller: imageTextController,
              decoration: InputDecoration(
                  hintText: 'Prompt DALL-E..',
                  hintStyle: TextStyle(fontSize: 16, color: Colors.white),
                  labelText: 'Type your text prompt',
                  floatingLabelStyle: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w500,
                      color: Colors.white),
                  labelStyle: TextStyle(fontSize: 16, color: Colors.white),
                  focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.white, width: 2)),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.white, width: 2),
                  ),
                  suffixIcon: IconButton(
                    icon: Icon(Icons.send),
                    onPressed: () async {
                      // generatedImageurl = await ApiService.generateImage(
                      //     userPrompt: imageTextController.text);
                      // setState(() {});
                    },
                    color: Colors.white,
                  )),
              onSubmitted: (value) async {
                // generatedImageurl = await ApiService.generateImage(
                //     userPrompt: imageTextController.text);
                // setState(() {});
              },
            ),
          ),
          (generatedImageurl != "")
              ? Container(
                  height: 500,
                  width: 500,
                  child: Image.network(generatedImageurl))
              : Container(
                  height: 500,
                  width: 500,
                  color: Colors.green,
                  child: Text('Image'),
                )
        ],
      ),
    );
  }
}

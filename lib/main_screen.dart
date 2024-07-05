import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  Future<void> getData() async {
    try {
      Response response = await Dio().get(
          "https:3//flutterapitest-8d075-default-rtdb.asia-southeast1.firebasedatabase.app/bucketlist.json");
      print(response.data);
    } catch (e) {
      showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
              title: Text(
                  "Can not connect to the server. Try again after some time."),
            );
          });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Rb Image Bucket"),
        centerTitle: true,
      ),
      body: ElevatedButton(onPressed: getData, child: Text("Get Data")),
    );
  }
}

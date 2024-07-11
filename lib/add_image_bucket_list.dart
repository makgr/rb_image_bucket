import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

class AddImageBucketList extends StatefulWidget {
  int newIndex;
  AddImageBucketList({super.key, required this.newIndex});

  @override
  State<AddImageBucketList> createState() => _AddImageBucketListState();
}

class _AddImageBucketListState extends State<AddImageBucketList> {
  Future<void> addImage() async {
    try {
      Map<String, dynamic> data = {
        "item": "amazing coxsbazar",
        "cost": 6000,
        "image":
            "https://images.unsplash.com/photo-1619177383949-f03975e50b19?q=80&w=1932&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D",
        "completed": false
      };

      Response response = await Dio().patch(
          "https://flutterapitest-8d075-default-rtdb.asia-southeast1.firebasedatabase.app/bucketlist/${widget.newIndex}.json",
          data: data);
      Navigator.pop(context, "refresh");
    } catch (e) {
      print("error");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text("Add Image in Bucket"),
      ),
      body: ElevatedButton(onPressed: addImage, child: Text("Add Image")),
    );
  }
}

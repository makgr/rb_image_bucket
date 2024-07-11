import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

class AddImageBucketList extends StatefulWidget {
  int newIndex;
  AddImageBucketList({super.key, required this.newIndex});

  @override
  State<AddImageBucketList> createState() => _AddImageBucketListState();
}

class _AddImageBucketListState extends State<AddImageBucketList> {
  TextEditingController itemText = TextEditingController();
  TextEditingController costText = TextEditingController();
  TextEditingController imageText = TextEditingController();

  Future<void> addImage() async {
    try {
      Map<String, dynamic> data = {
        "item": itemText.text,
        "cost": costText.text,
        "image": imageText.text,
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
    var addForm = GlobalKey<FormState>();

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text("Add Image in Bucket"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Form(
          key: addForm,
          child: Column(
            children: [
              TextFormField(
                validator: (value) {
                  
                },
                controller: itemText,
                decoration: InputDecoration(
                  label: Text("Item"),
                ),
              ),
              SizedBox(
                height: 30,
              ),
              TextFormField(
                controller: costText,
                decoration: InputDecoration(
                  label: Text("Cost"),
                ),
              ),
              SizedBox(
                height: 30,
              ),
              TextFormField(
                controller: imageText,
                decoration: InputDecoration(
                  label: Text("Image Link"),
                ),
              ),
              SizedBox(
                height: 30,
              ),
              Row(
                children: [
                  Expanded(
                    child: ElevatedButton(
                      onPressed: addImage,
                      child: Text("Add Image"),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.amber,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

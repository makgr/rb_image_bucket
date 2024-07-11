import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

class ViewItem extends StatefulWidget {
  String title;
  String image;
  int index;
  ViewItem(
      {super.key,
      required this.title,
      required this.image,
      required this.index});

  @override
  State<ViewItem> createState() => _ViewItemState();
}

class _ViewItemState extends State<ViewItem> {
  Future<void> deleteData() async {
    Navigator.pop(context);
    try {
      Response response = await Dio().delete(
          "https://flutterapitest-8d075-default-rtdb.asia-southeast1.firebasedatabase.app/bucketlist/${widget.index}.json");
      Navigator.pop(context, "refresh");
    } catch (e) {
      print("error");
    }
  }

  Future<void> markAsComplete() async {
    try {
      Map<String, dynamic> data = {"completed": true};

      Response response = await Dio().patch(
          "https://flutterapitest-8d075-default-rtdb.asia-southeast1.firebasedatabase.app/bucketlist/${widget.index}.json",
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
        title: Text(widget.title),
        actions: [
          PopupMenuButton(onSelected: (value) {
            if (value == 1) {
              showDialog(
                  context: context,
                  builder: (context) {
                    return AlertDialog(
                      title: Text("Are you sure to delete?"),
                      actions: [
                        InkWell(
                          onTap: () {
                            Navigator.pop(context);
                          },
                          child: Text("Cancel"),
                        ),
                        InkWell(
                          onTap: deleteData,
                          child: Text("Confirm"),
                        ),
                      ],
                    );
                  });
            }
            if (value == 2) {
              markAsComplete();
            }
          }, itemBuilder: (context) {
            return [
              PopupMenuItem(value: 1, child: Text("Delete")),
              PopupMenuItem(
                value: 2,
                child: Text("Mark as Complete"),
              ),
            ];
          }),
        ],
      ),
      body: Column(
        children: [
          Container(
            height: 300,
            width: double.infinity,
            decoration: BoxDecoration(
              image: DecorationImage(
                image: NetworkImage(widget.image),
                fit: BoxFit.cover,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

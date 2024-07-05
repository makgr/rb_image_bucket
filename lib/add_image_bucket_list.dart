import 'package:flutter/material.dart';

class AddImageBucketList extends StatefulWidget {
  const AddImageBucketList({super.key});

  @override
  State<AddImageBucketList> createState() => _AddImageBucketListState();
}

class _AddImageBucketListState extends State<AddImageBucketList> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text("Add Image in Bucket"),
      ),
    );
  }
}

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  List<dynamic> imageBucketListData = [];

  bool isLoading = false;

  Future<void> getData() async {
    setState(() {
      isLoading = true;
    });
    try {
      Response response = await Dio().get(
          "https://flutterapitest-8d075-default-rtdb.asia-southeast1.firebasedatabase.app/bucketlist.json");
      imageBucketListData = response.data;
      isLoading = false;
      setState(() {});
    } catch (e) {
      isLoading = false;
      setState(() {});
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
  void initState() {
    getData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Rb Image Bucket"),
        centerTitle: true,
        actions: [
          InkWell(
            onTap: getData,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Icon(Icons.refresh),
            ),
          ),
        ],
      ),
      body: RefreshIndicator(
        onRefresh: () async {
          getData();
        },
        child: isLoading
            ? Center(child: CircularProgressIndicator())
            : ListView.builder(
                itemCount: imageBucketListData.length,
                itemBuilder: (BuildContext context, int index) {
                  return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: ListTile(
                      leading: CircleAvatar(
                        backgroundImage: NetworkImage(imageBucketListData[index]
                                ['image'] ??
                            "https://scontent.fdac14-1.fna.fbcdn.net/v/t39.30808-6/428629326_3624898381084843_3442857291648613134_n.jpg?_nc_cat=106&ccb=1-7&_nc_sid=6ee11a&_nc_ohc=z-A-PwcH2ioQ7kNvgEQDL4c&_nc_ht=scontent.fdac14-1.fna&oh=00_AYDpxfJk64oKZbWOKgHcAQuzyhJhLB3Kl-NmTmO69RNE9w&oe=668E20C5"),
                      ),
                      title: Text(imageBucketListData[index]['item'] ?? "N/A"),
                      trailing: Text(
                        imageBucketListData[index]['cost'].toString(),
                        style: TextStyle(fontSize: 15),
                      ),
                    ),
                  );
                }),
      ),
    );
  }
}

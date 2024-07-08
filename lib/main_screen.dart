import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'package:rb_image_bucket/add_image_bucket_list.dart';
import 'package:rb_image_bucket/view_item.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  List<dynamic> imageBucketListData = [];

  bool isLoading = false;
  bool isError = false;

  Future<void> getData() async {
    setState(() {
      isLoading = true;
    });
    try {
      Response response = await Dio().get(
          "https://flutterapitest-8d075-default-rtdb.asia-southeast1.firebasedatabase.app/bucketlist.json");

      if (response.data is List) {
        imageBucketListData = response.data;
      } else {
        imageBucketListData = [];
      }
      isLoading = false;
      isError = false;
      setState(() {});
    } catch (e) {
      isLoading = false;
      isError = true;
      setState(() {});
    }
  }

  @override
  void initState() {
    getData();
    super.initState();
  }

  Widget errorWidget({required String errorText}) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.warning),
          Text(errorText),
          ElevatedButton(
              onPressed: () {
                getData();
              },
              child: Text("Try Again")),
        ],
      ),
    );
  }

  Widget listDataWidget() {
    List<dynamic> filteredList = imageBucketListData
        .where((element) => (!element?["completed"] ?? false))
        .toList();

    return filteredList.length < 1
        ? Center(child: Text("No data found."))
        : ListView.builder(
            itemCount: imageBucketListData.length,
            itemBuilder: (BuildContext context, int index) {
              return Padding(
                padding: const EdgeInsets.all(8.0),
                child: (imageBucketListData[index] is Map &&
                        (!imageBucketListData[index]?["completed"] ?? false))
                    ? ListTile(
                        onTap: () {
                          Navigator.push(context,
                              MaterialPageRoute(builder: (context) {
                            return ViewItem(
                              title:
                                  imageBucketListData[index]['item'] ?? "N/A",
                              image: imageBucketListData[index]['image'] ??
                                  "https://scontent.fdac14-1.fna.fbcdn.net/v/t39.30808-6/428629326_3624898381084843_3442857291648613134_n.jpg?_nc_cat=106&ccb=1-7&_nc_sid=6ee11a&_nc_ohc=z-A-PwcH2ioQ7kNvgEQDL4c&_nc_ht=scontent.fdac14-1.fna&oh=00_AYDpxfJk64oKZbWOKgHcAQuzyhJhLB3Kl-NmTmO69RNE9w&oe=668E20C5",
                              index: index,
                            );
                          })).then((value) {
                            if (value == "refresh") {
                              getData();
                            }
                          });
                        },
                        leading: CircleAvatar(
                          backgroundImage: NetworkImage(imageBucketListData[
                                  index]?['image'] ??
                              "https://scontent.fdac14-1.fna.fbcdn.net/v/t39.30808-6/428629326_3624898381084843_3442857291648613134_n.jpg?_nc_cat=106&ccb=1-7&_nc_sid=6ee11a&_nc_ohc=z-A-PwcH2ioQ7kNvgEQDL4c&_nc_ht=scontent.fdac14-1.fna&oh=00_AYDpxfJk64oKZbWOKgHcAQuzyhJhLB3Kl-NmTmO69RNE9w&oe=668E20C5"),
                        ),
                        title:
                            Text(imageBucketListData[index]?['item'] ?? "N/A"),
                        trailing: Text(
                          imageBucketListData[index]?['cost'].toString() ?? '0',
                          style: TextStyle(fontSize: 15),
                        ),
                      )
                    : SizedBox(),
              );
            });
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
            : isError
                ? errorWidget(errorText: "Error connecting..")
                : listDataWidget(),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(context, MaterialPageRoute(builder: (context) {
            return AddImageBucketList();
          }));
        },
        backgroundColor: Colors.amber,
        child: Icon(
          Icons.add,
        ),
      ),
    );
  }
}

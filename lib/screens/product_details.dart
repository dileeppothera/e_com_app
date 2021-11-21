import 'package:carousel_slider/carousel_slider.dart';
import 'package:ecom/models/prodetailModel.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';

import 'cart.dart';

class ProDetail extends StatefulWidget {
  String id;
  ProDetail(this.id);
  @override
  _ProDetailState createState() => _ProDetailState();
}

class _ProDetailState extends State<ProDetail> {
  late Future detail;
  late ProductDetail? prdet;
  bool flag = false;
  bool hasDat = false;
  @override
  void initState() {
    hasDat = false;
    detail = getProductDetails(widget.id);
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.red,
        elevation: 0.0,
        title: Text("Item Details"),
      ),
      body: SingleChildScrollView(
        child: FutureBuilder(
          future: detail,
          builder: (c, snap) {
            if (snap.hasData) {
              hasDat = true;
              prdet = snap.data as ProductDetail?;
              return Column(
                children: [
                  CarouselSlider(
                    options: CarouselOptions(
                        height: 280.0, autoPlay: true, enlargeCenterPage: true),
                    items: prdet!.images.map((i) {
                      return Builder(
                        builder: (BuildContext context) {
                          return Container(
                              width: MediaQuery.of(context).size.width,
                              margin: EdgeInsets.symmetric(horizontal: 1.0),
                              decoration: BoxDecoration(color: Colors.white),
                              child: Image.network(i.toString()));
                        },
                      );
                    }).toList(),
                  ),
                  // Image.network(prdet!.images[0].toString()),
                  TitleText(prdet!.name.toString()),
                  SizedBox(
                    height: 10,
                  ),
                  Text(
                    "OMR " + prdet!.price.toString(),
                    style: TextStyle(color: Colors.red),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Center(child: Text("Color")),
                        Padding(
                          padding: const EdgeInsets.all(30.0),
                          child: Container(
                              height: 40,
                              width: 40,
                              child: prdet!.attr["color"].isEmpty
                                  ? Container(child: Text("Not Available"))
                                  : Image.network(
                                      prdet!.attr["color"].toString())),
                        ),
                      ],
                    ),
                  ),

                  prdet!.attr['specs'] == []
                      ? Container()
                      : Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          // mainAxisSize: MainAxisSize.min,
                          children: prdet!.attr['specs'].isEmpty
                              ? []
                              : [
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceAround,
                                    children: [
                                      Column(
                                        children: [
                                          Container(
                                            height: 30,
                                            width: 30,
                                            child: Image.network(prdet!
                                                .attr['specs'][0]['icon']
                                                .toString()),
                                          ),
                                          Center(
                                              child: Text(prdet!.attr['specs']
                                                      [0]['value']
                                                  .toString())),
                                        ],
                                      ),
                                      Column(
                                        children: [
                                          Container(
                                            height: 30,
                                            width: 30,
                                            child: Image.network(prdet!
                                                .attr['specs'][1]['icon']
                                                .toString()),
                                          ),
                                          Center(
                                              child: Text(prdet!.attr['specs']
                                                      [1]['value']
                                                  .toString())),
                                        ],
                                      ),
                                      Column(
                                        children: [
                                          Container(
                                            height: 30,
                                            width: 30,
                                            child: Image.network(prdet!
                                                .attr['specs'][2]['icon']
                                                .toString()),
                                          ),
                                          Center(
                                              child: Text(prdet!.attr['specs']
                                                      [2]['value']
                                                  .toString())),
                                        ],
                                      ),
                                    ],
                                  ),
                                  SizedBox(
                                    height: 30,
                                  ),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    children: [
                                      // SizedBox(width: 0),
                                      Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Container(
                                            height: 30,
                                            width: 30,
                                            child: Image.network(prdet!
                                                .attr['specs'][3]['icon']
                                                .toString()),
                                          ),
                                          Center(
                                              child: Text(prdet!.attr['specs']
                                                      [3]['value']
                                                  .toString())),
                                        ],
                                      ),
                                      Column(
                                        children: [
                                          Container(
                                            height: 30,
                                            width: 30,
                                            child: Image.network(prdet!
                                                .attr['specs'][4]['icon']
                                                .toString()),
                                          ),
                                          Center(
                                              child: Text(prdet!.attr['specs']
                                                      [4]['value']
                                                  .toString())),
                                        ],
                                      ),
                                      Column(
                                        children: [
                                          Container(
                                            height: 30,
                                            width: 30,
                                            child: Image.network(prdet!
                                                .attr['specs'][5]['icon']
                                                .toString()),
                                          ),
                                          Center(
                                              child: Text(prdet!.attr['specs']
                                                      [5]['value']
                                                  .toString())),
                                        ],
                                      ),
                                    ],
                                  ),
                                ],
                        ),

                  SizedBox(height: 20),
                  TitleText("About"),
                  SizedBox(
                    height: 10,
                  ),
                  InkWell(
                      onTap: () {
                        setState(() {
                          flag = !flag;
                        });
                      },
                      child: flag == false
                          ? Text("View more",
                              style: TextStyle(color: Colors.blue))
                          : Text("Show less...",
                              style: TextStyle(color: Colors.blue))),
                  flag == true
                      ? Html(data: prdet!.description.toString())
                      : Container(),
                ],
              );
              // return Text(prdet!.description.toString());
            }
            return Center(child: CircularProgressIndicator());
          },
        ),
      ),
      bottomSheet: Container(
        width: MediaQuery.of(context).size.width,
        height: 60,
        child: ElevatedButton(
          child: Text("Add to Cart"),
          onPressed: () {
            Navigator.push(context, MaterialPageRoute(builder: (context) {
              return Cart(
                prd: prdet as ProductDetail,
              );
            }));
          },
        ),
      ),
    );
  }
}

class TitleText extends StatelessWidget {
  TitleText(this.text);
  String text;
  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: TextStyle(
        fontWeight: FontWeight.bold,
        fontSize: 20,
      ),
    );
  }
}

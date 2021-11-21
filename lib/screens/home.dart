// ignore_for_file: unnecessary_null_comparison

import 'package:ecom/models/homescreenModel.dart';
import 'package:ecom/models/otherModel.dart';
import 'package:ecom/screens/product_details.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  Welcome? home;
  List<Product>? productDet;
  Future homePhone = Future(() => null);
  Future product = Future(() => null);

  @override
  void initState() {
    homePhone = getData();
    product = getProduct();
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.red,
      body: Column(
        children: [
          Flexible(
            flex: 0,
            child: Container(
              height: 50,
              width: MediaQuery.of(context).size.width,
              color: Colors.red,
              child: Center(
                child: SearchWidget(),
              ),
            ),
          ),
          Flexible(
            flex: 0,
            child: Container(
              color: Colors.white,
              child: FutureBuilder(
                  future: homePhone,
                  builder: (c, snap) {
                    if (snap.hasData) {
                      home = snap.data as Welcome?;
                      return CarouselSlider(
                        options: CarouselOptions(height: 180.0, autoPlay: true),
                        items: home!.data.slider.map((i) {
                          return Builder(
                            builder: (BuildContext context) {
                              return Container(
                                  width: MediaQuery.of(context).size.width,
                                  margin: EdgeInsets.symmetric(horizontal: 1.0),
                                  decoration:
                                      BoxDecoration(color: Colors.white),
                                  child: Image.network(i.image.toString()));
                            },
                          );
                        }).toList(),
                      );
                    }
                    return Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: CircularProgressIndicator(),
                    );
                  }),
            ),
          ),
          FutureBuilder(
            future: product,
            builder: (c, s) {
              if (s.hasData) {
                productDet = s.data as List<Product>?;
                return Flexible(
                  flex: 12,
                  child: Container(
                    color: Colors.white,
                    child: ListView.builder(
                        shrinkWrap: true,
                        itemCount: productDet!.length,
                        itemBuilder: (c, i) {
                          if (productDet![i].type == 'productlist') {
                            return Column(
                              children: [
                                ListTile(
                                  trailing: ElevatedButton(
                                    onPressed: () {},
                                    child: Text("View All"),
                                  ),
                                  title: Text(
                                    productDet![i].data.title.toString(),
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 18,
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(2.0),
                                  child: Container(
                                    color: Colors.white,
                                    child: GridView.builder(
                                      shrinkWrap: true,
                                      itemCount:
                                          productDet![i].data.items.length,
                                      itemBuilder: (c, index) {
                                        return Padding(
                                          padding: const EdgeInsets.all(10.0),
                                          child: InkWell(
                                            onTap: () {
                                              Navigator.push(context,
                                                  MaterialPageRoute(
                                                      builder: (context) {
                                                return ProDetail(productDet![i]
                                                    .data
                                                    .items[index]
                                                    .id);
                                              }));
                                            },
                                            child: GridTile(
                                              child: Padding(
                                                padding:
                                                    const EdgeInsets.all(15.0),
                                                child: Center(
                                                    // ignore: unnecessary_null_comparison
                                                    child: productDet![i]
                                                                .data
                                                                .items[index]
                                                                .image !=
                                                            null
                                                        ? Image.network(
                                                            "https://omanphone.smsoman.com/pub/media/catalog/product/" +
                                                                productDet![i]
                                                                    .data
                                                                    .items[
                                                                        index]
                                                                    .image
                                                                    .trim())
                                                        : Text(
                                                            "No img to display")),
                                              ),
                                              header: Container(
                                                color: Colors.amber,
                                                child: Center(
                                                  child: Text(
                                                    productDet![i]
                                                        .data
                                                        .items[index]
                                                        .name,
                                                    style: TextStyle(
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      fontSize: 15,
                                                    ),
                                                  ),
                                                ),
                                              ),
                                              footer: Center(
                                                child: Text(
                                                  "OMR " +
                                                      productDet![i]
                                                          .data
                                                          .items[index]
                                                          .price
                                                          .toString(),
                                                  style: TextStyle(
                                                    fontWeight: FontWeight.bold,
                                                    color: Colors.red,
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ),
                                        );
                                      },
                                      gridDelegate:
                                          SliverGridDelegateWithFixedCrossAxisCount(
                                              crossAxisCount: 2),
                                    ),
                                  ),
                                ),
                              ],
                            );
                          }
                          if (productDet![i].type == 'banner') {
                            return Image.network(
                                productDet![i].data.file!.trim());
                          }
                          return Container();
                        }),
                  ),
                );
                // Column(
                //   children: [
                //     Container(
                //       color: Colors.white,
                //       height: 60,
                //       width: MediaQuery.of(context).size.width,
                //       child: Row(
                //         mainAxisAlignment: MainAxisAlignment.spaceAround,
                //         children: [
                //           Text(
                //             productDet![0].data.title.toString(),
                //             style: TextStyle(
                //               fontWeight: FontWeight.bold,
                //               fontSize: 18,
                //             ),
                //           ),
                //           ElevatedButton(
                //             onPressed: () {},
                //             child: Text("View All"),
                //           ),
                //         ],
                //       ),
                //     ),
                //     Container(
                //       color: Colors.white,
                //       child: GridView.builder(
                //         shrinkWrap: true,
                //         itemCount: productDet![0].data.items.length,
                //         itemBuilder: (c, i) {
                //           return Padding(
                //             padding: const EdgeInsets.all(8.0),
                //             child: GridTile(
                //               child: Padding(
                //                 padding: const EdgeInsets.all(8.0),
                //                 child: Center(
                //                     child: Image.network(
                //                         "https://omanphone.smsoman.com/pub/media/catalog/product/" +
                //                             productDet![0]
                //                                 .data
                //                                 .items[i]
                //                                 .image
                //                                 .trim())),
                //               ),
                //               header: Center(
                //                 child: Text(
                //                   productDet![0].data.items[i].name,
                //                   style: TextStyle(
                //                     fontWeight: FontWeight.bold,
                //                   ),
                //                 ),
                //               ),
                //               footer: Center(
                //                 child: Text(
                //                   "OMR " +
                //                       productDet![0]
                //                           .data
                //                           .items[i]
                //                           .price
                //                           .toString(),
                //                   style: TextStyle(
                //                     fontWeight: FontWeight.bold,
                //                     color: Colors.red,
                //                   ),
                //                 ),
                //               ),
                //             ),
                //           );
                //         },
                //         gridDelegate:
                //             SliverGridDelegateWithFixedCrossAxisCount(
                //                 crossAxisCount: 2),
                //       ),
                //     ),
                //   ],
                // );
              }
              return Padding(
                padding: const EdgeInsets.all(20.0),
                child: CircularProgressIndicator(),
              );
            },
          ),
        ],
      ),
    );
  }
}

class SearchWidget extends StatelessWidget {
  const SearchWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 40,
      width: MediaQuery.of(context).size.width * 0.75,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.all(
          Radius.circular(20),
        ),
      ),
      child: Row(
        children: [
          SizedBox(
            width: 8,
          ),
          Icon(Icons.search),
          Flexible(
              child: TextFormField(
            textAlign: TextAlign.center,
            decoration: InputDecoration(
              border: InputBorder.none,
              hintText: "Search",
            ),
          )),
        ],
      ),
    );
  }
}

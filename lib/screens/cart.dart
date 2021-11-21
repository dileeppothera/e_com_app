import 'package:ecom/constants/store.dart';
import 'package:ecom/models/prodetailModel.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Cart extends StatefulWidget {
  Cart({required this.prd});
  ProductDetail prd;
  @override
  _CartState createState() => _CartState();
}

class _CartState extends State<Cart> {
  late Future detail;
  late ProductDetail? prdet;
  double price = 1.0;
  @override
  void initState() {
    if (widget.prd != null) {
      if (!product.contains(widget.prd)) {
        product.add(widget.prd);
      }

      itemCount[widget.prd] =
          itemCount[widget.prd] == null ? 1 : itemCount[widget.prd]! + 1;
      for (var pr in product) {
        price = price + (pr.price * int.parse(itemCount[pr].toString()));
      }
    }

    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    price = 1.0;
    for (var pr in product) {
      price = price + (pr.price * int.parse(itemCount[pr].toString()));
    }
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.red,
        elevation: 0.0,
        title: Text("Cart"),
      ),
      body: product.isNotEmpty
          ? ListView.builder(
              itemCount: product.length,
              itemBuilder: (c, i) {
                return Container(
                  height: 200,
                  child: GridTile(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Padding(
                        padding: const EdgeInsets.all(15.0),
                        child: Container(
                            height: 40,
                            width: 40,
                            child: Image.network(product[i].images[0])),
                      ),
                    ),
                    header: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Text(
                            product[i].name.toString(),
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                          Text(
                            "OMR " + product[i].price.toString(),
                            style: TextStyle(
                                fontWeight: FontWeight.bold, color: Colors.red),
                          ),
                        ]),
                    footer: Container(
                      color: Colors.amber,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          IconButton(
                            onPressed: () {
                              setState(() {
                                itemCount[product[i]] =
                                    itemCount[product[i]]! - 1;
                                if (itemCount[product[i]] == 0) {
                                  itemCount.remove(product[i]);
                                  product.remove(product[i]);
                                }
                              });
                            },
                            icon: Text(
                              "-",
                              style: TextStyle(fontSize: 35),
                            ),
                          ),
                          Text(itemCount[product[i]].toString()),
                          IconButton(
                              onPressed: () {
                                setState(() {
                                  itemCount[product[i]] =
                                      itemCount[product[i]]! + 1;
                                });
                              },
                              icon: Text(
                                "+",
                                style: TextStyle(fontSize: 25),
                              )),
                          SizedBox(
                            width: 50,
                          ),
                          IconButton(
                            icon: Icon(Icons.delete),
                            onPressed: () {
                              setState(() {
                                itemCount.remove(product[i]);
                                product.remove(product[i]);
                              });
                            },
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              })
          : Center(child: Text("Nothing in cart")),
      bottomSheet: Container(
        width: MediaQuery.of(context).size.width,
        height: 50,
        color: Colors.red,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Text(
              "OMR " + price.toString(),
              style:
                  TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
            ),
            SizedBox(
              width: 30,
            ),
            ElevatedButton(onPressed: () {}, child: Text("Buy Now")),
          ],
        ),
      ),
    );
  }
}

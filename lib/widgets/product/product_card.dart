import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ProductCard extends StatefulWidget {
  final String title;
  final int price;
  final String image;
  final Function? callback;

  const ProductCard(this.title, this.price, this.image,
      {Key? key, this.callback})
      : super(key: key);

  @override
  State<ProductCard> createState() => _ProductCardState();
}

class _ProductCardState extends State<ProductCard> {
  @override
  void initState() {
    checkItemInCart();
    super.initState();
  }

  int quantity = 0;

  Future addToCart() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    await preferences.setInt(widget.title, 1);
    setState(() {
      quantity = 1;
    });
  }

  Future checkItemInCart() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    var item = preferences.getInt(widget.title);
    if (item != null) {
      setState(() {
        quantity = item;
      });
    }
  }

  Future increase() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    setState(() {
      quantity += 1;
    });
    await preferences.setInt(widget.title, quantity);
    if (widget.callback != null) {
      widget.callback!();
    }
  }

  Future decrease() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    setState(() {
      quantity -= 1;
    });
    if (quantity == 0) {
      await preferences.remove(widget.title);
    } else {
      await preferences.setInt(widget.title, quantity);
    }
    if (widget.callback != null) {
      widget.callback!();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        SizedBox(
          height: MediaQuery.of(context).size.height / 40,
        ),
        Container(
          height: MediaQuery.of(context).size.height / 6,
          width: MediaQuery.of(context).size.width / 1.1,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: const Color(0xFFFFFFFF),
              border: Border.all(width: 0.3)),
          child: Row(
            children: [
              SizedBox(
                width: MediaQuery.of(context).size.width / 20,
              ),
              Container(
                width: MediaQuery.of(context).size.width / 5,
                height: MediaQuery.of(context).size.height / 5,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Image.asset(
                  'assets/Products/${widget.image}.png',
                  width: MediaQuery.of(context).size.width / 5,
                  height: MediaQuery.of(context).size.height / 5,
                ),
              ),
              SizedBox(
                width: MediaQuery.of(context).size.width / 20,
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height: MediaQuery.of(context).size.height / 50,
                    width: MediaQuery.of(context).size.width / 10,
                  ),
                  SizedBox(
                    width: MediaQuery.of(context).size.width / 2.2,
                    child: Text(
                      widget.title,
                      style: const TextStyle(
                        fontSize: 22,
                        color: Colors.black,
                      ),
                    ),
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height / 120,
                  ),
                  Row(
                    children: [
                      Text(
                        "₹ " + widget.price.toString(),
                        style: const TextStyle(
                            fontSize: 23,
                            color: Colors.black,
                            fontWeight: FontWeight.bold),
                      ),
                      SizedBox(
                        width: widget.price.toString().length == 2 ? MediaQuery.of(context).size.width/15 : widget.price.toString().length == 3 ? MediaQuery.of(context).size.width/35 : MediaQuery.of(context).size.width/75,
                      ),
                      quantity > 0
                          ? Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                ElevatedButton(
                                  onPressed: () {
                                    decrease();
                                  },
                                  child: const Icon(Icons.remove),
                                  style: ElevatedButton.styleFrom(
                                    primary: const Color(0xFF3BD8F6),
                                    fixedSize: const Size(20, 15),
                                    shape: const CircleBorder(),
                                    textStyle: const TextStyle(color: Colors.teal),
                                  ),
                                ),
                                Text(quantity.toString(),
                                style: const TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                ),
                                ),
                                ElevatedButton(
                                  onPressed: () {
                                    increase();
                                  },
                                  child: const Icon(Icons.add),
                                  style: ElevatedButton.styleFrom(
                                    primary: const Color(0xFF3BD8F6),
                                    fixedSize: const Size(20, 15),
                                    shape: const CircleBorder(),
                                  ),
                                ),
                              ],
                            )

                          : Row(
                          //mainAxisAlignment: MainAxisAlignment.end,
                          //crossAxisAlignment: CrossAxisAlignment.end,
                          children:[
                            SizedBox(width: MediaQuery.of(context).size.width/6),
                            ElevatedButton(
                              onPressed: () async {
                                await addToCart();
                              },
                              child: const Icon(
                                Icons.add_shopping_cart_rounded,
                                size: 20,
                                color: Colors.black,
                              ),
                              style: ElevatedButton.styleFrom(
                                primary: const Color(0xFF3BD8F6),
                                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
                                fixedSize: const Size(20, 40),
                                elevation: 2.0,
                              ),
                            ),
                            SizedBox(width: MediaQuery.of(context).size.width/30),
                          ],
                        )
                    ],
                  ),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }
}

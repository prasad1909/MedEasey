import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ProductCard extends StatefulWidget {
  final String title;
  final int price;
  final String image;

  const ProductCard(this.title, this.price, this.image, {Key? key})
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
    print(widget.title + ' $item');
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
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(
          height: 20,
        ),
        Container(
          height: 200.0,
          width: 360.0,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              color: Colors.white,
              border: Border.all(width: 1)),
          child: Row(
            children: [
              const SizedBox(
                width: 20,
              ),
              Image.network(
                widget.image,
                width: MediaQuery.of(context).size.width / 5,
                height: MediaQuery.of(context).size.height / 5,
              ),
              const SizedBox(
                width: 30,
              ),
              Column(
                children: [
                  const SizedBox(
                    height: 50,
                  ),
                  SizedBox(
                    width: 160,
                    child: Text(
                      widget.title,
                      style: const TextStyle(
                        fontSize: 27,
                        color: Colors.black,
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Row(
                    children: [
                      Text(
                        "₹" + widget.price.toString(),
                        style: const TextStyle(
                            fontSize: 26,
                            color: Colors.black,
                            fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      quantity != 0
                          ? Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                ElevatedButton(
                                    onPressed: () {
                                      increase();
                                    },
                                    child: const Icon(Icons.add)),
                                Text(quantity.toString()),
                                ElevatedButton(
                                    onPressed: () {
                                      decrease();
                                    },
                                    child: const Icon(Icons.remove)),
                              ],
                            )
                          : ElevatedButton(
                              onPressed: () async {
                                await addToCart();
                              },
                              child: const Icon(
                                Icons.add_shopping_cart_rounded,
                                size: 20,
                              ),
                            ),
                    ],
                  ),
                ],
              ),
            ],
          ),
        )
      ],
    );
  }
}

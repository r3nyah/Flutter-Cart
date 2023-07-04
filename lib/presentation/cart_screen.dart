import 'package:flutter/material.dart';
import 'package:food_ordering/common/model.dart';
import 'package:food_ordering/common/provider.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class CartScreen extends StatefulWidget {
  const CartScreen({super.key});

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  @override
  Widget build(BuildContext context) {
    double _height = MediaQuery.of(context).size.height;
    double _width = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "My Cart",
          style: GoogleFonts.poppins(
            textStyle: TextStyle(

            )
          ),
        ),
        centerTitle: true,
        backgroundColor: Color(0xFF48BF53),
        leading: IconButton(
          onPressed: (){
            Navigator.pop(context);
          },
          icon: Icon(
            Icons.arrow_back_ios
          ),
        ),
      ),
      body: Column(
        children: [
          Expanded(
            flex: 14,
            child: ListView.builder(
              itemCount: Provider.of<CartProvider>(context).allCart.length,
              itemBuilder: (context, i){
                Product product = Provider.of<CartProvider>(context).allCart[i];
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Card(
                    elevation: 5,
                    child: Container(
                      height: _height * 0.2,
                      width: _width,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10)
                      ),
                      child: Row(
                        children: [
                          Expanded(
                            flex: 5,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Image.asset(
                                  product.image,
                                  height: _height * 0.10,
                                ),
                                Text(
                                  "${product.name.split(" ")[0]}",
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 20
                                  ),
                                )
                              ],
                            ),
                          ),
                          Expanded(
                            flex: 4,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Row(
                                  children: [
                                    InkWell(
                                      onTap: (){
                                        Provider.of<CartProvider>(
                                          context,
                                          listen: false
                                        ).Countpluse(product: product);
                                      },
                                      child: Container(
                                        height: 40,
                                        width: 40,
                                        decoration: BoxDecoration(
                                          color: Color(0xFF48BF53),
                                          borderRadius: BorderRadius.circular(20)
                                        ),
                                        alignment: Alignment.center,
                                        child: Text(
                                          "+",
                                          style: TextStyle(
                                            fontSize: 30,
                                            color: Colors.white,
                                          ),
                                        ),
                                      ),
                                    ),
                                    SizedBox(
                                      width: _width * 0.02,
                                    ),
                                    Text(
                                      "${product.quantity}",
                                      style: TextStyle(
                                        fontSize: 20
                                      ),
                                    ),
                                    SizedBox(width: _width * 0.02,),
                                    InkWell(
                                      onTap: (){
                                        Provider.of<CartProvider>(
                                          context,
                                          listen: false
                                        ).CountdecrementAndRemove(product: product);
                                      },
                                      child: Container(
                                        height: 40,
                                        width: 40,
                                        decoration: BoxDecoration(
                                          color: Color(0xFF48BF53),
                                          borderRadius: BorderRadius.circular(20)
                                        ),
                                        alignment: Alignment.center,
                                        child: Text(
                                          "-",
                                          style: TextStyle(
                                            fontSize: 40,
                                            color: Colors.white
                                          ),
                                        ),
                                      ),
                                    )
                                  ],
                                ),
                                Row(
                                  children: [
                                    Text(
                                      "Price : Rp.${product.price}",
                                      style: TextStyle(
                                        fontSize: 18
                                      ),
                                    ),
                                    IconButton(
                                      onPressed: (){
                                        Provider.of<CartProvider>(
                                          context,
                                          listen: false
                                        ).RemoveFromCart(product: product);
                                      },
                                      icon: Icon(
                                        Icons.delete,
                                        color: Colors.red
                                      ),
                                    )
                                  ],
                                )
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
          Expanded(
            flex: 3,
            child: Container(
              width: _width,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(25),
                  topRight: Radius.circular(25)
                ),
                boxShadow: <BoxShadow>[
                  BoxShadow(
                    blurRadius: 7,
                    spreadRadius: 0,
                    color: Colors.green,
                  )
                ]
              ),
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: Row(
                  children: [
                    Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(height: _height * 0.025,),
                        Text(
                          "Total Price : ${Provider.of<CartProvider>(context).totalPrice}K",
                          style: GoogleFonts.poppins(
                            textStyle: TextStyle(
                              fontSize: 18,
                              color: Colors.green,
                              fontWeight: FontWeight.w600
                            )
                          ),
                        ),
                        SizedBox(height: _height * 0.015,),
                        Text(
                          "Total Quantity : ${Provider.of<CartProvider>(context).allProduct}",
                          style: GoogleFonts.poppins(
                            textStyle: TextStyle(
                              fontSize: 18,
                              color: Colors.green,
                              fontWeight: FontWeight.w600
                            )
                          ),
                        )
                      ],
                    ),
                    Spacer(flex: 9,),
                    ElevatedButton(
                      onPressed: (){},
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.green,
                        shadowColor: Colors.green[900]
                      ),
                      child: Container(
                        padding: EdgeInsets.symmetric(
                          horizontal: 10,
                          vertical: 10
                        ),
                        child: Text(
                          "Buy",
                          style: GoogleFonts.poppins(
                            textStyle: TextStyle(
                              fontWeight: FontWeight.w500,
                              fontSize: 20
                            )
                          ),
                        ),
                      ),
                    ),
                    Spacer(),
                  ],
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
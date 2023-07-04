import 'package:flutter/material.dart';
import 'package:food_ordering/common/model.dart';

class CartProvider extends ChangeNotifier{
  List<Product> allCart = [];
  List<Product> favoriteList = [];

  get allProduct{
    int totalCount = 0;
    allCart.forEach((element){
      totalCount += element.quantity;
    });
    return totalCount;
  }

  get totalPrice{
    num price = 0;
    for(int i = 0; i < allCart.length; i++){
      price += (allCart[i].price * allCart[i].quantity);
    }
    return price;
  }

  void Countpluse({required Product product}){
    product.quantity++;
    notifyListeners();
  }

  void CountdecrementAndRemove({required Product product}){
    if(product.quantity > 1){
      product.quantity--;
      notifyListeners();
    }
  }

  void RemoveFromCart({required Product product}){
    product.quantity = 0;
    print(product.quantity);
    allCart.remove(product);
    notifyListeners();
  }

  void addToCart({required Product product}){
    if(product.quantity >= 1){
      print(product.quantity);
    }else{
      product.quantity++;
      allCart.add(product);
      notifyListeners();
    }
  }

  void addToFavourite({required Product product}){
    product.like = "true";
    favoriteList.add(product);
    notifyListeners();
  }

  void RemoveFromFavourite({required Product product}){
    product.like = "false";
    print(product.like);
    favoriteList.remove(product);
    notifyListeners();
  }
}
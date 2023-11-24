import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class GetxCot extends GetxController {
  var db = FirebaseFirestore.instance;
  var cart = [];
  int totelpraee = 0;
  var latLng;
  Map myinfo = {};
  var list_tipy_mine = FirebaseFirestore.instance
      .collection("app")
      .doc("iraq")
      .collection("iraq")
      .snapshots();

  var list_Second = FirebaseFirestore.instance
      .collection("app")
      .doc("iraq")
      .collection("iraq")
      .snapshots();

  var dbrq = FirebaseFirestore.instance;

  changeTipyMine(String tipy) {
    list_tipy_mine = FirebaseFirestore.instance
        .collection("app")
        .doc("iraq")
        .collection("iraq")
        .where("tipy", isEqualTo: tipy)
        .snapshots();
    update();
  }

  ListSecond(String id) {
    list_Second = FirebaseFirestore.instance
        .collection("app")
        .doc("iraq")
        .collection("iraq")
        .doc(id)
        .collection("item")
        .snapshots();
    update();
  }

  changeTipySecond(String id, String tipy) {
    list_Second = FirebaseFirestore.instance
        .collection("app")
        .doc("iraq")
        .collection("iraq")
        .doc(id)
        .collection("item")
        .where("tipy", isEqualTo: tipy)
        .snapshots();
    update();
  }

  addToCart(String id, String frome, String titel, int namber, int prass) {
    var map = {
      "id": id,
      "Titel": titel,
      "Frome": frome,
      "namber": namber,
      "praess": prass
    };
    cart.add(map);
    update();
  }

  addtoitem(int id) {
    cart[id]["namber"]++;
    montyCart();
    update();
  }

  subtoitem(int id) {
    if (cart[id]["namber"] > 1) {
      cart[id]["namber"]--;
    }
    montyCart();
    update();
  }

  deletefromCart(int id) {
    // cart.remove(id);
    cart.removeAt(id);
    montyCart();
    update();
  }

  deleteAllCart() {
    cart.clear();
    totelpraee = 0;
    update();
  }

  montyCart() {
    int x = 0;
    for (var i = 0; i < cart.length; i++) {
      int n = cart[i]["namber"];
      int tp = cart[i]["praess"];
      x = x + (n * tp);
    }
    totelpraee = x;
    update();
  }

//add gps
  addgps(LatLng latLngx) {
    latLng = latLngx;
    update();
  }

  myInfo(String id, String name, String phone, String cantry) {
    print("=================================================");
    myinfo.addAll({"id": id, "name": name, "phone": phone, "cantry": cantry});
    update();
    update([myinfo], true);
  }
}

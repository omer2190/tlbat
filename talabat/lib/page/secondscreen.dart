import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../src/colors.dart';
import '../src/getxcot.dart';
import '../widgets/mysection.dart';
import 'cartpage.dart';

class SecondScreen extends StatefulWidget {
  SecondScreen({Key? key, required this.id}) : super(key: key);

  String id;

  @override
  State<SecondScreen> createState() => _SecondScreenState();
}

class _SecondScreenState extends State<SecondScreen> {
  Radius radius = const Radius.circular(50);

  final db = FirebaseFirestore.instance;

  @override
  Widget build(BuildContext context) {
    final screenwidth = MediaQuery.of(context).size.width;
    final screenheight = MediaQuery.of(context).size.height;
    final statebarheight = MediaQuery.of(context).padding.top;
    final freeHeight = screenheight - statebarheight;
    return SafeArea(
        child: GetBuilder<GetxCot>(
            init: GetxCot(),
            builder: (value) {
              return WillPopScope(
                onWillPop: () async {
                  if (value.cart.isEmpty) {
                    return true;
                  } else {
                    opendialog(context);
                    return false;
                  }
                },
                child: Scaffold(
                  backgroundColor: Ccolors().globel,
                  appBar: AppBar(
                    backgroundColor: Ccolors().globel,
                    elevation: 0,
                    title: const Text("title"),
                  ),
                  body: SizedBox(
                    width: screenwidth,
                    height: freeHeight,
                    child: Card(
                      color: Ccolors().body,
                      margin: const EdgeInsets.all(0),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.only(
                              topLeft: radius, topRight: radius)),
                      child: Column(
                        children: [
                          SizedBox(
                            width: screenwidth,
                            height: 50,
                            child: Card(
                              margin: const EdgeInsets.all(0),
                              elevation: 5,
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.only(
                                      topLeft: radius, topRight: radius)),
                              child: const Center(
                                  child: Text(
                                "data",
                                style: TextStyle(fontSize: 28),
                              )),
                            ),
                          ),
                          Container(
                              margin: const EdgeInsets.only(top: 5),
                              height: 45,
                              padding: const EdgeInsets.symmetric(vertical: 6),
                              child: StreamBuilder(
                                stream: db
                                    .collection("app")
                                    .doc("iraq")
                                    .collection("iraq")
                                    .doc(widget.id)
                                    .collection("tipy")
                                    .snapshots(),
                                builder: (context,
                                    AsyncSnapshot<QuerySnapshot> snapshot) {
                                  if (!snapshot.hasData) {
                                    return const Center(
                                        child: Text("loding..."));
                                  }
                                  return ListView(
                                      scrollDirection: Axis.horizontal,
                                      children:
                                          snapshot.data!.docs.map((docmet) {
                                        return Mysection(
                                          title: docmet["tipy"],
                                          onPressed: () {
                                            value.changeTipySecond(
                                                widget.id, docmet["tipy"]);
                                          },
                                        );
                                      }).toList());
                                },
                              )),
                          Expanded(
                              child: StreamBuilder(
                            stream: value.list_Second,
                            builder: (context,
                                AsyncSnapshot<QuerySnapshot> snapshot) {
                              if (!snapshot.hasData) {
                                return const Center(child: Text("loding..."));
                              }
                              return ListView(
                                  children: snapshot.data!.docs.map((docmet) {
                                String titel = "";
                                String imageUil = "";
                                String dec = "";
                                try {
                                  titel = docmet["name"].toString();
                                  imageUil = docmet["imageUil"].toString();
                                  dec = docmet["dec"].toString();
                                } catch (e) {}
                                return MyCard(
                                  radius: radius,
                                  iconuri: imageUil,
                                  pres: 0,
                                  subtitle: dec,
                                  title: titel,
                                  onPressed: () {
                                    value.addToCart(widget.id, "", titel, 1, 1);
                                  },
                                );
                              }).toList());
                            },
                          ))
                        ],
                      ),
                    ),
                  ),
                  floatingActionButton: GetBuilder<GetxCot>(
                      init: GetxCot(),
                      builder: (value) {
                        if (value.cart.isNotEmpty) {
                          return FloatingActionButton(
                            backgroundColor: Ccolors().spshel,
                            // focusColor: Ccolors().spshel,
                            onPressed: () {
                              Navigator.push<void>(
                                context,
                                MaterialPageRoute<void>(
                                  builder: (BuildContext context) =>
                                      const Cartpage(),
                                ),
                              );
                            },
                            child: const Icon(Icons.shopping_cart),
                          );
                        } else {
                          return const SizedBox();
                        }
                      }),
                ),
              );
            }));
  }

  static void opendialog(context) {
    showDialog(
        context: context,
        builder: (context) => AlertDialog(
              shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(25)),
              ),
              title: const Text("warning"),
              content: const Text("return wll delete the content of thr cart"),
              actions: [
                GetBuilder<GetxCot>(
                    init: GetxCot(),
                    builder: (voidd) {
                      return Row(
                        children: [
                          myButtonPop("delete", () {
                            voidd.deleteAllCart();
                            Navigator.of(context).pop();
                            Navigator.of(context).pop();
                          }),
                          myButtonPop("back", () {
                            Navigator.of(context).pop();
                          })
                        ],
                      );
                    }),
              ],
            ));
  }

  static Expanded myButtonPop(String titel, VoidCallback onPressed) {
    return Expanded(
        child: Padding(
      padding: const EdgeInsets.only(left: 2, right: 10),
      child: MaterialButton(
          shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(25))),
          color: Ccolors().globel,
          onPressed: onPressed,
          child: Text(titel)),
    ));
  }
}

class MyCard extends StatelessWidget {
  const MyCard({
    Key? key,
    required this.radius,
    required this.title,
    required this.subtitle,
    required this.iconuri,
    required this.pres,
    required this.onPressed,
  }) : super(key: key);

  final Radius radius;
  final String iconuri;
  final String title;
  final String subtitle;
  final int pres;

  //var cart = <String>[];

  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 5, left: 8, right: 8),
      child: MaterialButton(
        color: Ccolors().card,
        elevation: 5,
        shape: RoundedRectangleBorder(
            borderRadius:
                BorderRadius.only(bottomRight: radius, topRight: radius)),
        padding: EdgeInsets.zero,
        onPressed: onPressed,
        child: Row(
          children: [
            Image.network(
              iconuri,
              width: 100,
              height: 100,
              errorBuilder: (context, error, stackTrace) {
                return Container(
                  width: 100,
                  height: 100,
                  color: Ccolors().body,
                );
              },
            ),
            Expanded(
                child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(title, style: const TextStyle(fontSize: 20)),
                  Text(subtitle, style: const TextStyle(fontSize: 16)),
                ],
              ),
            )),
            Padding(
              padding: const EdgeInsets.all(15),
              child: Column(
                children: [
                  Text("$pres\$", style: const TextStyle(fontSize: 20)),
                  Padding(
                    padding: const EdgeInsets.only(top: 5),
                    child: MaterialButton(
                        color: Ccolors().spshel,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.all(radius)),
                        onPressed: () {},
                        child: Text(
                          "Add",
                          style: TextStyle(color: Ccolors().card),
                        )),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

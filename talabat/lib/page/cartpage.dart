import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:talabat/page/mygps.dart';
import 'package:talabat/src/colors.dart';
import 'package:talabat/src/getxcot.dart';

class Cartpage extends StatefulWidget {
  const Cartpage({Key? key}) : super(key: key);

  @override
  State<Cartpage> createState() => _CartpageState();
}

class _CartpageState extends State<Cartpage> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      backgroundColor: Ccolors().globel,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Ccolors().globel,
      ),
      body: Card(
        color: Ccolors().card,
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(50), topRight: Radius.circular(50))),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Padding(
              padding: EdgeInsets.only(top: 50, left: 15),
              child: Text(
                "Cart",
                style: TextStyle(fontSize: 24),
              ),
            ),
            Expanded(
                child: GetBuilder<GetxCot>(
                    init: GetxCot(),
                    builder: (value) {
                      if (value.cart.isNotEmpty) {
                        return ListView.builder(
                          itemCount: value.cart.length,
                          itemBuilder: (context, index) {
                            return ItemforChat(
                              id: index,
                              minusButten: () {},
                            );
                          },
                        );
                      } else {
                        return const Center(child: Text("data"));
                      }
                    })),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: GetBuilder<GetxCot>(
                  init: GetxCot(),
                  builder: (value) {
                    return Column(
                      children: [
                        Row(
                          children: [
                            const Expanded(
                                child: Text(
                              "total summation",
                              style: TextStyle(fontSize: 20),
                            )),
                            Text(value.totelpraee.toString(),
                                style: const TextStyle(fontSize: 20)),
                          ],
                        ),
                        Container(
                          color: Ccolors().spshel,
                          height: 1,
                        ),
                        ListTile(
                          title: const Text(""),
                          trailing: IconButton(
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute<void>(
                                    builder: (BuildContext context) =>
                                        const MyGPS(),
                                  ),
                                );
                              },
                              icon: const Icon(Icons.location_on_outlined)),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(bottom: 15, top: 5),
                          child: MaterialButton(
                            minWidth: 500,
                            color: Ccolors().spshel,
                            elevation: 5,
                            onPressed: () {
                              // value.montyCart();
                              if (value.cart.isNotEmpty) {
                                print("hhhhhhhhhhhhhhhhhhh");
                                print(value.myinfo["phone"]);
                                value.db
                                    .collection("app")
                                    .doc("iraq")
                                    .collection("rq")
                                    .doc()
                                    .set({
                                  "name": value.myinfo["name"],
                                  "namber": value.myinfo["phone"],
                                  "datatime": FieldValue.serverTimestamp(),
                                  "titel": "",
                                  "token": "",
                                  //"gps": value.latLng!,
                                  "rq": value.cart,
                                  "dec": "",
                                });
                              }
                            },
                            shape: const RoundedRectangleBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(25))),
                            child: const Text("Add to "),
                          ),
                        )
                      ],
                    );
                  }),
            )
          ],
        ),
      ),
    ));
  }
}

class ItemforChat extends StatelessWidget {
  const ItemforChat({
    Key? key,
    required this.id,
    required this.minusButten,
  }) : super(key: key);
  final int id;

  final VoidCallback minusButten;

  @override
  Widget build(BuildContext context) {
    return GetBuilder<GetxCot>(
        init: GetxCot(),
        builder: (value) {
          String iconuri = "";
          String titel = value.cart[id]["Titel"];
          int praess = value.cart[id]["praess"];
          int namber = value.cart[id]["namber"];
          return MaterialButton(
            onPressed: () {},
            child: Card(
              child: Row(
                children: [
                  Image.network(
                    iconuri,
                    width: 125,
                    height: 100,
                    errorBuilder: (context, error, stackTrace) {
                      return Container(
                        width: 125,
                        height: 100,
                        color: Ccolors().body,
                      );
                    },
                  ),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(titel, style: const TextStyle(fontSize: 20)),
                        Text(praess.toString(),
                            style: const TextStyle(fontSize: 18)),
                        Row(
                          children: [
                            IconButton(
                                onPressed: () {
                                  value.subtoitem(id);
                                },
                                icon: const Icon(Icons.subtitles_off_rounded)),
                            Text(namber.toString()),
                            IconButton(
                                onPressed: () {
                                  value.addtoitem(id);
                                },
                                icon: const Icon(Icons.add)),
                          ],
                        ),
                      ],
                    ),
                  ),
                  IconButton(
                      onPressed: () {
                        value.deletefromCart(id);
                      },
                      icon: Icon(
                        Icons.delete,
                        color: Ccolors().spshel,
                      ))
                ],
              ),
            ),
          );
        });
  }
}

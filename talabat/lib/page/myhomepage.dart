import 'package:carousel_slider/carousel_slider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:talabat/page/secondscreen.dart';
import 'package:talabat/src/colors.dart';
import 'package:talabat/widgets/mysection.dart';

import '../src/getxcot.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);
  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  //valuebls set up
  Radius radius = const Radius.circular(50);
  final urlImdes = [];
  final db = FirebaseFirestore.instance;
  bool value = false;

  // appbar set-up
  final appBar2 = AppBar(
    backgroundColor: Ccolors().globel,
    elevation: 0,
    title: const Text("title"),
    actions: const [Icon(Icons.search)],
  );
  void geturi() async {
    final docRef = await db.collection("ADS").get();
    for (var uir in docRef.docs) {
      setState(() {
        urlImdes.add(uir.data()["uri"]);
      });
    }
  }

  @override
  void initState() {
    geturi();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final screenwidth = MediaQuery.of(context).size.width;
    final screenheight = MediaQuery.of(context).size.height;
    final appbarheight = appBar2.preferredSize.height;
    final statebarheight = MediaQuery.of(context).padding.top;
    final freeHeight = screenheight - appbarheight - statebarheight;
    return SafeArea(
      child: Scaffold(
        backgroundColor: Ccolors().globel,
        appBar: appBar2,
        drawer: Drawer(
          // ignore: sort_child_properties_last
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 10, top: 20),
                child: Row(
                  children: const [
                    CircleAvatar(),
                    Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Text("data"),
                    )
                  ],
                ),
              ),
              ListTile(
                title: const Text("data"),
                trailing: Switch(value: value, onChanged: (voidd) {}),
              ),
              Container(
                margin: const EdgeInsets.symmetric(horizontal: 10),
                height: 1,
                color: Ccolors().spshel,
              ),
              const ListTile(
                title: Text("data"),
                leading: Icon(Icons.notifications_none),
              ),
              Expanded(child: ListView()),
              Card(
                color: Ccolors().spshel,
                child: ListTile(
                  onTap: () {},
                  title: Text(
                    "hggg",
                    style: TextStyle(color: Ccolors().card),
                  ),
                  leading: Icon(
                    Icons.login_outlined,
                    color: Ccolors().card,
                  ),
                ),
              )
            ],
          ),
        ),
        body: SizedBox(
          width: screenwidth,
          height: freeHeight,
          child: Card(
            margin: const EdgeInsets.all(0),
            shape: RoundedRectangleBorder(
                borderRadius:
                    BorderRadius.only(topLeft: radius, topRight: radius)),
            child: Column(
              children: [
                // for titel
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
                //  for AS
                Padding(
                    padding: const EdgeInsets.only(top: 6),
                    child: myCarouselSlider()),
                // for list sectien
                Container(
                  margin: const EdgeInsets.only(top: 5),
                  height: 45,
                  child: StreamBuilder(
                    stream: db
                        .collection("app")
                        .doc("iraq")
                        .collection("tipy")
                        .snapshots(),
                    builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
                      if (!snapshot.hasData) {
                        return const Center(child: Text("loding..."));
                      }
                      return ListView(
                          scrollDirection: Axis.horizontal,
                          children: snapshot.data!.docs.map((docmet) {
                            return //Text(docmet["uri"]);
                                GetBuilder<GetxCot>(
                                    init: GetxCot(),
                                    builder: (context) {
                                      return Mysection(
                                        title: docmet["tipy"],
                                        onPressed: () {
                                          context
                                              .changeTipyMine(docmet["tipy"]);
                                        },
                                      );
                                    });
                          }).toList());
                    },
                  ),
                ),
                //for list body
                Expanded(
                    child: GetBuilder<GetxCot>(
                  init: GetxCot(),
                  builder: (value) {
                    return StreamBuilder(
                      stream: value.list_tipy_mine,
                      builder:
                          (context, AsyncSnapshot<QuerySnapshot> snapshot) {
                        if (!snapshot.hasData) {
                          return const Center(child: Text("loding..."));
                        }
                        return ListView(
                            children: snapshot.data!.docs.map((docmet) {
                          String titel = "";
                          String imageUil = "";
                          try {
                            titel = docmet["name"].toString();
                            imageUil = docmet["imageUil"].toString();
                          } catch (e) {}
                          return materialbuttn(titel, imageUil, docmet.id);
                        }).toList());
                      },
                    );
                  },
                ))
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget myCarouselSlider() {
    if (urlImdes.isNotEmpty) {
      return CarouselSlider.builder(
        options: CarouselOptions(height: 100, autoPlay: true),
        itemCount: urlImdes.length,
        itemBuilder: (context, index, realIndex) {
          final urindex = urlImdes[index];
          return buildImage(urindex, index);
        },
      );
    } else {
      return const SizedBox();
    }
  }

  Widget materialbuttn(String title, String iconuri, String id) {
    return GetBuilder<GetxCot>(
        init: GetxCot(),
        builder: (value) {
          return Card(
            margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 5),
            child: MaterialButton(
              padding: EdgeInsets.zero,
              elevation: 10,
              onPressed: () {
                value.ListSecond(id);
                Navigator.push(
                  context,
                  MaterialPageRoute<void>(
                    builder: (BuildContext context) => SecondScreen(id: id),
                  ),
                );
              },
              child: SizedBox(
                height: 100,
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
                    Expanded(child: Text(title)),
                    IconButton(
                        onPressed: () {},
                        icon: const Icon(Icons.arrow_circle_right)),
                  ],
                ),
              ),
            ),
          );
        });
  }
}

Widget buildImage(String urindex, int index) {
  return Container(
    margin: const EdgeInsets.symmetric(horizontal: 5),
    color: Ccolors().body,
    child: Image.network(
      urindex,
      fit: BoxFit.cover,
    ),
  );
}

import 'package:flutter/material.dart';
import 'package:talabat/src/colors.dart';

class ItemPage extends StatefulWidget {
  const ItemPage({Key? key}) : super(key: key);

  @override
  State<ItemPage> createState() => _ItemPageState();
}

class _ItemPageState extends State<ItemPage> {
  Radius radius = const Radius.circular(50);
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      backgroundColor: Ccolors().globel,
      body: Column(
        children: [
          Image.network(
            "data:image/jpeg;base64,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",
            //scale: 0.1,
            fit: BoxFit.fitWidth,
            width: MediaQuery.of(context).size.width,
            height: 200,
          ),
          Expanded(
              flex: 2,
              child: Card(
                margin: EdgeInsets.zero,
                // shape: RoundedRectangleBorder(
                //     borderRadius:
                //         BorderRadius.only(topLeft: radius, topRight: radius)),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Padding(
                      padding: EdgeInsets.only(top: 50, left: 10, right: 10),
                      child: Text(
                        "data",
                        style: TextStyle(fontSize: 24),
                      ),
                    ),
                    const Padding(
                      padding: EdgeInsets.only(top: 15, left: 10, right: 10),
                      child: Text("data", style: TextStyle(fontSize: 18)),
                    ),
                    Expanded(
                        child: Padding(
                      padding: const EdgeInsets.all(10),
                      child: TextField(
                        minLines: 4,
                        maxLines: 6,
                        decoration: InputDecoration(
                            //label: Text("Titel"),
                            hintText: "SepTitel",
                            enabledBorder: OutlineInputBorder(
                                borderSide: BorderSide(color: Ccolors().spshel),
                                borderRadius: BorderRadius.circular(5)),
                            focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(5))),
                      ),
                    )),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          IconButton(
                              onPressed: () {},
                              icon: Icon(Icons.linear_scale,
                                  color: Ccolors().globel)),
                          const Padding(
                            padding: EdgeInsets.symmetric(horizontal: 15),
                            child: Text("0"),
                          ),
                          IconButton(
                              onPressed: () {},
                              icon: Icon(
                                Icons.add,
                                color: Ccolors().globel,
                              ))
                        ],
                      ),
                    ),
                    Center(
                      child: Padding(
                          padding: const EdgeInsets.only(bottom: 20, top: 10),
                          child: MaterialButton(
                            color: Ccolors().spshel,
                            elevation: 5,
                            onPressed: () {},
                            shape: const RoundedRectangleBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(25))),
                            child: Text(
                              "Add to ",
                              style: TextStyle(color: Ccolors().card),
                            ),
                          )),
                    )
                  ],
                ),
              ))
        ],
      ),
    ));
  }
}

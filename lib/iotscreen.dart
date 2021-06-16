import 'dart:ffi';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class IotScreen extends StatefulWidget {
  @override
  _IotScreenState createState() => _IotScreenState();
}

class _IotScreenState extends State<IotScreen> {
  @override
  String jawaban = "";
  String value;
  final dbRef = FirebaseDatabase.instance.reference();
  onUpdate() {
    setState(() {
      value = jawaban;
    });
  }

  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations(
        [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);
    return Scaffold(
      body: StreamBuilder(
          stream: dbRef.child("Data").onValue,
          builder: (context, snapshot) {
            if (snapshot.hasData &&
                !snapshot.hasError &&
                snapshot.data.snapshot.value != null) {
              return Column(
                children: [
                  Padding(
                    padding: EdgeInsets.all(30),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(""),
                        Text(
                          "Ishihara Test",
                          style: TextStyle(
                              fontSize: 20, fontWeight: FontWeight.bold),
                        ),
                        Text("")
                      ],
                    ),
                  ),
                  SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text("Hasil Test Buta Warna, Benar :",
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold)),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                                snapshot.data.snapshot
                                    .value["Hasil Test Buta Warna, Benar"]
                                    .toString(),
                                style: TextStyle(
                                    fontSize: 20, fontWeight: FontWeight.bold)),
                          ),
                        ],
                      )
                    ],
                  ),
                  SizedBox(height: 100),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextField(
                      decoration: InputDecoration(
                          hintText: "Berapa angka yang anda lihat?",
                          hintStyle: TextStyle(color: Colors.grey),
                          border: OutlineInputBorder()),
                      keyboardType: TextInputType.number,
                      onChanged: (val) {
                        setState(() => jawaban = val);
                      },
                    ),
                  ),
                  SizedBox(height: 100),
                  RaisedButton.icon(
                      onPressed: () {
                        onUpdate();
                        onWrite();
                      },
                      label: Text(
                        "Konfirmasi",
                        style: TextStyle(color: Colors.yellow),
                      ),
                      color: Colors.grey,
                      elevation: 10,
                      icon: Icon(Icons.send_to_mobile))
                ],
              );
            } else
              Container();
          }),
    );
  }

  Future<void> onWrite() {
    // dbRef.child("Data").set({"Hasil Test Buta Warna, Benar": 0});
    dbRef.child("LightState").set({"switch": jawaban});
  }
}

class Int {}

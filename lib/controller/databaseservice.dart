import 'dart:math';

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class DatabaseService {
  FirebaseDatabase database = FirebaseDatabase.instanceFor(
      app: Firebase.app(),
      databaseURL:
          "https://fir-ti-a70af-default-rtdb.asia-southeast1.firebasedatabase.app/");

  void tambahData(String user, String url) async {
    DatabaseReference ref =
        database.ref("$user/${DateTime.now().microsecondsSinceEpoch}/");

    await ref.set({"name": "John", "age": Random().nextInt(100), "url": url});
  }

  Future<List<Map<dynamic, dynamic>>?> ambilData(String user) async {
    DatabaseReference ref = database.ref("$user/");

    try {
      final data = await ref.get();

      if (data.exists) {
        final datas = data.value as Map<dynamic, dynamic>;
        final List<Map> listData = datas.entries.map((e) {
          return {
            "name": e.value["name"],
            "age": e.value["age"],
            "url": e.value["url"]
          };
        }).toList();

        return listData;
      } else {
        return [];
      }
    } catch (e) {
      print(e);
    }
    return null;
  }
}

class DatabaseServiceFirestore {
  FirebaseFirestore database = FirebaseFirestore.instance;

  void tambahData(String user, String url) async {
    final ref = database.collection("users").doc(user).collection("kontak");

    await ref.add({"name": "John", "age": Random().nextInt(100), "url": url});
  }

  Future<List<Map<dynamic, dynamic>>?> ambilData(String user) async {
    final ref = database.collection("users").doc(user).collection("kontak");

    try {
      final data = await ref.get();

      final List<Map> listData = data.docs.map((e) {
        return {
          "name": e.data()["name"],
          "age": e.data()["age"],
          "url": e.data()["url"]
        };
      }).toList();

      return listData;
    } catch (e) {
      print(e);
    }
    return null;
  }
}

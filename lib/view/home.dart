import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_ti/controller/databaseservice.dart';
import 'package:firebase_ti/view/login.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  final User user;
  const HomePage({super.key, required this.user});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  TextEditingController urlController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Hello, ${widget.user.displayName}"),
        foregroundColor: Colors.white,
        backgroundColor: Colors.blue,
        actions: [
          IconButton(
              onPressed: () {
                Navigator.of(context).pushReplacement(
                    MaterialPageRoute(builder: (context) => LoginPage()));
              },
              icon: Icon(Icons.logout))
        ],
      ),
      body: FutureBuilder(
        future: DatabaseServiceFirestore().ambilData(widget.user.uid),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: CircularProgressIndicator(),
            );
          } else {
            var data = snapshot.data;
            return ListView.builder(
                itemCount: data!.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    title: Text(data[index]["name"]),
                    subtitle: Text(data[index]["age"].toString()),
                    leading: CircleAvatar(
                      backgroundImage: NetworkImage(data[index]["url"]),
                    ),
                  );
                });
          }
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          DatabaseServiceFirestore().tambahData(widget.user.uid,
              "https://raw.githubusercontent.com/Angello28/pm_kanlstm_2024_2025/refs/heads/main/KAN-selected_run1.png");
          setState(() {});
        },
        foregroundColor: Colors.white,
        backgroundColor: Colors.blue,
        child: Icon(Icons.add),
      ),
    );
  }
}

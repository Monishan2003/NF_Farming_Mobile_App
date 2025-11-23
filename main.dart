import 'package:flutter/material.dart';

void main() {
  runApp(AloeVeraApp());
}

class AloeVeraApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Aloe Vera App',
      theme: ThemeData(
        primaryColor: Colors.green,
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            padding: EdgeInsets.symmetric(horizontal: 25, vertical: 14),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
          ),
        ),
      ),
      home: LoginPage(),
    );
  }
}

//---------------------------------------------------------------
// LOGIN PAGE
//---------------------------------------------------------------
class LoginPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Login")),
      body: Center(
        child: ElevatedButton(
          onPressed: () {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text("Login Successful")),
            );
            Navigator.push(context, MaterialPageRoute(builder: (_) => HomePage()));
          },
          child: Text("Login"),
        ),
      ),
    );
  }
}

//---------------------------------------------------------------
// HOME PAGE
//---------------------------------------------------------------
class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Home")),
      body: ListView(
        padding: EdgeInsets.all(20),
        children: [
          homeButton(context, "Farmer List", FarmerListPage()),
          homeButton(context, "Add Farmer", AddFarmerPage()),
          homeButton(context, "Selling", SellingPage()),
          homeButton(context, "Buying", BuyingPage()),
        ],
      ),
    );
  }

  Widget homeButton(BuildContext context, String title, Widget page) {
    return Container(
      margin: EdgeInsets.only(bottom: 15),
      child: ElevatedButton(
        onPressed: () {
          Navigator.push(context, MaterialPageRoute(builder: (_) => page));
        },
        child: Text(title),
      ),
    );
  }
}

//---------------------------------------------------------------
// FARMER LIST PAGE
//---------------------------------------------------------------
class FarmerListPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Farmer List")),
      body: Center(
        child: ElevatedButton(
          onPressed: () {
            Navigator.push(context, MaterialPageRoute(builder: (_) => AddFarmerPage()));
          },
          child: Text("Add Farmer"),
        ),
      ),
    );
  }
}

//---------------------------------------------------------------
// ADD FARMER PAGE
//---------------------------------------------------------------
class AddFarmerPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Add Farmer")),
      body: Center(
        child: ElevatedButton(
          onPressed: () {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text("Farmer added successfully")),
            );
          },
          child: Text("Save Farmer"),
        ),
      ),
    );
  }
}

//---------------------------------------------------------------
// SELLING PAGE
//---------------------------------------------------------------
class SellingPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Selling")),
      body: Center(
        child: ElevatedButton(
          onPressed: () {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text("Selling completed successfully")),
            );
          },
          child: Text("Confirm Selling"),
        ),
      ),
    );
  }
}

//---------------------------------------------------------------
// BUYING PAGE
//---------------------------------------------------------------
class BuyingPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Buying")),
      body: Center(
        child: ElevatedButton(
          onPressed: () {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text("Buying completed successfully")),
            );
          },
          child: Text("Confirm Buying"),
        ),
      ),
    );
  }
}

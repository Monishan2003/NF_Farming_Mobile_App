import 'package:flutter/material.dart';

void main() => runApp(FieldVisitorApp());

class FieldVisitorApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(fontFamily: 'Poppins'),
      home: FieldVisitorDashboard(),
    );
  }
}

class FieldVisitorDashboard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFE8F7EE), // light green (same as Figma)
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [

              // ----- TOP GREEN CARD -----
              Container(
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: const Color(0xFF21A66F), // your Figma green
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("Welcome ,",
                        style: TextStyle(color: Colors.white70, fontSize: 14)),
                    SizedBox(height: 4),
                    Text(
                      "Field visitor Name 👋",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 2),
                    Text(
                      "Field Visitor Dashboard",
                      style: TextStyle(color: Colors.white70, fontSize: 13),
                    ),
                    SizedBox(height: 16),

                    // Search Box
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 12),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Row(
                        children: [
                          Expanded(
                            child: TextField(
                              decoration: InputDecoration(
                                border: InputBorder.none,
                                hintText: "Enter UserId or Farmer Name",
                                hintStyle: TextStyle(fontSize: 14),
                              ),
                            ),
                          ),
                          Icon(Icons.search, color: Colors.black54)
                        ],
                      ),
                    )
                  ],
                ),
              ),

              SizedBox(height: 20),

              // ----- TARGET CARD -----
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Icon(Icons.show_chart, color: Colors.green),
                        SizedBox(width: 8),
                        Text(
                          "Track your target",
                          style: TextStyle(
                              fontSize: 16, fontWeight: FontWeight.w600),
                        )
                      ],
                    ),
                    SizedBox(height: 12),
                    Text("Target", style: TextStyle(fontSize: 14)),
                    SizedBox(height: 6),
                    LinearProgressIndicator(
                      value: 0.60, // 90/150
                      backgroundColor: Colors.grey.shade300,
                      color: const Color(0xFF21A66F),
                    ),
                    SizedBox(height: 8),
                    Text("90/150    60%", style: TextStyle(fontSize: 13)),
                  ],
                ),
              ),

              SizedBox(height: 20),

              // ----- MONTH HEADER -----
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "This Month Visit",
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  CircleAvatar(
                    radius: 12,
                    backgroundColor: Color(0xFF21A66F),
                    child: Text(
                      "10",
                      style: TextStyle(color: Colors.white, fontSize: 12),
                    ),
                  )
                ],
              ),

              SizedBox(height: 14),

              // ----- LIST ITEMS -----
              for (int i = 0; i < 8; i++) _buildVisitCard()
            ],
          ),
        ),
      ),

      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(16),
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: const Color(0xFF21A66F),
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
            padding: const EdgeInsets.symmetric(vertical: 16),
          ),
          onPressed: () {},
          child: Text(
            "+  Add New Members",
            style: TextStyle(fontSize: 16, color: Colors.white),
          ),
        ),
      ),
    );
  }

  // ====== Visit Card Widget ======
  Widget _buildVisitCard() {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14),
      ),
      child: Row(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("Jhon Kunasimgam",
                  style: TextStyle(
                      fontSize: 15, fontWeight: FontWeight.w600)),
              SizedBox(height: 4),
              Row(
                children: [
                  Icon(Icons.location_on, size: 16, color: Colors.green),
                  SizedBox(width: 4),
                  Text("Green Road, Trincomalee",
                      style: TextStyle(color: Colors.grey, fontSize: 13))
                ],
              )
            ],
          ),
          Spacer(),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 12, vertical: 6),
            decoration: BoxDecoration(
              color: Color(0xFFFFF2E0),
              borderRadius: BorderRadius.circular(20),
            ),
            child: Text("Pending",
                style: TextStyle(color: Color(0xFFE4933B), fontSize: 12)),
          )
        ],
      ),
    );
  }
}

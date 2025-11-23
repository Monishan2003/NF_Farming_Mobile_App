import 'package:flutter/material.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFE8FFE8), // light green bg
      bottomNavigationBar: _bottomBar(),
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [

            // Top Back Button & Notification
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Icon(Icons.arrow_back, color: Colors.black),
                  const Icon(Icons.notifications_none, color: Colors.black),
                ],
              ),
            ),

            // Profile Card
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 12),
              padding: const EdgeInsets.all(14),
              decoration: BoxDecoration(
                color: const Color(0xFF1CAA48), // green card
                borderRadius: BorderRadius.circular(16),
              ),
              child: Row(
                children: [
                  // Profile Image
                  Container(
                    width: 55,
                    height: 55,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      image: const DecorationImage(
                        image: AssetImage("assets/user.jpg"),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),

                  const SizedBox(width: 12),

                  // Text
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: const [
                      Text(
                        "Ravi Mohan (k001)",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: 4),
                      Text(
                        "field visitor",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 14,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),

            const SizedBox(height: 20),

            // Settings Header
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 16),
              child: Text(
                "Settings",
                style: TextStyle(
                  fontSize: 18,
                  color: Colors.green,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),

            const SizedBox(height: 6),

            _menuTile(Icons.settings, "Preferences"),
            _menuTile(Icons.person_outline, "Account"),

            const SizedBox(height: 20),

            // Resources Header
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 16),
              child: Text(
                "Resources",
                style: TextStyle(
                  fontSize: 18,
                  color: Colors.green,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),

            const SizedBox(height: 6),

            _menuTile(Icons.support_agent, "Community Support"),
            _menuTile(Icons.calendar_month, "Monthly Summary"),
            _menuTile(Icons.group_outlined, "My Members"),
          ],
        ),
      ),
    );
  }

  // Menu item widget
  Widget _menuTile(IconData icon, String title) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 14),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: Colors.green.shade200),
      ),
      child: Row(
        children: [
          Icon(icon, color: Colors.green, size: 24),
          const SizedBox(width: 12),
          Text(
            title,
            style: const TextStyle(fontSize: 16, color: Colors.green),
          ),
          const Spacer(),
          const Icon(Icons.chevron_right, color: Colors.green),
        ],
      ),
    );
  }

  // Bottom navigation bar
  Widget _bottomBar() {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 8),
      decoration: const BoxDecoration(
        color: Color(0xFFF2F2F2),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: const [
          _bottomItem(Icons.home, "Home"),
          _bottomItem(Icons.group, "Members"),
          _bottomItem(Icons.note_alt, "Notes"),
          _bottomItem(Icons.notifications, "Notify"),
          _bottomItem(Icons.person, "Profile"),
        ],
      ),
    );
  }
}

class _bottomItem extends StatelessWidget {
  final IconData icon;
  final String label;

  const _bottomItem(this.icon, this.label);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(icon, color: Colors.black87),
        Text(label, style: const TextStyle(fontSize: 12)),
      ],
    );
  }
}

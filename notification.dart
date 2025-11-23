// lib/main.dart
import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(NFPlantationApp());
}

/// Colors & styles used for the UI to match your green/light theme
class AppTheme {
  static const Color primary = Color(0xFF1E8A4A); // deep green
  static const Color lightBg = Color(0xFFEFFEF5); // very light green/mint
  static const Color card = Color(0xFFCEEFD6);
  static const double borderRadius = 12.0;
  static final TextStyle header = TextStyle(
    color: primary,
    fontSize: 20,
    fontWeight: FontWeight.bold,
  );
  static final TextStyle section = TextStyle(
    color: primary,
    fontSize: 16,
    fontWeight: FontWeight.w600,
  );
}

class NFPlantationApp extends StatefulWidget {
  @override
  State<NFPlantationApp> createState() => _NFPlantationAppState();
}

class _NFPlantationAppState extends State<NFPlantationApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'NF Plantation',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primaryColor: AppTheme.primary,
        scaffoldBackgroundColor: AppTheme.lightBg,
        appBarTheme: AppBarTheme(
          backgroundColor: AppTheme.lightBg,
          elevation: 0,
          iconTheme: IconThemeData(color: AppTheme.primary),
          titleTextStyle: AppTheme.header,
        ),
      ),
      initialRoute: '/',
      routes: {
        '/': (_) => MainShell(),
        '/settings': (_) => SettingsScreen(),
        '/notification_settings': (_) => NotificationSettingsScreen(),
        '/notifications_list': (_) => NotificationsListScreen(),
        '/members': (_) => MembersScreen(),
        '/notes': (_) => NotesScreen(),
        '/profile': (_) => ProfileScreen(),
      },
    );
  }
}

/// MainShell hosts bottom nav and switches main pages.
class MainShell extends StatefulWidget {
  @override
  State<MainShell> createState() => _MainShellState();
}

class _MainShellState extends State<MainShell> {
  int _index = 0;
  final _pages = [
    HomeScreen(),
    MembersScreen(),
    NotesScreen(),
    NotificationsListScreen(),
    ProfileScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pages[_index],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _index,
        selectedItemColor: AppTheme.primary,
        unselectedItemColor: Colors.grey[600],
        showUnselectedLabels: true,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
          BottomNavigationBarItem(icon: Icon(Icons.group), label: 'Members'),
          BottomNavigationBarItem(icon: Icon(Icons.note), label: 'Notes'),
          BottomNavigationBarItem(icon: Icon(Icons.notifications), label: 'Notify'),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Profile'),
        ],
        onTap: (i) => setState(() => _index = i),
      ),
    );
  }
}

/// Global in-memory manager for notifications and settings (simple demo)
class NotificationManager {
  static final NotificationManager _instance = NotificationManager._internal();
  factory NotificationManager() => _instance;
  NotificationManager._internal() {
    // seed demo notifications
    notifications = [
      AppNotification(
        id: '1',
        title: 'Farmer removed successfully',
        message: 'The farmer has been removed. All linked info cleared.',
        timeAgo: '10m ago',
        group: NotificationGroup.today,
        icon: Icons.delete,
      ),
      AppNotification(
        id: '2',
        title: 'Selling completed successfully',
        message: 'Sale completed. Your transaction is now updated.',
        timeAgo: '2h ago',
        group: NotificationGroup.today,
        icon: Icons.check_circle,
      ),
      AppNotification(
        id: '3',
        title: 'Farmer added successfully',
        message: 'The farmer has been added successfully. You can manage records.',
        timeAgo: '2d ago',
        group: NotificationGroup.week,
        icon: Icons.add,
      ),
      AppNotification(
        id: '4',
        title: 'Successfully Registered',
        message: 'Registration successful. Thank you for being part of our community.',
        timeAgo: '3d ago',
        group: NotificationGroup.week,
        icon: Icons.card_giftcard,
      ),
    ];
  }

  List<AppNotification> notifications = [];

  /// toggles/drops notification settings
  Map<String, bool> settings = {
    'Sound': true,
    'Account': true,
    'Community Support': true,
    'Monthly Summary': true,
    'My field visitor': true,
  };

  void remove(String id) {
    notifications.removeWhere((n) => n.id == id);
  }

  void clearAll() {
    notifications.clear();
  }

  void toggleSetting(String key, bool val) {
    settings[key] = val;
  }

  List<AppNotification> byGroup(NotificationGroup g) =>
      notifications.where((n) => n.group == g).toList();
}

enum NotificationGroup { today, week }

class AppNotification {
  final String id;
  final String title;
  final String message;
  final String timeAgo;
  final IconData icon;
  final NotificationGroup group;

  AppNotification({
    required this.id,
    required this.title,
    required this.message,
    required this.timeAgo,
    required this.icon,
    required this.group,
  });
}

/// HomeScreen - shows profile card and Settings/Resources similar to your design
class HomeScreen extends StatelessWidget {
  final String localImagePath =
      '/mnt/data/db6485ec-221f-4f40-a052-08b1c16da7bc.png'; // your uploaded image path

  Widget profileCard(BuildContext context) {
    final fm = NotificationManager();
    ImageProvider? imageProvider;
    try {
      final f = File(localImagePath);
      if (f.existsSync()) {
        imageProvider = FileImage(f);
      }
    } catch (_) {
      imageProvider = null;
    }

    return Container(
      padding: const EdgeInsets.all(12),
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      decoration: BoxDecoration(
        color: AppTheme.primary,
        borderRadius: BorderRadius.circular(AppTheme.borderRadius),
      ),
      child: Row(
        children: [
          CircleAvatar(
            radius: 28,
            backgroundImage: imageProvider ?? const AssetImage('assets/profile_placeholder.png'),
            backgroundColor: Colors.white,
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Ravi Mohan (k001)', style: TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold)),
                const SizedBox(height: 4),
                Text('field visitor', style: TextStyle(color: Colors.white70)),
              ],
            ),
          ),
          IconButton(
            onPressed: () {
              Navigator.pushNamed(context, '/notifications_list');
            },
            icon: const Icon(Icons.notifications, color: Colors.white),
          )
        ],
      ),
    );
  }

  Widget sectionTile(BuildContext ctx, {required IconData icon, required String title, String? route}) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(AppTheme.borderRadius)),
      child: ListTile(
        leading: Icon(icon, color: AppTheme.primary),
        title: Text(title, style: TextStyle(color: AppTheme.primary)),
        trailing: const Icon(Icons.chevron_right),
        onTap: () {
          if (route != null) Navigator.pushNamed(ctx, route);
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final nm = NotificationManager();
    return Scaffold(
      appBar: AppBar(
        leading: BackButton(color: AppTheme.primary),
        title: const Text(''),
        actions: [
          IconButton(
            icon: const Icon(Icons.settings),
            onPressed: () => Navigator.pushNamed(context, '/settings'),
            color: AppTheme.primary,
          )
        ],
      ),
      body: ListView(
        children: [
          profileCard(context),
          const SizedBox(height: 8),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 6),
            child: Text('Settings', style: AppTheme.section),
          ),
          sectionTile(context, icon: Icons.settings_applications, title: 'Preferences', route: '/settings'),
          sectionTile(context, icon: Icons.person, title: 'Account', route: '/profile'),
          sectionTile(context, icon: Icons.notifications_active, title: 'Notification Setting', route: '/notification_settings'),
          const SizedBox(height: 8),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 6),
            child: Text('Resources', style: AppTheme.section),
          ),
          sectionTile(context, icon: Icons.group, title: 'Community Support'),
          sectionTile(context, icon: Icons.calendar_today, title: 'Monthly Summary'),
          sectionTile(context, icon: Icons.person_add, title: 'My Members', route: '/members'),
          const SizedBox(height: 60),
        ],
      ),
    );
  }
}

/// Settings Screen (simple placeholder)
class SettingsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Settings'),
        leading: BackButton(color: AppTheme.primary),
      ),
      body: ListView(
        padding: const EdgeInsets.all(12),
        children: [
          Card(
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(AppTheme.borderRadius)),
            child: ListTile(
              leading: Icon(Icons.tune, color: AppTheme.primary),
              title: const Text('Preferences'),
              trailing: const Icon(Icons.chevron_right),
            ),
          ),
          Card(
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(AppTheme.borderRadius)),
            child: ListTile(
              leading: Icon(Icons.person, color: AppTheme.primary),
              title: const Text('Account'),
              trailing: const Icon(Icons.chevron_right),
            ),
          ),
        ],
      ),
    );
  }
}

/// Notification Settings screen: toggles for each setting
class NotificationSettingsScreen extends StatefulWidget {
  @override
  State<NotificationSettingsScreen> createState() => _NotificationSettingsScreenState();
}

class _NotificationSettingsScreenState extends State<NotificationSettingsScreen> {
  final nm = NotificationManager();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Notification'),
        leading: BackButton(color: AppTheme.primary),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: nm.settings.keys.map((k) {
            return Card(
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(AppTheme.borderRadius)),
              margin: const EdgeInsets.symmetric(vertical: 8),
              child: SwitchListTile(
                value: nm.settings[k] ?? false,
                onChanged: (v) {
                  setState(() {
                    nm.toggleSetting(k, v);
                  });
                },
                title: Text(k),
                secondary: const Icon(Icons.notifications),
              ),
            );
          }).toList(),
        ),
      ),
    );
  }
}

/// Notifications List: grouped by Today and This Week with remove/clear actions.
class NotificationsListScreen extends StatefulWidget {
  @override
  State<NotificationsListScreen> createState() => _NotificationsListScreenState();
}

class _NotificationsListScreenState extends State<NotificationsListScreen> {
  final nm = NotificationManager();

  void _remove(String id) {
    setState(() {
      nm.remove(id);
    });
  }

  void _clearAll() {
    setState(() {
      nm.clearAll();
    });
  }

  Widget _buildNotificationCard(AppNotification n) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(AppTheme.borderRadius)),
      margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
      child: ListTile(
        leading: CircleAvatar(
          backgroundColor: AppTheme.card,
          child: Icon(n.icon, color: AppTheme.primary),
        ),
        title: Text(n.title, style: TextStyle(fontWeight: FontWeight.bold)),
        subtitle: Text(n.message),
        trailing: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(n.timeAgo, style: TextStyle(fontSize: 12, color: Colors.grey[600])),
            IconButton(
              onPressed: () => _remove(n.id),
              icon: Icon(Icons.delete_outline, size: 20, color: Colors.grey[700]),
            )
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final today = nm.byGroup(NotificationGroup.today);
    final week = nm.byGroup(NotificationGroup.week);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Notification'),
        leading: BackButton(color: AppTheme.primary),
        actions: [
          TextButton(
            onPressed: _clearAll,
            child: const Text('Clear', style: TextStyle(color: Colors.black54)),
          )
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.only(top: 12),
        child: ListView(
          children: [
            if (today.isNotEmpty) Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Text('TODAY', style: TextStyle(color: AppTheme.primary, fontWeight: FontWeight.bold)),
            ),
            ...today.map(_buildNotificationCard),
            if (week.isNotEmpty) Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
              child: Text('THIS WEEK', style: TextStyle(color: AppTheme.primary, fontWeight: FontWeight.bold)),
            ),
            ...week.map(_buildNotificationCard),
            if (nm.notifications.isEmpty)
              Padding(
                padding: const EdgeInsets.all(36.0),
                child: Center(child: Text('No notifications', style: TextStyle(color: Colors.grey[700]))),
              ),
            const SizedBox(height: 80),
          ],
        ),
      ),
    );
  }
}

/// Members screen (simple)
class MembersScreen extends StatelessWidget {
  final demoMembers = List.generate(8, (i) => 'Farmer ${i + 1}');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Members'),
        leading: BackButton(color: AppTheme.primary),
      ),
      body: ListView.builder(
        itemCount: demoMembers.length,
        itemBuilder: (c, i) {
          return Card(
            margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(AppTheme.borderRadius)),
            child: ListTile(
              leading: CircleAvatar(child: Text(demoMembers[i][0])),
              title: Text(demoMembers[i]),
              subtitle: Text('Village ${i + 1}'),
              trailing: Icon(Icons.chevron_right),
              onTap: () {},
            ),
          );
        },
      ),
    );
  }
}

/// Notes screen (simple placeholder)
class NotesScreen extends StatelessWidget {
  final demoNotes = [
    'Note about fertilizer schedule',
    'Contact list update',
    'Monthly summary draft'
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Notes'),
        leading: BackButton(color: AppTheme.primary),
      ),
      body: ListView.builder(
        itemCount: demoNotes.length,
        itemBuilder: (c, i) {
          return Card(
            margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
            child: ListTile(
              title: Text(demoNotes[i]),
              trailing: Icon(Icons.notes),
            ),
          );
        },
      ),
    );
  }
}

/// Profile screen
class ProfileScreen extends StatelessWidget {
  final String localImagePath =
      '/mnt/data/db6485ec-221f-4f40-a052-08b1c16da7bc.png'; // path to uploaded image

  @override
  Widget build(BuildContext context) {
    ImageProvider? imageProvider;
    try {
      final f = File(localImagePath);
      if (f.existsSync()) imageProvider = FileImage(f);
    } catch (_) {
      imageProvider = null;
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('Profile'),
        leading: BackButton(color: AppTheme.primary),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          Center(
            child: CircleAvatar(
              radius: 48,
              backgroundImage: imageProvider ?? const AssetImage('assets/profile_placeholder.png'),
              backgroundColor: Colors.white,
            ),
          ),
          const SizedBox(height: 12),
          Center(child: Text('Ravi Mohan (k001)', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold))),
          const SizedBox(height: 8),
          Center(child: Text('Field visitor', style: TextStyle(color: Colors.grey[700]))),
          const SizedBox(height: 20),
          Card(
            child: ListTile(
              leading: Icon(Icons.email, color: AppTheme.primary),
              title: Text('ravi@example.com'),
            ),
          ),
          Card(
            child: ListTile(
              leading: Icon(Icons.phone, color: AppTheme.primary),
              title: Text('+94 7xx xxx xxx'),
            ),
          ),
        ],
      ),
    );
  }
}

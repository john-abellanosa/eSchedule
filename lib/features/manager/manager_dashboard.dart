import 'package:escheduler/Features/manager/pages/manager_request_page/manager_request_page.dart';
import 'package:escheduler/Features/manager/pages/manager_home_page.dart';
import 'package:escheduler/Features/manager/pages/manager_profile_page.dart';
import 'package:escheduler/Features/manager/pages/manager_schedule_page.dart';
import 'package:escheduler/Features/manager/pages/manager_team_page.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const eSchedule());
}

class eSchedule extends StatelessWidget {
  const eSchedule({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'eSchedule',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
        scaffoldBackgroundColor: const Color(0xFFF5F7FA),
        fontFamily: 'SF Pro Display',
        colorScheme: ColorScheme.fromSwatch().copyWith(
          secondary: const Color(0xFF1E3A8A),
        ),
        useMaterial3: true,
      ),
      home: const ManagerDashboard(),
    );
  }
}

class ManagerDashboard extends StatefulWidget {
  const ManagerDashboard({Key? key}) : super(key: key);

  @override
  State<ManagerDashboard> createState() => _ManagerDashboardState();
}

class _ManagerDashboardState extends State<ManagerDashboard> {
  int _selectedIndex = 0;

  final List<Widget> _pages = [
    const ManagerHomePage(),
    const ManagerTeamPage(),
    const ManagerSchedulePage(),
    const ManagerRequestPage(),
    const ManagerProfilePage(),
  ];

  // Outlined icons for inactive state
  final List<IconData> _outlinedIcons = [
    Icons.home_outlined,
    Icons.people_outlined,
    Icons.calendar_today_outlined,
    Icons.description_outlined,
    Icons.person_outlined,
  ];

  // Filled icons for active state
  final List<IconData> _filledIcons = [
    Icons.home_rounded,
    Icons.people_rounded,
    Icons.calendar_today_rounded,
    Icons.description_rounded,
    Icons.person_rounded,
  ];

  final List<String> _labels = [
    'Home',
    'Team',
    'Schedule',
    'Requests',
    'Profile',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pages[_selectedIndex],
      bottomNavigationBar: Container(
        height: 58, // Smaller height
        decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(.08),
              blurRadius: 12,
              offset: const Offset(0, -2),
            ),
          ],
        ),
        child: SafeArea(
          top: false,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 1),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                _navItem(0),
                _navItem(1),
                Flexible(child: _centerLogo()),
                _navItem(3),
                _navItem(4),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _navItem(int index) {
    final selected = _selectedIndex == index;
    // Same width padding as before
    final horizontalPadding = index >= 3 ? 6 : 12;

    return GestureDetector(
      onTap: () => setState(() => _selectedIndex = index),
      child: Container(
        padding: EdgeInsets.symmetric(
          horizontal: horizontalPadding.toDouble(),
          vertical: 4, // Smaller vertical padding
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              selected ? _filledIcons[index] : _outlinedIcons[index],
              size: 23, // Slightly smaller icon
              color: selected ? const Color(0xFF1E3A8A) : Colors.grey[400],
            ),
            const SizedBox(height: 2), // Smaller spacing
            Text(
              _labels[index],
              style: TextStyle(
                fontSize: 9, // Smaller font
                fontWeight: selected ? FontWeight.w600 : FontWeight.normal,
                color: selected ? const Color(0xFF1E3A8A) : Colors.grey[600],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _centerLogo() {
    final bool selected = _selectedIndex == 2;

    return GestureDetector(
      onTap: () {
        setState(() => _selectedIndex = 2);
      },
      child: Container(
        height: 58, // Match parent smaller height
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Transform.translate(
              offset: const Offset(0, -10), // Less offset for smaller height
              child: Stack(
                alignment: Alignment.center,
                children: [
                  // Background circle
                  Container(
                    width: 42, // Smaller size
                    height: 42,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: selected
                          ? const Color(0xFF1E3A8A).withOpacity(0.1)
                          : Colors.transparent,
                    ),
                  ),
                  // Icon/Image
                  Container(
                    width: 39, // Smaller size
                    height: 39,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(
                        color: Colors.white,
                        width: 1.5,
                      ), // Thinner border
                    ),
                    child: ClipOval(
                      child: Image.asset(
                        'assets/img/schedule_page_icon.png',
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  // Overlay for active state
                  if (selected)
                    Container(
                      width: 39,
                      height: 39,
                      decoration: BoxDecoration(shape: BoxShape.circle),
                    ),
                ],
              ),
            ),
            Transform.translate(
              offset: const Offset(0, -8), // Less offset for smaller height
              child: Text(
                'Schedule',
                style: TextStyle(
                  fontSize: 9, // Smaller font
                  fontWeight: selected ? FontWeight.w600 : FontWeight.normal,
                  color: selected ? const Color(0xFF1E3A8A) : Colors.grey[600],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

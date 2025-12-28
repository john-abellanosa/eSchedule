import 'package:escheduler/features/crew/dashboard/pages/crew_request_page.dart';
import 'package:escheduler/features/crew/dashboard/pages/crew_home_page.dart';
import 'package:escheduler/features/crew/dashboard/pages/crew_profile_page.dart';
import 'package:escheduler/features/crew/dashboard/pages/crew_schedule_page.dart';
import 'package:escheduler/features/crew/dashboard/pages/crew_team_page.dart';
import 'package:flutter/material.dart';

void main() => runApp(const eSchedule());

/* ------------------------------------------------------------------
   1.  APP SHELL  (identical theme & fonts)
   ------------------------------------------------------------------ */
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
      ),
      home: const CrewDashboard(),
    );
  }
}

class CrewDashboard extends StatefulWidget {
  const CrewDashboard({Key? key}) : super(key: key);

  @override
  State<CrewDashboard> createState() => _CrewDashboardState();
}

class _CrewDashboardState extends State<CrewDashboard> {
  int _selectedIndex = 0;

  final _screens = const [
    CrewHomePage(),
    CrewTeamPage(),
    CrewSchedulePage(),
    CrewRequestPage(),
    CrewProfilePage(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _screens[_selectedIndex],
      bottomNavigationBar: Container(
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
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 1),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                _navItem(Icons.home_rounded, 'Home', 0),
                _navItem(Icons.people_rounded, 'Team', 1),
                Flexible(child: _centerLogo()),
                _navItem(
                  Icons.description_rounded,
                  'Requests',
                  3,
                  smallerPadding: true,
                ),
                _navItem(
                  Icons.person_rounded,
                  'Profile',
                  4,
                  smallerPadding: true,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _navItem(
    IconData icon,
    String label,
    int index, {
    bool smallerPadding = false,
  }) {
    final selected = _selectedIndex == index;
    return GestureDetector(
      onTap: () => setState(() => _selectedIndex = index),
      child: Container(
        padding: EdgeInsets.symmetric(
          horizontal: smallerPadding
              ? 6
              : 12, // Reduced horizontal padding for active state
          vertical: smallerPadding
              ? 10
              : 8, // Reduced vertical padding for active state
        ),
        decoration: BoxDecoration(
          color: selected
              ? const Color(0xFF1E3A8A).withOpacity(.1)
              : Colors.transparent,
          borderRadius: BorderRadius.circular(8),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              icon,
              size: 22,
              color: selected ? const Color(0xFF1E3A8A) : Colors.grey[400],
            ),
            const SizedBox(height: 4),
            Text(
              label,
              style: TextStyle(
                fontSize: 10,
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
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Transform.translate(
            offset: const Offset(0, -14),
            child: Container(
              width: 56,
              height: 56,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(color: Colors.white, width: 3),
              ),
              child: ClipOval(
                child: Image.asset(
                  'assets/img/schedule_page_icon.png',
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),
          Transform.translate(
            offset: const Offset(0, -12),
            child: Text(
              'Schedule',
              style: TextStyle(
                fontSize: 10,
                fontWeight: selected ? FontWeight.w600 : FontWeight.normal,
                color: selected ? const Color(0xFF1E3A8A) : Colors.grey[600],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

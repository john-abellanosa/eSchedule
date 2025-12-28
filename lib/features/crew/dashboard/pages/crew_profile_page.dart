import 'package:flutter/material.dart';

class CrewProfilePage extends StatelessWidget {
  const CrewProfilePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F7FA),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              // Header with gradient
              Container(
                padding: const EdgeInsets.all(20),
                decoration: const BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      Color(0xFF1E3A8A), // Dark blue
                      Color(0xFF3B82F6), // Light blue
                    ],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                ),
                child: Column(
                  children: [
                    Row(
                      children: [
                        const Text(
                          'Profile',
                          style: TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                        const Spacer(),
                        Container(
                          padding: const EdgeInsets.all(10),
                          decoration: BoxDecoration(
                            color: Colors.white.withOpacity(0.2),
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: const Icon(
                            Icons.settings_rounded,
                            color: Colors.white,
                            size: 20,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 24),
                    CircleAvatar(
                      radius: 50,
                      backgroundColor: Colors.white,
                      child: const Text(
                        'JD',
                        style: TextStyle(
                          color: Color(0xFF1E3A8A), // BLUE THEME
                          fontWeight: FontWeight.bold,
                          fontSize: 32,
                        ),
                      ),
                    ),
                    const SizedBox(height: 16),
                    const Text(
                      'John Sindicato',
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      'Crew Member • ID: CM2024-1234',
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.white.withOpacity(0.9),
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 20),

              // Stats Row
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Row(
                  children: [
                    Expanded(
                      child: _buildProfileStat(
                        '152',
                        'Total Shifts',
                        Icons.calendar_month_rounded,
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: _buildProfileStat(
                        '4.8',
                        'Rating',
                        Icons.star_rounded,
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: _buildProfileStat(
                        '8 mo',
                        'Tenure',
                        Icons.workspace_premium_rounded,
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 24),

              // Menu Items
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Column(
                  children: [
                    _buildMenuItem(
                      Icons.person_outline_rounded,
                      'Personal Information',
                    ),
                    _buildMenuItem(
                      Icons.credit_card_rounded,
                      'Payment & Earnings',
                    ),
                    _buildMenuItem(Icons.schedule_rounded, 'Availability'),
                    _buildMenuItem(Icons.history_rounded, 'Shift History'),
                    _buildMenuItem(Icons.assessment_rounded, 'Performance'),
                    _buildMenuItem(
                      Icons.notifications_outlined,
                      'Notifications',
                    ),
                    _buildMenuItem(
                      Icons.help_outline_rounded,
                      'Help & Support',
                    ),
                    _buildMenuItem(
                      Icons.privacy_tip_outlined,
                      'Privacy Policy',
                    ),

                    const SizedBox(height: 12),

                    _buildMenuItem(
                      Icons.logout_rounded,
                      'Logout',
                      isLogout: true,
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 24),
            ],
          ),
        ),
      ),
    );
  }

  // BLUE STAT CARDS
  Widget _buildProfileStat(String value, String label, IconData icon) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.04),
            blurRadius: 10,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        children: [
          Icon(icon, color: Color(0xFF1E3A8A), size: 24), // BLUE ICON
          const SizedBox(height: 8),
          Text(
            value,
            style: const TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Color(0xFF1A1D1F),
            ),
          ),
          const SizedBox(height: 2),
          Text(
            label,
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 11, color: Colors.grey[600]),
          ),
        ],
      ),
    );
  }

  // MENU ITEMS
  Widget _buildMenuItem(IconData icon, String title, {bool isLogout = false}) {
    const blackColor = Color(0xFF1A1D1F); // Black for text and icon
    const darkRed = Color(0xFFB91C1C); // Darker red for logout

    return Container(
      margin: const EdgeInsets.only(bottom: 8),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.04),
            blurRadius: 10,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: ListTile(
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 16,
        ), // closer to icon
        leading: Icon(
          icon,
          color: isLogout ? darkRed : blackColor, // black for regular items
          size: 20,
        ),
        title: Text(
          title,
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w600,
            color: isLogout ? darkRed : blackColor,
          ),
        ),
        trailing: Icon(
          Icons.arrow_forward_ios_rounded,
          size: 16,
          color: Colors.grey[400],
        ),
        onTap: () {},
      ),
    );
  }
}

import 'package:flutter/material.dart';

class ManagerProfilePage extends StatelessWidget {
  const ManagerProfilePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F7FA),
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            pinned: true,
            expandedHeight: 220,
            flexibleSpace: FlexibleSpaceBar(
              background: Container(
                decoration: const BoxDecoration(
                  gradient: LinearGradient(
                    colors: [Color(0xFF1E3A8A), Color(0xFF3B82F6)],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                ),
                child: SafeArea(
                  bottom: false,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      // Profile Image with Border
                      Container(
                        width: 100,
                        height: 100,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          border: Border.all(color: Colors.white, width: 3),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.2),
                              blurRadius: 10,
                              offset: const Offset(0, 4),
                            ),
                          ],
                        ),
                        child: ClipOval(
                          child: Container(
                            color: const Color(0xFFE0F2FE),
                            child: const Center(
                              child: Text(
                                'MA',
                                style: TextStyle(
                                  fontSize: 32,
                                  fontWeight: FontWeight.w700,
                                  color: Color(0xFF0369A1),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 16),
                      const Text(
                        'Manager Account',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      const SizedBox(height: 4),
                      const Text(
                        'Restaurant Manager',
                        style: TextStyle(
                          color: Colors.white70,
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 24),
              child: Column(
                children: [
                  // Stats Cards
                  Row(
                    children: [
                      Expanded(
                        child: _buildStatCard(
                          icon: Icons.people,
                          value: '48',
                          label: 'Team Size',
                          color: const Color(0xFF1E3A8A),
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: _buildStatCard(
                          icon: Icons.calendar_today,
                          value: '22',
                          label: 'Days Present',
                          color: const Color(0xFF059669),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 12),
                  Row(
                    children: [
                      Expanded(
                        child: _buildStatCard(
                          icon: Icons.star,
                          value: '4.8',
                          label: 'Rating',
                          color: const Color(0xFFF59E0B),
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: _buildStatCard(
                          icon: Icons.schedule,
                          value: '2.5y',
                          label: 'Tenure',
                          color: const Color(0xFF7C3AED),
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 32),

                  // Profile Information Card
                  _buildInfoCard(
                    title: 'Personal Information',
                    children: [
                      _buildInfoItem(
                        icon: Icons.person,
                        label: 'Full Name',
                        value: 'Michael Anderson',
                      ),
                      _buildInfoItem(
                        icon: Icons.email,
                        label: 'Email',
                        value: 'm.anderson@restaurant.com',
                      ),
                      _buildInfoItem(
                        icon: Icons.phone,
                        label: 'Phone',
                        value: '+1 (555) 123-4567',
                      ),
                      _buildInfoItem(
                        icon: Icons.business,
                        label: 'Restaurant',
                        value: 'FoodChain Downtown',
                      ),
                      _buildInfoItem(
                        icon: Icons.location_on,
                        label: 'Location',
                        value: 'New York, NY',
                      ),
                    ],
                  ),

                  const SizedBox(height: 24),

                  // Management Section
                  _buildInfoCard(
                    title: 'Management',
                    children: [
                      _buildManagementItem(
                        icon: Icons.work,
                        label: 'Department',
                        value: 'Operations',
                        color: const Color(0xFF1E3A8A),
                      ),
                      _buildManagementItem(
                        icon: Icons.security,
                        label: 'Access Level',
                        value: 'Full Access',
                        color: const Color(0xFF059669),
                      ),
                      _buildManagementItem(
                        icon: Icons.badge,
                        label: 'Employee ID',
                        value: 'MGR-2023-001',
                        color: const Color(0xFF7C3AED),
                      ),
                      _buildManagementItem(
                        icon: Icons.event_available,
                        label: 'Joined Date',
                        value: 'Jan 15, 2022',
                        color: const Color(0xFFF59E0B),
                      ),
                    ],
                  ),

                  const SizedBox(height: 24),

                  // Quick Actions
                  _buildInfoCard(
                    title: 'Quick Actions',
                    children: [
                      _buildActionItem(
                        icon: Icons.settings,
                        label: 'Settings',
                        onTap: () {},
                      ),
                      _buildActionItem(
                        icon: Icons.help,
                        label: 'Help & Support',
                        onTap: () {},
                      ),
                      _buildActionItem(
                        icon: Icons.privacy_tip,
                        label: 'Privacy Policy',
                        onTap: () {},
                      ),
                      _buildActionItem(
                        icon: Icons.info,
                        label: 'About App',
                        onTap: () {},
                      ),
                    ],
                  ),

                  const SizedBox(height: 32),

                  // Logout Button
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: () {
                        _showLogoutDialog(context);
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFFDC2626),
                        padding: const EdgeInsets.symmetric(vertical: 16),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        elevation: 0,
                        shadowColor: Colors.transparent,
                      ),
                      child: const Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(Icons.logout, size: 20, color: Colors.white),
                          SizedBox(width: 12),
                          Text(
                            'Logout',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),

                  const SizedBox(height: 32),

                  // App Version
                  const Text(
                    'Restaurant Manager v2.4.1',
                    style: TextStyle(
                      color: Color(0xFF94A3B8),
                      fontSize: 12,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStatCard({
    required IconData icon,
    required String value,
    required String label,
    required Color color,
  }) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: const Color(0xFFE7EBF0)),
        boxShadow: const [
          BoxShadow(
            color: Color(0x140F172A),
            blurRadius: 10,
            offset: Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        children: [
          Container(
            width: 48,
            height: 48,
            decoration: BoxDecoration(
              color: color.withOpacity(0.1),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Center(child: Icon(icon, size: 24, color: color)),
          ),
          const SizedBox(height: 12),
          Text(
            value,
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.w700,
              color: color,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            label,
            style: const TextStyle(
              fontSize: 12,
              color: Color(0xFF64748B),
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildInfoCard({
    required String title,
    required List<Widget> children,
  }) {
    return Container(
      padding: const EdgeInsets.all(0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: const Color(0xFFE7EBF0)),
        boxShadow: const [
          BoxShadow(
            color: Color(0x0F000000),
            blurRadius: 10,
            offset: Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(20),
            child: Text(
              title,
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w700,
                color: Color(0xFF0F172A),
              ),
            ),
          ),
          const Divider(height: 1, color: Color(0xFFE7EBF0)),
          ...children,
        ],
      ),
    );
  }

  Widget _buildInfoItem({
    required IconData icon,
    required String label,
    required String value,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
      child: Row(
        children: [
          Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              color: const Color(0xFFF1F5F9),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Center(
              child: Icon(icon, size: 20, color: const Color(0xFF64748B)),
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  label,
                  style: const TextStyle(
                    fontSize: 12,
                    color: Color(0xFF64748B),
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  value,
                  style: const TextStyle(
                    fontSize: 14,
                    color: Color(0xFF0F172A),
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildManagementItem({
    required IconData icon,
    required String label,
    required String value,
    required Color color,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
      child: Row(
        children: [
          Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              color: color.withOpacity(0.1),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Center(child: Icon(icon, size: 20, color: color)),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  label,
                  style: const TextStyle(
                    fontSize: 12,
                    color: Color(0xFF64748B),
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  value,
                  style: TextStyle(
                    fontSize: 14,
                    color: color,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildActionItem({
    required IconData icon,
    required String label,
    required VoidCallback onTap,
  }) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(8),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
          child: Row(
            children: [
              Container(
                width: 40,
                height: 40,
                decoration: BoxDecoration(
                  color: const Color(0xFFF1F5F9),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Center(
                  child: Icon(icon, size: 20, color: const Color(0xFF64748B)),
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Text(
                  label,
                  style: const TextStyle(
                    fontSize: 14,
                    color: Color(0xFF0F172A),
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
              const Icon(
                Icons.chevron_right,
                size: 20,
                color: Color(0xFFCBD5E1),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _showLogoutDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => Dialog(
        backgroundColor: Colors.white,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                width: 60,
                height: 60,
                decoration: BoxDecoration(
                  color: const Color(0xFFFEE2E2),
                  shape: BoxShape.circle,
                ),
                child: const Center(
                  child: Icon(Icons.logout, size: 28, color: Color(0xFFDC2626)),
                ),
              ),
              const SizedBox(height: 20),
              const Text(
                'Logout',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w700,
                  color: Color(0xFF0F172A),
                ),
              ),
              const SizedBox(height: 8),
              const Text(
                'Are you sure you want to logout?',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 14,
                  color: Color(0xFF64748B),
                  fontWeight: FontWeight.w500,
                ),
              ),
              const SizedBox(height: 24),
              Row(
                children: [
                  Expanded(
                    child: OutlinedButton(
                      onPressed: () => Navigator.pop(context),
                      style: OutlinedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(vertical: 14),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        side: const BorderSide(color: Color(0xFFE2E8F0)),
                      ),
                      child: const Text(
                        'Cancel',
                        style: TextStyle(
                          color: Color(0xFF64748B),
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: ElevatedButton(
                      onPressed: () {
                        // Perform logout action
                        Navigator.pop(context);
                        // Navigate to login screen or perform logout logic
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFFDC2626),
                        padding: const EdgeInsets.symmetric(vertical: 14),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      child: const Text(
                        'Logout',
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

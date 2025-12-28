import 'package:escheduler/features/manager/pages/manager_notification.dart';
import 'package:flutter/material.dart';

class ManagerHomePage extends StatelessWidget {
  const ManagerHomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F7FA),
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            pinned: true,
            elevation: 0,
            backgroundColor: Colors.transparent,
            expandedHeight: 96,
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
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 10,
                    ),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        CircleAvatar(
                          radius: 20,
                          backgroundColor: Colors.white.withOpacity(0.18),
                          child: const Text(
                            'JD',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 14,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        ),
                        const SizedBox(width: 10),
                        const Expanded(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'John Doe',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 16,
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                              SizedBox(height: 2),
                              Text(
                                'Service Manager',
                                style: TextStyle(
                                  color: Colors.white70,
                                  fontSize: 11,
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox.shrink(),
                        Container(
                          decoration: BoxDecoration(
                            color: Color(0xFF1E3A8A),
                            borderRadius: BorderRadius.circular(
                              12,
                            ), // Border radius
                          ),
                          child: IconButton(
                            icon: const Icon(
                              Icons.notifications_outlined,
                              color: Colors.white,
                            ),
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => ManagerNotifications(),
                                ),
                              );
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildMetrics(),
                  const SizedBox(height: 16),

                  // _sectionHeader('Quick Actions'),
                  // const SizedBox(height: 12),
                  // _buildQuickActions(context),
                  // const SizedBox(height: 16),
                  _sectionHeader(
                    'Upcoming Shifts',
                    trailing: _mutedAction('View All'),
                  ),
                  const SizedBox(height: 12),
                  _buildShiftItem(
                    'Tomorrow',
                    'Dec 13',
                    '8:00 AM - 4:00 PM',
                    'Management',
                    const Color(0xFF06B6D4),
                  ),
                  const SizedBox(height: 8),
                  _buildShiftItem(
                    'Saturday',
                    'Dec 14',
                    '10:00 AM - 6:00 PM',
                    'Supervision',
                    const Color(0xFF8B5CF6),
                  ),
                  const SizedBox(height: 8),
                  _buildShiftItem(
                    'Sunday',
                    'Dec 15',
                    '12:00 PM - 8:00 PM',
                    'Management',
                    const Color(0xFF667EEA),
                  ),
                  const SizedBox(height: 24),

                  _sectionHeader(
                    'Staff Overview',
                    trailing: _mutedAction('View All'),
                  ),
                  const SizedBox(height: 12),
                  _buildStaffStatus(
                    'Morning Shift',
                    '6:00 AM - 2:00 PM',
                    5,
                    5,
                    const Color(0xFF10B981),
                  ),
                  const SizedBox(height: 8),
                  _buildStaffStatus(
                    'Afternoon Shift',
                    '2:00 PM - 10:00 PM',
                    4,
                    6,
                    const Color(0xFFF59E0B),
                  ),
                  const SizedBox(height: 8),
                  _buildStaffStatus(
                    'Night Shift',
                    '10:00 PM - 6:00 AM',
                    3,
                    4,
                    const Color(0xFF06B6D4),
                  ),
                  const SizedBox(height: 24),

                  _sectionHeader(
                    'Announcements',
                    trailing: _mutedAction('Create New'),
                  ),
                  const SizedBox(height: 12),
                  _buildAnnouncement(
                    'Holiday Schedule Update',
                    'The holiday schedule for December 24-26 has been posted. Please check your shifts.',
                    '1 day ago',
                  ),
                  const SizedBox(height: 8),
                  _buildAnnouncement(
                    'Staff Meeting Reminder',
                    'Monthly staff meeting on Friday, December 13 at 3:00 PM in the conference room.',
                    '3 days ago',
                  ),
                  const SizedBox(height: 8),
                  _buildAnnouncement(
                    'New Equipment Training',
                    'Training session for new kitchen equipment scheduled for next Monday at 9:00 AM.',
                    '5 days ago',
                  ),
                  const SizedBox(height: 24),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMetrics() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 0),
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              blurRadius: 10,
              offset: const Offset(0, 5),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 8,
                    vertical: 3,
                  ),
                  decoration: BoxDecoration(
                    color: const Color(0xFF1E3A8A).withOpacity(0.2),
                    borderRadius: BorderRadius.circular(6),
                  ),
                  child: const Text(
                    'NEXT SHIFT',
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 10,
                      fontWeight: FontWeight.w600,
                      letterSpacing: 1,
                    ),
                  ),
                ),
                const Spacer(),
                const Icon(
                  Icons.access_time_rounded,
                  color: Colors.white,
                  size: 18,
                ),
              ],
            ),
            const SizedBox(height: 14),
            const Text(
              'Today, December 12',
              style: TextStyle(
                color: Colors.black,
                fontSize: 14,
                fontWeight: FontWeight.w500,
              ),
            ),
            const SizedBox(height: 6),
            const Text(
              '8:00 AM - 4:00 PM',
              style: TextStyle(
                color: Colors.black,
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 10),
            Row(
              children: [
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 10,
                    vertical: 5,
                  ),
                  decoration: BoxDecoration(
                    color: const Color(0xFF1E3A8A),
                    borderRadius: BorderRadius.circular(6),
                  ),
                  child: const Row(
                    children: [
                      Icon(
                        Icons.admin_panel_settings_rounded,
                        size: 14,
                        color: Colors.white,
                      ),
                      SizedBox(width: 6),
                      Text(
                        'Management',
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.w600,
                          fontSize: 12,
                        ),
                      ),
                    ],
                  ),
                ),
                const Spacer(),
                Text(
                  'Starts in 1 hour',
                  style: TextStyle(
                    color: Colors.black.withOpacity(0.9),
                    fontSize: 12,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildShiftItem(
    String day,
    String date,
    String time,
    String dept,
    Color color,
  ) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: const Color(0xFFE7EBF0)),
        boxShadow: const [
          BoxShadow(
            color: Color(0x140F172A),
            blurRadius: 8,
            offset: Offset(0, 3),
          ),
        ],
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 6,
            height: 6,
            margin: const EdgeInsets.only(top: 4),
            decoration: BoxDecoration(color: color, shape: BoxShape.circle),
          ),
          const SizedBox(width: 10),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Text(
                      day,
                      style: const TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w700,
                        color: Color(0xFF0F172A),
                      ),
                    ),
                    const SizedBox(width: 6),
                    Text(
                      date,
                      style: const TextStyle(
                        fontSize: 10,
                        color: Color(0xFF94A3B8),
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 3),
                Text(
                  time,
                  style: const TextStyle(
                    fontSize: 12,
                    color: Color(0xFF0F172A),
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 5),
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 6,
                    vertical: 3,
                  ),
                  decoration: BoxDecoration(
                    color: const Color(0xFF1E3A8A),
                    borderRadius: BorderRadius.circular(4),
                  ),
                  child: Text(
                    dept,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 10,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(width: 6),
          const Icon(Icons.chevron_right, size: 18, color: Color(0xFF94A3B8)),
        ],
      ),
    );
  }

  Widget _buildStaffStatus(
    String title,
    String time,
    int filled,
    int requiredCount,
    Color color,
  ) {
    final double ratio = requiredCount == 0
        ? 0
        : (filled / requiredCount).clamp(0, 1).toDouble();
    final int percentage = (ratio * 100).round();

    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: const Color(0xFFE7EBF0)),
        boxShadow: const [
          BoxShadow(
            color: Color(0x140F172A),
            blurRadius: 8,
            offset: Offset(0, 3),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                title,
                style: const TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w700,
                  color: Color(0xFF0F172A),
                ),
              ),
              Text(
                '$filled/$requiredCount',
                style: const TextStyle(
                  fontSize: 10,
                  color: Color(0xFF64748B),
                  fontWeight: FontWeight.w700,
                ),
              ),
            ],
          ),
          const SizedBox(height: 3),
          Text(
            time,
            style: const TextStyle(fontSize: 10, color: Color(0xFF64748B)),
          ),
          const SizedBox(height: 6),
          ClipRRect(
            borderRadius: BorderRadius.circular(4),
            child: LinearProgressIndicator(
              value: ratio,
              minHeight: 6,
              backgroundColor: const Color(0xFFE2E8F0),
              valueColor: AlwaysStoppedAnimation<Color>(color.withOpacity(0.9)),
            ),
          ),
          const SizedBox(height: 6),
          Text(
            '$percentage%',
            style: const TextStyle(
              fontSize: 10,
              color: Color(0xFF64748B),
              fontWeight: FontWeight.w700,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildAnnouncement(String title, String body, String timeAgo) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: const Color(0xFFE7EBF0)),
        boxShadow: const [
          BoxShadow(
            color: Color(0x140F172A),
            blurRadius: 8,
            offset: Offset(0, 3),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: const TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w700,
              color: Color(0xFF0F172A),
            ),
          ),
          const SizedBox(height: 4),
          Text(
            body,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            style: const TextStyle(
              fontSize: 12,
              color: Color(0xFF475569),
              height: 1.35,
            ),
          ),
          const SizedBox(height: 6),
          Text(
            timeAgo,
            style: const TextStyle(
              fontSize: 10,
              color: Color(0xFF94A3B8),
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }

  // Helpers
  Widget _sectionHeader(String title, {Widget? trailing}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          style: const TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w800,
            color: Color(0xFF0F172A),
            letterSpacing: -0.1,
          ),
        ),
        if (trailing != null) trailing,
      ],
    );
  }

  Widget _mutedAction(String label) {
    return TextButton(
      onPressed: () {},
      style: TextButton.styleFrom(
        padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 3),
        minimumSize: const Size(36, 24),
        tapTargetSize: MaterialTapTargetSize.shrinkWrap,
      ),
      child: Text(
        label,
        style: const TextStyle(
          fontSize: 10,
          color: Color(0xFF1E3A8A),
          fontWeight: FontWeight.w700,
        ),
      ),
    );
  }
}

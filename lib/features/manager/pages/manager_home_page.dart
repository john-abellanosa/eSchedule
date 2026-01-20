import 'package:escheduler/Features/manager/pages/manager_notification.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class ManagerHomePage extends StatelessWidget {
  const ManagerHomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F7FA),
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            automaticallyImplyLeading: false,
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
                        Expanded(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Welcome Manager',
                                style: TextStyle(
                                  color: Colors.white.withOpacity(0.9),
                                  fontSize: 12,
                                ),
                              ),
                              const SizedBox(height: 2),
                              const Text(
                                'John Doe',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 16,
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox.shrink(),
                        Container(
                          decoration: BoxDecoration(
                            color: Color(0xFF1E3A8A),
                            borderRadius: BorderRadius.circular(12),
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
                  _buildDateTimeWidget(),
                  const SizedBox(height: 16),

                  _buildMetrics(),
                  const SizedBox(height: 24),

                  _sectionHeader('Announcements'),
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

                  _sectionHeader('Crew Overview'),
                  const SizedBox(height: 12),

                  // Graveyard Shift (12:00AM - 06:00AM)
                  _buildCrewShiftItem(
                    title: 'Graveyard',
                    timeRange: '12:00AM - 06:00AM',
                    crewCount: 8,
                    icon: Icons.night_shelter_outlined,
                  ),
                  const SizedBox(height: 8),

                  // Morning Shift (06:00AM - 12:00PM)
                  _buildCrewShiftItem(
                    title: 'Morning',
                    timeRange: '06:00AM - 12:00PM',
                    crewCount: 15,
                    icon: Icons.wb_sunny_outlined,
                  ),
                  const SizedBox(height: 8),

                  // Afternoon Shift (12:00PM - 06:00PM)
                  _buildCrewShiftItem(
                    title: 'Afternoon',
                    timeRange: '12:00PM - 06:00PM',
                    crewCount: 12,
                    icon: Icons.sunny,
                  ),
                  const SizedBox(height: 8),

                  // Evening Shift (06:00PM - 12:00AM)
                  _buildCrewShiftItem(
                    title: 'Evening',
                    timeRange: '06:00PM - 12:00AM',
                    crewCount: 10,
                    icon: Icons.nights_stay_outlined,
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

  Widget _buildDateTimeWidget() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: StreamBuilder<DateTime>(
        stream: Stream.periodic(
          const Duration(seconds: 1),
          (_) => DateTime.now(),
        ),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return const SizedBox();
          }

          final now = snapshot.data!;
          final dateFormat = DateFormat('EEE, MMMM d, y');
          final timeFormat = DateFormat('hh:mm:ss a');

          return Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    dateFormat.format(now),
                    style: const TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                      color: Color(0xFF1E3A8A),
                    ),
                  ),
                  const SizedBox(height: 2),
                  Text(
                    'Current Date & Time',
                    style: TextStyle(
                      fontSize: 11,
                      fontWeight: FontWeight.w500,
                      color: Colors.grey[600],
                    ),
                  ),
                ],
              ),
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 12,
                  vertical: 8,
                ),
                decoration: BoxDecoration(
                  color: const Color(0xFF1E3A8A),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Text(
                  timeFormat.format(now),
                  style: const TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.w700,
                    color: Colors.white,
                    letterSpacing: 0.5,
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }

  Widget _buildMetrics() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 0),
      child: Container(
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.2),
              blurRadius: 12,
              offset: const Offset(0, 6),
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

  Widget _buildCrewShiftItem({
    required String title,
    required String timeRange,
    required int crewCount,
    required IconData icon,
  }) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(
            color: const Color(0xFF000000).withOpacity(0.04),
            blurRadius: 8,
            offset: const Offset(0, 2),
            spreadRadius: 0,
          ),
        ],
      ),
      child: Row(
        children: [
          Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              color: const Color(0xFF1E3A8A),
              borderRadius: BorderRadius.circular(8),
              boxShadow: [
                BoxShadow(
                  color: const Color(0xFF1E3A8A).withOpacity(0.15),
                  blurRadius: 4,
                  offset: const Offset(0, 1),
                ),
              ],
            ),
            child: Center(child: Icon(icon, size: 18, color: Colors.white)),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                // Shift info
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        title,
                        style: const TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w700,
                          color: Color(0xFF111827),
                          letterSpacing: -0.2,
                        ),
                      ),
                      const SizedBox(height: 2),
                      Row(
                        children: [
                          Icon(
                            Icons.access_time_outlined,
                            size: 12,
                            color: const Color(0xFF6B7280),
                          ),
                          const SizedBox(width: 4),
                          Text(
                            timeRange,
                            style: const TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.w500,
                              color: Color(0xFF6B7280),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),

                // **UPDATED: Closer spacing between number and "crew"**
                Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      '$crewCount',
                      style: const TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w800,
                        color: Color(0xFF1E3A8A),
                        letterSpacing: -0.3,
                        height: 0.9, // Adjust line height for tighter spacing
                      ),
                    ),
                    const SizedBox(
                      height: 0,
                    ), // Changed from 2 to 0 for minimal spacing
                    Text(
                      'crew',
                      style: TextStyle(
                        fontSize: 10,
                        fontWeight: FontWeight.w500,
                        color: const Color(0xFF64748B),
                        letterSpacing: 0.3,
                      ),
                    ),
                  ],
                ),
              ],
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
}

import 'package:escheduler/features/crew/dashboard/pages/crew_notification.dart';
import 'package:flutter/material.dart';

class CrewHomePage extends StatefulWidget {
  const CrewHomePage({Key? key}) : super(key: key);

  @override
  State<CrewHomePage> createState() => _CrewHomePageState();
}

class _CrewHomePageState extends State<CrewHomePage> {
  final ScrollController _scrollController = ScrollController();
  bool _showShadow = false;

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_scrollListener);
  }

  void _scrollListener() {
    if (_scrollController.position.pixels > 0 && !_showShadow) {
      setState(() => _showShadow = true);
    } else if (_scrollController.position.pixels <= 0 && _showShadow) {
      setState(() => _showShadow = false);
    }
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F7FA),
      body: CustomScrollView(
        controller: _scrollController,
        slivers: [
          SliverAppBar(
            automaticallyImplyLeading: false,
            pinned: true,
            floating: true,
            snap: true,
            backgroundColor: Colors.white,
            elevation: _showShadow ? 4 : 0,
            toolbarHeight: 80,
            titleSpacing: 0,
            title: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Row(
                children: [
                  CircleAvatar(
                    radius: 20,
                    backgroundColor: const Color(0xFF1E3A8A),
                    child: const Text(
                      'JD',
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'Welcome back,',
                          style: TextStyle(
                            fontSize: 12,
                            color: Colors.grey[600],
                          ),
                        ),
                        const Text(
                          'John Sindicato',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: Color(0xFF1A1D1F),
                          ),
                        ),
                      ],
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const CrewNotifications(),
                        ),
                      );
                    },
                    child: Stack(
                      children: [
                        Container(
                          padding: const EdgeInsets.all(8),
                          decoration: BoxDecoration(
                            color: const Color(0xFFF5F7FA),
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: const Icon(
                            Icons.notifications_rounded,
                            color: Color(0xFF1A1D1F),
                            size: 24,
                          ),
                        ),
                        Positioned(
                          right: 4,
                          top: 4,
                          child: Container(
                            width: 8,
                            height: 8,
                            decoration: const BoxDecoration(
                              color: Color(0xFFEF4444),
                              shape: BoxShape.circle,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Next Shift Card - Stays the same
                  Container(
                    padding: const EdgeInsets.all(20),
                    decoration: BoxDecoration(
                      gradient: const LinearGradient(
                        colors: [Color(0xFF1E3A8A), Color(0xFF3B82F6)],
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                      ),
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
                                horizontal: 10,
                                vertical: 4,
                              ),
                              decoration: BoxDecoration(
                                color: Colors.white.withOpacity(0.2),
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child: const Text(
                                'NEXT SHIFT',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 11,
                                  fontWeight: FontWeight.w600,
                                  letterSpacing: 1,
                                ),
                              ),
                            ),
                            const Spacer(),
                            const Icon(
                              Icons.access_time_rounded,
                              color: Colors.white,
                              size: 20,
                            ),
                          ],
                        ),
                        const SizedBox(height: 16),
                        const Text(
                          'Today, December 11',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        const SizedBox(height: 8),
                        const Text(
                          '2:00 PM - 10:00 PM',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 28,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 12),
                        Row(
                          children: [
                            Container(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 12,
                                vertical: 6,
                              ),
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child: const Row(
                                children: [
                                  Icon(
                                    Icons.restaurant_rounded,
                                    size: 16,
                                    color: Color(0xFF1E3A8A),
                                  ),
                                  SizedBox(width: 6),
                                  Text(
                                    'Kitchen',
                                    style: TextStyle(
                                      color: Color(0xFF1E3A8A),
                                      fontWeight: FontWeight.w600,
                                      fontSize: 13,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            const Spacer(),
                            Text(
                              'Starts in 2 hours',
                              style: TextStyle(
                                color: Colors.white.withOpacity(0.9),
                                fontSize: 13,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 20),

                  // Stats Section - Enhanced
                  Row(
                    children: [
                      Expanded(
                        child: _buildStatCard(
                          'Hours',
                          '32.5',
                          'This Week',
                          Icons.access_time_rounded,
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: _buildStatCard(
                          'Shifts',
                          '18',
                          'Completed',
                          Icons.check_circle_rounded,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 12),
                  Row(
                    children: [
                      Expanded(
                        child: _buildStatCard(
                          'Available',
                          '5',
                          'Open Slots',
                          Icons.event_available_rounded,
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: _buildStatCard(
                          'Time Off',
                          '24h',
                          'Balance',
                          Icons.beach_access_rounded,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),

                  // Quick Actions
                  // _sectionHeader('Quick Actions'),
                  // const SizedBox(height: 12),
                  // Row(
                  //   children: [
                  //     Expanded(
                  //       child: _buildActionCard(
                  //         context,
                  //         'Swap Shift',
                  //         Icons.swap_horiz_outlined,
                  //       ),
                  //     ),
                  //     const SizedBox(width: 12),
                  //     Expanded(
                  //       child: _buildActionCard(
                  //         context,
                  //         'Time Off',
                  //         Icons.event_busy_outlined,
                  //       ),
                  //     ),
                  //   ],
                  // ),
                  // const SizedBox(height: 12),
                  // Row(
                  //   children: [
                  //     Expanded(
                  //       child: _buildActionCard(
                  //         context,
                  //         'Pick Up',
                  //         Icons.add_circle_outline_rounded,
                  //       ),
                  //     ),
                  //     const SizedBox(width: 12),
                  //     Expanded(
                  //       child: _buildActionCard(
                  //         context,
                  //         'Schedule',
                  //         Icons.calendar_month_outlined,
                  //       ),
                  //     ),
                  //   ],
                  // ),
                  // const SizedBox(height: 20),

                  // Upcoming Shifts
                  _sectionHeader(
                    'Upcoming Shifts',
                    trailing: _mutedAction('View All'),
                  ),
                  const SizedBox(height: 12),
                  _buildShiftItem(
                    'Tomorrow',
                    'Dec 12',
                    '9:00 AM - 5:00 PM',
                    'Front Counter',
                    const Color(0xFF06B6D4),
                  ),
                  const SizedBox(height: 8),
                  _buildShiftItem(
                    'Thursday',
                    'Dec 13',
                    '11:00 AM - 7:00 PM',
                    'Drive-Thru',
                    const Color(0xFF8B5CF6),
                  ),
                  const SizedBox(height: 8),
                  _buildShiftItem(
                    'Friday',
                    'Dec 14',
                    '3:00 PM - 11:00 PM',
                    'Kitchen',
                    const Color(0xFF667EEA),
                  ),
                  const SizedBox(height: 20),

                  // Announcements
                  _sectionHeader('Announcements'),
                  const SizedBox(height: 12),
                  _buildAnnouncement(
                    'Holiday Schedule Released',
                    'Check your shifts for the upcoming holidays. Make swap requests early!',
                    '2 days ago',
                  ),
                  const SizedBox(height: 8),
                  _buildAnnouncement(
                    'New Menu Items Training',
                    'Mandatory training session for all crew members this Friday at 10 AM.',
                    '4 days ago',
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

  Widget _buildStatCard(
    String label,
    String value,
    String subtitle,
    IconData icon,
  ) {
    return Container(
      padding: const EdgeInsets.all(12), // Reduced padding
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10), // Smaller radius
        border: Border.all(color: const Color(0xFFE7EBF0)),
        boxShadow: const [
          BoxShadow(
            color: Color(0x140F172A),
            blurRadius: 10,
            offset: Offset(0, 4),
          ),
        ],
      ),
      child: Stack(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                value,
                style: const TextStyle(
                  fontSize: 18, // Smaller font size
                  fontWeight: FontWeight.w700,
                  color: Color(0xFF0F172A),
                ),
              ),
              const SizedBox(height: 4), // Reduced spacing
              Text(
                label,
                style: const TextStyle(
                  fontSize: 11, // Smaller font size
                  color: Color(0xFF64748B),
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(height: 2), // Reduced spacing
              Text(
                subtitle,
                style: const TextStyle(
                  fontSize: 10, // Smaller font size
                  color: Color(0xFF94A3B8),
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
          Positioned(
            top: 0, // Adjust the top position as needed
            right: 0, // Adjust the right position as needed
            child: Container(
              padding: const EdgeInsets.all(6), // Reduced padding
              decoration: BoxDecoration(
                color: const Color(0xFF1E3A8A).withOpacity(0.08),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Icon(icon, size: 18, color: const Color(0xFF1E3A8A)),
            ),
          ),
        ],
      ),
    );
  }

  // Widget _buildActionCard(BuildContext context, String label, IconData icon) {
  //   return InkWell(
  //     onTap: () {
  //       ScaffoldMessenger.of(context).showSnackBar(
  //         SnackBar(
  //           content: Text('$label clicked'),
  //           duration: const Duration(seconds: 1),
  //         ),
  //       );
  //     },
  //     child: Container(
  //       padding: const EdgeInsets.symmetric(
  //         vertical: 14,
  //         horizontal: 12,
  //       ), // Reduced padding
  //       decoration: BoxDecoration(
  //         color: Colors.white,
  //         borderRadius: BorderRadius.circular(10), // Smaller radius
  //         border: Border.all(color: const Color(0xFFE7EBF0)),
  //         boxShadow: const [
  //           BoxShadow(
  //             color: Color(0x140F172A),
  //             blurRadius: 10,
  //             offset: Offset(0, 4),
  //           ),
  //         ],
  //       ),
  //       child: Row(
  //         children: [
  //           Container(
  //             padding: const EdgeInsets.all(6), // Reduced padding
  //             decoration: BoxDecoration(
  //               color: const Color(0xFF1E3A8A).withOpacity(0.08),
  //               borderRadius: BorderRadius.circular(8),
  //             ),
  //             child: Icon(icon, size: 18, color: const Color(0xFF1E3A8A)),
  //           ),
  //           const SizedBox(width: 10), // Reduced spacing
  //           Expanded(
  //             child: Text(
  //               label,
  //               style: const TextStyle(
  //                 fontSize: 12, // Smaller font size
  //                 fontWeight: FontWeight.w600,
  //                 color: Color(0xFF0F172A),
  //               ),
  //             ),
  //           ),
  //           const Icon(
  //             Icons.arrow_forward_ios,
  //             size: 14,
  //             color: Color(0xFF94A3B8),
  //           ),
  //         ],
  //       ),
  //     ),
  //   );
  // }

  Widget _buildShiftItem(
    String day,
    String date,
    String time,
    String station,
    Color color,
  ) {
    return Container(
      padding: const EdgeInsets.all(12), // Reduced padding
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10), // Smaller radius
        border: Border.all(color: const Color(0xFFE7EBF0)),
        boxShadow: const [
          BoxShadow(
            color: Color(0x140F172A),
            blurRadius: 10,
            offset: Offset(0, 4),
          ),
        ],
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 6, // Smaller width
            height: 6, // Smaller height
            margin: const EdgeInsets.only(top: 6),
            decoration: BoxDecoration(color: color, shape: BoxShape.circle),
          ),
          const SizedBox(width: 10), // Reduced spacing
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Text(
                      day,
                      style: const TextStyle(
                        fontSize: 13, // Smaller font size
                        fontWeight: FontWeight.w700,
                        color: Color(0xFF0F172A),
                      ),
                    ),
                    const SizedBox(width: 6), // Reduced spacing
                    Text(
                      date,
                      style: const TextStyle(
                        fontSize: 11, // Smaller font size
                        color: Color(0xFF94A3B8),
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 4), // Reduced spacing
                Text(
                  time,
                  style: const TextStyle(
                    fontSize: 12, // Smaller font size
                    color: Color(0xFF0F172A),
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 6), // Reduced spacing
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 6, // Reduced padding
                    vertical: 3, // Reduced padding
                  ),
                  decoration: BoxDecoration(
                    color: const Color(0xFF1E3A8A),
                    borderRadius: BorderRadius.circular(6),
                  ),
                  child: Text(
                    station,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 10, // Smaller font size
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(width: 6), // Reduced spacing
          const Icon(Icons.chevron_right, size: 18, color: Color(0xFF94A3B8)),
        ],
      ),
    );
  }

  Widget _buildAnnouncement(String title, String description, String time) {
    return Container(
      padding: const EdgeInsets.all(12), // Reduced padding
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10), // Smaller radius
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
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: const TextStyle(
              fontSize: 13, // Smaller font size
              fontWeight: FontWeight.w700,
              color: Color(0xFF0F172A),
            ),
          ),
          const SizedBox(height: 6), // Reduced spacing
          Text(
            description,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            style: const TextStyle(
              fontSize: 12, // Smaller font size
              color: Color(0xFF475569),
              height: 1.35,
            ),
          ),
          const SizedBox(height: 8), // Reduced spacing
          Text(
            time,
            style: const TextStyle(
              fontSize: 11, // Smaller font size
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
            fontSize: 14, // Smaller font size
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
        padding: const EdgeInsets.symmetric(
          horizontal: 6,
          vertical: 3,
        ), // Reduced padding
        minimumSize: const Size(40, 28),
        tapTargetSize: MaterialTapTargetSize.shrinkWrap,
      ),
      child: Text(
        label,
        style: const TextStyle(
          fontSize: 12, // Smaller font size
          color: Color(0xFF1E3A8A),
          fontWeight: FontWeight.w700,
        ),
      ),
    );
  }
}

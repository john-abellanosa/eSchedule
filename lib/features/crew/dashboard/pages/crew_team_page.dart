import 'package:flutter/material.dart';

class CrewTeamPage extends StatefulWidget {
  const CrewTeamPage({Key? key}) : super(key: key);

  @override
  _CrewTeamPageState createState() => _CrewTeamPageState();
}

class _CrewTeamPageState extends State<CrewTeamPage> {
  final TextEditingController _searchController = TextEditingController();
  final FocusNode _searchFocusNode = FocusNode();

  // Sample crew data with actual names
  final Map<String, Map<String, List<String>>> _crewData = {
    'Morning Shift': {
      'Front Counter': [
        'Emma Davis',
        'James Wilson',
        'Sophia Brown',
        'Michael Chen',
      ],
      'Drive-Thru': ['Olivia Taylor', 'David Miller', 'Sarah Johnson'],
      'Kitchen': [
        'Robert Lee',
        'Jennifer White',
        'Thomas Harris',
        'Lisa Martin',
        'Daniel Clark',
      ],
      'Fry Station': ['Kevin Wilson', 'Amanda Scott'],
      'Drinks & Desserts': ['Brian Adams', 'Jessica Turner'],
    },
    'Mid Shift': {
      'Front Counter': [
        'Sarah Johnson',
        'Michael Chen',
        'Emma Davis',
        'James Wilson',
        'Olivia Taylor',
      ],
      'Drive-Thru': [
        'David Miller',
        'Jennifer White',
        'Thomas Harris',
        'Lisa Martin',
      ],
      'Kitchen': [
        'Robert Lee',
        'Daniel Clark',
        'Kevin Wilson',
        'Amanda Scott',
        'Brian Adams',
        'Jessica Turner',
      ],
      'Fry Station': ['Sophia Brown', 'Michael Chen', 'David Miller'],
      'Drinks & Desserts': ['Emma Davis', 'James Wilson'],
    },
    'Night Shift': {
      'Front Counter': ['Thomas Harris', 'Lisa Martin', 'Daniel Clark'],
      'Drive-Thru': ['Kevin Wilson', 'Amanda Scott', 'Brian Adams'],
      'Kitchen': [
        'Jessica Turner',
        'Sophia Brown',
        'Michael Chen',
        'David Miller',
      ],
      'Fry Station': ['Emma Davis', 'James Wilson'],
      'Drinks & Desserts': ['Sarah Johnson'],
    },
    'Graveyard Shift': {
      'Front Counter': ['Olivia Taylor', 'Robert Lee'],
      'Drive-Thru': ['Jennifer White', 'Thomas Harris'],
      'Kitchen': ['Lisa Martin', 'Daniel Clark', 'Kevin Wilson'],
      'Fry Station': ['Amanda Scott'],
    },
  };

  // Sample AWOL and Late data for viewing only
  final Map<String, bool> _awolStatus = {
    'Morning Shift|Front Counter|Emma Davis': true,
    'Mid Shift|Kitchen|Robert Lee': true,
  };

  final Map<String, String> _lateStatus = {
    'Night Shift|Drive-Thru|Kevin Wilson': '15 minutes',
    'Morning Shift|Kitchen|Thomas Harris': '30 minutes',
  };

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      FocusManager.instance.addListener(_handleFocusChange);
    });
  }

  @override
  void dispose() {
    FocusManager.instance.removeListener(_handleFocusChange);
    _searchFocusNode.dispose();
    _searchController.dispose();
    super.dispose();
  }

  void _handleFocusChange() {
    if (_searchFocusNode.hasFocus &&
        !FocusManager.instance.primaryFocus!.hasFocus) {
      _searchFocusNode.unfocus();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F7FA),
      body: GestureDetector(
        onTap: () {
          FocusScope.of(context).unfocus();
        },
        behavior: HitTestBehavior.translucent,
        child: CustomScrollView(
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
                          const Expanded(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Team Schedule',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 20,
                                    fontWeight: FontWeight.w700,
                                  ),
                                ),
                                SizedBox(height: 2),
                                Text(
                                  'Today, December 12',
                                  style: TextStyle(
                                    color: Colors.white70,
                                    fontSize: 12,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Container(
                            decoration: BoxDecoration(
                              color: const Color(0xFF1E3A8A),
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: IconButton(
                              icon: const Icon(
                                Icons.filter_list,
                                color: Colors.white,
                              ),
                              onPressed: () {},
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
                padding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 16,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Welcome Message
                    Container(
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(12),
                        boxShadow: const [
                          BoxShadow(
                            color: Color(0x0F000000),
                            blurRadius: 10,
                            offset: Offset(0, 2),
                          ),
                        ],
                      ),
                      child: Row(
                        children: [
                          Container(
                            width: 50,
                            height: 50,
                            decoration: BoxDecoration(
                              color: const Color(0xFFE0F2FE),
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: const Center(
                              child: Text(
                                'JD',
                                style: TextStyle(
                                  color: Color(0xFF0369A1),
                                  fontWeight: FontWeight.w700,
                                  fontSize: 18,
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(width: 10),
                          const Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'John Doe',
                                  style: TextStyle(
                                    fontWeight: FontWeight.w700,
                                    fontSize: 16,
                                    color: Color(0xFF0F172A),
                                  ),
                                ),
                                SizedBox(height: 4),
                                Text(
                                  'Mid Shift • Kitchen • 12:00 PM - 6:00 PM',
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: Color(0xFF64748B),
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 10),

                    // Search Bar
                    GestureDetector(
                      onTap: () {
                        _searchFocusNode.requestFocus();
                      },
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 16,
                          vertical: 8,
                        ),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(10),
                          border: Border.all(
                            color: const Color(0xFFE2E8F0),
                            width: 1,
                          ),
                          boxShadow: const [
                            BoxShadow(
                              color: Color(0x0F000000),
                              blurRadius: 10,
                              offset: Offset(0, 2),
                            ),
                          ],
                        ),
                        child: Row(
                          children: [
                            Icon(
                              Icons.search,
                              color: Colors.grey[600],
                              size: 20,
                            ),
                            const SizedBox(width: 12),
                            Expanded(
                              child: TextField(
                                controller: _searchController,
                                focusNode: _searchFocusNode,
                                decoration: InputDecoration(
                                  hintText: 'Search crew members...',
                                  hintStyle: TextStyle(
                                    color: Colors.grey[500],
                                    fontSize: 14,
                                  ),
                                  border: InputBorder.none,
                                  contentPadding: EdgeInsets.zero,
                                  isDense: true,
                                ),
                                style: const TextStyle(
                                  fontSize: 14,
                                  color: Color(0xFF0F172A),
                                ),
                                onChanged: (value) {
                                  setState(() {});
                                },
                              ),
                            ),
                            if (_searchController.text.isNotEmpty)
                              GestureDetector(
                                onTap: () {
                                  _searchController.clear();
                                  _searchFocusNode.unfocus();
                                  setState(() {});
                                },
                                child: Icon(
                                  Icons.clear,
                                  color: Colors.grey[600],
                                  size: 18,
                                ),
                              ),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),
                    _buildDateSelector(),
                    const SizedBox(height: 24),
                    _buildShiftSection('Morning Shift', '6:00 AM - 12:00 PM'),
                    const SizedBox(height: 20),
                    _buildShiftSection('Mid Shift', '12:00 PM - 6:00 PM'),
                    const SizedBox(height: 20),
                    _buildShiftSection('Night Shift', '6:00 PM - 12:00 AM'),
                    const SizedBox(height: 20),
                    _buildShiftSection('Graveyard Shift', '12:00 AM - 6:00 AM'),
                    const SizedBox(height: 24),
                    _buildLeaveSection(),
                    const SizedBox(height: 20),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDateSelector() {
    return SizedBox(
      height: 80,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: 7,
        itemBuilder: (context, index) {
          bool isSelected = index == 0;
          DateTime date = DateTime.now().add(Duration(days: index));
          return Container(
            width: 60,
            margin: const EdgeInsets.only(right: 10),
            decoration: BoxDecoration(
              color: isSelected ? const Color(0xFF1E3A8A) : Colors.white,
              borderRadius: BorderRadius.circular(12),
              border: Border.all(
                color: isSelected
                    ? const Color(0xFF1E3A8A)
                    : const Color(0xFFE7EBF0),
              ),
              boxShadow: isSelected
                  ? [
                      BoxShadow(
                        color: const Color(0xFF1E3A8A).withOpacity(0.3),
                        blurRadius: 8,
                        offset: const Offset(0, 4),
                      ),
                    ]
                  : [
                      const BoxShadow(
                        color: Color(0x140F172A),
                        blurRadius: 10,
                        offset: Offset(0, 4),
                      ),
                    ],
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  [
                    'Sun',
                    'Mon',
                    'Tue',
                    'Wed',
                    'Thu',
                    'Fri',
                    'Sat',
                  ][date.weekday % 7],
                  style: TextStyle(
                    fontSize: 11,
                    color: isSelected
                        ? Colors.white70
                        : const Color(0xFF94A3B8),
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 6),
                Text(
                  '${date.day}',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w700,
                    color: isSelected ? Colors.white : const Color(0xFF0F172A),
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  [
                    'Jan',
                    'Feb',
                    'Mar',
                    'Apr',
                    'May',
                    'Jun',
                    'Jul',
                    'Aug',
                    'Sep',
                    'Oct',
                    'Nov',
                    'Dec',
                  ][date.month - 1],
                  style: TextStyle(
                    fontSize: 10,
                    fontWeight: FontWeight.w600,
                    color: isSelected
                        ? Colors.white70
                        : const Color(0xFF94A3B8),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget _buildShiftSection(String title, String time) {
    final stationData = _crewData[title]!;
    final totalCrewCount = stationData.values.fold<int>(
      0,
      (sum, crewList) => sum + crewList.length,
    );

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w800,
                    color: Color(0xFF0F172A),
                    letterSpacing: -0.1,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  time,
                  style: const TextStyle(
                    fontSize: 12,
                    color: Color(0xFF64748B),
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
              decoration: BoxDecoration(
                color: const Color(0xFF1E3A8A).withOpacity(0.1),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Text(
                '$totalCrewCount Crew',
                style: const TextStyle(
                  fontSize: 11,
                  fontWeight: FontWeight.w700,
                  color: Color(0xFF1E3A8A),
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 12),
        ...stationData.entries.map((entry) {
          final station = entry.key;
          final crewList = entry.value;
          return Padding(
            padding: const EdgeInsets.only(bottom: 8),
            child: _buildStationRow(title, station, crewList),
          );
        }).toList(),
      ],
    );
  }

  Widget _buildStationRow(String shift, String station, List<String> crewList) {
    IconData stationIcon;

    switch (station) {
      case 'Front Counter':
        stationIcon = Icons.point_of_sale;
        break;
      case 'Drive-Thru':
        stationIcon = Icons.drive_eta;
        break;
      case 'Kitchen':
        stationIcon = Icons.restaurant;
        break;
      case 'Fry Station':
        stationIcon = Icons.local_fire_department;
        break;
      case 'Drinks & Desserts':
        stationIcon = Icons.local_cafe;
        break;
      default:
        stationIcon = Icons.store;
    }

    return Container(
      padding: const EdgeInsets.all(14),
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
          Row(
            children: [
              Container(
                width: 44,
                height: 44,
                decoration: BoxDecoration(
                  color: const Color(0xFF1E3A8A).withOpacity(0.1),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Center(
                  child: Icon(
                    stationIcon,
                    color: const Color(0xFF1E3A8A),
                    size: 24,
                  ),
                ),
              ),
              const SizedBox(width: 14),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      station,
                      style: const TextStyle(
                        fontWeight: FontWeight.w700,
                        fontSize: 14,
                        color: Color(0xFF0F172A),
                      ),
                    ),
                    const SizedBox(height: 4),
                    Row(
                      children: [
                        const Icon(
                          Icons.people,
                          size: 14,
                          color: Color(0xFF64748B),
                        ),
                        const SizedBox(width: 4),
                        Text(
                          '${crewList.length} crew members',
                          style: const TextStyle(
                            fontSize: 12,
                            color: Color(0xFF64748B),
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Column(
            children: crewList.map((crewName) {
              final memberKey = '$shift|$station|$crewName';
              final isAwol = _awolStatus[memberKey] ?? false;
              final lateDuration = _lateStatus[memberKey];
              final isLate = lateDuration != null;

              // Simple color scheme
              Color bgColor = const Color(0xFFF8FAFC); // Default background
              Color statusColor = const Color(0xFF0F172A); // Black for names
              Color statusTextColor = Colors.grey[700]!;
              Color borderColor = const Color(0xFFE2E8F0);

              if (isAwol || isLate) {
                // AWOL and Late: Red theme
                bgColor = const Color(0xFFFEF2F2);
                borderColor = const Color(0xFFFECACA);
                statusTextColor = const Color(0xFFDC2626);
              }

              return Padding(
                padding: const EdgeInsets.only(bottom: 8),
                child: Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: bgColor,
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(color: borderColor),
                  ),
                  child: Row(
                    children: [
                      Container(
                        width: 32,
                        height: 32,
                        decoration: BoxDecoration(
                          color: isAwol || isLate
                              ? const Color(
                                  0xFFFEE2E2,
                                ) // Red for both AWOL and Late
                              : const Color(0xFFF1F5F9),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Center(
                          child: Text(
                            crewName[0],
                            style: TextStyle(
                              color: isAwol || isLate
                                  ? const Color(
                                      0xFFDC2626,
                                    ) // Red for both AWOL and Late
                                  : const Color(0xFF475569),
                              fontWeight: FontWeight.w700,
                              fontSize: 14,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            // Name in black always
                            Text(
                              crewName,
                              style: const TextStyle(
                                fontWeight: FontWeight.w600,
                                fontSize: 14,
                                color: Color(0xFF0F172A), // Black
                              ),
                            ),
                            if (isAwol)
                              Text(
                                'AWOL',
                                style: TextStyle(
                                  fontSize: 11,
                                  color: statusTextColor,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            if (isLate)
                              Text(
                                'Late by $lateDuration',
                                style: TextStyle(
                                  fontSize: 11,
                                  color: statusTextColor,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                          ],
                        ),
                      ),
                      // No 3-dot menu for crew view-only version
                      // Just show status indicator if applicable
                      if (isAwol || isLate)
                        Container(
                          width: 32,
                          height: 32,
                          decoration: BoxDecoration(
                            color: const Color(0xFFFEE2E2),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Center(
                            child: Icon(
                              isAwol ? Icons.warning : Icons.timer,
                              size: 16,
                              color: const Color(0xFFDC2626),
                            ),
                          ),
                        ),
                    ],
                  ),
                ),
              );
            }).toList(),
          ),
        ],
      ),
    );
  }

  Widget _buildLeaveSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'On Leave Today',
          style: TextStyle(
            fontSize: 15,
            fontWeight: FontWeight.w800,
            color: Color(0xFF0F172A),
            letterSpacing: -0.1,
          ),
        ),
        const SizedBox(height: 12),
        _buildLeaveMember('Emma Davis', 'Sick Leave', 'Dec 12 - Dec 14'),
        const SizedBox(height: 8),
        _buildLeaveMember('James Wilson', 'Annual Leave', 'Dec 11 - Dec 15'),
      ],
    );
  }

  Widget _buildLeaveMember(String name, String leaveType, String duration) {
    return Container(
      padding: const EdgeInsets.all(14),
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
      child: Row(
        children: [
          Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              color: const Color(0xFFFEE2E2),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Center(
              child: Text(
                name[0],
                style: const TextStyle(
                  color: Color(0xFFDC2626),
                  fontWeight: FontWeight.w700,
                  fontSize: 16,
                ),
              ),
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  name,
                  style: const TextStyle(
                    fontWeight: FontWeight.w700,
                    fontSize: 14,
                    color: Color(0xFF0F172A), // Black
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  leaveType,
                  style: const TextStyle(
                    fontSize: 12,
                    color: Color(0xFF64748B),
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                decoration: BoxDecoration(
                  color: const Color(0xFFFEE2E2),
                  borderRadius: BorderRadius.circular(6),
                ),
                child: const Text(
                  'On Leave',
                  style: TextStyle(
                    fontSize: 11,
                    color: Color(0xFFDC2626),
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
              const SizedBox(height: 4),
              Text(
                duration,
                style: const TextStyle(
                  fontSize: 11,
                  color: Color(0xFF94A3B8),
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

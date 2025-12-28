import 'package:flutter/material.dart';

class ManagerTeamPage extends StatefulWidget {
  const ManagerTeamPage({Key? key}) : super(key: key);

  @override
  _ManagerTeamPageState createState() => _ManagerTeamPageState();
}

class _ManagerTeamPageState extends State<ManagerTeamPage> {
  // Store AWOL and Late status for each crew member
  final Map<String, bool> _awolStatus = {};
  final Map<String, String> _lateStatus = {}; // Stores late duration
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

  @override
  void initState() {
    super.initState();
    // Listen for back button press
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
    // Close search when tapping outside if search is focused
    if (_searchFocusNode.hasFocus &&
        !FocusManager.instance.primaryFocus!.hasFocus) {
      _searchFocusNode.unfocus();
    }
  }

  Future<void> _showLateDurationDialog(
    BuildContext context,
    String memberKey,
    String crewName,
  ) async {
    final TextEditingController durationController = TextEditingController();

    await showDialog(
      context: context,
      builder: (context) => Dialog(
        backgroundColor: Colors.white,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Mark as Late',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w700,
                  color: Colors.grey[800],
                ),
              ),
              const SizedBox(height: 4),
              Text(
                crewName,
                style: TextStyle(fontSize: 14, color: Colors.grey[600]),
              ),
              const SizedBox(height: 20),
              TextFormField(
                controller: durationController,
                decoration: InputDecoration(
                  hintText: 'e.g., 15 minutes, 30 min, 1 hour',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide(color: Colors.grey[300]!),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide(color: Colors.grey[300]!),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: const BorderSide(color: Color(0xFF1E3A8A)),
                  ),
                  contentPadding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 14,
                  ),
                  prefixIcon: Icon(
                    Icons.timer,
                    size: 20,
                    color: Colors.grey[600],
                  ),
                  filled: true,
                  fillColor: Colors.grey[50],
                ),
              ),
              const SizedBox(height: 8),
              Text(
                'Enter how long they were late',
                style: TextStyle(fontSize: 12, color: Colors.grey[500]),
              ),
              const SizedBox(height: 24),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  TextButton(
                    onPressed: () => Navigator.pop(context),
                    style: TextButton.styleFrom(
                      foregroundColor: Colors.grey[600],
                      padding: const EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 8,
                      ),
                    ),
                    child: const Text('Cancel'),
                  ),
                  const SizedBox(width: 8),
                  ElevatedButton(
                    onPressed: () {
                      if (durationController.text.trim().isNotEmpty) {
                        setState(() {
                          _lateStatus[memberKey] = durationController.text
                              .trim();
                          _awolStatus[memberKey] =
                              false; // Remove AWOL status if marking as late
                        });
                        Navigator.pop(context);
                      }
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF1E3A8A),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      padding: const EdgeInsets.symmetric(
                        horizontal: 20,
                        vertical: 10,
                      ),
                    ),
                    child: const Text(
                      'Mark Late',
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w600,
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

  void _showActionMenu(
    BuildContext context,
    String memberKey,
    String crewName,
  ) {
    final isAwol = _awolStatus[memberKey] ?? false;
    final isLate = _lateStatus[memberKey] != null;

    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.white,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(20),
          topRight: Radius.circular(20),
        ),
      ),
      builder: (context) => SafeArea(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const SizedBox(height: 12),
            Container(
              width: 40,
              height: 4,
              decoration: BoxDecoration(
                color: Colors.grey[300],
                borderRadius: BorderRadius.circular(2),
              ),
            ),
            const SizedBox(height: 16),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Text(
                crewName,
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  color: Colors.grey[800],
                ),
              ),
            ),
            const SizedBox(height: 8),
            Text(
              'Attendance Actions',
              style: TextStyle(fontSize: 12, color: Colors.grey[500]),
            ),
            const SizedBox(height: 20),
            Divider(height: 1, color: Colors.grey[200]),
            // Mark as Late option - icon blue, text black
            ListTile(
              leading: Icon(
                Icons.timer,
                color: const Color(0xFF1E3A8A), // Blue icon
              ),
              title: Text(
                'Mark as Late',
                style: TextStyle(
                  color: Colors.grey[800], // Black text
                  fontWeight: FontWeight.w500,
                ),
              ),
              trailing: isLate
                  ? Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 8,
                        vertical: 4,
                      ),
                      decoration: BoxDecoration(
                        color: const Color(0xFFFEE2E2), // Light red background
                        borderRadius: BorderRadius.circular(6),
                      ),
                      child: Text(
                        _lateStatus[memberKey]!,
                        style: const TextStyle(
                          fontSize: 11,
                          color: Color(0xFFDC2626), // Red text
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    )
                  : null,
              onTap: () {
                Navigator.pop(context);
                _showLateDurationDialog(context, memberKey, crewName);
              },
            ),
            Divider(
              height: 1,
              color: Colors.grey[200],
              indent: 16,
              endIndent: 16,
            ),
            // Mark as AWOL option - icon blue, text black
            ListTile(
              leading: Icon(
                Icons.warning,
                color: const Color(0xFF1E3A8A), // Blue icon
              ),
              title: Text(
                isAwol ? 'Remove AWOL' : 'Mark as AWOL',
                style: TextStyle(
                  color: Colors.grey[800], // Black text
                  fontWeight: FontWeight.w500,
                ),
              ),
              trailing: isAwol
                  ? Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 8,
                        vertical: 4,
                      ),
                      decoration: BoxDecoration(
                        color: const Color(0xFFFEE2E2),
                        borderRadius: BorderRadius.circular(6),
                      ),
                      child: const Text(
                        'AWOL',
                        style: TextStyle(
                          fontSize: 11,
                          color: Color(0xFFDC2626),
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    )
                  : null,
              onTap: () {
                setState(() {
                  _awolStatus[memberKey] = !isAwol;
                  if (_awolStatus[memberKey] == true) {
                    _lateStatus.remove(
                      memberKey,
                    ); // Remove late status if marking as AWOL
                  }
                });
                Navigator.pop(context);
              },
            ),
            Divider(
              height: 1,
              color: Colors.grey[200],
              indent: 16,
              endIndent: 16,
            ),
            // Close option - icon blue, text black
            ListTile(
              leading: const Icon(
                Icons.close,
                color: Color(0xFF1E3A8A),
              ), // Blue icon
              title: const Text(
                'Close',
                style: TextStyle(
                  color: Colors.black, // Black text
                  fontWeight: FontWeight.w500,
                ),
              ),
              onTap: () => Navigator.pop(context),
            ),
            const SizedBox(height: 16),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F7FA),
      body: GestureDetector(
        onTap: () {
          // Close keyboard when tapping outside
          FocusScope.of(context).unfocus();
        },
        behavior: HitTestBehavior.translucent,
        child: CustomScrollView(
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
                    // Search Bar
                    GestureDetector(
                      onTap: () {
                        // Focus on search field when tapped
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
                                  // You can add search functionality here
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
                      // 3-dot menu button
                      GestureDetector(
                        onTap: () =>
                            _showActionMenu(context, memberKey, crewName),
                        child: Container(
                          width: 36,
                          height: 36,
                          child: Center(
                            child: Icon(
                              Icons.more_vert,
                              size: 20,
                              color: const Color.fromARGB(255, 0, 0, 0),
                            ),
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

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class CrewTeamPage extends StatefulWidget {
  const CrewTeamPage({Key? key}) : super(key: key);

  @override
  _CrewTeamPageState createState() => _CrewTeamPageState();
}

class _CrewTeamPageState extends State<CrewTeamPage> {
  final TextEditingController _searchController = TextEditingController();
  final FocusNode _searchFocusNode = FocusNode();

  // Filter state
  String? _selectedShift;
  final List<String> _shiftFilters = [
    'All Shifts',
    'Graveyard Shift',
    'Morning Shift',
    'Afternoon Shift',
    'Evening Shift',
  ];

  // Sample crew data with actual names
  final Map<String, Map<String, List<String>>> _crewData = {
    'Graveyard Shift': {
      'Front Counter': ['Olivia Taylor', 'Robert Lee'],
      'Drive-Thru': ['Jennifer White', 'Thomas Harris'],
      'Kitchen': ['Lisa Martin', 'Daniel Clark', 'Kevin Wilson'],
      'Fry Station': ['Amanda Scott'],
    },
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
    'Afternoon Shift': {
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
    'Evening Shift': {
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
  };

  @override
  void initState() {
    super.initState();
    _selectedShift = 'All Shifts';
    _searchController.addListener(_onSearchChanged);
    WidgetsBinding.instance.addPostFrameCallback((_) {
      FocusManager.instance.addListener(_handleFocusChange);
    });
  }

  @override
  void dispose() {
    FocusManager.instance.removeListener(_handleFocusChange);
    _searchController.removeListener(_onSearchChanged);
    _searchFocusNode.dispose();
    _searchController.dispose();
    super.dispose();
  }

  void _onSearchChanged() {
    setState(() {});
  }

  void _handleFocusChange() {
    if (_searchFocusNode.hasFocus &&
        !FocusManager.instance.primaryFocus!.hasFocus) {
      _searchFocusNode.unfocus();
    }
  }

  void _showFilterMenu(BuildContext context) {
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
                'Filter by Shift',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  color: Colors.grey[800],
                ),
              ),
            ),
            const SizedBox(height: 20),
            Divider(height: 1, color: Colors.grey[200]),
            ..._shiftFilters.map((shift) {
              bool isSelected = _selectedShift == shift;
              return Column(
                children: [
                  ListTile(
                    leading: Icon(
                      Icons.check_circle,
                      color: isSelected
                          ? const Color(0xFF1E3A8A)
                          : Colors.transparent,
                      size: 22,
                    ),
                    title: Text(
                      shift,
                      style: TextStyle(
                        color: Colors.grey[800],
                        fontWeight: FontWeight.w500,
                        fontSize: 14,
                      ),
                    ),
                    onTap: () {
                      setState(() {
                        _selectedShift = shift;
                      });
                      Navigator.pop(context);
                    },
                  ),
                  if (shift != _shiftFilters.last)
                    Divider(
                      height: 1,
                      color: Colors.grey[200],
                      indent: 16,
                      endIndent: 16,
                    ),
                ],
              );
            }).toList(),
            const SizedBox(height: 16),
          ],
        ),
      ),
    );
  }

  // Get filtered crew data based on shift and search
  Map<String, Map<String, List<String>>> get _filteredCrewData {
    final searchQuery = _searchController.text.trim().toLowerCase();
    Map<String, Map<String, List<String>>> filteredData = {};

    // First filter by shift
    if (_selectedShift == 'All Shifts') {
      filteredData = Map.from(_crewData);
    } else if (_selectedShift != null &&
        _crewData.containsKey(_selectedShift)) {
      filteredData[_selectedShift!] = _crewData[_selectedShift!]!;
    }

    // Then filter by search query if there is one
    if (searchQuery.isNotEmpty) {
      final Map<String, Map<String, List<String>>> searchFilteredData = {};

      for (final shiftEntry in filteredData.entries) {
        final shift = shiftEntry.key;
        final stationData = shiftEntry.value;
        final Map<String, List<String>> filteredStationData = {};

        for (final stationEntry in stationData.entries) {
          final station = stationEntry.key;
          final crewList = stationEntry.value;
          final filteredCrew = crewList
              .where((crewName) => crewName.toLowerCase().contains(searchQuery))
              .toList();

          if (filteredCrew.isNotEmpty) {
            filteredStationData[station] = filteredCrew;
          }
        }

        if (filteredStationData.isNotEmpty) {
          searchFilteredData[shift] = filteredStationData;
        }
      }

      return searchFilteredData;
    }

    return filteredData;
  }

  @override
  Widget build(BuildContext context) {
    final filteredCrewData = _filteredCrewData;
    final hasSearchResults = filteredCrewData.isNotEmpty;
    final searchQuery = _searchController.text.trim();

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
                          Expanded(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Text(
                                  'Team Schedule',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 20,
                                    fontWeight: FontWeight.w700,
                                  ),
                                ),
                                const SizedBox(height: 2),
                                Text(
                                  _getCurrentDate(),
                                  style: const TextStyle(
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
                              onPressed: () => _showFilterMenu(context),
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
                                    color: Colors.grey[400],
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
                              ),
                            ),
                            if (_searchController.text.isNotEmpty)
                              GestureDetector(
                                onTap: () {
                                  _searchController.clear();
                                  _searchFocusNode.unfocus();
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
                    // Search results message
                    if (searchQuery.isNotEmpty && hasSearchResults)
                      Padding(
                        padding: const EdgeInsets.only(bottom: 12),
                        child: Text(
                          'Search results for "$searchQuery"',
                          style: const TextStyle(
                            fontSize: 14,
                            color: Color(0xFF64748B),
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                    if (searchQuery.isNotEmpty && !hasSearchResults)
                      Padding(
                        padding: const EdgeInsets.only(bottom: 20),
                        child: Container(
                          padding: const EdgeInsets.all(16),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(12),
                            border: Border.all(
                              color: const Color(0xFFE2E8F0),
                              width: 1,
                            ),
                          ),
                          child: Center(
                            child: Column(
                              children: [
                                Icon(
                                  Icons.search_off,
                                  size: 48,
                                  color: Colors.grey[400],
                                ),
                                const SizedBox(height: 12),
                                Text(
                                  'No results found',
                                  style: TextStyle(
                                    fontSize: 16,
                                    color: Colors.grey[600],
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                                const SizedBox(height: 4),
                                Text(
                                  'No crew members match "$searchQuery"',
                                  style: TextStyle(
                                    fontSize: 14,
                                    color: Colors.grey[500],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    // Display shift filter status
                    if (_selectedShift != null &&
                        _selectedShift != 'All Shifts' &&
                        !searchQuery.isNotEmpty)
                      Padding(
                        padding: const EdgeInsets.only(bottom: 16),
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 12,
                            vertical: 6,
                          ),
                          decoration: BoxDecoration(
                            color: const Color(0xFF1E3A8A),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Icon(
                                Icons.filter_alt,
                                size: 14,
                                color: Colors.white,
                              ),
                              const SizedBox(width: 6),
                              Text(
                                _selectedShift!,
                                style: const TextStyle(
                                  fontSize: 12,
                                  color: Colors.white,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              const SizedBox(width: 8),
                              GestureDetector(
                                onTap: () {
                                  setState(() {
                                    _selectedShift = 'All Shifts';
                                  });
                                },
                                child: Icon(
                                  Icons.close,
                                  size: 14,
                                  color: Colors.white,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    if (hasSearchResults)
                      ...filteredCrewData.entries.map((entry) {
                        final shift = entry.key;
                        return Padding(
                          padding: const EdgeInsets.only(bottom: 20),
                          child: _buildShiftSection(
                            shift,
                            _getShiftTime(shift),
                          ),
                        );
                      }).toList()
                    else if (!searchQuery.isNotEmpty)
                      ..._crewData.entries.map((entry) {
                        final shift = entry.key;
                        return Padding(
                          padding: const EdgeInsets.only(bottom: 20),
                          child: _buildShiftSection(
                            shift,
                            _getShiftTime(shift),
                          ),
                        );
                      }).toList(),
                    if (!searchQuery.isNotEmpty) ...[
                      const SizedBox(height: 24),
                      _buildLeaveSection(),
                      const SizedBox(height: 20),
                    ],
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  String _getCurrentDate() {
    final now = DateTime.now();
    final formatter = DateFormat('EEEE, MMMM d, y');
    return formatter.format(now);
  }

  String _getShiftTime(String shift) {
    switch (shift) {
      case 'Graveyard Shift':
        return '12:00 AM - 6:00 AM';
      case 'Morning Shift':
        return '6:00 AM - 12:00 PM';
      case 'Afternoon Shift':
        return '12:00 PM - 6:00 PM';
      case 'Evening Shift':
        return '6:00 PM - 12:00 AM';
      default:
        return '';
    }
  }

  Widget _buildShiftSection(String title, String time) {
    final stationData = _filteredCrewData[title] ?? _crewData[title]!;
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
              return Padding(
                padding: const EdgeInsets.only(bottom: 8),
                child: Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: const Color(0xFFF8FAFC),
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(color: const Color(0xFFE2E8F0)),
                  ),
                  child: Row(
                    children: [
                      Container(
                        width: 32,
                        height: 32,
                        decoration: BoxDecoration(
                          color: const Color(0xFFF1F5F9),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Center(
                          child: Text(
                            crewName[0],
                            style: const TextStyle(
                              color: Color(0xFF475569),
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
                            Text(
                              crewName,
                              style: const TextStyle(
                                fontWeight: FontWeight.w600,
                                fontSize: 14,
                                color: Color(0xFF0F172A),
                              ),
                            ),
                          ],
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
                    color: Color(0xFF0F172A),
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

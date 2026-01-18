import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class CrewSchedulePage extends StatefulWidget {
  const CrewSchedulePage({Key? key}) : super(key: key);

  @override
  State<CrewSchedulePage> createState() => _CrewSchedulePageState();
}

class _CrewSchedulePageState extends State<CrewSchedulePage> {
  int selectedWeek = 0; // 0=this 1=next 2=month
  final DateFormat _dateFormatter = DateFormat('MMM d');
  final DateFormat _monthFormatter = DateFormat('MMMM yyyy');
  final DateFormat _weekRangeFormatter = DateFormat('MMM d');

  // Store the actual data for each view
  late Map<int, List<Map<String, dynamic>>> _weekData;
  late Map<String, String> _weekRanges; // Store week ranges

  @override
  void initState() {
    super.initState();
    _weekRanges = {
      '0': 'Jan 18 - Jan 24',
      '1': 'Jan 25 - Jan 31',
      '2': 'JANUARY 2024',
    };
    _weekData = _generateScheduleData();
  }

  Map<int, List<Map<String, dynamic>>> _generateScheduleData() {
    // Fixed date: January 18, 2024 (Thursday)
    final currentDate = DateTime(2024, 1, 18);

    // THIS WEEK (Jan 18-24)
    final thisWeekData = [
      {
        'day': 'Thursday',
        'date': 'Jan 18',
        'time': '9:00 AM - 5:00 PM',
        'break': '3:00 PM',
        'hours': 8,
        'department': 'Front Counter',
        'station': 'Counter 2',
        'color': const Color(0xFF06B6D4),
      },
      {
        'day': 'Friday',
        'date': 'Jan 19',
        'time': '11:00 AM - 7:00 PM',
        'break': '4:30 PM',
        'hours': 8,
        'department': 'Drive-Thru',
        'station': 'Drinks Station',
        'color': const Color(0xFF8B5CF6),
      },
      {'day': 'Saturday', 'date': 'Jan 20', 'off': true},
      {
        'day': 'Sunday',
        'date': 'Jan 21',
        'time': '10:00 AM - 6:00 PM',
        'break': '2:00 PM',
        'hours': 8,
        'department': 'Drive-Thru',
        'station': 'Presenter/Runner',
        'color': const Color(0xFF8B5CF6),
      },
      {
        'day': 'Monday',
        'date': 'Jan 22',
        'time': '12:00 PM - 8:00 PM',
        'break': '5:00 PM',
        'hours': 8,
        'department': 'Front Counter',
        'station': 'Cashier',
        'color': const Color(0xFF06B6D4),
      },
      {
        'day': 'Tuesday',
        'date': 'Jan 23',
        'time': '9:00 AM - 5:00 PM',
        'break': '12:30 PM',
        'hours': 8,
        'department': 'Kitchen',
        'station': 'Grill Master',
        'color': const Color(0xFF667EEA),
      },
      {'day': 'Wednesday', 'date': 'Jan 24', 'off': true},
    ];

    // NEXT WEEK (Jan 25-31)
    final nextWeekData = [
      {
        'day': 'Thursday',
        'date': 'Jan 25',
        'time': '11:00 AM - 7:00 PM',
        'break': '4:00 PM',
        'hours': 8,
        'department': 'Drive-Thru',
        'station': 'Order Taker',
        'color': const Color(0xFF8B5CF6),
      },
      {
        'day': 'Friday',
        'date': 'Jan 26',
        'time': '2:00 PM - 10:00 PM',
        'break': '6:30 PM',
        'hours': 8,
        'department': 'Kitchen',
        'station': 'Fryer Station',
        'color': const Color(0xFF667EEA),
      },
      {'day': 'Saturday', 'date': 'Jan 27', 'off': true},
      {
        'day': 'Sunday',
        'date': 'Jan 28',
        'time': '10:00 AM - 6:00 PM',
        'break': '2:00 PM',
        'hours': 8,
        'department': 'Front Counter',
        'station': 'Counter 1',
        'color': const Color(0xFF06B6D4),
      },
      {
        'day': 'Monday',
        'date': 'Jan 29',
        'time': '12:00 PM - 8:00 PM',
        'break': '5:00 PM',
        'hours': 8,
        'department': 'Drive-Thru',
        'station': 'Presenter/Runner',
        'color': const Color(0xFF8B5CF6),
      },
      {'day': 'Tuesday', 'date': 'Jan 30', 'off': true},
      {'day': 'Wednesday', 'date': 'Jan 31', 'off': true},
    ];

    // JANUARY data - Jan 1-31
    final monthData = <Map<String, dynamic>>[];

    // Create a map to store specific dates data
    final Map<String, Map<String, dynamic>> specificDates = {};

    // Add This Week data to specific dates
    for (var day in thisWeekData) {
      specificDates[day['date'] as String] = day;
    }

    // Add Next Week data to specific dates
    for (var day in nextWeekData) {
      specificDates[day['date'] as String] = day;
    }

    // Add data for Jan 1-17 with breaks
    final jan1to17Data = [
      {'day': 'Monday', 'date': 'Jan 1', 'off': true},
      {
        'day': 'Tuesday',
        'date': 'Jan 2',
        'time': '9:00 AM - 5:00 PM',
        'break': '12:30 PM',
        'hours': 8,
        'department': 'Front Counter',
        'station': 'Counter 1',
        'color': const Color(0xFF06B6D4),
      },
      {
        'day': 'Wednesday',
        'date': 'Jan 3',
        'time': '11:00 AM - 7:00 PM',
        'break': '4:00 PM',
        'hours': 8,
        'department': 'Drive-Thru',
        'station': 'Order Taker',
        'color': const Color(0xFF8B5CF6),
      },
      {'day': 'Thursday', 'date': 'Jan 4', 'off': true},
      {
        'day': 'Friday',
        'date': 'Jan 5',
        'time': '2:00 PM - 10:00 PM',
        'break': '6:30 PM',
        'hours': 8,
        'department': 'Kitchen',
        'station': 'ASM/GRILL',
        'color': const Color(0xFF667EEA),
      },
      {
        'day': 'Saturday',
        'date': 'Jan 6',
        'time': '3:00 PM - 11:00 PM',
        'break': '8:00 PM',
        'hours': 8,
        'department': 'Kitchen',
        'station': 'Fryer Station',
        'color': const Color(0xFF667EEA),
      },
      {'day': 'Sunday', 'date': 'Jan 7', 'off': true},
      {
        'day': 'Monday',
        'date': 'Jan 8',
        'time': '9:00 AM - 5:00 PM',
        'break': '1:00 PM',
        'hours': 8,
        'department': 'Front Counter',
        'station': 'Counter 1',
        'color': const Color(0xFF06B6D4),
      },
      {
        'day': 'Tuesday',
        'date': 'Jan 9',
        'time': '11:00 AM - 7:00 PM',
        'break': '3:30 PM',
        'hours': 8,
        'department': 'Drive-Thru',
        'station': 'Presenter/Runner',
        'color': const Color(0xFF8B5CF6),
      },
      {
        'day': 'Wednesday',
        'date': 'Jan 10',
        'time': '2:00 PM - 10:00 PM',
        'break': '6:00 PM',
        'hours': 8,
        'department': 'Kitchen',
        'station': 'ASM/GRILL',
        'color': const Color(0xFF667EEA),
      },
      {
        'day': 'Thursday',
        'date': 'Jan 11',
        'time': '9:00 AM - 5:00 PM',
        'break': '12:00 PM',
        'hours': 8,
        'department': 'Front Counter',
        'station': 'Cashier',
        'color': const Color(0xFF06B6D4),
      },
      {
        'day': 'Friday',
        'date': 'Jan 12',
        'time': '3:00 PM - 11:00 PM',
        'break': '7:00 PM',
        'hours': 8,
        'department': 'Kitchen',
        'station': 'Fryer Station',
        'color': const Color(0xFF667EEA),
      },
      {'day': 'Saturday', 'date': 'Jan 13', 'off': true},
      {'day': 'Sunday', 'date': 'Jan 14', 'off': true},
      {
        'day': 'Monday',
        'date': 'Jan 15',
        'time': '10:00 AM - 6:00 PM',
        'break': '2:00 PM',
        'hours': 8,
        'department': 'Drive-Thru',
        'station': 'Order Taker',
        'color': const Color(0xFF8B5CF6),
      },
      {
        'day': 'Tuesday',
        'date': 'Jan 16',
        'time': '2:00 PM - 10:00 PM',
        'break': '6:00 PM',
        'hours': 8,
        'department': 'Kitchen',
        'station': 'Grill Master',
        'color': const Color(0xFF667EEA),
      },
      {'day': 'Wednesday', 'date': 'Jan 17', 'off': true},
    ];

    // Add Jan 1-17 data to specific dates
    for (var day in jan1to17Data) {
      specificDates[day['date'] as String] = day;
    }

    // Generate all days of January (1-31)
    for (int day = 1; day <= 31; day++) {
      final dateStr = 'Jan $day';
      final weekday = _getWeekdayForDate(2024, 1, day);

      if (specificDates.containsKey(dateStr)) {
        // Use the specific data for this date
        monthData.add(specificDates[dateStr]!);
      } else {
        // Default to rest day for any unspecified dates
        monthData.add({'day': weekday, 'date': dateStr, 'off': true});
      }
    }

    return {0: thisWeekData, 1: nextWeekData, 2: monthData};
  }

  String _getWeekdayForDate(int year, int month, int day) {
    final date = DateTime(year, month, day);
    final weekdays = [
      'Monday',
      'Tuesday',
      'Wednesday',
      'Thursday',
      'Friday',
      'Saturday',
      'Sunday',
    ];
    return weekdays[date.weekday - 1];
  }

  String get _currentDateDisplay {
    return _weekRanges[selectedWeek.toString()] ?? '';
  }

  String get _currentDateSubtitle {
    if (selectedWeek == 2) {
      return 'MONTH SCHEDULE';
    }
    return 'WEEK SCHEDULE';
  }

  @override
  Widget build(BuildContext context) {
    final data = _weekData[selectedWeek] ?? [];
    int totalHours = 0;
    for (var d in data) {
      if (d['off'] != true && d['hours'] != null) {
        totalHours += d['hours'] as int;
      }
    }

    return Scaffold(
      backgroundColor: const Color(0xFFF5F7FA),
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(110),
        child: Container(
          decoration: const BoxDecoration(
            color: Color(0xFF1E3A8A),
            boxShadow: [
              BoxShadow(
                color: Color(0x140F172A),
                blurRadius: 10,
                offset: Offset(0, 4),
              ),
            ],
          ),
          child: SafeArea(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            _currentDateDisplay,
                            style: const TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w800,
                              color: Colors.white,
                              letterSpacing: 0.3,
                            ),
                          ),
                          const SizedBox(height: 2),
                          Text(
                            _currentDateSubtitle,
                            style: TextStyle(
                              fontSize: 10,
                              fontWeight: FontWeight.w600,
                              color: Colors.white.withOpacity(0.8),
                              letterSpacing: 1.0,
                            ),
                          ),
                        ],
                      ),
                      const Spacer(),
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 10,
                          vertical: 6,
                        ),
                        decoration: BoxDecoration(
                          color: Colors.white.withOpacity(0.15),
                          borderRadius: BorderRadius.circular(16),
                          border: Border.all(
                            color: Colors.white.withOpacity(0.3),
                            width: 1,
                          ),
                        ),
                        child: Row(
                          children: [
                            const Icon(
                              Icons.calendar_today_rounded,
                              color: Colors.white,
                              size: 14,
                            ),
                            const SizedBox(width: 4),
                            Text(
                              'Jan 18', // Current date (Thursday)
                              style: const TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.w600,
                                color: Colors.white,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 12),
                  Row(
                    children: [
                      Expanded(child: _weekTab('This Week', 0)),
                      const SizedBox(width: 6),
                      Expanded(child: _weekTab('Next Week', 1)),
                      const SizedBox(width: 6),
                      Expanded(child: _weekTab('Month', 2)),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
      body: selectedWeek == 2
          ? _monthView()
          : ListView.separated(
              padding: const EdgeInsets.fromLTRB(
                12,
                12,
                12,
                40,
              ), // Increased bottom padding from 12 to 40
              separatorBuilder: (_, __) => const SizedBox(height: 6),
              itemCount: data.length + 1,
              itemBuilder: (_, i) {
                if (i == 0) {
                  // TOTAL HOURS CARD
                  return Container(
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      gradient: const LinearGradient(
                        colors: [Color(0xFF1E3A8A), Color(0xFF3B82F6)],
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                      ),
                      borderRadius: BorderRadius.circular(8),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.2),
                          blurRadius: 8,
                          offset: const Offset(0, 4),
                        ),
                      ],
                    ),
                    child: Row(
                      children: [
                        const Icon(
                          Icons.access_time_rounded,
                          color: Colors.white,
                          size: 22,
                        ),
                        const SizedBox(width: 10),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              selectedWeek == 2
                                  ? 'Total Hours This Month'
                                  : 'Total Hours This Week',
                              style: TextStyle(
                                color: Colors.white.withOpacity(.9),
                                fontSize: 11,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            const SizedBox(height: 2),
                            Text(
                              '$totalHours hours',
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  );
                } else {
                  // DAYS LIST
                  return _dayCard(data[i - 1]);
                }
              },
            ),
    );
  }

  Widget _weekTab(String label, int index) {
    final selected = selectedWeek == index;
    return GestureDetector(
      onTap: () => setState(() {
        selectedWeek = index;
      }),
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 8),
        decoration: BoxDecoration(
          color: selected ? Colors.white : Colors.white.withOpacity(0.2),
          borderRadius: BorderRadius.circular(6),
          border: Border.all(
            color: selected ? const Color(0xFF1E3A8A) : Colors.transparent,
            width: 1.5,
          ),
        ),
        child: Text(
          label,
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 10,
            fontWeight: FontWeight.w700,
            color: selected ? const Color(0xFF1E3A8A) : Colors.white,
          ),
        ),
      ),
    );
  }

  Widget _dayCard(Map<String, dynamic> d) {
    final off = d['off'] == true;
    final department = d['department'] as String?;
    final station = d['station'] as String?;
    final time = d['time'] as String?;
    final breakTime = d['break'] as String?;
    final hours = d['hours'] as int?;
    final color = d['color'] as Color? ?? Colors.grey;

    return Container(
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: const Color(0xFFE7EBF0), width: 1),
        boxShadow: const [
          BoxShadow(
            color: Color(0x0A0F172A),
            blurRadius: 6,
            offset: Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        children: [
          Container(
            width: 42,
            height: 42,
            decoration: BoxDecoration(
              color: off
                  ? const Color(0xFFF1F5F9)
                  : const Color(0xFF1E3A8A).withOpacity(.08),
              borderRadius: BorderRadius.circular(6),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  (d['date'] as String).split(' ')[1],
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w700,
                    color: off
                        ? const Color(0xFF94A3B8)
                        : const Color(0xFF0F172A),
                  ),
                ),
                Text(
                  (d['day'] as String).substring(0, 3).toUpperCase(),
                  style: TextStyle(
                    fontSize: 8,
                    fontWeight: FontWeight.w700,
                    color: off
                        ? const Color(0xFF94A3B8)
                        : const Color(0xFF64748B),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(width: 10),
          Expanded(
            child: off
                ? const Text(
                    'Rest Day',
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                      color: Color(0xFF94A3B8),
                    ),
                  )
                : Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Main shift time row
                      Row(
                        children: [
                          Expanded(
                            child: Text(
                              time!,
                              style: const TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.w700,
                                color: Color(0xFF0F172A),
                              ),
                            ),
                          ),
                          if (hours != null)
                            Container(
                              margin: const EdgeInsets.only(left: 6),
                              padding: const EdgeInsets.symmetric(
                                horizontal: 5,
                                vertical: 1,
                              ),
                              decoration: BoxDecoration(
                                color: const Color(0xFF10B981),
                                borderRadius: BorderRadius.circular(3),
                              ),
                              child: Text(
                                '${hours}h',
                                style: const TextStyle(
                                  fontSize: 9,
                                  fontWeight: FontWeight.w700,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                        ],
                      ),

                      // Break time row
                      if (breakTime != null && breakTime.isNotEmpty) ...[
                        const SizedBox(height: 4),
                        Row(
                          children: [
                            Icon(
                              Icons.coffee_outlined,
                              size: 10,
                              color: const Color(0xFF64748B).withOpacity(0.8),
                            ),
                            const SizedBox(width: 4),
                            Text(
                              'Break at $breakTime',
                              style: TextStyle(
                                fontSize: 10,
                                fontWeight: FontWeight.w600,
                                color: const Color(0xFF64748B).withOpacity(0.8),
                              ),
                            ),
                          ],
                        ),
                      ],

                      // Department and station tags
                      if (department != null && station != null) ...[
                        const SizedBox(height: 6),
                        Wrap(
                          spacing: 4,
                          runSpacing: 4,
                          children: [
                            Container(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 5,
                                vertical: 2,
                              ),
                              decoration: BoxDecoration(
                                color: const Color(0xFF1E3A8A),
                                borderRadius: BorderRadius.circular(4),
                              ),
                              child: Text(
                                department,
                                style: const TextStyle(
                                  fontSize: 9,
                                  fontWeight: FontWeight.w700,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                            Container(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 5,
                                vertical: 2,
                              ),
                              decoration: BoxDecoration(
                                color: const Color(0xFF3B82F6),
                                borderRadius: BorderRadius.circular(4),
                              ),
                              child: Text(
                                station,
                                style: const TextStyle(
                                  fontSize: 9,
                                  fontWeight: FontWeight.w700,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ],
                  ),
          ),
        ],
      ),
    );
  }

  Widget _monthView() {
    final data = _weekData[2] ?? [];
    int totalHours = 0;
    for (var d in data) {
      if (d['off'] != true && d['hours'] != null) {
        totalHours += d['hours'] as int;
      }
    }

    return ListView.builder(
      padding: const EdgeInsets.fromLTRB(
        12,
        12,
        12,
        40,
      ), // Increased bottom padding from 12 to 40
      itemCount: data.length + 2,
      itemBuilder: (context, index) {
        if (index == 0) {
          // TOTAL HOURS CARD
          return Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              gradient: const LinearGradient(
                colors: [Color(0xFF1E3A8A), Color(0xFF3B82F6)],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              borderRadius: BorderRadius.circular(8),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.2),
                  blurRadius: 8,
                  offset: const Offset(0, 4),
                ),
              ],
            ),
            child: Row(
              children: [
                const Icon(
                  Icons.access_time_rounded,
                  color: Colors.white,
                  size: 22,
                ),
                const SizedBox(width: 10),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Total Hours This Month',
                      style: TextStyle(
                        color: Colors.white.withOpacity(.9),
                        fontSize: 11,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const SizedBox(height: 2),
                    Text(
                      '$totalHours hours',
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          );
        } else if (index == 1) {
          return const SizedBox(height: 6);
        } else {
          final dayData = data[index - 2];
          final off = dayData['off'] == true;
          final department = dayData['department'] as String?;
          final station = dayData['station'] as String?;
          final time = dayData['time'] as String?;
          final breakTime = dayData['break'] as String?;
          final hours = dayData['hours'] as int?;
          final dateString = dayData['date'] as String;

          // Parse the date from the string (e.g., "Jan 9")
          final dateParts = dateString.split(' ');
          final month = dateParts[0];
          final day = int.parse(dateParts[1]);

          // Get the day name from the data
          final dayName = dayData['day'] as String;

          return Container(
            margin: const EdgeInsets.only(bottom: 6),
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(8),
              border: Border.all(color: const Color(0xFFE7EBF0), width: 1),
              boxShadow: const [
                BoxShadow(
                  color: Color(0x0A0F172A),
                  blurRadius: 6,
                  offset: Offset(0, 2),
                ),
              ],
            ),
            child: Row(
              children: [
                Container(
                  width: 42,
                  height: 42,
                  decoration: BoxDecoration(
                    color: off
                        ? const Color(0xFFF1F5F9)
                        : const Color(0xFF1E3A8A).withOpacity(.08),
                    borderRadius: BorderRadius.circular(6),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        day.toString(),
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w700,
                          color: off
                              ? const Color(0xFF94A3B8)
                              : const Color(0xFF0F172A),
                        ),
                      ),
                      Text(
                        dayName.substring(0, 3).toUpperCase(),
                        style: TextStyle(
                          fontSize: 8,
                          fontWeight: FontWeight.w700,
                          color: off
                              ? const Color(0xFF94A3B8)
                              : const Color(0xFF64748B),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: off
                      ? const Text(
                          'Rest Day',
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w600,
                            color: Color(0xFF94A3B8),
                          ),
                        )
                      : Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            // Main shift time row
                            Row(
                              children: [
                                Expanded(
                                  child: Text(
                                    time!,
                                    style: const TextStyle(
                                      fontSize: 12,
                                      fontWeight: FontWeight.w700,
                                      color: Color(0xFF0F172A),
                                    ),
                                  ),
                                ),
                                if (hours != null)
                                  Container(
                                    margin: const EdgeInsets.only(left: 6),
                                    padding: const EdgeInsets.symmetric(
                                      horizontal: 5,
                                      vertical: 1,
                                    ),
                                    decoration: BoxDecoration(
                                      color: const Color(0xFF10B981),
                                      borderRadius: BorderRadius.circular(3),
                                    ),
                                    child: Text(
                                      '${hours}h',
                                      style: const TextStyle(
                                        fontSize: 9,
                                        fontWeight: FontWeight.w700,
                                        color: Colors.white,
                                      ),
                                    ),
                                  ),
                              ],
                            ),

                            // Break time row
                            if (breakTime != null && breakTime.isNotEmpty) ...[
                              const SizedBox(height: 4),
                              Row(
                                children: [
                                  Icon(
                                    Icons.coffee_outlined,
                                    size: 10,
                                    color: const Color(
                                      0xFF64748B,
                                    ).withOpacity(0.8),
                                  ),
                                  const SizedBox(width: 4),
                                  Text(
                                    'Break at $breakTime',
                                    style: TextStyle(
                                      fontSize: 10,
                                      fontWeight: FontWeight.w600,
                                      color: const Color(
                                        0xFF64748B,
                                      ).withOpacity(0.8),
                                    ),
                                  ),
                                ],
                              ),
                            ],

                            // Department and station tags
                            if (department != null && station != null) ...[
                              const SizedBox(height: 6),
                              Wrap(
                                spacing: 4,
                                runSpacing: 4,
                                children: [
                                  Container(
                                    padding: const EdgeInsets.symmetric(
                                      horizontal: 5,
                                      vertical: 2,
                                    ),
                                    decoration: BoxDecoration(
                                      color: const Color(0xFF1E3A8A),
                                      borderRadius: BorderRadius.circular(4),
                                    ),
                                    child: Text(
                                      department,
                                      style: const TextStyle(
                                        fontSize: 9,
                                        fontWeight: FontWeight.w700,
                                        color: Colors.white,
                                      ),
                                    ),
                                  ),
                                  Container(
                                    padding: const EdgeInsets.symmetric(
                                      horizontal: 5,
                                      vertical: 2,
                                    ),
                                    decoration: BoxDecoration(
                                      color: const Color(0xFF3B82F6),
                                      borderRadius: BorderRadius.circular(4),
                                    ),
                                    child: Text(
                                      station,
                                      style: const TextStyle(
                                        fontSize: 9,
                                        fontWeight: FontWeight.w700,
                                        color: Colors.white,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ],
                        ),
                ),
              ],
            ),
          );
        }
      },
    );
  }
}

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class ManagerSchedulePage extends StatefulWidget {
  const ManagerSchedulePage({Key? key}) : super(key: key);

  @override
  State<ManagerSchedulePage> createState() => _ManagerSchedulePageState();
}

class _ManagerSchedulePageState extends State<ManagerSchedulePage> {
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
    // THIS WEEK (Jan 18-24) - Manager Schedule
    final thisWeekData = [
      {
        'day': 'Thursday',
        'date': 'Jan 18',
        'time': '8:00 AM - 6:00 PM',
        'break': '1:00 PM',
        'hours': 10,
        'position': 'Service Manager',
      },
      {
        'day': 'Friday',
        'date': 'Jan 19',
        'time': '9:00 AM - 7:00 PM',
        'break': '2:00 PM',
        'hours': 10,
        'position': 'Manager In-Charge',
      },
      {
        'day': 'Saturday',
        'date': 'Jan 20',
        'time': '10:00 AM - 8:00 PM',
        'break': '3:00 PM',
        'hours': 10,
        'position': 'Shift Leader',
      },
      {
        'day': 'Sunday',
        'date': 'Jan 21',
        'time': '11:00 AM - 9:00 PM',
        'break': '4:00 PM',
        'hours': 10,
        'position': 'Expediter',
      },
      {
        'day': 'Monday',
        'date': 'Jan 22',
        'time': '8:00 AM - 6:00 PM',
        'break': '1:00 PM',
        'hours': 10,
        'position': 'B2B',
      },
      {
        'day': 'Tuesday',
        'date': 'Jan 23',
        'time': '9:00 AM - 7:00 PM',
        'break': '2:00 PM',
        'hours': 10,
        'position': 'Service Manager',
      },
      {
        'day': 'Wednesday',
        'date': 'Jan 24',
        'time': '10:00 AM - 8:00 PM',
        'break': '3:00 PM',
        'hours': 10,
        'position': 'Manager In-Charge',
      },
    ];

    // NEXT WEEK (Jan 25-31) - Manager Schedule
    final nextWeekData = [
      {
        'day': 'Thursday',
        'date': 'Jan 25',
        'time': '11:00 AM - 9:00 PM',
        'break': '4:00 PM',
        'hours': 10,
        'position': 'Shift Leader',
      },
      {
        'day': 'Friday',
        'date': 'Jan 26',
        'time': '8:00 AM - 6:00 PM',
        'break': '1:00 PM',
        'hours': 10,
        'position': 'Expediter',
      },
      {
        'day': 'Saturday',
        'date': 'Jan 27',
        'time': '9:00 AM - 7:00 PM',
        'break': '2:00 PM',
        'hours': 10,
        'position': 'B2B',
      },
      {
        'day': 'Sunday',
        'date': 'Jan 28',
        'time': '10:00 AM - 8:00 PM',
        'break': '3:00 PM',
        'hours': 10,
        'position': 'Service Manager',
      },
      {
        'day': 'Monday',
        'date': 'Jan 29',
        'time': '11:00 AM - 9:00 PM',
        'break': '4:00 PM',
        'hours': 10,
        'position': 'Manager In-Charge',
      },
      {
        'day': 'Tuesday',
        'date': 'Jan 30',
        'time': '8:00 AM - 6:00 PM',
        'break': '1:00 PM',
        'hours': 10,
        'position': 'Shift Leader',
      },
      {
        'day': 'Wednesday',
        'date': 'Jan 31',
        'time': '9:00 AM - 7:00 PM',
        'break': '2:00 PM',
        'hours': 10,
        'position': 'Expediter',
      },
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

    // Add data for Jan 1-17
    final jan1to17Data = [
      {
        'day': 'Monday',
        'date': 'Jan 1',
        'time': '10:00 AM - 8:00 PM',
        'break': '3:00 PM',
        'hours': 10,
        'position': 'Service Manager',
      },
      {
        'day': 'Tuesday',
        'date': 'Jan 2',
        'time': '11:00 AM - 9:00 PM',
        'break': '4:00 PM',
        'hours': 10,
        'position': 'Manager In-Charge',
      },
      {
        'day': 'Wednesday',
        'date': 'Jan 3',
        'time': '8:00 AM - 6:00 PM',
        'break': '1:00 PM',
        'hours': 10,
        'position': 'Shift Leader',
      },
      {
        'day': 'Thursday',
        'date': 'Jan 4',
        'time': '9:00 AM - 7:00 PM',
        'break': '2:00 PM',
        'hours': 10,
        'position': 'Expediter',
      },
      {
        'day': 'Friday',
        'date': 'Jan 5',
        'time': '10:00 AM - 8:00 PM',
        'break': '3:00 PM',
        'hours': 10,
        'position': 'B2B',
      },
      {
        'day': 'Saturday',
        'date': 'Jan 6',
        'time': '11:00 AM - 9:00 PM',
        'break': '4:00 PM',
        'hours': 10,
        'position': 'Service Manager',
      },
      {
        'day': 'Sunday',
        'date': 'Jan 7',
        'time': '8:00 AM - 6:00 PM',
        'break': '1:00 PM',
        'hours': 10,
        'position': 'Manager In-Charge',
      },
      {
        'day': 'Monday',
        'date': 'Jan 8',
        'time': '9:00 AM - 7:00 PM',
        'break': '2:00 PM',
        'hours': 10,
        'position': 'Shift Leader',
      },
      {
        'day': 'Tuesday',
        'date': 'Jan 9',
        'time': '10:00 AM - 8:00 PM',
        'break': '3:00 PM',
        'hours': 10,
        'position': 'Expediter',
      },
      {
        'day': 'Wednesday',
        'date': 'Jan 10',
        'time': '11:00 AM - 9:00 PM',
        'break': '4:00 PM',
        'hours': 10,
        'position': 'B2B',
      },
      {
        'day': 'Thursday',
        'date': 'Jan 11',
        'time': '8:00 AM - 6:00 PM',
        'break': '1:00 PM',
        'hours': 10,
        'position': 'Service Manager',
      },
      {
        'day': 'Friday',
        'date': 'Jan 12',
        'time': '9:00 AM - 7:00 PM',
        'break': '2:00 PM',
        'hours': 10,
        'position': 'Manager In-Charge',
      },
      {
        'day': 'Saturday',
        'date': 'Jan 13',
        'time': '10:00 AM - 8:00 PM',
        'break': '3:00 PM',
        'hours': 10,
        'position': 'Shift Leader',
      },
      {
        'day': 'Sunday',
        'date': 'Jan 14',
        'time': '11:00 AM - 9:00 PM',
        'break': '4:00 PM',
        'hours': 10,
        'position': 'Expediter',
      },
      {
        'day': 'Monday',
        'date': 'Jan 15',
        'time': '8:00 AM - 6:00 PM',
        'break': '1:00 PM',
        'hours': 10,
        'position': 'B2B',
      },
      {
        'day': 'Tuesday',
        'date': 'Jan 16',
        'time': '9:00 AM - 7:00 PM',
        'break': '2:00 PM',
        'hours': 10,
        'position': 'Service Manager',
      },
      {
        'day': 'Wednesday',
        'date': 'Jan 17',
        'time': '10:00 AM - 8:00 PM',
        'break': '3:00 PM',
        'hours': 10,
        'position': 'Manager In-Charge',
      },
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
        // For any unspecified dates (shouldn't happen in our case)
        monthData.add({
          'day': weekday,
          'date': dateStr,
          'time': '8:00 AM - 6:00 PM',
          'break': '1:00 PM',
          'hours': 10,
          'position': 'Service Manager',
        });
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
                              'Jan 18',
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
              itemCount: data.length,
              itemBuilder: (_, index) {
                return _dayCard(data[index]);
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
    final time = d['time'] as String;
    final breakTime = d['break'] as String;
    final hours = d['hours'] as int;
    final position = d['position'] as String;

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
              color: const Color(0xFF1E3A8A).withOpacity(.08),
              borderRadius: BorderRadius.circular(6),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  (d['date'] as String).split(' ')[1],
                  style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w700,
                    color: Color(0xFF0F172A),
                  ),
                ),
                Text(
                  (d['day'] as String).substring(0, 3).toUpperCase(),
                  style: const TextStyle(
                    fontSize: 8,
                    fontWeight: FontWeight.w700,
                    color: Color(0xFF64748B),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(width: 10),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Main shift time row
                Row(
                  children: [
                    Expanded(
                      child: Text(
                        time,
                        style: const TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w700,
                          color: Color(0xFF0F172A),
                        ),
                      ),
                    ),
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

                // Position tag - Dark Blue
                const SizedBox(height: 6),
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 8,
                    vertical: 3,
                  ),
                  decoration: BoxDecoration(
                    color: const Color(0xFF1E3A8A), // Dark Blue
                    borderRadius: BorderRadius.circular(4),
                  ),
                  child: Text(
                    position,
                    style: const TextStyle(
                      fontSize: 10,
                      fontWeight: FontWeight.w700,
                      color: Colors.white,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _monthView() {
    final data = _weekData[2] ?? [];

    return ListView.builder(
      padding: const EdgeInsets.fromLTRB(
        12,
        12,
        12,
        40,
      ), // Increased bottom padding from 12 to 40
      itemCount: data.length,
      itemBuilder: (context, index) {
        final dayData = data[index];
        final time = dayData['time'] as String;
        final breakTime = dayData['break'] as String;
        final hours = dayData['hours'] as int;
        final position = dayData['position'] as String;
        final dateString = dayData['date'] as String;

        // Parse the date from the string (e.g., "Jan 9")
        final dateParts = dateString.split(' ');
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
                  color: const Color(0xFF1E3A8A).withOpacity(.08),
                  borderRadius: BorderRadius.circular(6),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      day.toString(),
                      style: const TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w700,
                        color: Color(0xFF0F172A),
                      ),
                    ),
                    Text(
                      dayName.substring(0, 3).toUpperCase(),
                      style: const TextStyle(
                        fontSize: 8,
                        fontWeight: FontWeight.w700,
                        color: Color(0xFF64748B),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Main shift time row
                    Row(
                      children: [
                        Expanded(
                          child: Text(
                            time,
                            style: const TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.w700,
                              color: Color(0xFF0F172A),
                            ),
                          ),
                        ),
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

                    // Position tag - Dark Blue
                    const SizedBox(height: 6),
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 8,
                        vertical: 3,
                      ),
                      decoration: BoxDecoration(
                        color: const Color(0xFF1E3A8A), // Dark Blue
                        borderRadius: BorderRadius.circular(4),
                      ),
                      child: Text(
                        position,
                        style: const TextStyle(
                          fontSize: 10,
                          fontWeight: FontWeight.w700,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}

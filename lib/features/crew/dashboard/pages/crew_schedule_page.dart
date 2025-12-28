import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class CrewSchedulePage extends StatefulWidget {
  const CrewSchedulePage({Key? key}) : super(key: key);

  @override
  State<CrewSchedulePage> createState() => _CrewSchedulePageState();
}

class _CrewSchedulePageState extends State<CrewSchedulePage> {
  int selectedWeek = 0; // 0=this 1=next 2=month

  final Map<int, List<Map<String, dynamic>>> _weekData = {
    0: [
      {
        'day': 'Monday',
        'date': 'Dec 9',
        'time': '9:00 AM - 5:00 PM',
        'station': 'Front Counter',
        'color': const Color(0xFF06B6D4),
      },
      {
        'day': 'Tuesday',
        'date': 'Dec 10',
        'time': '11:00 AM - 7:00 PM',
        'station': 'Drive-Thru',
        'color': const Color(0xFF8B5CF6),
      },
      {
        'day': 'Wednesday',
        'date': 'Dec 11',
        'time': '2:00 PM - 10:00 PM',
        'station': 'Kitchen',
        'color': const Color(0xFF667EEA),
      },
      {
        'day': 'Thursday',
        'date': 'Dec 12',
        'time': '9:00 AM - 5:00 PM',
        'station': 'Front Counter',
        'color': const Color(0xFF06B6D4),
      },
      {
        'day': 'Friday',
        'date': 'Dec 13',
        'time': '3:00 PM - 11:00 PM',
        'station': 'Kitchen',
        'color': const Color(0xFF667EEA),
      },
      {'day': 'Saturday', 'date': 'Dec 14', 'off': true},
      {'day': 'Sunday', 'date': 'Dec 15', 'off': true},
    ],
    1: [
      {
        'day': 'Monday',
        'date': 'Dec 16',
        'time': '10:00 AM - 6:00 PM',
        'station': 'Drive-Thru',
        'color': const Color(0xFF8B5CF6),
      },
      {
        'day': 'Tuesday',
        'date': 'Dec 17',
        'time': '2:00 PM - 10:00 PM',
        'station': 'Kitchen',
        'color': const Color(0xFF667EEA),
      },
      {'day': 'Wednesday', 'date': 'Dec 18', 'off': true},
      {
        'day': 'Thursday',
        'date': 'Dec 19',
        'time': '9:00 AM - 5:00 PM',
        'station': 'Front Counter',
        'color': const Color(0xFF06B6D4),
      },
      {
        'day': 'Friday',
        'date': 'Dec 20',
        'time': '11:00 AM - 7:00 PM',
        'station': 'Drive-Thru',
        'color': const Color(0xFF8B5CF6),
      },
      {'day': 'Saturday', 'date': 'Dec 21', 'off': true},
      {'day': 'Sunday', 'date': 'Dec 22', 'off': true},
    ],
    2: [
      // Month view data
      {
        'day': 'Monday',
        'date': 'Dec 9',
        'time': '9:00 AM - 5:00 PM',
        'station': 'Front Counter',
        'color': const Color(0xFF06B6D4),
      },
      {
        'day': 'Tuesday',
        'date': 'Dec 10',
        'time': '11:00 AM - 7:00 PM',
        'station': 'Drive-Thru',
        'color': const Color(0xFF8B5CF6),
      },
      {
        'day': 'Wednesday',
        'date': 'Dec 11',
        'time': '2:00 PM - 10:00 PM',
        'station': 'Kitchen',
        'color': const Color(0xFF667EEA),
      },
      {
        'day': 'Thursday',
        'date': 'Dec 12',
        'time': '9:00 AM - 5:00 PM',
        'station': 'Front Counter',
        'color': const Color(0xFF06B6D4),
      },
      {
        'day': 'Friday',
        'date': 'Dec 13',
        'time': '3:00 PM - 11:00 PM',
        'station': 'Kitchen',
        'color': const Color(0xFF667EEA),
      },
      {'day': 'Saturday', 'date': 'Dec 14', 'off': true},
      {'day': 'Sunday', 'date': 'Dec 15', 'off': true},
      {
        'day': 'Monday',
        'date': 'Dec 16',
        'time': '10:00 AM - 6:00 PM',
        'station': 'Drive-Thru',
        'color': const Color(0xFF8B5CF6),
      },
      {
        'day': 'Tuesday',
        'date': 'Dec 17',
        'time': '2:00 PM - 10:00 PM',
        'station': 'Kitchen',
        'color': const Color(0xFF667EEA),
      },
      {'day': 'Wednesday', 'date': 'Dec 18', 'off': true},
      {
        'day': 'Thursday',
        'date': 'Dec 19',
        'time': '9:00 AM - 5:00 PM',
        'station': 'Front Counter',
        'color': const Color(0xFF06B6D4),
      },
      {
        'day': 'Friday',
        'date': 'Dec 20',
        'time': '11:00 AM - 7:00 PM',
        'station': 'Drive-Thru',
        'color': const Color(0xFF8B5CF6),
      },
      {'day': 'Saturday', 'date': 'Dec 21', 'off': true},
      {'day': 'Sunday', 'date': 'Dec 22', 'off': true},
    ],
  };

  @override
  Widget build(BuildContext context) {
    final data = _weekData[selectedWeek] ?? [];
    int totalHours = 0;
    for (var d in data) {
      if (d['off'] != true) totalHours += 8; // rough
    }

    return Scaffold(
      backgroundColor: const Color(0xFFF5F7FA),
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(120),
        child: Container(
          decoration: const BoxDecoration(
            color: Colors.white,
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
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              child: Column(
                children: [
                  Row(
                    children: [
                      const Text(
                        'My Schedule',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w800,
                          color: Color(0xFF0F172A),
                          letterSpacing: -0.1,
                        ),
                      ),
                      const Spacer(),
                      GestureDetector(
                        onTap: () {
                          // Toggle calendar view if needed
                        },
                        child: Container(
                          padding: const EdgeInsets.all(8),
                          decoration: BoxDecoration(
                            color: const Color(0xFF1E3A8A).withOpacity(0.08),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: const Icon(
                            Icons.calendar_today_rounded,
                            color: Color(0xFF1E3A8A),
                            size: 18,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 12),
                  Row(
                    children: [
                      Expanded(child: _weekTab('This Week', 0)),
                      const SizedBox(width: 8),
                      Expanded(child: _weekTab('Next Week', 1)),
                      const SizedBox(width: 8),
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
              padding: const EdgeInsets.fromLTRB(16, 16, 16, 16),
              separatorBuilder: (_, __) => const SizedBox(height: 8),
              itemCount: data.length + 1, // +1 for total hours card
              itemBuilder: (_, i) {
                if (i == 0) {
                  // TOTAL HOURS CARD
                  return Container(
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      gradient: const LinearGradient(
                        colors: [Color(0xFF1E3A8A), Color(0xFF3B82F6)],
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                      ),
                      borderRadius: BorderRadius.circular(10),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.2),
                          blurRadius: 12,
                          offset: const Offset(0, 6),
                        ),
                      ],
                    ),
                    child: Row(
                      children: [
                        const Icon(
                          Icons.access_time_rounded,
                          color: Colors.white,
                          size: 28,
                        ),
                        const SizedBox(width: 12),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Total Hours This Week',
                              style: TextStyle(
                                color: Colors.white.withOpacity(.9),
                                fontSize: 12,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            const SizedBox(height: 4),
                            Text(
                              '$totalHours hours',
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 22,
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
        padding: const EdgeInsets.symmetric(vertical: 10),
        decoration: BoxDecoration(
          color: selected ? const Color(0xFF1E3A8A) : const Color(0xFFDCE6FF),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Text(
          label,
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 11,
            fontWeight: FontWeight.w700,
            color: selected ? Colors.white : const Color(0xFF1E3A8A),
          ),
        ),
      ),
    );
  }

  Widget _dayCard(Map<String, dynamic> d) {
    final off = d['off'] == true;
    final color = d['color'] as Color? ?? Colors.grey;
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
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
            width: 48,
            height: 48,
            decoration: BoxDecoration(
              color: off
                  ? const Color(0xFFF1F5F9)
                  : const Color(0xFF1E3A8A).withOpacity(.08),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  d['date'].split(' ')[1],
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w700,
                    color: off
                        ? const Color(0xFF94A3B8)
                        : const Color(0xFF0F172A),
                  ),
                ),
                Text(
                  d['day'].substring(0, 3).toUpperCase(),
                  style: TextStyle(
                    fontSize: 9,
                    fontWeight: FontWeight.w700,
                    color: off
                        ? const Color(0xFF94A3B8)
                        : const Color(0xFF64748B),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: off
                ? const Text(
                    'Day Off',
                    style: TextStyle(
                      fontSize: 13,
                      fontWeight: FontWeight.w600,
                      color: Color(0xFF94A3B8),
                    ),
                  )
                : Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        d['time'],
                        style: const TextStyle(
                          fontSize: 13,
                          fontWeight: FontWeight.w700,
                          color: Color(0xFF0F172A),
                        ),
                      ),
                      const SizedBox(height: 6),
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 6,
                          vertical: 3,
                        ),
                        decoration: BoxDecoration(
                          color: const Color(0xFF1E3A8A),
                          borderRadius: BorderRadius.circular(6),
                        ),
                        child: Text(
                          d['station'],
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
          if (!off)
            TextButton(
              onPressed: () => _showGiveAwayDialog(d),
              style: TextButton.styleFrom(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                minimumSize: const Size(60, 32),
                tapTargetSize: MaterialTapTargetSize.shrinkWrap,
              ),
              child: const Text(
                'Give Away',
                style: TextStyle(
                  fontSize: 11,
                  fontWeight: FontWeight.w700,
                  color: Color(0xFF1E3A8A),
                ),
              ),
            ),
        ],
      ),
    );
  }

  Widget _monthView() {
    final now = DateTime.now();
    final firstDayOfMonth = DateTime(now.year, now.month, 1);
    final lastDayOfMonth = DateTime(now.year, now.month + 1, 0);
    final daysInMonth = lastDayOfMonth.day;

    int totalHours = 0;
    for (var d in _weekData[2] ?? []) {
      if (d['off'] != true) totalHours += 8; // rough
    }

    return ListView.builder(
      padding: const EdgeInsets.fromLTRB(16, 16, 16, 16),
      itemCount: daysInMonth + 2,
      itemBuilder: (context, index) {
        if (index == 0) {
          // TOTAL HOURS CARD
          return Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              gradient: const LinearGradient(
                colors: [Color(0xFF1E3A8A), Color(0xFF3B82F6)],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              borderRadius: BorderRadius.circular(10),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.2),
                  blurRadius: 12,
                  offset: const Offset(0, 6),
                ),
              ],
            ),
            child: Row(
              children: [
                const Icon(
                  Icons.access_time_rounded,
                  color: Colors.white,
                  size: 28,
                ),
                const SizedBox(width: 12),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Total Hours This Month',
                      style: TextStyle(
                        color: Colors.white.withOpacity(.9),
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      '$totalHours hours',
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          );
        } else if (index == 1) {
          return const SizedBox(height: 8);
        } else {
          final day = firstDayOfMonth.add(Duration(days: index - 2));
          final List<Map<String, dynamic>> monthData =
              _weekData[2] ?? const <Map<String, dynamic>>[];
          final Map<String, dynamic> dayData = monthData.firstWhere(
            (d) => d['date'] == DateFormat('MMM d').format(day),
            orElse: () => {'off': true},
          );

          return Container(
            margin: const EdgeInsets.only(bottom: 8),
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(10),
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
                  width: 48,
                  height: 48,
                  decoration: BoxDecoration(
                    color: dayData['off'] == true
                        ? const Color(0xFFF1F5F9)
                        : const Color(0xFF1E3A8A).withOpacity(.08),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        day.day.toString(),
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w700,
                          color: dayData['off'] == true
                              ? const Color(0xFF94A3B8)
                              : const Color(0xFF0F172A),
                        ),
                      ),
                      Text(
                        DateFormat('EEE').format(day).toUpperCase(),
                        style: TextStyle(
                          fontSize: 9,
                          fontWeight: FontWeight.w700,
                          color: dayData['off'] == true
                              ? const Color(0xFF94A3B8)
                              : const Color(0xFF64748B),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: dayData['off'] == true
                      ? const Text(
                          'Day Off',
                          style: TextStyle(
                            fontSize: 13,
                            fontWeight: FontWeight.w600,
                            color: Color(0xFF94A3B8),
                          ),
                        )
                      : Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              dayData['time'],
                              style: const TextStyle(
                                fontSize: 13,
                                fontWeight: FontWeight.w700,
                                color: Color(0xFF0F172A),
                              ),
                            ),
                            const SizedBox(height: 6),
                            Container(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 6,
                                vertical: 3,
                              ),
                              decoration: BoxDecoration(
                                color: const Color(0xFF1E3A8A),
                                borderRadius: BorderRadius.circular(6),
                              ),
                              child: Text(
                                dayData['station'],
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
                if (dayData['off'] != true)
                  TextButton(
                    onPressed: () => _showGiveAwayDialog(dayData),
                    style: TextButton.styleFrom(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 8,
                        vertical: 4,
                      ),
                      minimumSize: const Size(60, 32),
                      tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                    ),
                    child: const Text(
                      'Give Away',
                      style: TextStyle(
                        fontSize: 11,
                        fontWeight: FontWeight.w700,
                        color: Color(0xFF1E3A8A),
                      ),
                    ),
                  ),
              ],
            ),
          );
        }
      },
    );
  }

  void _showGiveAwayDialog(Map<String, dynamic> shift) {
    showDialog(
      context: context,
      builder: (dialogContext) => Dialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        child: Container(
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(10),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Row(
                children: [
                  const Icon(
                    Icons.warning_amber_rounded,
                    color: Color(0xFFFFA07A),
                    size: 22,
                  ),
                  const SizedBox(width: 8),
                  const Expanded(
                    child: Text(
                      'Give Away Shift',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w800,
                        color: Color(0xFF0F172A),
                      ),
                    ),
                  ),
                  IconButton(
                    icon: const Icon(Icons.close, size: 20),
                    onPressed: () => Navigator.of(dialogContext).pop(),
                    padding: EdgeInsets.zero,
                    constraints: const BoxConstraints(),
                  ),
                ],
              ),
              const SizedBox(height: 16),

              Container(
                padding: const EdgeInsets.all(14),
                decoration: BoxDecoration(
                  color: const Color(0xFFF5F7FA),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Column(
                  children: [
                    _dialogRow('Day:', shift['day']),
                    const SizedBox(height: 8),
                    _dialogRow('Date:', shift['date']),
                    const SizedBox(height: 8),
                    _dialogRow('Time:', shift['time']),
                    const SizedBox(height: 8),
                    _dialogRow('Station:', shift['station']),
                  ],
                ),
              ),
              const SizedBox(height: 16),

              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  TextButton(
                    onPressed: () => Navigator.of(dialogContext).pop(),
                    child: const Text(
                      'Cancel',
                      style: TextStyle(
                        fontSize: 13,
                        fontWeight: FontWeight.w700,
                        color: Color(0xFF1E3A8A),
                      ),
                    ),
                  ),
                  const SizedBox(width: 8),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF1E3A8A),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                      padding: const EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 10,
                      ),
                    ),
                    onPressed: () {
                      Navigator.of(dialogContext).pop();
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text(
                            'Shift given away → ${shift['day']} ${shift['date']}',
                          ),
                        ),
                      );
                    },
                    child: const Text(
                      'Confirm',
                      style: TextStyle(
                        fontSize: 13,
                        fontWeight: FontWeight.w700,
                        color: Colors.white,
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

  Widget _dialogRow(String label, String value) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: const TextStyle(
            fontSize: 13,
            fontWeight: FontWeight.w600,
            color: Color(0xFF64748B),
          ),
        ),
        Text(
          value,
          style: const TextStyle(
            fontSize: 13,
            fontWeight: FontWeight.w700,
            color: Color(0xFF0F172A),
          ),
        ),
      ],
    );
  }
}

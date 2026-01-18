import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class CrewShiftHistoryPage extends StatefulWidget {
  const CrewShiftHistoryPage({Key? key}) : super(key: key);

  @override
  State<CrewShiftHistoryPage> createState() => _CrewShiftHistoryPageState();
}

class _CrewShiftHistoryPageState extends State<CrewShiftHistoryPage> {
  final DateFormat _dateFormatter = DateFormat('MMM d');
  final DateFormat _monthYearFormatter = DateFormat('MMMM yyyy');

  DateTime _selectedDate = DateTime.now();
  int _selectedYear = DateTime.now().year;
  int _selectedMonth = DateTime.now().month;
  List<int> _availableYears = [];

  final Map<int, Map<int, List<Map<String, dynamic>>>> _shiftHistoryData = {};

  @override
  void initState() {
    super.initState();
    _initializeYears();
    _initializeSampleData();
  }

  void _initializeYears() {
    final currentYear = DateTime.now().year;
    _availableYears = List.generate(3, (index) => currentYear - 1 + index);
  }

  void _initializeSampleData() {
    for (int year in _availableYears) {
      _shiftHistoryData[year] = {};
      for (int month = 1; month <= 12; month++) {
        _shiftHistoryData[year]![month] = _generateMonthShifts(year, month);
      }
    }
  }

  List<Map<String, dynamic>> _generateMonthShifts(int year, int month) {
    final List<Map<String, dynamic>> shifts = [];
    final daysInMonth = DateTime(year, month + 1, 0).day;

    final patterns = [
      {
        'time': '9:00 AM - 5:00 PM',
        'hours': 8,
        'department': 'Front Counter',
        'station': 'Counter 1',
        'color': const Color(0xFF06B6D4),
      },
      {
        'time': '11:00 AM - 7:00 PM',
        'hours': 8,
        'department': 'Drive-Thru',
        'station': 'Presenter/Runner',
        'color': const Color(0xFF8B5CF6),
      },
      {
        'time': '2:00 PM - 10:00 PM',
        'hours': 8,
        'department': 'Kitchen',
        'station': 'ASM/GRILL',
        'color': const Color(0xFF667EEA),
      },
      {
        'time': '3:00 PM - 11:00 PM',
        'hours': 8,
        'department': 'Kitchen',
        'station': 'Fryer Station',
        'color': const Color(0xFF667EEA),
      },
      {
        'time': '10:00 AM - 6:00 PM',
        'hours': 8,
        'department': 'Drive-Thru',
        'station': 'Order Taker',
        'color': const Color(0xFF8B5CF6),
      },
      {
        'time': '8:00 AM - 4:00 PM',
        'hours': 8,
        'department': 'Front Counter',
        'station': 'Cashier',
        'color': const Color(0xFF06B6D4),
      },
      {
        'time': '12:00 PM - 8:00 PM',
        'hours': 8,
        'department': 'Drive-Thru',
        'station': 'Drinks Station',
        'color': const Color(0xFF8B5CF6),
      },
    ];

    int patternIndex = 0;
    int consecutiveWorkDays = 0;
    int workDayCounter = 0;

    for (int day = 1; day <= daysInMonth; day++) {
      final currentDate = DateTime(year, month, day);
      final weekday = currentDate.weekday;

      if (weekday == 7) {
        // Sunday rest day
        shifts.add({
          'day': DateFormat('EEEE').format(currentDate),
          'date': _dateFormatter.format(currentDate),
          'off': true,
          'hours': 0,
        });
        consecutiveWorkDays = 0;
      } else {
        if (consecutiveWorkDays < 5) {
          final pattern = patterns[patternIndex % patterns.length];
          shifts.add({
            'day': DateFormat('EEEE').format(currentDate),
            'date': _dateFormatter.format(currentDate),
            'time': pattern['time'],
            'hours': pattern['hours'],
            'department': pattern['department'],
            'station': pattern['station'],
            'color': pattern['color'],
          });
          consecutiveWorkDays++;
          patternIndex++;
        } else {
          shifts.add({
            'day': DateFormat('EEEE').format(currentDate),
            'date': _dateFormatter.format(currentDate),
            'off': true,
            'hours': 0,
          });
          workDayCounter++;
          if (workDayCounter >= 2) {
            consecutiveWorkDays = 0;
            workDayCounter = 0;
          }
        }
      }
    }

    return shifts;
  }

  void _showMonthYearPicker(BuildContext context) {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.white,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(12)),
      ),
      isScrollControlled: true,
      builder: (context) {
        return StatefulBuilder(
          builder: (context, setModalState) {
            return Container(
              padding: const EdgeInsets.fromLTRB(16, 16, 16, 20),
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.vertical(top: Radius.circular(12)),
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        'Select Month & Year',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w700,
                          color: Color(0xFF1A1D1F),
                        ),
                      ),
                      IconButton(
                        onPressed: () => Navigator.pop(context),
                        icon: const Icon(Icons.close_rounded, size: 20),
                        padding: EdgeInsets.zero,
                        constraints: const BoxConstraints(),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),

                  // Year Selection
                  SizedBox(
                    height: 40,
                    child: ListView(
                      scrollDirection: Axis.horizontal,
                      children: _availableYears.map((year) {
                        return Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 4),
                          child: ChoiceChip(
                            label: Text(
                              year.toString(),
                              style: TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.w600,
                                color: _selectedYear == year
                                    ? Colors.white
                                    : const Color(0xFF64748B),
                              ),
                            ),
                            selected: _selectedYear == year,
                            onSelected: (selected) {
                              setModalState(() {
                                _selectedYear = year;
                              });
                            },
                            selectedColor: const Color(0xFF1E3A8A),
                            backgroundColor: Colors.white,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(16),
                              side: BorderSide(
                                color: _selectedYear == year
                                    ? const Color(0xFF1E3A8A)
                                    : const Color(0xFFE7EBF0),
                              ),
                            ),
                            padding: const EdgeInsets.symmetric(
                              horizontal: 12,
                              vertical: 4,
                            ),
                          ),
                        );
                      }).toList(),
                    ),
                  ),

                  const SizedBox(height: 20),

                  // Month Selection Grid
                  GridView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 3,
                          childAspectRatio: 2,
                          crossAxisSpacing: 8,
                          mainAxisSpacing: 8,
                        ),
                    itemCount: 12,
                    itemBuilder: (context, index) {
                      final month = index + 1;
                      final monthName = DateFormat(
                        'MMM',
                      ).format(DateTime(2024, month));
                      final isSelected =
                          _selectedYear == _selectedDate.year &&
                          month == _selectedDate.month;

                      return GestureDetector(
                        onTap: () {
                          Navigator.pop(context);
                          // Update the main state after closing the modal
                          WidgetsBinding.instance.addPostFrameCallback((_) {
                            setState(() {
                              _selectedDate = DateTime(_selectedYear, month);
                              _selectedMonth = month;
                            });
                          });
                        },
                        child: Container(
                          decoration: BoxDecoration(
                            color: isSelected
                                ? const Color(0xFF1E3A8A)
                                : Colors.white,
                            borderRadius: BorderRadius.circular(8),
                            border: Border.all(
                              color: isSelected
                                  ? const Color(0xFF1E3A8A)
                                  : const Color(0xFFE7EBF0),
                              width: isSelected ? 1.5 : 1,
                            ),
                          ),
                          child: Center(
                            child: Text(
                              monthName,
                              style: TextStyle(
                                fontSize: 13,
                                fontWeight: FontWeight.w600,
                                color: isSelected
                                    ? Colors.white
                                    : const Color(0xFF1A1D1F),
                              ),
                            ),
                          ),
                        ),
                      );
                    },
                  ),

                  const SizedBox(height: 16),

                  // Apply Button
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.pop(context);
                        setState(() {
                          _selectedDate = DateTime(
                            _selectedYear,
                            _selectedMonth,
                          );
                        });
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF1E3A8A),
                        padding: const EdgeInsets.symmetric(vertical: 12),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                      child: const Text(
                        'Apply',
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            );
          },
        );
      },
    );
  }

  int _calculateTotalHours(List<Map<String, dynamic>> shifts) {
    int totalHours = 0;
    for (var shift in shifts) {
      final hours = shift['hours'] as int? ?? 0;
      totalHours += hours;
    }
    return totalHours;
  }

  @override
  Widget build(BuildContext context) {
    final currentMonthShifts =
        _shiftHistoryData[_selectedDate.year]?[_selectedDate.month] ?? [];
    final totalHours = _calculateTotalHours(currentMonthShifts);
    final monthName = _monthYearFormatter.format(_selectedDate);

    return Scaffold(
      backgroundColor: const Color(0xFFF5F7FA),
      appBar: AppBar(
        title: const Text(
          'Shift History',
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w700,
            color: Color(0xFF1A1D1F),
          ),
        ),
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_rounded, size: 20),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: Column(
        children: [
          // Month Selection Header
          Container(
            color: Colors.white,
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            child: Column(
              children: [
                GestureDetector(
                  onTap: () => _showMonthYearPicker(context),
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 12,
                      vertical: 10,
                    ),
                    decoration: BoxDecoration(
                      color: const Color(0xFFF5F7FA),
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(color: const Color(0xFFE7EBF0)),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              monthName,
                              style: const TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w700,
                                color: Color(0xFF1A1D1F),
                              ),
                            ),
                            const SizedBox(height: 2),
                            Text(
                              'Tap to select different month',
                              style: TextStyle(
                                fontSize: 10,
                                color: const Color(0xFF64748B).withOpacity(0.8),
                              ),
                            ),
                          ],
                        ),
                        Container(
                          padding: const EdgeInsets.all(6),
                          decoration: BoxDecoration(
                            color: const Color(0xFF1E3A8A).withOpacity(0.1),
                            borderRadius: BorderRadius.circular(6),
                          ),
                          child: const Icon(
                            Icons.calendar_month_rounded,
                            color: Color(0xFF1E3A8A),
                            size: 16,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 12),
                // Month Navigation
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    IconButton(
                      onPressed: () {
                        setState(() {
                          final prevMonth = DateTime(
                            _selectedDate.year,
                            _selectedDate.month - 1,
                          );
                          _selectedDate = prevMonth;
                          _selectedYear = prevMonth.year;
                          _selectedMonth = prevMonth.month;
                        });
                      },
                      icon: const Icon(Icons.chevron_left_rounded, size: 20),
                      style: IconButton.styleFrom(
                        backgroundColor: const Color(0xFFF5F7FA),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                          side: const BorderSide(color: Color(0xFFE7EBF0)),
                        ),
                        padding: const EdgeInsets.all(8),
                      ),
                    ),
                    Text(
                      DateFormat(
                        'MMMM yyyy',
                      ).format(_selectedDate).toUpperCase(),
                      style: const TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w700,
                        color: Color(0xFF1E3A8A),
                      ),
                    ),
                    IconButton(
                      onPressed: () {
                        setState(() {
                          final nextMonth = DateTime(
                            _selectedDate.year,
                            _selectedDate.month + 1,
                          );
                          _selectedDate = nextMonth;
                          _selectedYear = nextMonth.year;
                          _selectedMonth = nextMonth.month;
                        });
                      },
                      icon: const Icon(Icons.chevron_right_rounded, size: 20),
                      style: IconButton.styleFrom(
                        backgroundColor: const Color(0xFFF5F7FA),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                          side: const BorderSide(color: Color(0xFFE7EBF0)),
                        ),
                        padding: const EdgeInsets.all(8),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),

          // Total Hours Card
          Padding(
            padding: const EdgeInsets.all(12),
            child: Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                gradient: const LinearGradient(
                  colors: [Color(0xFF1E3A8A), Color(0xFF3B82F6)],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: BorderRadius.circular(8),
                boxShadow: const [
                  BoxShadow(
                    color: Color(0x140F172A),
                    blurRadius: 8,
                    offset: Offset(0, 4),
                  ),
                ],
              ),
              child: Row(
                children: [
                  Container(
                    padding: const EdgeInsets.all(6),
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.2),
                      borderRadius: BorderRadius.circular(6),
                    ),
                    child: const Icon(
                      Icons.access_time_rounded,
                      color: Colors.white,
                      size: 20,
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Total Hours - ${DateFormat('MMM yyyy').format(_selectedDate)}',
                          style: TextStyle(
                            color: Colors.white.withOpacity(0.9),
                            fontSize: 12,
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
                  ),
                ],
              ),
            ),
          ),

          // Shifts List
          Expanded(
            child: currentMonthShifts.isEmpty
                ? Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.history_toggle_off_rounded,
                          size: 48,
                          color: Colors.grey[400],
                        ),
                        const SizedBox(height: 12),
                        const Text(
                          'No shift history for this month',
                          style: TextStyle(
                            fontSize: 14,
                            color: Color(0xFF64748B),
                          ),
                        ),
                      ],
                    ),
                  )
                : ListView.builder(
                    padding: const EdgeInsets.symmetric(horizontal: 12),
                    itemCount: currentMonthShifts.length,
                    itemBuilder: (context, index) {
                      final shift = currentMonthShifts[index];
                      final off = shift['off'] == true;
                      final department = shift['department'] as String?;
                      final station = shift['station'] as String?;
                      final time = shift['time'] as String?;
                      final hours = shift['hours'] as int? ?? 0;
                      final dateString = shift['date'] as String;
                      final dayName = shift['day'] as String;

                      final dateParts = dateString.split(' ');
                      final day = dateParts.length > 1 ? dateParts[1] : '';

                      return Container(
                        margin: const EdgeInsets.only(bottom: 6),
                        padding: const EdgeInsets.all(10),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(8),
                          border: Border.all(color: const Color(0xFFE7EBF0)),
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
                            // Date Box
                            Container(
                              width: 48,
                              height: 48,
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
                                    day,
                                    style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w800,
                                      color: off
                                          ? const Color(0xFF94A3B8)
                                          : const Color(0xFF0F172A),
                                    ),
                                  ),
                                  Text(
                                    dayName.substring(0, 3).toUpperCase(),
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
                            const SizedBox(width: 10),

                            // Shift Details
                            Expanded(
                              child: off
                                  ? Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        const Text(
                                          'Rest Day',
                                          style: TextStyle(
                                            fontSize: 13,
                                            fontWeight: FontWeight.w600,
                                            color: Color(0xFF94A3B8),
                                          ),
                                        ),
                                        const SizedBox(height: 2),
                                        Text(
                                          'No hours',
                                          style: TextStyle(
                                            fontSize: 11,
                                            color: const Color(
                                              0xFF94A3B8,
                                            ).withOpacity(0.7),
                                          ),
                                        ),
                                      ],
                                    )
                                  : Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Row(
                                          children: [
                                            Expanded(
                                              child: Text(
                                                time ?? '',
                                                style: const TextStyle(
                                                  fontSize: 13,
                                                  fontWeight: FontWeight.w700,
                                                  color: Color(0xFF0F172A),
                                                ),
                                              ),
                                            ),
                                            Container(
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                    horizontal: 6,
                                                    vertical: 3,
                                                  ),
                                              decoration: BoxDecoration(
                                                color: const Color(
                                                  0xFF10B981,
                                                ).withOpacity(0.15),
                                                borderRadius:
                                                    BorderRadius.circular(4),
                                              ),
                                              child: Text(
                                                '${hours}h',
                                                style: const TextStyle(
                                                  fontSize: 11,
                                                  fontWeight: FontWeight.w700,
                                                  color: Color(0xFF10B981),
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                        if (department != null &&
                                            station != null) ...[
                                          const SizedBox(height: 6),
                                          Wrap(
                                            spacing: 4,
                                            runSpacing: 4,
                                            children: [
                                              Container(
                                                padding:
                                                    const EdgeInsets.symmetric(
                                                      horizontal: 6,
                                                      vertical: 3,
                                                    ),
                                                decoration: BoxDecoration(
                                                  color: const Color(
                                                    0xFF1E3A8A,
                                                  ),
                                                  borderRadius:
                                                      BorderRadius.circular(4),
                                                ),
                                                child: Text(
                                                  department,
                                                  style: const TextStyle(
                                                    fontSize: 10,
                                                    fontWeight: FontWeight.w700,
                                                    color: Colors.white,
                                                  ),
                                                ),
                                              ),
                                              Container(
                                                padding:
                                                    const EdgeInsets.symmetric(
                                                      horizontal: 6,
                                                      vertical: 3,
                                                    ),
                                                decoration: BoxDecoration(
                                                  color: const Color(
                                                    0xFF3B82F6,
                                                  ),
                                                  borderRadius:
                                                      BorderRadius.circular(4),
                                                ),
                                                child: Text(
                                                  station,
                                                  style: const TextStyle(
                                                    fontSize: 10,
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
                    },
                  ),
          ),
        ],
      ),
    );
  }
}

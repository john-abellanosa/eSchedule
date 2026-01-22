import 'package:flutter/material.dart';
import 'package:escheduler/features/crew/pages/crew_request_page/widgets/empty_state/empty_state.dart';
import 'package:escheduler/features/crew/pages/crew_request_page/dialog/new_request_dialog.dart';
import 'package:escheduler/features/crew/pages/crew_request_page/widgets/input_widgets/input_widgets.dart';
import 'package:escheduler/features/crew/pages/crew_request_page/request_form/leave_request_form.dart';
import 'package:escheduler/features/crew/pages/crew_request_page/request_form/give_away_request_form.dart';
import 'package:escheduler/features/crew/pages/crew_request_page/request_form/swap_request_form.dart';
import 'package:escheduler/features/crew/pages/crew_request_page/request_form/off_duty_request_form.dart';

class CrewRequestPage extends StatefulWidget {
  const CrewRequestPage({Key? key}) : super(key: key);

  @override
  State<CrewRequestPage> createState() => _CrewRequestPageState();
}

class _CrewRequestPageState extends State<CrewRequestPage>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  // Sample data for Requests (Swap and Give Away)
  final List<Request> _requests = [
    Request(
      id: '1',
      type: 'Swap',
      fromEmployee: 'Sarah Johnson',
      fromDepartment: 'Front Counter',
      fromStation: 'Counter 1',
      fromTimeIn: '09:00 AM',
      fromTimeOut: '05:00 PM',
      toDepartment: 'Drive Thru',
      toStation: 'Order Taker',
      toTimeIn: '10:00 AM',
      toTimeOut: '06:00 PM',
      date: 'Mon, Dec 15',
      reason: 'Doctor appointment in the morning',
      swapPartner: 'Mike Chen',
      requestedDate: 'Dec 12, 2024',
    ),
    Request(
      id: '2',
      type: 'Give Away',
      fromEmployee: 'Alex Brown',
      fromDepartment: 'Kitchen',
      fromStation: 'Fry Station',
      fromTimeIn: '11:00 AM',
      fromTimeOut: '07:00 PM',
      toDepartment: '',
      toStation: '',
      toTimeIn: '',
      toTimeOut: '',
      date: 'Tue, Dec 16',
      reason: 'Family event in the evening',
      swapPartner: '',
      requestedDate: 'Dec 13, 2024',
    ),
  ];

  // Empty lists for other sections
  final List<Request> _status = [];
  final List<Request> _completedRequests = [];
  final List<Request> _cancelledRequests = [];

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 4, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8FAFC),
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: const Color(0xFF1E3A8A),
        elevation: 0,
        title: const Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Manage Your Requests',
              style: TextStyle(
                color: Colors.white,
                fontSize: 18,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
        actions: [
          IconButton(
            onPressed: () => showNewRequestDialog(context),
            icon: const Icon(Icons.add, color: Colors.white),
            tooltip: 'New Request',
          ),
          const SizedBox(width: 8),
        ],
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(48),
          child: Container(
            color: const Color(0xFF1E3A8A),
            child: Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 0,
              ), // No horizontal padding
              child: TabBar(
                controller: _tabController,
                indicatorColor: Colors.white,
                labelColor: Colors.white,
                unselectedLabelColor: Colors.white70,
                labelStyle: const TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w600,
                ),
                unselectedLabelStyle: const TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w500,
                ),
                isScrollable: false,
                padding: EdgeInsets.zero,
                indicatorPadding: EdgeInsets.zero,
                labelPadding: EdgeInsets.zero, // Add this
                tabs: const [
                  Tab(text: 'Requests'),
                  Tab(text: 'Status'),
                  Tab(text: 'Completed'),
                  Tab(text: 'Cancelled'),
                ],
              ),
            ),
          ),
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          _buildRequestsTab(),
          _buildStatusTab(),
          _buildCompletedTab(),
          _buildCancelledTab(),
        ],
      ),
    );
  }

  Widget _buildRequestsTab() {
    if (_requests.isEmpty) {
      return buildEmptyState(
        icon: Icons.gesture,
        title: 'No Requests',
        message: 'No one is requesting shifts from you',
      );
    }

    return ListView.builder(
      padding: const EdgeInsets.all(12),
      itemCount: _requests.length,
      itemBuilder: (context, index) {
        return _buildRequestCard(_requests[index]);
      },
    );
  }

  Widget _buildRequestCard(Request request) {
    final bool isSwap = request.type == 'Swap';

    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: const Color(0xFFE2E8F0)),
        boxShadow: [
          BoxShadow(
            color: const Color(0xFF000000).withOpacity(0.03),
            blurRadius: 2,
            offset: const Offset(0, 1),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header Badge with Requested Date
          Padding(
            padding: const EdgeInsets.all(12),
            child: Row(
              children: [
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 8,
                    vertical: 4,
                  ),
                  decoration: BoxDecoration(
                    color: const Color(0xFF1E3A8A),
                    borderRadius: BorderRadius.circular(4),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(
                        isSwap ? Icons.swap_horiz : Icons.gesture,
                        color: Colors.white,
                        size: 14,
                      ),
                      const SizedBox(width: 4),
                      Text(
                        isSwap ? 'Swap Schedule' : 'Give Away Schedule',
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 11,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ],
                  ),
                ),
                const Spacer(),
                Row(
                  children: [
                    const Icon(
                      Icons.access_time,
                      size: 12,
                      color: Color(0xFF94A3B8),
                    ),
                    const SizedBox(width: 4),
                    Text(
                      request.requestedDate,
                      style: const TextStyle(
                        fontSize: 10,
                        color: Color(0xFF94A3B8),
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          Divider(
            height: 1,
            color: const Color(0xFFE2E8F0),
            indent: 12,
            endIndent: 12,
          ),

          // Main Content
          Padding(
            padding: const EdgeInsets.all(12),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Requested by
                _buildInfoRow(
                  icon: Icons.person_outline,
                  label: 'Requested by',
                  value: request.fromEmployee,
                  bold: true,
                ),
                const SizedBox(height: 12),

                // Date
                _buildInfoRow(
                  icon: Icons.calendar_today,
                  label: isSwap ? 'Swap Date' : 'Schedule Date',
                  value: request.date,
                ),
                const SizedBox(height: 12),

                // Shifts Section
                if (isSwap) ...[
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        child: _buildSwapShiftSection(
                          icon: Icons.work_outline,
                          title: 'Their Shift',
                          department: request.fromDepartment,
                          station: request.fromStation,
                          timeIn: request.fromTimeIn,
                          timeOut: request.fromTimeOut,
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: _buildSwapShiftSection(
                          icon: Icons.swap_horiz,
                          title: 'Your Shift',
                          department: request.toDepartment,
                          station: request.toStation,
                          timeIn: request.toTimeIn,
                          timeOut: request.toTimeOut,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 12),
                ] else ...[
                  _buildShiftSection(
                    icon: Icons.work_outline,
                    title: 'Their Shift',
                    department: request.fromDepartment,
                    station: request.fromStation,
                    timeIn: request.fromTimeIn,
                    timeOut: request.fromTimeOut,
                  ),
                  const SizedBox(height: 12),
                ],

                // Reason
                _buildReasonSection(request.reason),
              ],
            ),
          ),

          // Action Buttons
          Divider(height: 1, color: const Color(0xFFE2E8F0)),
          Padding(
            padding: const EdgeInsets.all(12),
            child: Row(
              children: [
                Expanded(
                  child: SizedBox(
                    height: 36,
                    child: OutlinedButton(
                      onPressed: () => _handleDecline(request.id),
                      style: OutlinedButton.styleFrom(
                        side: BorderSide(color: const Color(0xFFE2E8F0)),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(4),
                        ),
                      ),
                      child: const Text(
                        'Decline',
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w600,
                          color: Color(0xFF64748B),
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: SizedBox(
                    height: 36,
                    child: ElevatedButton(
                      onPressed: () => _handleAccept(request.id),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF1E3A8A),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(4),
                        ),
                      ),
                      child: const Text(
                        'Accept',
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w600,
                          color: Colors.white,
                        ),
                      ),
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

  // Helper method: Simple info row
  Widget _buildInfoRow({
    required IconData icon,
    required String label,
    required String value,
    bool bold = false,
    bool isSmall = false,
  }) {
    return Row(
      children: [
        Icon(icon, size: 14, color: const Color(0xFF64748B)),
        const SizedBox(width: 8),
        Expanded(
          child: RichText(
            text: TextSpan(
              children: [
                TextSpan(
                  text: '$label: ',
                  style: TextStyle(
                    fontSize: isSmall ? 10 : 11,
                    fontWeight: FontWeight.w600,
                    color: const Color(0xFF1E293B),
                  ),
                ),
                TextSpan(
                  text: value,
                  style: TextStyle(
                    fontSize: isSmall ? 10 : 11,
                    fontWeight: bold ? FontWeight.w600 : FontWeight.w500,
                    color: bold
                        ? const Color(0xFF1E293B)
                        : const Color(0xFF64748B),
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  // Helper method: Shift details section (for non-swap)
  Widget _buildShiftSection({
    required IconData icon,
    required String title,
    required String department,
    required String station,
    required String timeIn,
    required String timeOut,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(icon, size: 14, color: const Color(0xFF64748B)),
            const SizedBox(width: 8),
            Text(
              title,
              style: const TextStyle(
                fontSize: 11,
                fontWeight: FontWeight.w600,
                color: Color(0xFF1E293B),
              ),
            ),
          ],
        ),
        const SizedBox(height: 6),
        Padding(
          padding: const EdgeInsets.only(left: 22),
          child: Text(
            '$department - $station • $timeIn - $timeOut',
            style: const TextStyle(
              fontSize: 10,
              color: Color(0xFF475569),
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
      ],
    );
  }

  // Helper method: Swap shift section with background
  Widget _buildSwapShiftSection({
    required IconData icon,
    required String title,
    required String department,
    required String station,
    required String timeIn,
    required String timeOut,
  }) {
    return Container(
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: const Color(0xFFF8FAFC),
        borderRadius: BorderRadius.circular(6),
        border: Border.all(color: const Color(0xFFE2E8F0)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(icon, size: 13, color: const Color(0xFF64748B)),
              const SizedBox(width: 6),
              Text(
                title,
                style: const TextStyle(
                  fontSize: 11,
                  fontWeight: FontWeight.w700,
                  color: Color(0xFF1E293B),
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Text(
            department,
            style: const TextStyle(
              fontSize: 10,
              fontWeight: FontWeight.w600,
              color: Color(0xFF1E293B),
            ),
          ),
          const SizedBox(height: 4),
          Text(
            station,
            style: const TextStyle(
              fontSize: 9,
              fontWeight: FontWeight.w500,
              color: Color(0xFF475569),
            ),
          ),
          const SizedBox(height: 4),
          Text(
            '$timeIn - $timeOut',
            style: const TextStyle(
              fontSize: 9,
              fontWeight: FontWeight.w500,
              color: Color(0xFF64748B),
            ),
          ),
        ],
      ),
    );
  }

  // Helper method: Reason section
  Widget _buildReasonSection(String reason) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(Icons.note_outlined, size: 14, color: const Color(0xFF64748B)),
            const SizedBox(width: 8),
            const Text(
              'Reason',
              style: TextStyle(
                fontSize: 11,
                fontWeight: FontWeight.w600,
                color: Color(0xFF1E293B),
              ),
            ),
          ],
        ),
        const SizedBox(height: 6),
        Padding(
          padding: const EdgeInsets.only(left: 22),
          child: Text(
            reason,
            style: const TextStyle(
              fontSize: 10,
              color: Color(0xFF475569),
              height: 1.4,
            ),
          ),
        ),
      ],
    );
  }

  // Helper method: Simple info row

  void _handleAccept(String requestId) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Request $requestId accepted'),
        backgroundColor: const Color(0xFF1E3A8A),
        duration: const Duration(seconds: 2),
      ),
    );
  }

  void _handleDecline(String requestId) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Request $requestId declined'),
        backgroundColor: const Color(0xFF64748B),
        duration: const Duration(seconds: 2),
      ),
    );
  }

  Widget _buildStatusTab() {
    // Sample data for Status Tab - including all 4 types
    final List<dynamic> _statusRequests = [
      // EXAMPLE 1: Swap Schedule - Only Co-worker Approved (first step approved)
      {
        'type': 'Swap',
        'id': '1',
        'fromEmployee': 'Michael Rodriguez',
        'fromDepartment': 'Drive Thru',
        'fromStation': 'Cashier',
        'fromTimeIn': '02:00 PM',
        'fromTimeOut': '10:00 PM',
        'toDepartment': 'Front Counter',
        'toStation': 'Counter 3',
        'toTimeIn': '01:00 PM',
        'toTimeOut': '09:00 PM',
        'date': 'Wed, Dec 17',
        'reason': 'Need to attend evening class',
        'swapPartner': 'Emily Wilson',
        'requestedDate': 'Dec 14, 2024',
        'approvedStatuses': [],
        'pendingStatuses': [
          "Pending Admin Approval",
          "Pending Scheduler Approval",
        ],
        'canCancel': false,
      },
      // EXAMPLE 2: Give Away Schedule - Co-worker & Admin Approved (first two steps approved)
      {
        'type': 'Give Away',
        'id': '2',
        'fromEmployee': 'You',
        'fromDepartment': 'Kitchen',
        'fromStation': 'Grill Station',
        'fromTimeIn': '08:00 AM',
        'fromTimeOut': '04:00 PM',
        'toDepartment': '',
        'toStation': '',
        'toTimeIn': '',
        'toTimeOut': '',
        'date': 'Thu, Dec 18',
        'reason': 'Personal day off',
        'swapPartner': '',
        'requestedDate': 'Dec 15, 2024',
        'approvedStatuses': ["Co-worker Accepted", "Admin Approved"],
        'pendingStatuses': ["Pending Scheduler Approval"],
        'canCancel': false,
      },
      // EXAMPLE 3: Swap Schedule - All Pending (just requested)
      {
        'type': 'Swap',
        'id': '3',
        'fromEmployee': 'You',
        'fromDepartment': 'Front Counter',
        'fromStation': 'Counter 1',
        'fromTimeIn': '09:00 AM',
        'fromTimeOut': '05:00 PM',
        'toDepartment': 'Drive Thru',
        'toStation': 'Order Taker',
        'toTimeIn': '10:00 AM',
        'toTimeOut': '06:00 PM',
        'date': 'Fri, Dec 19',
        'reason': 'Doctor appointment',
        'swapPartner': 'Alex Brown',
        'requestedDate': 'Dec 16, 2024',
        'approvedStatuses': [],
        'pendingStatuses': [
          "Awaiting Co-worker's response",
          "Pending Admin Approval",
          "Pending Scheduler Approval",
        ],
        'canCancel': true,
      },
      // EXAMPLE 4: Give Away Schedule - Co-worker Approved (first step approved)
      {
        'type': 'Give Away',
        'id': '4',
        'fromEmployee': 'Rachel Green',
        'fromDepartment': 'Front Counter',
        'fromStation': 'Drive-Thru Presenter',
        'fromTimeIn': '12:00 PM',
        'fromTimeOut': '08:00 PM',
        'toDepartment': '',
        'toStation': '',
        'toTimeIn': '',
        'toTimeOut': '',
        'date': 'Sat, Dec 20',
        'reason': 'Family event',
        'swapPartner': '',
        'requestedDate': 'Dec 17, 2024',
        'approvedStatuses': ["Admin Approved"],
        'pendingStatuses': ["Pending Scheduler Approval"],
        'canCancel': false,
      },
      // Leave Request - Pending Admin Approval
      {
        'type': 'Leave',
        'id': 'C3',
        'fromEmployee': 'You',
        'leaveType': 'Annual Leave',
        'startDate': 'Wed, Dec 17',
        'endDate': 'Fri, Dec 19',
        'reason': 'Short vacation with family',
        'requestedDate': 'Dec 14, 2024',
        'approvedStatuses': [], // Only Admin Approved
        'pendingStatuses': ["Pending Admin Approval"],
        'canCancel': true,
      },
      // Off Duty Request - Pending Scheduler Approval
      {
        'type': 'Off Duty',
        'id': 'O1',
        'fromEmployee': 'You',
        'date': 'Tue, Dec 24',
        'duration': '2 Days',
        'reason': 'Christmas holiday',
        'requestedDate': 'Dec 17, 2024',
        'approvedStatuses': [],
        'pendingStatuses': ["Pending Scheduler Approval"],
        'canCancel': true,
      },
    ];

    if (_statusRequests.isEmpty) {
      return buildEmptyState(
        icon: Icons.pending_actions,
        title: 'No Status Updates',
        message: 'No requests are currently being processed',
      );
    }

    return ListView.builder(
      padding: const EdgeInsets.all(12),
      itemCount: _statusRequests.length,
      itemBuilder: (context, index) {
        final item = _statusRequests[index];
        final String type = item['type'] as String;

        if (type == 'Swap' || type == 'Give Away') {
          return _buildStatusCard(item);
        } else if (type == 'Leave') {
          return _buildLeaveStatusCard(item);
        } else if (type == 'Off Duty') {
          return _buildOffDutyStatusCard(item);
        }

        return Container();
      },
    );
  }

  // Helper method: Build approved status badges
  Widget _buildApprovedStatusBadges(List<String> approvedStatuses) {
    if (approvedStatuses.isEmpty) return const SizedBox.shrink();

    return Column(
      children: approvedStatuses.map((status) {
        return Padding(
          padding: const EdgeInsets.only(bottom: 6),
          child: Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
            decoration: BoxDecoration(
              color: const Color(0xFFDCFCE7), // Light green background
              borderRadius: BorderRadius.circular(4),
              border: Border.all(
                color: const Color(0xFF16A34A), // Green border
                width: 0.5,
              ),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(
                  Icons.check_circle,
                  size: 12,
                  color: const Color(0xFF16A34A), // Green icon
                ),
                const SizedBox(width: 6),
                Text(
                  status,
                  style: const TextStyle(
                    fontSize: 10,
                    fontWeight: FontWeight.w600,
                    color: const Color(0xFF166534), // Dark green text
                  ),
                ),
              ],
            ),
          ),
        );
      }).toList(),
    );
  }

  // Helper method: Build pending status badges
  Widget _buildPendingStatusBadges(List<String> pendingStatuses) {
    if (pendingStatuses.isEmpty) return const SizedBox.shrink();

    return Column(
      children: pendingStatuses.map((status) {
        return Padding(
          padding: const EdgeInsets.only(bottom: 6),
          child: Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
            decoration: BoxDecoration(
              color: const Color(0xFFFFF9DB), // Light yellowish color
              borderRadius: BorderRadius.circular(4),
              border: Border.all(
                color: const Color(0xFFF59E0B), // Amber border
                width: 0.5,
              ),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(
                  Icons.access_time,
                  size: 12,
                  color: const Color(0xFFB45309), // Dark amber for icon
                ),
                const SizedBox(width: 6),
                Text(
                  status,
                  style: const TextStyle(
                    fontSize: 10,
                    fontWeight: FontWeight.w600,
                    color: const Color(0xFFB45309), // Dark amber for text
                  ),
                ),
              ],
            ),
          ),
        );
      }).toList(),
    );
  }

  // Helper method: Build cancel button (bottom right)
  // Helper method: Build cancel button (simple red text button)
  Widget _buildCancelButton(bool canCancel, String requestId) {
    if (!canCancel) return const SizedBox.shrink();

    return Align(
      alignment: Alignment.centerRight,
      child: GestureDetector(
        onTap: () => _handleCancelRequest(requestId),
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
          decoration: BoxDecoration(
            color: const Color(0xFFDC2626),
            borderRadius: BorderRadius.circular(4),
          ),
          child: Text(
            'Cancel Request',
            style: TextStyle(
              fontSize: 10,
              fontWeight: FontWeight.w600,
              color: Colors.white,
            ),
          ),
        ),
      ),
    );
  }

  // Swap and Give Away Status Card
  Widget _buildStatusCard(Map<String, dynamic> data) {
    final bool isSwap = data['type'] == 'Swap';
    final List<String> approvedStatuses =
        (data['approvedStatuses'] as List<dynamic>).cast<String>();
    final List<String> pendingStatuses =
        (data['pendingStatuses'] as List<dynamic>).cast<String>();
    final bool canCancel = data['canCancel'] as bool;
    final String requestId = data['id'] as String;

    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: const Color(0xFFE2E8F0)),
        boxShadow: [
          BoxShadow(
            color: const Color(0xFF000000).withOpacity(0.03),
            blurRadius: 2,
            offset: const Offset(0, 1),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header Badge with Requested Date
          Padding(
            padding: const EdgeInsets.all(12),
            child: Row(
              children: [
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 8,
                    vertical: 4,
                  ),
                  decoration: BoxDecoration(
                    color: const Color(0xFF1E3A8A),
                    borderRadius: BorderRadius.circular(4),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(
                        isSwap ? Icons.swap_horiz : Icons.gesture,
                        color: Colors.white,
                        size: 14,
                      ),
                      const SizedBox(width: 4),
                      Text(
                        isSwap ? 'Swap Schedule' : 'Give Away Schedule',
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 11,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ],
                  ),
                ),
                const Spacer(),
                Row(
                  children: [
                    const Icon(
                      Icons.access_time,
                      size: 12,
                      color: Color(0xFF94A3B8),
                    ),
                    const SizedBox(width: 4),
                    Text(
                      data['requestedDate'] as String,
                      style: const TextStyle(
                        fontSize: 10,
                        color: Color(0xFF94A3B8),
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          Divider(
            height: 1,
            color: const Color(0xFFE2E8F0),
            indent: 12,
            endIndent: 12,
          ),

          // Main Content
          Padding(
            padding: const EdgeInsets.all(12),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Requested by
                _buildInfoRow(
                  icon: Icons.person_outline,
                  label: 'Requested by',
                  value: data['fromEmployee'] as String,
                  bold: true,
                ),
                const SizedBox(height: 12),

                // Date
                _buildInfoRow(
                  icon: Icons.calendar_today,
                  label: isSwap ? 'Swap Date' : 'Schedule Date',
                  value: data['date'] as String,
                ),
                const SizedBox(height: 12),

                // Shifts Section
                if (isSwap) ...[
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        child: _buildSwapShiftSection(
                          icon: Icons.work_outline,
                          title: 'Their Shift',
                          department: data['fromDepartment'] as String,
                          station: data['fromStation'] as String,
                          timeIn: data['fromTimeIn'] as String,
                          timeOut: data['fromTimeOut'] as String,
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: _buildSwapShiftSection(
                          icon: Icons.swap_horiz,
                          title: 'Your Shift',
                          department: data['toDepartment'] as String,
                          station: data['toStation'] as String,
                          timeIn: data['toTimeIn'] as String,
                          timeOut: data['toTimeOut'] as String,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 12),
                ] else ...[
                  _buildShiftSection(
                    icon: Icons.work_outline,
                    title: 'Their Shift',
                    department: data['fromDepartment'] as String,
                    station: data['fromStation'] as String,
                    timeIn: data['fromTimeIn'] as String,
                    timeOut: data['fromTimeOut'] as String,
                  ),
                  const SizedBox(height: 12),
                ],

                // Reason
                _buildReasonSection(data['reason'] as String),
              ],
            ),
          ),

          // Status Section with Top Border
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              border: Border(
                top: BorderSide(color: const Color(0xFFE2E8F0), width: 1),
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Approved Statuses (Green)
                _buildApprovedStatusBadges(approvedStatuses),

                // Pending Statuses (Yellow)
                _buildPendingStatusBadges(pendingStatuses),

                // Cancel Button (bottom right, simple red text)
                const SizedBox(height: 4),
                _buildCancelButton(canCancel, requestId),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // Leave Request Status Card
  Widget _buildLeaveStatusCard(Map<String, dynamic> data) {
    final List<String> approvedStatuses =
        (data['approvedStatuses'] as List<dynamic>).cast<String>();
    final List<String> pendingStatuses =
        (data['pendingStatuses'] as List<dynamic>).cast<String>();
    final bool canCancel = data['canCancel'] as bool;
    final String requestId = data['id'] as String;

    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: const Color(0xFFE2E8F0)),
        boxShadow: [
          BoxShadow(
            color: const Color(0xFF000000).withOpacity(0.03),
            blurRadius: 2,
            offset: const Offset(0, 1),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header Badge with Requested Date
          Padding(
            padding: const EdgeInsets.all(12),
            child: Row(
              children: [
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 8,
                    vertical: 4,
                  ),
                  decoration: BoxDecoration(
                    color: const Color(0xFF1E3A8A),
                    borderRadius: BorderRadius.circular(4),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const Icon(
                        Icons.beach_access,
                        color: Colors.white,
                        size: 14,
                      ),
                      const SizedBox(width: 4),
                      const Text(
                        'Leave Request',
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 11,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ],
                  ),
                ),
                const Spacer(),
                Row(
                  children: [
                    const Icon(
                      Icons.access_time,
                      size: 12,
                      color: Color(0xFF94A3B8),
                    ),
                    const SizedBox(width: 4),
                    Text(
                      data['requestedDate'] as String,
                      style: const TextStyle(
                        fontSize: 10,
                        color: const Color(0xFF94A3B8),
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          Divider(
            height: 1,
            color: const Color(0xFFE2E8F0),
            indent: 12,
            endIndent: 12,
          ),

          // Main Content
          Padding(
            padding: const EdgeInsets.all(12),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Requested by
                _buildInfoRow(
                  icon: Icons.person_outline,
                  label: 'Requested by',
                  value: data['fromEmployee'] as String,
                  bold: true,
                ),
                const SizedBox(height: 12),

                // Leave Type
                _buildInfoRow(
                  icon: Icons.category,
                  label: 'Leave Type',
                  value: data['leaveType'] as String,
                ),
                const SizedBox(height: 12),

                // Dates Section
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        const Icon(
                          Icons.calendar_today,
                          size: 14,
                          color: Color(0xFF64748B),
                        ),
                        const SizedBox(width: 8),
                        const Text(
                          'Dates',
                          style: TextStyle(
                            fontSize: 11,
                            fontWeight: FontWeight.w600,
                            color: Color(0xFF1E293B),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 6),
                    Padding(
                      padding: const EdgeInsets.only(left: 22),
                      child: Row(
                        children: [
                          Expanded(
                            child: Container(
                              padding: const EdgeInsets.all(10),
                              decoration: BoxDecoration(
                                color: const Color(0xFFF8FAFC),
                                borderRadius: BorderRadius.circular(6),
                                border: Border.all(
                                  color: const Color(0xFFE2E8F0),
                                ),
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const Text(
                                    'From',
                                    style: TextStyle(
                                      fontSize: 10,
                                      fontWeight: FontWeight.w600,
                                      color: Color(0xFF475569),
                                    ),
                                  ),
                                  const SizedBox(height: 4),
                                  Text(
                                    data['startDate'] as String,
                                    style: const TextStyle(
                                      fontSize: 10,
                                      fontWeight: FontWeight.w700,
                                      color: Color(0xFF1E293B),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          const SizedBox(width: 8),
                          Expanded(
                            child: Container(
                              padding: const EdgeInsets.all(10),
                              decoration: BoxDecoration(
                                color: const Color(0xFFF8FAFC),
                                borderRadius: BorderRadius.circular(6),
                                border: Border.all(
                                  color: const Color(0xFFE2E8F0),
                                ),
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const Text(
                                    'To',
                                    style: TextStyle(
                                      fontSize: 10,
                                      fontWeight: FontWeight.w600,
                                      color: Color(0xFF475569),
                                    ),
                                  ),
                                  const SizedBox(height: 4),
                                  Text(
                                    data['endDate'] as String,
                                    style: const TextStyle(
                                      fontSize: 10,
                                      fontWeight: FontWeight.w700,
                                      color: Color(0xFF1E293B),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 12),

                // Reason
                _buildReasonSection(data['reason'] as String),
              ],
            ),
          ),

          // Status Section with Top Border
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              border: Border(
                top: BorderSide(color: const Color(0xFFE2E8F0), width: 1),
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Approved Statuses (Green) - Usually empty for Leave
                _buildApprovedStatusBadges(approvedStatuses),

                // Pending Statuses (Yellow)
                _buildPendingStatusBadges(pendingStatuses),

                // Cancel Button (bottom right, only shown when status is pending)
                const SizedBox(height: 8),
                _buildCancelButton(canCancel, requestId),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // Off Duty Request Status Card
  Widget _buildOffDutyStatusCard(Map<String, dynamic> data) {
    final List<String> approvedStatuses =
        (data['approvedStatuses'] as List<dynamic>).cast<String>();
    final List<String> pendingStatuses =
        (data['pendingStatuses'] as List<dynamic>).cast<String>();
    final bool canCancel = data['canCancel'] as bool;
    final String requestId = data['id'] as String;

    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: const Color(0xFFE2E8F0)),
        boxShadow: [
          BoxShadow(
            color: const Color(0xFF000000).withOpacity(0.03),
            blurRadius: 2,
            offset: const Offset(0, 1),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header Badge with Requested Date
          Padding(
            padding: const EdgeInsets.all(12),
            child: Row(
              children: [
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 8,
                    vertical: 4,
                  ),
                  decoration: BoxDecoration(
                    color: const Color(0xFF1E3A8A),
                    borderRadius: BorderRadius.circular(4),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const Icon(
                        Icons.event_busy,
                        color: Colors.white,
                        size: 14,
                      ),
                      const SizedBox(width: 4),
                      const Text(
                        'Off Duty Request',
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 11,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ],
                  ),
                ),
                const Spacer(),
                Row(
                  children: [
                    const Icon(
                      Icons.access_time,
                      size: 12,
                      color: Color(0xFF94A3B8),
                    ),
                    const SizedBox(width: 4),
                    Text(
                      data['requestedDate'] as String,
                      style: const TextStyle(
                        fontSize: 10,
                        color: const Color(0xFF94A3B8),
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          Divider(
            height: 1,
            color: const Color(0xFFE2E8F0),
            indent: 12,
            endIndent: 12,
          ),

          // Main Content
          Padding(
            padding: const EdgeInsets.all(12),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Requested by
                _buildInfoRow(
                  icon: Icons.person_outline,
                  label: 'Requested by',
                  value: data['fromEmployee'] as String,
                  bold: true,
                ),
                const SizedBox(height: 12),

                // Date
                _buildInfoRow(
                  icon: Icons.calendar_today,
                  label: 'Date',
                  value: data['date'] as String,
                ),
                const SizedBox(height: 12),

                // Duration
                _buildInfoRow(
                  icon: Icons.schedule,
                  label: 'Duration',
                  value: data['duration'] as String,
                ),
                const SizedBox(height: 12),

                // Reason
                _buildReasonSection(data['reason'] as String),
              ],
            ),
          ),

          // Status Section with Top Border
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              border: Border(
                top: BorderSide(color: const Color(0xFFE2E8F0), width: 1),
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Approved Statuses (Green) - Usually empty for Off Duty
                _buildApprovedStatusBadges(approvedStatuses),

                // Pending Statuses (Yellow)
                _buildPendingStatusBadges(pendingStatuses),

                // Cancel Button (bottom right, only shown when status is pending)
                const SizedBox(height: 8),
                _buildCancelButton(canCancel, requestId),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // Handle cancel request with simple confirmation dialog
  void _handleCancelRequest(String requestId) {
    showDialog(
      context: context,
      builder: (context) => Dialog(
        backgroundColor: Colors.white,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        child: Container(
          constraints: BoxConstraints(minWidth: 300),
          child: Padding(
            padding: const EdgeInsets.fromLTRB(16, 16, 16, 8),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Message
                const Text(
                  'Are you sure you want to cancel this request? This action cannot be undone.',
                  style: TextStyle(
                    fontSize: 14,
                    color: Color(0xFF475569),
                    height: 1.4,
                  ),
                ),

                const SizedBox(height: 12),

                // Buttons at bottom right
                Align(
                  alignment: Alignment.centerRight,
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      TextButton(
                        onPressed: () => Navigator.pop(context),
                        child: const Text(
                          'No, keep it',
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w500,
                            color: Color(0xFF64748B),
                          ),
                        ),
                      ),

                      TextButton(
                        onPressed: () {
                          Navigator.pop(context);
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text('Request $requestId cancelled'),
                              backgroundColor: const Color(0xFFDC2626),
                              duration: const Duration(seconds: 2),
                            ),
                          );
                        },
                        child: const Text(
                          'Yes, Cancel',
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                            color: Color(0xFFDC2626),
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
      ),
    );
  }

  Widget _buildCompletedTab() {
    // Sample data for Completed Tab - All Approved
    final List<dynamic> _completedRequests = [
      // EXAMPLE 1: Swap Schedule - All Approved
      {
        'type': 'Swap',
        'id': 'C1',
        'fromEmployee': 'Jennifer Lee',
        'fromDepartment': 'Drive Thru',
        'fromStation': 'Order Taker',
        'fromTimeIn': '11:00 AM',
        'fromTimeOut': '07:00 PM',
        'toDepartment': 'Front Counter',
        'toStation': 'Counter 2',
        'toTimeIn': '10:00 AM',
        'toTimeOut': '06:00 PM',
        'date': 'Mon, Dec 15',
        'reason': 'Medical appointment in the afternoon',
        'swapPartner': 'Robert Garcia',
        'requestedDate': 'Dec 12, 2024',
        'approvedStatuses': ["Admin Approved", "Scheduler Approved"],
        'pendingStatuses': [],
        'canCancel': false,
      },
      // EXAMPLE 2: Give Away Schedule - All Approved
      {
        'type': 'Give Away',
        'id': 'C2',
        'fromEmployee': 'You',
        'fromDepartment': 'Kitchen',
        'fromStation': 'Grill Station',
        'fromTimeIn': '02:00 PM',
        'fromTimeOut': '10:00 PM',
        'toDepartment': '',
        'toStation': '',
        'toTimeIn': '',
        'toTimeOut': '',
        'date': 'Tue, Dec 16',
        'reason': 'Family wedding ceremony',
        'swapPartner': '',
        'requestedDate': 'Dec 13, 2024',
        'approvedStatuses': [
          "Co-worker Accepted",
          "Admin Approved",
          "Scheduler Approved",
        ],
        'pendingStatuses': [],
        'canCancel': false,
      },
      // EXAMPLE 3: Leave Request - All Approved
      {
        'type': 'Leave',
        'id': 'C3',
        'fromEmployee': 'You',
        'leaveType': 'Annual Leave',
        'startDate': 'Wed, Dec 17',
        'endDate': 'Fri, Dec 19',
        'reason': 'Short vacation with family',
        'requestedDate': 'Dec 14, 2024',
        'approvedStatuses': ["Admin Approved"],
        'pendingStatuses': [],
        'canCancel': false,
      },
      // EXAMPLE 4: Off Duty Request - All Approved
      {
        'type': 'Off Duty',
        'id': 'C4',
        'fromEmployee': 'You',
        'date': 'Sat, Dec 20',
        'duration': '1 Day',
        'reason': 'Personal day off for relocation',
        'requestedDate': 'Dec 15, 2024',
        'approvedStatuses': ["Scheduler Approved"],
        'pendingStatuses': [],
        'canCancel': false,
      },
    ];

    if (_completedRequests.isEmpty) {
      return buildEmptyState(
        icon: Icons.check_circle,
        title: 'No Completed Requests',
        message: 'Your completed requests will appear here',
      );
    }

    return ListView.builder(
      padding: const EdgeInsets.all(12),
      itemCount: _completedRequests.length,
      itemBuilder: (context, index) {
        final item = _completedRequests[index];
        final String type = item['type'] as String;

        if (type == 'Swap' || type == 'Give Away') {
          return _buildCompletedCard(item);
        } else if (type == 'Leave') {
          return _buildCompletedLeaveCard(item);
        } else if (type == 'Off Duty') {
          return _buildCompletedOffDutyCard(item);
        }

        return Container();
      },
    );
  }

  // Completed Swap and Give Away Card - Exactly like Status Tab but with all approved
  Widget _buildCompletedCard(Map<String, dynamic> data) {
    final bool isSwap = data['type'] == 'Swap';
    final List<String> approvedStatuses =
        (data['approvedStatuses'] as List<dynamic>).cast<String>();
    final List<String> pendingStatuses =
        (data['pendingStatuses'] as List<dynamic>).cast<String>();
    final bool canCancel = data['canCancel'] as bool;
    final String requestId = data['id'] as String;

    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: const Color(0xFFE2E8F0)),
        boxShadow: [
          BoxShadow(
            color: const Color(0xFF000000).withOpacity(0.03),
            blurRadius: 2,
            offset: const Offset(0, 1),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header Badge with Requested Date - Exactly like Status Tab
          Padding(
            padding: const EdgeInsets.all(12),
            child: Row(
              children: [
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 8,
                    vertical: 4,
                  ),
                  decoration: BoxDecoration(
                    color: const Color(0xFF1E3A8A),
                    borderRadius: BorderRadius.circular(4),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(
                        isSwap ? Icons.swap_horiz : Icons.gesture,
                        color: Colors.white,
                        size: 14,
                      ),
                      const SizedBox(width: 4),
                      Text(
                        isSwap ? 'Swap Schedule' : 'Give Away Schedule',
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 11,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ],
                  ),
                ),
                const Spacer(),
                Row(
                  children: [
                    const Icon(
                      Icons.access_time,
                      size: 12,
                      color: Color(0xFF94A3B8),
                    ),
                    const SizedBox(width: 4),
                    Text(
                      data['requestedDate'] as String,
                      style: const TextStyle(
                        fontSize: 10,
                        color: Color(0xFF94A3B8),
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          Divider(
            height: 1,
            color: const Color(0xFFE2E8F0),
            indent: 12,
            endIndent: 12,
          ),

          // Main Content - Exactly like Status Tab
          Padding(
            padding: const EdgeInsets.all(12),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Requested by
                _buildInfoRow(
                  icon: Icons.person_outline,
                  label: 'Requested by',
                  value: data['fromEmployee'] as String,
                  bold: true,
                ),
                const SizedBox(height: 12),

                // Date
                _buildInfoRow(
                  icon: Icons.calendar_today,
                  label: isSwap ? 'Swap Date' : 'Schedule Date',
                  value: data['date'] as String,
                ),
                const SizedBox(height: 12),

                // Shifts Section
                if (isSwap) ...[
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        child: _buildSwapShiftSection(
                          icon: Icons.work_outline,
                          title: 'Their Shift',
                          department: data['fromDepartment'] as String,
                          station: data['fromStation'] as String,
                          timeIn: data['fromTimeIn'] as String,
                          timeOut: data['fromTimeOut'] as String,
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: _buildSwapShiftSection(
                          icon: Icons.swap_horiz,
                          title: 'Your Shift',
                          department: data['toDepartment'] as String,
                          station: data['toStation'] as String,
                          timeIn: data['toTimeIn'] as String,
                          timeOut: data['toTimeOut'] as String,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 12),
                ] else ...[
                  _buildShiftSection(
                    icon: Icons.work_outline,
                    title: 'Their Shift',
                    department: data['fromDepartment'] as String,
                    station: data['fromStation'] as String,
                    timeIn: data['fromTimeIn'] as String,
                    timeOut: data['fromTimeOut'] as String,
                  ),
                  const SizedBox(height: 12),
                ],

                // Reason
                _buildReasonSection(data['reason'] as String),
              ],
            ),
          ),

          // Status Section with Top Border - Exactly like Status Tab but with all approved
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              border: Border(
                top: BorderSide(color: const Color(0xFFE2E8F0), width: 1),
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Approved Statuses (Green) - All items here are approved
                _buildApprovedStatusBadges(approvedStatuses),

                // Pending Statuses (Yellow) - Empty for completed tab
                _buildPendingStatusBadges(pendingStatuses),

                // Cancel Button (bottom right) - No cancel for completed items
                const SizedBox(height: 4),
                _buildCancelButton(canCancel, requestId),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // Completed Leave Request Card - Exactly like Status Tab but with all approved
  Widget _buildCompletedLeaveCard(Map<String, dynamic> data) {
    final List<String> approvedStatuses =
        (data['approvedStatuses'] as List<dynamic>).cast<String>();
    final List<String> pendingStatuses =
        (data['pendingStatuses'] as List<dynamic>).cast<String>();
    final bool canCancel = data['canCancel'] as bool;
    final String requestId = data['id'] as String;

    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: const Color(0xFFE2E8F0)),
        boxShadow: [
          BoxShadow(
            color: const Color(0xFF000000).withOpacity(0.03),
            blurRadius: 2,
            offset: const Offset(0, 1),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header Badge with Requested Date - Exactly like Status Tab
          Padding(
            padding: const EdgeInsets.all(12),
            child: Row(
              children: [
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 8,
                    vertical: 4,
                  ),
                  decoration: BoxDecoration(
                    color: const Color(0xFF1E3A8A),
                    borderRadius: BorderRadius.circular(4),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const Icon(
                        Icons.beach_access,
                        color: Colors.white,
                        size: 14,
                      ),
                      const SizedBox(width: 4),
                      const Text(
                        'Leave Request',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 11,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ],
                  ),
                ),
                const Spacer(),
                Row(
                  children: [
                    const Icon(
                      Icons.access_time,
                      size: 12,
                      color: Color(0xFF94A3B8),
                    ),
                    const SizedBox(width: 4),
                    Text(
                      data['requestedDate'] as String,
                      style: const TextStyle(
                        fontSize: 10,
                        color: Color(0xFF94A3B8),
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          Divider(
            height: 1,
            color: const Color(0xFFE2E8F0),
            indent: 12,
            endIndent: 12,
          ),

          // Main Content - Exactly like Status Tab
          Padding(
            padding: const EdgeInsets.all(12),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Requested by
                _buildInfoRow(
                  icon: Icons.person_outline,
                  label: 'Requested by',
                  value: data['fromEmployee'] as String,
                  bold: true,
                ),
                const SizedBox(height: 12),

                // Leave Type
                _buildInfoRow(
                  icon: Icons.category,
                  label: 'Leave Type',
                  value: data['leaveType'] as String,
                ),
                const SizedBox(height: 12),

                // Dates Section
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        const Icon(
                          Icons.calendar_today,
                          size: 14,
                          color: Color(0xFF64748B),
                        ),
                        const SizedBox(width: 8),
                        const Text(
                          'Dates',
                          style: TextStyle(
                            fontSize: 11,
                            fontWeight: FontWeight.w600,
                            color: Color(0xFF1E293B),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 6),
                    Padding(
                      padding: const EdgeInsets.only(left: 22),
                      child: Row(
                        children: [
                          Expanded(
                            child: Container(
                              padding: const EdgeInsets.all(10),
                              decoration: BoxDecoration(
                                color: const Color(0xFFF8FAFC),
                                borderRadius: BorderRadius.circular(6),
                                border: Border.all(
                                  color: const Color(0xFFE2E8F0),
                                ),
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const Text(
                                    'From',
                                    style: TextStyle(
                                      fontSize: 10,
                                      fontWeight: FontWeight.w600,
                                      color: Color(0xFF475569),
                                    ),
                                  ),
                                  const SizedBox(height: 4),
                                  Text(
                                    data['startDate'] as String,
                                    style: const TextStyle(
                                      fontSize: 10,
                                      fontWeight: FontWeight.w700,
                                      color: Color(0xFF1E293B),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          const SizedBox(width: 8),
                          Expanded(
                            child: Container(
                              padding: const EdgeInsets.all(10),
                              decoration: BoxDecoration(
                                color: const Color(0xFFF8FAFC),
                                borderRadius: BorderRadius.circular(6),
                                border: Border.all(
                                  color: const Color(0xFFE2E8F0),
                                ),
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const Text(
                                    'To',
                                    style: TextStyle(
                                      fontSize: 10,
                                      fontWeight: FontWeight.w600,
                                      color: Color(0xFF475569),
                                    ),
                                  ),
                                  const SizedBox(height: 4),
                                  Text(
                                    data['endDate'] as String,
                                    style: const TextStyle(
                                      fontSize: 10,
                                      fontWeight: FontWeight.w700,
                                      color: Color(0xFF1E293B),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 12),

                // Reason
                _buildReasonSection(data['reason'] as String),
              ],
            ),
          ),

          // Status Section with Top Border - Exactly like Status Tab but with all approved
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              border: Border(
                top: BorderSide(color: const Color(0xFFE2E8F0), width: 1),
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Approved Statuses (Green) - All items here are approved
                _buildApprovedStatusBadges(approvedStatuses),

                // Pending Statuses (Yellow) - Empty for completed tab
                _buildPendingStatusBadges(pendingStatuses),

                // Cancel Button (bottom right) - No cancel for completed items
                const SizedBox(height: 8),
                _buildCancelButton(canCancel, requestId),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // Completed Off Duty Request Card - Exactly like Status Tab but with all approved
  Widget _buildCompletedOffDutyCard(Map<String, dynamic> data) {
    final List<String> approvedStatuses =
        (data['approvedStatuses'] as List<dynamic>).cast<String>();
    final List<String> pendingStatuses =
        (data['pendingStatuses'] as List<dynamic>).cast<String>();
    final bool canCancel = data['canCancel'] as bool;
    final String requestId = data['id'] as String;

    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: const Color(0xFFE2E8F0)),
        boxShadow: [
          BoxShadow(
            color: const Color(0xFF000000).withOpacity(0.03),
            blurRadius: 2,
            offset: const Offset(0, 1),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header Badge with Requested Date - Exactly like Status Tab
          Padding(
            padding: const EdgeInsets.all(12),
            child: Row(
              children: [
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 8,
                    vertical: 4,
                  ),
                  decoration: BoxDecoration(
                    color: const Color(0xFF1E3A8A),
                    borderRadius: BorderRadius.circular(4),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const Icon(
                        Icons.event_busy,
                        color: Colors.white,
                        size: 14,
                      ),
                      const SizedBox(width: 4),
                      const Text(
                        'Off Duty Request',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 11,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ],
                  ),
                ),
                const Spacer(),
                Row(
                  children: [
                    const Icon(
                      Icons.access_time,
                      size: 12,
                      color: Color(0xFF94A3B8),
                    ),
                    const SizedBox(width: 4),
                    Text(
                      data['requestedDate'] as String,
                      style: const TextStyle(
                        fontSize: 10,
                        color: Color(0xFF94A3B8),
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          Divider(
            height: 1,
            color: const Color(0xFFE2E8F0),
            indent: 12,
            endIndent: 12,
          ),

          // Main Content - Exactly like Status Tab
          Padding(
            padding: const EdgeInsets.all(12),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Requested by
                _buildInfoRow(
                  icon: Icons.person_outline,
                  label: 'Requested by',
                  value: data['fromEmployee'] as String,
                  bold: true,
                ),
                const SizedBox(height: 12),

                // Date
                _buildInfoRow(
                  icon: Icons.calendar_today,
                  label: 'Date',
                  value: data['date'] as String,
                ),
                const SizedBox(height: 12),

                // Duration
                _buildInfoRow(
                  icon: Icons.schedule,
                  label: 'Duration',
                  value: data['duration'] as String,
                ),
                const SizedBox(height: 12),

                // Reason
                _buildReasonSection(data['reason'] as String),
              ],
            ),
          ),

          // Status Section with Top Border - Exactly like Status Tab but with all approved
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              border: Border(
                top: BorderSide(color: const Color(0xFFE2E8F0), width: 1),
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Approved Statuses (Green) - All items here are approved
                _buildApprovedStatusBadges(approvedStatuses),

                // Pending Statuses (Yellow) - Empty for completed tab
                _buildPendingStatusBadges(pendingStatuses),

                // Cancel Button (bottom right) - No cancel for completed items
                const SizedBox(height: 8),
                _buildCancelButton(canCancel, requestId),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCancelledTab() {
    // Sample data for Cancelled Tab - same format as Status and Completed
    final List<dynamic> _cancelledRequests = [
      // EXAMPLE 1: Swap Schedule - Declined by Co-worker (someone else declined your request)
      {
        'type': 'Swap',
        'id': 'X1',
        'fromEmployee': 'You',
        'fromDepartment': 'Drive Thru',
        'fromStation': 'Cashier',
        'fromTimeIn': '03:00 PM',
        'fromTimeOut': '11:00 PM',
        'toDepartment': 'Front Counter',
        'toStation': 'Counter 1',
        'toTimeIn': '02:00 PM',
        'toTimeOut': '10:00 PM',
        'date': 'Mon, Dec 22',
        'reason': 'Need to attend family gathering',
        'swapPartner': 'Lisa Wong',
        'requestedDate': 'Dec 18, 2024',
        'approvedStatuses': [],
        'pendingStatuses': ["Co-worker Declined"],
        'canCancel': false,
      },
      // EXAMPLE 2: Give Away Schedule - Declined by Admin (admin declined your request)
      {
        'type': 'Give Away',
        'id': 'X2',
        'fromEmployee': 'Maria Garcia',
        'fromDepartment': 'Kitchen',
        'fromStation': 'Prep Station',
        'fromTimeIn': '09:00 AM',
        'fromTimeOut': '05:00 PM',
        'toDepartment': '',
        'toStation': '',
        'toTimeIn': '',
        'toTimeOut': '',
        'date': 'Tue, Dec 23',
        'reason': 'Personal errands to run',
        'swapPartner': '',
        'requestedDate': 'Dec 19, 2024',
        'approvedStatuses': [],
        'pendingStatuses': ["Admin Declined"],
        'canCancel': false,
      },
      // EXAMPLE 3: Swap Schedule - Declined by Scheduler
      {
        'type': 'Swap',
        'id': 'X3',
        'fromEmployee': 'Tom Wilson',
        'fromDepartment': 'Front Counter',
        'fromStation': 'Counter 2',
        'fromTimeIn': '10:00 AM',
        'fromTimeOut': '06:00 PM',
        'toDepartment': 'Drive Thru',
        'toStation': 'Order Taker',
        'toTimeIn': '11:00 AM',
        'toTimeOut': '07:00 PM',
        'date': 'Wed, Dec 24',
        'reason': 'Medical checkup scheduled',
        'swapPartner': 'Emma Davis',
        'requestedDate': 'Dec 20, 2024',
        'approvedStatuses': ["Admin Approved"],
        'pendingStatuses': ["Scheduler Declined"],
        'canCancel': false,
      },
      // EXAMPLE 4: Leave Request - Cancelled by me (I cancelled my own request)
      {
        'type': 'Leave',
        'id': 'X4',
        'fromEmployee': 'You',
        'leaveType': 'Sick Leave',
        'startDate': 'Fri, Dec 26',
        'endDate': 'Mon, Dec 29',
        'reason': 'Not feeling well, doctor advised rest',
        'requestedDate': 'Dec 22, 2024',
        'approvedStatuses': [],
        'pendingStatuses': ["Cancelled"],
        'canCancel': false,
      },
      // EXAMPLE 5: Off Duty Request - Declined by Admin
      {
        'type': 'Off Duty',
        'id': 'X5',
        'fromEmployee': 'You',
        'date': 'Tue, Dec 30',
        'duration': '1 Day',
        'reason': 'Need personal day for home repairs',
        'requestedDate': 'Dec 23, 2024',
        'approvedStatuses': [],
        'pendingStatuses': ["Scheduler Declined"],
        'canCancel': false,
      },
      // EXAMPLE 6: Give Away Schedule - Cancelled by me (I cancelled my own request)
      {
        'type': 'Give Away',
        'id': 'X6',
        'fromEmployee': 'James Miller',
        'fromDepartment': 'Drive Thru',
        'fromStation': 'Presenter',
        'fromTimeIn': '01:00 PM',
        'fromTimeOut': '09:00 PM',
        'toDepartment': '',
        'toStation': '',
        'toTimeIn': '',
        'toTimeOut': '',
        'date': 'Thu, Dec 25',
        'reason': 'Unexpected personal commitment',
        'swapPartner': '',
        'requestedDate': 'Dec 21, 2024',
        'approvedStatuses': ["Admin Approved"],
        'pendingStatuses': ["Scheduler Declined"],
        'canCancel': false,
      },
      // EXAMPLE 7: Off Duty Request - Declined by Scheduler
      {
        'type': 'Off Duty',
        'id': 'X7',
        'fromEmployee': 'You',
        'date': 'Sat, Jan 4',
        'duration': '2 Days',
        'reason': 'Weekend family event',
        'requestedDate': 'Dec 25, 2024',
        'approvedStatuses': [],
        'pendingStatuses': ["Scheduler Declined"],
        'canCancel': false,
      },
      // EXAMPLE 8: Leave Request - Declined by Admin
      {
        'type': 'Leave',
        'id': 'X8',
        'fromEmployee': 'You',
        'leaveType': 'Annual Leave',
        'startDate': 'Wed, Jan 1',
        'endDate': 'Fri, Jan 3',
        'reason': 'Changed vacation plans',
        'requestedDate': 'Dec 24, 2024',
        'approvedStatuses': [],
        'pendingStatuses': ["Admin Declined"],
        'canCancel': false,
      },
    ];

    if (_cancelledRequests.isEmpty) {
      return buildEmptyState(
        icon: Icons.cancel,
        title: 'No Cancelled Requests',
        message: 'Cancelled requests will appear here',
      );
    }

    return ListView.builder(
      padding: const EdgeInsets.all(12),
      itemCount: _cancelledRequests.length,
      itemBuilder: (context, index) {
        final item = _cancelledRequests[index];
        final String type = item['type'] as String;

        if (type == 'Swap' || type == 'Give Away') {
          return _buildCancelledCard(item);
        } else if (type == 'Leave') {
          return _buildCancelledLeaveCard(item);
        } else if (type == 'Off Duty') {
          return _buildCancelledOffDutyCard(item);
        }

        return Container();
      },
    );
  }

  // Helper method: Build cancelled status badges (using pendingStatuses but with red color)
  Widget _buildCancelledStatusBadges(List<String> cancelledStatuses) {
    if (cancelledStatuses.isEmpty) return const SizedBox.shrink();

    return Column(
      children: cancelledStatuses.map((status) {
        return Padding(
          padding: const EdgeInsets.only(bottom: 6),
          child: Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
            decoration: BoxDecoration(
              color: const Color(0xFFFEE2E2), // Light red background
              borderRadius: BorderRadius.circular(4),
              border: Border.all(
                color: const Color(0xFFDC2626), // Red border
                width: 0.5,
              ),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(
                  Icons.cancel,
                  size: 12,
                  color: const Color(0xFFDC2626), // Red icon
                ),
                const SizedBox(width: 6),
                Text(
                  status,
                  style: const TextStyle(
                    fontSize: 10,
                    fontWeight: FontWeight.w600,
                    color: const Color(0xFF991B1B), // Dark red text
                  ),
                ),
              ],
            ),
          ),
        );
      }).toList(),
    );
  }

  // Cancelled Swap and Give Away Card - EXACTLY like Status Tab
  Widget _buildCancelledCard(Map<String, dynamic> data) {
    final bool isSwap = data['type'] == 'Swap';
    final List<String> approvedStatuses =
        (data['approvedStatuses'] as List<dynamic>).cast<String>();
    final List<String> pendingStatuses =
        (data['pendingStatuses'] as List<dynamic>).cast<String>();
    final bool canCancel = data['canCancel'] as bool;
    final String requestId = data['id'] as String;

    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: const Color(0xFFE2E8F0)),
        boxShadow: [
          BoxShadow(
            color: const Color(0xFF000000).withOpacity(0.03),
            blurRadius: 2,
            offset: const Offset(0, 1),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header Badge with Requested Date - Exactly like Status Tab
          Padding(
            padding: const EdgeInsets.all(12),
            child: Row(
              children: [
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 8,
                    vertical: 4,
                  ),
                  decoration: BoxDecoration(
                    color: const Color(0xFF1E3A8A),
                    borderRadius: BorderRadius.circular(4),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(
                        isSwap ? Icons.swap_horiz : Icons.gesture,
                        color: Colors.white,
                        size: 14,
                      ),
                      const SizedBox(width: 4),
                      Text(
                        isSwap ? 'Swap Schedule' : 'Give Away Schedule',
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 11,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ],
                  ),
                ),
                const Spacer(),
                Row(
                  children: [
                    const Icon(
                      Icons.access_time,
                      size: 12,
                      color: Color(0xFF94A3B8),
                    ),
                    const SizedBox(width: 4),
                    Text(
                      data['requestedDate'] as String,
                      style: const TextStyle(
                        fontSize: 10,
                        color: Color(0xFF94A3B8),
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          Divider(
            height: 1,
            color: const Color(0xFFE2E8F0),
            indent: 12,
            endIndent: 12,
          ),

          // Main Content - Exactly like Status Tab
          Padding(
            padding: const EdgeInsets.all(12),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Requested by
                _buildInfoRow(
                  icon: Icons.person_outline,
                  label: 'Requested by',
                  value: data['fromEmployee'] as String,
                  bold: true,
                ),
                const SizedBox(height: 12),

                // Date
                _buildInfoRow(
                  icon: Icons.calendar_today,
                  label: isSwap ? 'Swap Date' : 'Schedule Date',
                  value: data['date'] as String,
                ),
                const SizedBox(height: 12),

                // Shifts Section
                if (isSwap) ...[
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        child: _buildSwapShiftSection(
                          icon: Icons.work_outline,
                          title: 'Their Shift',
                          department: data['fromDepartment'] as String,
                          station: data['fromStation'] as String,
                          timeIn: data['fromTimeIn'] as String,
                          timeOut: data['fromTimeOut'] as String,
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: _buildSwapShiftSection(
                          icon: Icons.swap_horiz,
                          title: 'Your Shift',
                          department: data['toDepartment'] as String,
                          station: data['toStation'] as String,
                          timeIn: data['toTimeIn'] as String,
                          timeOut: data['toTimeOut'] as String,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 12),
                ] else ...[
                  _buildShiftSection(
                    icon: Icons.work_outline,
                    title: 'Their Shift',
                    department: data['fromDepartment'] as String,
                    station: data['fromStation'] as String,
                    timeIn: data['fromTimeIn'] as String,
                    timeOut: data['fromTimeOut'] as String,
                  ),
                  const SizedBox(height: 12),
                ],

                // Reason
                _buildReasonSection(data['reason'] as String),
              ],
            ),
          ),

          // Status Section with Top Border - Exactly like Status Tab but with cancelled statuses
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              border: Border(
                top: BorderSide(color: const Color(0xFFE2E8F0), width: 1),
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Approved Statuses (Green) - Empty for cancelled tab
                _buildApprovedStatusBadges(approvedStatuses),

                // Cancelled Statuses (Red) - Using pendingStatuses data but styled as cancelled
                _buildCancelledStatusBadges(pendingStatuses),

                // Cancel Button (bottom right) - No cancel for cancelled items
                const SizedBox(height: 4),
                _buildCancelButton(canCancel, requestId),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // Cancelled Leave Request Card - EXACTLY like Status Tab
  Widget _buildCancelledLeaveCard(Map<String, dynamic> data) {
    final List<String> approvedStatuses =
        (data['approvedStatuses'] as List<dynamic>).cast<String>();
    final List<String> pendingStatuses =
        (data['pendingStatuses'] as List<dynamic>).cast<String>();
    final bool canCancel = data['canCancel'] as bool;
    final String requestId = data['id'] as String;

    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: const Color(0xFFE2E8F0)),
        boxShadow: [
          BoxShadow(
            color: const Color(0xFF000000).withOpacity(0.03),
            blurRadius: 2,
            offset: const Offset(0, 1),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header Badge with Requested Date - Exactly like Status Tab
          Padding(
            padding: const EdgeInsets.all(12),
            child: Row(
              children: [
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 8,
                    vertical: 4,
                  ),
                  decoration: BoxDecoration(
                    color: const Color(0xFF1E3A8A),
                    borderRadius: BorderRadius.circular(4),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const Icon(
                        Icons.beach_access,
                        color: Colors.white,
                        size: 14,
                      ),
                      const SizedBox(width: 4),
                      const Text(
                        'Leave Request',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 11,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ],
                  ),
                ),
                const Spacer(),
                Row(
                  children: [
                    const Icon(
                      Icons.access_time,
                      size: 12,
                      color: Color(0xFF94A3B8),
                    ),
                    const SizedBox(width: 4),
                    Text(
                      data['requestedDate'] as String,
                      style: const TextStyle(
                        fontSize: 10,
                        color: Color(0xFF94A3B8),
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          Divider(
            height: 1,
            color: const Color(0xFFE2E8F0),
            indent: 12,
            endIndent: 12,
          ),

          // Main Content - Exactly like Status Tab
          Padding(
            padding: const EdgeInsets.all(12),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Requested by
                _buildInfoRow(
                  icon: Icons.person_outline,
                  label: 'Requested by',
                  value: data['fromEmployee'] as String,
                  bold: true,
                ),
                const SizedBox(height: 12),

                // Leave Type
                _buildInfoRow(
                  icon: Icons.category,
                  label: 'Leave Type',
                  value: data['leaveType'] as String,
                ),
                const SizedBox(height: 12),

                // Dates Section
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        const Icon(
                          Icons.calendar_today,
                          size: 14,
                          color: Color(0xFF64748B),
                        ),
                        const SizedBox(width: 8),
                        const Text(
                          'Dates',
                          style: TextStyle(
                            fontSize: 11,
                            fontWeight: FontWeight.w600,
                            color: Color(0xFF1E293B),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 6),
                    Padding(
                      padding: const EdgeInsets.only(left: 22),
                      child: Row(
                        children: [
                          Expanded(
                            child: Container(
                              padding: const EdgeInsets.all(10),
                              decoration: BoxDecoration(
                                color: const Color(0xFFF8FAFC),
                                borderRadius: BorderRadius.circular(6),
                                border: Border.all(
                                  color: const Color(0xFFE2E8F0),
                                ),
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const Text(
                                    'From',
                                    style: TextStyle(
                                      fontSize: 10,
                                      fontWeight: FontWeight.w600,
                                      color: Color(0xFF475569),
                                    ),
                                  ),
                                  const SizedBox(height: 4),
                                  Text(
                                    data['startDate'] as String,
                                    style: const TextStyle(
                                      fontSize: 10,
                                      fontWeight: FontWeight.w700,
                                      color: Color(0xFF1E293B),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          const SizedBox(width: 8),
                          Expanded(
                            child: Container(
                              padding: const EdgeInsets.all(10),
                              decoration: BoxDecoration(
                                color: const Color(0xFFF8FAFC),
                                borderRadius: BorderRadius.circular(6),
                                border: Border.all(
                                  color: const Color(0xFFE2E8F0),
                                ),
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const Text(
                                    'To',
                                    style: TextStyle(
                                      fontSize: 10,
                                      fontWeight: FontWeight.w600,
                                      color: Color(0xFF475569),
                                    ),
                                  ),
                                  const SizedBox(height: 4),
                                  Text(
                                    data['endDate'] as String,
                                    style: const TextStyle(
                                      fontSize: 10,
                                      fontWeight: FontWeight.w700,
                                      color: Color(0xFF1E293B),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 12),

                // Reason
                _buildReasonSection(data['reason'] as String),
              ],
            ),
          ),

          // Status Section with Top Border - Exactly like Status Tab but with cancelled statuses
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              border: Border(
                top: BorderSide(color: const Color(0xFFE2E8F0), width: 1),
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Approved Statuses (Green) - Empty for cancelled tab
                _buildApprovedStatusBadges(approvedStatuses),

                // Cancelled Statuses (Red) - Using pendingStatuses data but styled as cancelled
                _buildCancelledStatusBadges(pendingStatuses),

                // Cancel Button (bottom right) - No cancel for cancelled items
                const SizedBox(height: 8),
                _buildCancelButton(canCancel, requestId),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // Cancelled Off Duty Request Card - EXACTLY like Status Tab
  Widget _buildCancelledOffDutyCard(Map<String, dynamic> data) {
    final List<String> approvedStatuses =
        (data['approvedStatuses'] as List<dynamic>).cast<String>();
    final List<String> pendingStatuses =
        (data['pendingStatuses'] as List<dynamic>).cast<String>();
    final bool canCancel = data['canCancel'] as bool;
    final String requestId = data['id'] as String;

    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: const Color(0xFFE2E8F0)),
        boxShadow: [
          BoxShadow(
            color: const Color(0xFF000000).withOpacity(0.03),
            blurRadius: 2,
            offset: const Offset(0, 1),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header Badge with Requested Date - Exactly like Status Tab
          Padding(
            padding: const EdgeInsets.all(12),
            child: Row(
              children: [
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 8,
                    vertical: 4,
                  ),
                  decoration: BoxDecoration(
                    color: const Color(0xFF1E3A8A),
                    borderRadius: BorderRadius.circular(4),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const Icon(
                        Icons.event_busy,
                        color: Colors.white,
                        size: 14,
                      ),
                      const SizedBox(width: 4),
                      const Text(
                        'Off Duty Request',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 11,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ],
                  ),
                ),
                const Spacer(),
                Row(
                  children: [
                    const Icon(
                      Icons.access_time,
                      size: 12,
                      color: Color(0xFF94A3B8),
                    ),
                    const SizedBox(width: 4),
                    Text(
                      data['requestedDate'] as String,
                      style: const TextStyle(
                        fontSize: 10,
                        color: Color(0xFF94A3B8),
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          Divider(
            height: 1,
            color: const Color(0xFFE2E8F0),
            indent: 12,
            endIndent: 12,
          ),

          // Main Content - Exactly like Status Tab
          Padding(
            padding: const EdgeInsets.all(12),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Requested by
                _buildInfoRow(
                  icon: Icons.person_outline,
                  label: 'Requested by',
                  value: data['fromEmployee'] as String,
                  bold: true,
                ),
                const SizedBox(height: 12),

                // Date
                _buildInfoRow(
                  icon: Icons.calendar_today,
                  label: 'Date',
                  value: data['date'] as String,
                ),
                const SizedBox(height: 12),

                // Duration
                _buildInfoRow(
                  icon: Icons.schedule,
                  label: 'Duration',
                  value: data['duration'] as String,
                ),
                const SizedBox(height: 12),

                // Reason
                _buildReasonSection(data['reason'] as String),
              ],
            ),
          ),

          // Status Section with Top Border - Exactly like Status Tab but with cancelled statuses
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              border: Border(
                top: BorderSide(color: const Color(0xFFE2E8F0), width: 1),
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Approved Statuses (Green) - Empty for cancelled tab
                _buildApprovedStatusBadges(approvedStatuses),

                // Cancelled Statuses (Red) - Using pendingStatuses data but styled as cancelled
                _buildCancelledStatusBadges(pendingStatuses),

                // Cancel Button (bottom right) - No cancel for cancelled items
                const SizedBox(height: 8),
                _buildCancelButton(canCancel, requestId),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

// Data Model for Requests
class Request {
  final String id;
  final String type; // 'Swap' or 'Give Away'
  final String fromEmployee;
  final String fromDepartment;
  final String fromStation;
  final String fromTimeIn;
  final String fromTimeOut;
  final String toDepartment; // For swaps only
  final String toStation; // For swaps only
  final String toTimeIn; // For swaps only
  final String toTimeOut; // For swaps only
  final String date;
  final String reason;
  final String swapPartner; // For swaps only
  final String requestedDate;

  Request({
    required this.id,
    required this.type,
    required this.fromEmployee,
    required this.fromDepartment,
    required this.fromStation,
    required this.fromTimeIn,
    required this.fromTimeOut,
    required this.toDepartment,
    required this.toStation,
    required this.toTimeIn,
    required this.toTimeOut,
    required this.date,
    required this.reason,
    required this.swapPartner,
    required this.requestedDate,
  });
}

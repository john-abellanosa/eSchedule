import 'package:flutter/material.dart';

class ManagerRequestPage extends StatefulWidget {
  const ManagerRequestPage({Key? key}) : super(key: key);

  @override
  State<ManagerRequestPage> createState() => _ManagerRequestPageState();
}

class _ManagerRequestPageState extends State<ManagerRequestPage>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  // Color coding for different request types
  final Map<String, Color> _requestColors = {
    'Leave': Color(0xFF3B82F6), // Blue
    'Swap': Color(0xFF8B5CF6), // Purple
    'Give Away': Color(0xFF10B981), // Green
  };

  // Sample data - My Requests
  final List<Request> _myRequests = [
    Request(
      id: '1',
      type: 'Leave',
      title: 'Annual Leave',
      date: 'Dec 24 - 26, 2025',
      duration: '3 days',
      status: 'Pending',
      statusColor: Color(0xFFF59E0B),
      employee: 'You',
      reason: 'Christmas holiday with family',
    ),
    Request(
      id: '2',
      type: 'Swap',
      title: 'Swap with Sarah Johnson',
      date: 'Dec 22, 2025',
      duration: '2PM-10PM ↔ 6AM-2PM',
      status: 'Awaiting Co-worker',
      statusColor: Color(0xFF8B5CF6),
      employee: 'You ↔ Sarah',
      reason: 'Morning appointment',
    ),
    Request(
      id: '3',
      type: 'Give Away',
      title: 'Give to Mike Chen',
      date: 'Dec 21, 2025',
      duration: '6AM-2PM',
      status: 'Pending',
      statusColor: Color(0xFFF59E0B),
      employee: 'You',
      reason: 'Family emergency',
    ),
  ];

  // Sample data - Swap Offers
  final List<SwapOffer> _swapOffers = [
    SwapOffer(
      id: '1',
      fromEmployee: 'Leo Martinez',
      position: 'Kitchen Staff',
      date: 'Dec 20, 2025',
      time: '8:00 AM - 4:00 PM',
      reason: 'Family event - need different shift',
      status: 'Pending',
    ),
    SwapOffer(
      id: '2',
      fromEmployee: 'Sarah Johnson',
      position: 'Front Counter',
      date: 'Dec 22, 2025',
      time: '2:00 PM - 10:00 PM',
      reason: 'Doctor appointment in the morning',
      status: 'Pending',
    ),
  ];

  // Sample data - Give Away Offers
  final List<GiveAwayOffer> _giveAwayOffers = [
    GiveAwayOffer(
      id: '1',
      fromEmployee: 'Mike Chen',
      position: 'Drive-Thru',
      date: 'Dec 21, 2025',
      time: '6:00 AM - 2:00 PM',
      reason: 'Family emergency out of town',
      status: 'Pending',
    ),
  ];

  // Sample data - For Approval
  final List<ApprovalRequest> _pendingApproval = [
    ApprovalRequest(
      id: '1',
      type: 'Leave',
      employee: 'Mike Chen',
      details: 'Annual Leave - Dec 28-30, 2025',
      status: 'Pending',
      statusColor: Color(0xFFF59E0B),
      submittedDate: 'Today, 9:30 AM',
      reason: 'Year-end vacation',
    ),
    ApprovalRequest(
      id: '2',
      type: 'Swap',
      employee: 'Leo Martinez ↔ Sarah Johnson',
      details: 'Dec 20, 2025 • 8AM-4PM ↔ 2PM-10PM',
      status: 'Approved',
      statusColor: Color(0xFF10B981),
      submittedDate: 'Yesterday, 3:45 PM',
      reason: 'Shift preference adjustment',
    ),
    ApprovalRequest(
      id: '3',
      type: 'Give Away',
      employee: 'James Wilson to Alex Brown',
      details: 'Dec 23, 2025 • 2:00 PM - 10:00 PM',
      status: 'Pending',
      statusColor: Color(0xFFF59E0B),
      submittedDate: '2 days ago',
      reason: 'Family commitment',
    ),
  ];

  // Sample data - History
  final List<HistoryItem> _historyItems = [
    HistoryItem(
      id: 'H001',
      type: 'Leave',
      title: 'Annual Leave Approved',
      date: 'Dec 18, 2025',
      time: '10:15 AM',
      status: 'Approved',
      statusColor: Color(0xFF10B981),
      details: 'Your leave request for Dec 24-26 has been approved',
      action: 'By: Manager Smith',
    ),
    HistoryItem(
      id: 'H002',
      type: 'Swap',
      title: 'Swap Request Declined',
      date: 'Dec 17, 2025',
      time: '3:30 PM',
      status: 'Declined',
      statusColor: Color(0xFFEF4444),
      details: 'Swap with Mike Chen on Dec 22 was declined',
      action: 'Reason: Schedule conflict',
    ),
    HistoryItem(
      id: 'H003',
      type: 'Give Away',
      title: 'Shift Taken',
      date: 'Dec 16, 2025',
      time: '11:45 AM',
      status: 'Completed',
      statusColor: Color(0xFF3B82F6),
      details: 'You took Sarah\'s shift on Dec 21',
      action: '6:00 AM - 2:00 PM • Drive-Thru',
    ),
    HistoryItem(
      id: 'H004',
      type: 'Leave',
      title: 'Leave Request Cancelled',
      date: 'Dec 15, 2025',
      time: '9:20 AM',
      status: 'Cancelled',
      statusColor: Color(0xFFEF4444),
      details: 'You cancelled your leave request for Dec 18',
      action: 'Personal reason',
    ),
    HistoryItem(
      id: 'H005',
      type: 'Swap',
      title: 'Swap Completed',
      date: 'Dec 14, 2025',
      time: '2:00 PM',
      status: 'Completed',
      statusColor: Color(0xFF10B981),
      details: 'Successfully swapped with Rachel Green',
      action: 'Dec 20 • 2PM-10PM ↔ 6AM-2PM',
    ),
  ];

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 5, vsync: this);
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
        backgroundColor: const Color(0xFF1E3A8A),
        elevation: 0,
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Manage Requests',
              style: TextStyle(
                color: Colors.white,
                fontSize: 18,
                fontWeight: FontWeight.w600,
              ),
            ),
            // const SizedBox(height: 2),
            // Text(
            //   'Manage all your shift requests here',
            //   style: TextStyle(
            //     color: Colors.white.withOpacity(0.85),
            //     fontSize: 12,
            //     fontWeight: FontWeight.w400,
            //   ),
            // ),
          ],
        ),
        actions: [
          IconButton(
            onPressed: () => _showNewRequestDialog(context),
            icon: const Icon(Icons.add, color: Colors.white),
            tooltip: 'New Request',
          ),
          const SizedBox(width: 8),
        ],
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(48),
          child: Container(
            color: const Color(0xFF1E3A8A),
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
              isScrollable: true,
              padding: EdgeInsets.zero, // Remove default padding
              indicatorPadding: EdgeInsets.zero, // Remove indicator padding
              tabAlignment: TabAlignment.start, // Align tabs to start
              tabs: const [
                Tab(text: 'My Requests'),
                Tab(text: 'Swap Offers'),
                Tab(text: 'Shift Offers'),
                Tab(text: 'Admin/RGM Approval'),
                Tab(text: 'History'),
              ],
            ),
          ),
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          _buildMyRequestsTab(),
          _buildSwapOffersTab(),
          _buildGiveAwayOffersTab(),
          _buildForApprovalTab(),
          _buildHistoryTab(),
        ],
      ),
    );
  }

  Widget _buildMyRequestsTab() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          _sectionHeader('My Requests'),
          const SizedBox(height: 16),
          if (_myRequests.isEmpty)
            _buildEmptyState(
              icon: Icons.description,
              title: 'No Active Requests',
              message: 'You don\'t have any active requests',
            )
          else
            ..._myRequests.map(
              (request) => Padding(
                padding: const EdgeInsets.only(bottom: 12),
                child: _buildRequestCard(request),
              ),
            ),
        ],
      ),
    );
  }

  Widget _buildSwapOffersTab() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          _sectionHeader('Swap Offers for You'),
          const SizedBox(height: 16),
          if (_swapOffers.isEmpty)
            _buildEmptyState(
              icon: Icons.swap_horiz,
              title: 'No Swap Offers',
              message: 'No one is offering to swap shifts with you',
            )
          else
            ..._swapOffers.map(
              (offer) => Padding(
                padding: const EdgeInsets.only(bottom: 12),
                child: _buildSwapOfferCard(offer),
              ),
            ),
        ],
      ),
    );
  }

  Widget _buildGiveAwayOffersTab() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          _sectionHeader('Shift Offers for You'),
          const SizedBox(height: 16),
          if (_giveAwayOffers.isEmpty)
            _buildEmptyState(
              icon: Icons.gesture,
              title: 'No Shift Offers',
              message: 'No one is giving away shifts to you',
            )
          else
            ..._giveAwayOffers.map(
              (offer) => Padding(
                padding: const EdgeInsets.only(bottom: 12),
                child: _buildGiveAwayOfferCard(offer),
              ),
            ),
        ],
      ),
    );
  }

  Widget _buildForApprovalTab() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          _sectionHeader('Requests for Approval'),
          const SizedBox(height: 16),
          if (_pendingApproval.isEmpty)
            _buildEmptyState(
              icon: Icons.approval,
              title: 'No Pending Approvals',
              message: 'No requests require your approval',
            )
          else
            ..._pendingApproval.map(
              (request) => Padding(
                padding: const EdgeInsets.only(bottom: 12),
                child: _buildApprovalCard(request),
              ),
            ),
        ],
      ),
    );
  }

  Widget _buildHistoryTab() {
    return Column(
      children: [
        // History Header
        Container(
          padding: const EdgeInsets.fromLTRB(16, 0, 12, 0),
          decoration: BoxDecoration(
            color: Colors.white,
            border: Border(bottom: BorderSide(color: const Color(0xFFE2E8F0))),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                'Request History',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  color: Color(0xFF1E293B),
                ),
              ),
              IconButton(
                onPressed: () => _showFilterDialog(context),
                icon: Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: const Color(0xFFF1F5F9),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: const Icon(
                    Icons.filter_list,
                    size: 20,
                    color: Color(0xFF475569),
                  ),
                ),
              ),
            ],
          ),
        ),

        // History List
        Expanded(
          child: ListView.separated(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
            separatorBuilder: (context, index) => const SizedBox(height: 12),
            itemCount: _historyItems.length,
            itemBuilder: (context, index) {
              final historyItem = _historyItems[index];
              return _buildHistoryCard(historyItem);
            },
          ),
        ),
      ],
    );
  }

  void _showFilterDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) {
        return Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          backgroundColor: Colors.white,
          child: Container(
            padding: const EdgeInsets.all(20),
            width: MediaQuery.of(context).size.width * 0.9,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Header
                const Row(
                  children: [
                    Icon(Icons.filter_alt, color: Color(0xFF1E3A8A), size: 20),
                    SizedBox(width: 8),
                    Text(
                      'Filter History',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                        color: Color(0xFF1E293B),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 20),

                // Filter by Request Type
                const Text(
                  'Request Type',
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: Color(0xFF1E293B),
                  ),
                ),
                const SizedBox(height: 12),

                // Request Type Chips
                Wrap(
                  spacing: 8,
                  runSpacing: 8,
                  children: [
                    _filterChip('All', true, const Color(0xFF1E3A8A)),
                    _filterChip('Leave', false, const Color(0xFF3B82F6)),
                    _filterChip('Swap', false, const Color(0xFF8B5CF6)),
                    _filterChip('Give Away', false, const Color(0xFF10B981)),
                  ],
                ),

                const SizedBox(height: 24),

                // Filter by Status
                const Text(
                  'Status',
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: Color(0xFF1E293B),
                  ),
                ),
                const SizedBox(height: 12),

                // Status Chips
                Wrap(
                  spacing: 8,
                  runSpacing: 8,
                  children: [
                    _filterChip('All', true, const Color(0xFF1E3A8A)),
                    _filterChip('Approved', false, const Color(0xFF10B981)),
                    _filterChip('Declined', false, const Color(0xFFEF4444)),
                    _filterChip('Cancelled', false, const Color(0xFFEF4444)),
                    _filterChip('Pending', false, const Color(0xFFF59E0B)),
                  ],
                ),

                const SizedBox(height: 32),

                // Action Buttons
                Row(
                  children: [
                    Expanded(
                      child: OutlinedButton(
                        onPressed: () => Navigator.pop(context),
                        style: OutlinedButton.styleFrom(
                          foregroundColor: const Color(0xFF64748B),
                          side: const BorderSide(color: Color(0xFFE2E8F0)),
                          padding: const EdgeInsets.symmetric(vertical: 12),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                        child: const Text(
                          'Clear All',
                          style: TextStyle(fontWeight: FontWeight.w600),
                        ),
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: ElevatedButton(
                        onPressed: () => Navigator.pop(context),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFF1E3A8A),
                          foregroundColor: Colors.white,
                          padding: const EdgeInsets.symmetric(vertical: 12),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                        child: const Text(
                          'Apply Filters',
                          style: TextStyle(fontWeight: FontWeight.w600),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _filterChip(String label, bool isSelected, Color color) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      decoration: BoxDecoration(
        color: isSelected ? color : Colors.white,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: isSelected ? color : const Color(0xFFE2E8F0),
          width: 1.5,
        ),
      ),
      child: Text(
        label,
        style: TextStyle(
          fontSize: 13,
          fontWeight: FontWeight.w600,
          color: isSelected ? Colors.white : const Color(0xFF475569),
        ),
      ),
    );
  }

  Widget _historySummaryCard({
    required String count,
    required String label,
    required String subLabel,
    required Color color,
    required List<Color> gradientColors,
    required IconData icon,
  }) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: gradientColors,
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: color.withOpacity(0.3),
            blurRadius: 12,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                width: 32,
                height: 32,
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.2),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Icon(icon, color: Colors.white, size: 18),
              ),
              const Spacer(),
              Text(
                count,
                style: const TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.w800,
                  color: Colors.white,
                  height: 1,
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          Text(
            label,
            style: const TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w600,
              color: Colors.white,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            subLabel,
            style: TextStyle(
              fontSize: 11,
              fontWeight: FontWeight.w500,
              color: Colors.white.withOpacity(0.9),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildHistoryCard(HistoryItem item) {
    Color typeColor = _requestColors[item.type] ?? const Color(0xFF64748B);

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: const Color(0xFFE2E8F0)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                decoration: BoxDecoration(
                  color: typeColor.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(4),
                ),
                child: Text(
                  item.type,
                  style: TextStyle(
                    fontSize: 11,
                    color: typeColor,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                decoration: BoxDecoration(
                  color: item.statusColor.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(4),
                ),
                child: Text(
                  item.status,
                  style: TextStyle(
                    fontSize: 11,
                    color: item.statusColor,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Text(
            item.title,
            style: const TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.w600,
              color: Color(0xFF1E293B),
            ),
          ),
          const SizedBox(height: 8),
          Row(
            children: [
              const Icon(
                Icons.calendar_today,
                size: 12,
                color: Color(0xFF64748B),
              ),
              const SizedBox(width: 4),
              Text(
                item.date,
                style: const TextStyle(fontSize: 12, color: Color(0xFF64748B)),
              ),
              const SizedBox(width: 8),
              const Icon(Icons.access_time, size: 12, color: Color(0xFF64748B)),
              const SizedBox(width: 4),
              Text(
                item.time,
                style: const TextStyle(fontSize: 12, color: Color(0xFF64748B)),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Text(
            item.details,
            style: const TextStyle(fontSize: 13, color: Color(0xFF475569)),
          ),
          const SizedBox(height: 8),
          Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: const Color(0xFFF8FAFC),
              borderRadius: BorderRadius.circular(6),
            ),
            child: Row(
              children: [
                Icon(
                  _getHistoryIcon(item.type, item.status),
                  size: 14,
                  color: const Color(0xFF64748B),
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: Text(
                    item.action,
                    style: const TextStyle(
                      fontSize: 12,
                      color: Color(0xFF64748B),
                    ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 12),
          Align(
            alignment: Alignment.centerRight,
            child: Text(
              'ID: ${item.id}',
              style: const TextStyle(fontSize: 11, color: Color(0xFF94A3B8)),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildRequestCard(Request request) {
    Color typeColor = _requestColors[request.type] ?? const Color(0xFF64748B);

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: const Color(0xFFE2E8F0)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                decoration: BoxDecoration(
                  color: typeColor.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(4),
                ),
                child: Text(
                  request.type,
                  style: TextStyle(
                    fontSize: 12,
                    color: typeColor,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                decoration: BoxDecoration(
                  color: request.statusColor.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(4),
                ),
                child: Text(
                  request.status,
                  style: TextStyle(
                    fontSize: 12,
                    color: request.statusColor,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Text(
            request.title,
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w700,
              color: Color(0xFF1E293B),
            ),
          ),
          const SizedBox(height: 8),
          Row(
            children: [
              const Icon(
                Icons.calendar_today,
                size: 14,
                color: Color(0xFF64748B),
              ),
              const SizedBox(width: 4),
              Text(
                request.date,
                style: const TextStyle(fontSize: 13, color: Color(0xFF475569)),
              ),
              const SizedBox(width: 12),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                decoration: BoxDecoration(
                  color: const Color(0xFF1E3A8A).withOpacity(0.1),
                  borderRadius: BorderRadius.circular(4),
                ),
                child: Text(
                  request.duration,
                  style: const TextStyle(
                    fontSize: 12,
                    color: Color(0xFF1E3A8A),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Text(
            request.reason,
            style: const TextStyle(fontSize: 13, color: Color(0xFF64748B)),
          ),
          const SizedBox(height: 12),
          Row(
            children: [
              Expanded(
                child: OutlinedButton(
                  onPressed: () => _showCancelConfirmation(context),
                  style: OutlinedButton.styleFrom(
                    foregroundColor: const Color(0xFF64748B),
                    side: const BorderSide(color: Color(0xFFE2E8F0)),
                    padding: const EdgeInsets.symmetric(vertical: 8),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(6),
                    ),
                  ),
                  child: const Text('Cancel', style: TextStyle(fontSize: 13)),
                ),
              ),
              const SizedBox(width: 8),
              Expanded(
                child: ElevatedButton(
                  onPressed: () => _showEditForm(context, request),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF1E3A8A),
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(vertical: 8),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(6),
                    ),
                  ),
                  child: const Text('Edit', style: TextStyle(fontSize: 13)),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildSwapOfferCard(SwapOffer offer) {
    Color typeColor = _requestColors['Swap']!;

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: const Color(0xFFE2E8F0)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                decoration: BoxDecoration(
                  color: typeColor.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(4),
                ),
                child: Text(
                  'Swap',
                  style: TextStyle(
                    fontSize: 12,
                    color: typeColor,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
              const Spacer(),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                decoration: BoxDecoration(
                  color: const Color(0xFFF59E0B).withOpacity(0.1),
                  borderRadius: BorderRadius.circular(4),
                ),
                child: Text(
                  offer.status,
                  style: const TextStyle(
                    fontSize: 12,
                    color: Color(0xFFF59E0B),
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Row(
            children: [
              const Icon(Icons.swap_horiz, size: 18, color: Color(0xFF1E3A8A)),
              const SizedBox(width: 8),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      offer.fromEmployee,
                      style: const TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.w600,
                        color: Color(0xFF1E293B),
                      ),
                    ),
                    Text(
                      'wants to swap shifts with you',
                      style: const TextStyle(
                        fontSize: 13,
                        color: Color(0xFF64748B),
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
              const Icon(
                Icons.calendar_today,
                size: 14,
                color: Color(0xFF64748B),
              ),
              const SizedBox(width: 6),
              Text(
                offer.date,
                style: const TextStyle(fontSize: 13, color: Color(0xFF475569)),
              ),
              const SizedBox(width: 12),
              const Icon(Icons.access_time, size: 14, color: Color(0xFF64748B)),
              const SizedBox(width: 6),
              Text(
                offer.time,
                style: const TextStyle(fontSize: 13, color: Color(0xFF475569)),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Row(
            children: [
              const Icon(
                Icons.business_center,
                size: 14,
                color: Color(0xFF64748B),
              ),
              const SizedBox(width: 6),
              Text(
                offer.position,
                style: const TextStyle(fontSize: 13, color: Color(0xFF475569)),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Text(
            'Reason: ${offer.reason}',
            style: const TextStyle(fontSize: 13, color: Color(0xFF64748B)),
          ),
          const SizedBox(height: 16),
          Row(
            children: [
              Expanded(
                child: OutlinedButton(
                  onPressed: () => _handleSwapResponse(offer.id, false),
                  style: OutlinedButton.styleFrom(
                    foregroundColor: const Color(0xFF64748B),
                    side: const BorderSide(color: Color(0xFFE2E8F0)),
                    padding: const EdgeInsets.symmetric(vertical: 10),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(6),
                    ),
                  ),
                  child: const Text('Decline', style: TextStyle(fontSize: 13)),
                ),
              ),
              const SizedBox(width: 8),
              Expanded(
                child: ElevatedButton(
                  onPressed: () => _handleSwapResponse(offer.id, true),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF1E3A8A),
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(vertical: 10),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(6),
                    ),
                  ),
                  child: const Text('Accept', style: TextStyle(fontSize: 13)),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildGiveAwayOfferCard(GiveAwayOffer offer) {
    Color typeColor = _requestColors['Give Away']!;

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: const Color(0xFFE2E8F0)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                decoration: BoxDecoration(
                  color: typeColor.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(4),
                ),
                child: Text(
                  'Give Away',
                  style: TextStyle(
                    fontSize: 12,
                    color: typeColor,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
              const Spacer(),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                decoration: BoxDecoration(
                  color: const Color(0xFFF59E0B).withOpacity(0.1),
                  borderRadius: BorderRadius.circular(4),
                ),
                child: Text(
                  offer.status,
                  style: const TextStyle(
                    fontSize: 12,
                    color: Color(0xFFF59E0B),
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Row(
            children: [
              const Icon(Icons.gesture, size: 18, color: Color(0xFF1E3A8A)),
              const SizedBox(width: 8),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      offer.fromEmployee,
                      style: const TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.w600,
                        color: Color(0xFF1E293B),
                      ),
                    ),
                    Text(
                      'is giving away their shift to you',
                      style: const TextStyle(
                        fontSize: 13,
                        color: Color(0xFF64748B),
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
              const Icon(
                Icons.calendar_today,
                size: 14,
                color: Color(0xFF64748B),
              ),
              const SizedBox(width: 6),
              Text(
                offer.date,
                style: const TextStyle(fontSize: 13, color: Color(0xFF475569)),
              ),
              const SizedBox(width: 12),
              const Icon(Icons.access_time, size: 14, color: Color(0xFF64748B)),
              const SizedBox(width: 6),
              Text(
                offer.time,
                style: const TextStyle(fontSize: 13, color: Color(0xFF475569)),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Row(
            children: [
              const Icon(
                Icons.business_center,
                size: 14,
                color: Color(0xFF64748B),
              ),
              const SizedBox(width: 6),
              Text(
                offer.position,
                style: const TextStyle(fontSize: 13, color: Color(0xFF475569)),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Text(
            'Reason: ${offer.reason}',
            style: const TextStyle(fontSize: 13, color: Color(0xFF64748B)),
          ),
          const SizedBox(height: 16),
          Row(
            children: [
              Expanded(
                child: OutlinedButton(
                  onPressed: () => _showShiftDetails(offer),
                  style: OutlinedButton.styleFrom(
                    foregroundColor: const Color(0xFF64748B),
                    side: const BorderSide(color: Color(0xFFE2E8F0)),
                    padding: const EdgeInsets.symmetric(vertical: 10),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(6),
                    ),
                  ),
                  child: const Text(
                    'View Details',
                    style: TextStyle(fontSize: 13),
                  ),
                ),
              ),
              const SizedBox(width: 8),
              Expanded(
                child: ElevatedButton(
                  onPressed: () => _handleTakeShift(offer.id),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF1E3A8A),
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(vertical: 10),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(6),
                    ),
                  ),
                  child: const Text(
                    'Take Shift',
                    style: TextStyle(fontSize: 13),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildApprovalCard(ApprovalRequest request) {
    Color typeColor = _requestColors[request.type] ?? const Color(0xFF64748B);

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: const Color(0xFFE2E8F0)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                decoration: BoxDecoration(
                  color: typeColor.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(4),
                ),
                child: Text(
                  request.type,
                  style: TextStyle(
                    fontSize: 12,
                    color: typeColor,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                decoration: BoxDecoration(
                  color: request.statusColor.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(4),
                ),
                child: Text(
                  request.status,
                  style: TextStyle(
                    fontSize: 12,
                    color: request.statusColor,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Text(
            request.employee,
            style: const TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.w600,
              color: Color(0xFF1E293B),
            ),
          ),
          const SizedBox(height: 8),
          Row(
            children: [
              const Icon(
                Icons.calendar_today,
                size: 14,
                color: Color(0xFF64748B),
              ),
              const SizedBox(width: 8),
              Expanded(
                child: Text(
                  request.details,
                  style: const TextStyle(
                    fontSize: 13,
                    color: Color(0xFF475569),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Text(
            'Reason: ${request.reason}',
            style: const TextStyle(fontSize: 13, color: Color(0xFF64748B)),
          ),
          const SizedBox(height: 8),
          Text(
            'Submitted: ${request.submittedDate}',
            style: const TextStyle(fontSize: 12, color: Color(0xFF94A3B8)),
          ),
        ],
      ),
    );
  }

  Widget _sectionHeader(String title) {
    return Text(
      title,
      style: const TextStyle(
        fontSize: 16,
        fontWeight: FontWeight.w600,
        color: Color(0xFF1E293B),
      ),
    );
  }

  Widget _buildEmptyState({
    required IconData icon,
    required String title,
    required String message,
  }) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 48),
      child: Column(
        children: [
          Icon(icon, size: 48, color: const Color(0xFFCBD5E1)),
          const SizedBox(height: 16),
          Text(
            title,
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w600,
              color: Color(0xFF64748B),
            ),
          ),
          const SizedBox(height: 8),
          Text(
            message,
            textAlign: TextAlign.center,
            style: const TextStyle(fontSize: 14, color: Color(0xFF94A3B8)),
          ),
        ],
      ),
    );
  }

  // Helper method to get icon for history items
  IconData _getHistoryIcon(String type, String status) {
    if (type == 'Leave') {
      return Icons.beach_access;
    } else if (type == 'Swap') {
      return Icons.swap_horiz;
    } else if (type == 'Give Away') {
      return Icons.gesture;
    } else if (type == 'Approval') {
      return Icons.approval;
    }

    if (status == 'Approved' || status == 'Completed') {
      return Icons.check_circle;
    } else if (status == 'Declined') {
      return Icons.cancel;
    } else if (status == 'Cancelled') {
      return Icons.block;
    }

    return Icons.history;
  }

  // Dialog Methods (keep all existing dialog methods)
  void _showNewRequestDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        backgroundColor: Colors.white,
        title: const Text(
          'Create New Request',
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ListTile(
              contentPadding: EdgeInsets.zero,
              leading: const Icon(Icons.beach_access, color: Color(0xFF1E3A8A)),
              title: const Text(
                'Leave Request',
                style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
              ),
              subtitle: const Text('Request time off work'),
              onTap: () {
                Navigator.pop(context);
                _showLeaveRequestForm(context);
              },
            ),
            ListTile(
              contentPadding: EdgeInsets.zero,
              leading: const Icon(Icons.swap_horiz, color: Color(0xFF1E3A8A)),
              title: const Text(
                'Swap Request',
                style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
              ),
              subtitle: const Text('Exchange shifts with coworker'),
              onTap: () {
                Navigator.pop(context);
                _showSwapRequestForm(context);
              },
            ),
            ListTile(
              contentPadding: EdgeInsets.zero,
              leading: const Icon(Icons.gesture, color: Color(0xFF1E3A8A)),
              title: const Text(
                'Give Away Request',
                style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
              ),
              subtitle: const Text('Give your shift to another employee'),
              onTap: () {
                Navigator.pop(context);
                _showGiveAwayRequestForm(context);
              },
            ),
          ],
        ),
      ),
    );
  }

  void _showLeaveRequestForm(BuildContext context, {bool isEdit = false}) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.white,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
      ),
      builder: (context) => Padding(
        padding: EdgeInsets.only(
          bottom: MediaQuery.of(context).viewInsets.bottom,
        ),
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(20),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  const Icon(Icons.beach_access, color: Color(0xFF1E3A8A)),
                  const SizedBox(width: 12),
                  Text(
                    isEdit ? 'Edit Leave Request' : 'New Leave Request',
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20),
              const Text(
                'Leave Type',
                style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
              ),
              const SizedBox(height: 8),
              DropdownButtonFormField<String>(
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                    borderSide: const BorderSide(color: Color(0xFFE2E8F0)),
                  ),
                  contentPadding: const EdgeInsets.symmetric(
                    horizontal: 12,
                    vertical: 14,
                  ),
                ),
                items: ['Annual', 'Sick', 'Personal', 'Emergency', 'Unpaid']
                    .map(
                      (type) =>
                          DropdownMenuItem(value: type, child: Text(type)),
                    )
                    .toList(),
                onChanged: (value) {},
              ),
              const SizedBox(height: 16),
              const Text(
                'Dates',
                style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
              ),
              const SizedBox(height: 8),
              Row(
                children: [
                  Expanded(
                    child: TextFormField(
                      decoration: InputDecoration(
                        labelText: 'Start Date',
                        labelStyle: const TextStyle(color: Color(0xFF64748B)),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                          borderSide: const BorderSide(
                            color: Color(0xFFE2E8F0),
                          ),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                          borderSide: const BorderSide(
                            color: Color(0xFFE2E8F0),
                          ),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                          borderSide: const BorderSide(
                            color: Color(0xFF1E3A8A),
                          ),
                        ),
                        contentPadding: const EdgeInsets.symmetric(
                          horizontal: 12,
                          vertical: 14,
                        ),
                        suffixIcon: const Icon(
                          Icons.calendar_today,
                          size: 18,
                          color: Color(0xFF64748B),
                        ),
                      ),
                      readOnly: true,
                      onTap: () async {
                        await showDatePicker(
                          context: context,
                          initialDate: DateTime.now(),
                          firstDate: DateTime.now(),
                          lastDate: DateTime.now().add(
                            const Duration(days: 365),
                          ),
                        );
                      },
                    ),
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    child: TextFormField(
                      decoration: InputDecoration(
                        labelText: 'End Date',
                        labelStyle: const TextStyle(color: Color(0xFF64748B)),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                          borderSide: const BorderSide(
                            color: Color(0xFFE2E8F0),
                          ),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                          borderSide: const BorderSide(
                            color: Color(0xFFE2E8F0),
                          ),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                          borderSide: const BorderSide(
                            color: Color(0xFF1E3A8A),
                          ),
                        ),
                        contentPadding: const EdgeInsets.symmetric(
                          horizontal: 12,
                          vertical: 14,
                        ),
                        suffixIcon: const Icon(
                          Icons.calendar_today,
                          size: 18,
                          color: Color(0xFF64748B),
                        ),
                      ),
                      readOnly: true,
                      onTap: () async {
                        await showDatePicker(
                          context: context,
                          initialDate: DateTime.now(),
                          firstDate: DateTime.now(),
                          lastDate: DateTime.now().add(
                            const Duration(days: 365),
                          ),
                        );
                      },
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              const Text(
                'Reason',
                style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
              ),
              const SizedBox(height: 8),
              TextFormField(
                decoration: InputDecoration(
                  hintText: 'Enter reason for leave',
                  hintStyle: const TextStyle(color: Color(0xFF94A3B8)),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                    borderSide: const BorderSide(color: Color(0xFFE2E8F0)),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                    borderSide: const BorderSide(color: Color(0xFFE2E8F0)),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                    borderSide: const BorderSide(color: Color(0xFF1E3A8A)),
                  ),
                  contentPadding: const EdgeInsets.symmetric(
                    horizontal: 12,
                    vertical: 14,
                  ),
                ),
                maxLines: 3,
              ),
              const SizedBox(height: 24),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.pop(context);
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text(
                          isEdit
                              ? 'Leave request updated'
                              : 'Leave request submitted',
                        ),
                        backgroundColor: const Color(0xFF1E3A8A),
                      ),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF1E3A8A),
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(vertical: 14),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  child: Text(
                    isEdit ? 'Update Request' : 'Submit Request',
                    style: const TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _showSwapRequestForm(BuildContext context, {bool isEdit = false}) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.white,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
      ),
      builder: (context) => Padding(
        padding: EdgeInsets.only(
          bottom: MediaQuery.of(context).viewInsets.bottom,
        ),
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(20),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  const Icon(Icons.swap_horiz, color: Color(0xFF1E3A8A)),
                  const SizedBox(width: 12),
                  Text(
                    isEdit ? 'Edit Swap Request' : 'New Swap Request',
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20),
              const Text(
                'Swap Partner',
                style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
              ),
              const SizedBox(height: 8),
              DropdownButtonFormField<String>(
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                    borderSide: const BorderSide(color: Color(0xFFE2E8F0)),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                    borderSide: const BorderSide(color: Color(0xFFE2E8F0)),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                    borderSide: const BorderSide(color: Color(0xFF1E3A8A)),
                  ),
                  contentPadding: const EdgeInsets.symmetric(
                    horizontal: 12,
                    vertical: 14,
                  ),
                ),
                items:
                    [
                          'Sarah Johnson',
                          'Mike Chen',
                          'Alex Brown',
                          'Rachel Green',
                          'James Wilson',
                          'Leo Martinez',
                        ]
                        .map(
                          (name) =>
                              DropdownMenuItem(value: name, child: Text(name)),
                        )
                        .toList(),
                onChanged: (value) {},
              ),
              const SizedBox(height: 16),
              const Text(
                'Shift Date',
                style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
              ),
              const SizedBox(height: 8),
              TextFormField(
                decoration: InputDecoration(
                  labelText: 'Select Date',
                  labelStyle: const TextStyle(color: Color(0xFF64748B)),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                    borderSide: const BorderSide(color: Color(0xFFE2E8F0)),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                    borderSide: const BorderSide(color: Color(0xFFE2E8F0)),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                    borderSide: const BorderSide(color: Color(0xFF1E3A8A)),
                  ),
                  contentPadding: const EdgeInsets.symmetric(
                    horizontal: 12,
                    vertical: 14,
                  ),
                  suffixIcon: const Icon(
                    Icons.calendar_today,
                    size: 18,
                    color: Color(0xFF64748B),
                  ),
                ),
                readOnly: true,
                onTap: () async {
                  await showDatePicker(
                    context: context,
                    initialDate: DateTime.now(),
                    firstDate: DateTime.now(),
                    lastDate: DateTime.now().add(const Duration(days: 90)),
                  );
                },
              ),
              const SizedBox(height: 16),
              const Text(
                'Reason',
                style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
              ),
              const SizedBox(height: 8),
              TextFormField(
                decoration: InputDecoration(
                  hintText: 'Explain why you want to swap shifts',
                  hintStyle: const TextStyle(color: Color(0xFF94A3B8)),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                    borderSide: const BorderSide(color: Color(0xFFE2E8F0)),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                    borderSide: const BorderSide(color: Color(0xFFE2E8F0)),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                    borderSide: const BorderSide(color: Color(0xFF1E3A8A)),
                  ),
                  contentPadding: const EdgeInsets.symmetric(
                    horizontal: 12,
                    vertical: 14,
                  ),
                ),
                maxLines: 3,
              ),
              const SizedBox(height: 24),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.pop(context);
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text(
                          isEdit
                              ? 'Swap request updated'
                              : 'Swap request submitted',
                        ),
                        backgroundColor: const Color(0xFF1E3A8A),
                      ),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF1E3A8A),
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(vertical: 14),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  child: Text(
                    isEdit ? 'Update Request' : 'Submit Request',
                    style: const TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _showGiveAwayRequestForm(BuildContext context, {bool isEdit = false}) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.white,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
      ),
      builder: (context) => Padding(
        padding: EdgeInsets.only(
          bottom: MediaQuery.of(context).viewInsets.bottom,
        ),
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(20),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  const Icon(Icons.gesture, color: Color(0xFF1E3A8A)),
                  const SizedBox(width: 12),
                  Text(
                    isEdit ? 'Edit Give Away Request' : 'New Give Away Request',
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20),
              const Text(
                'Give To',
                style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
              ),
              const SizedBox(height: 8),
              DropdownButtonFormField<String>(
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                    borderSide: const BorderSide(color: Color(0xFFE2E8F0)),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                    borderSide: const BorderSide(color: Color(0xFFE2E8F0)),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                    borderSide: const BorderSide(color: Color(0xFF1E3A8A)),
                  ),
                  contentPadding: const EdgeInsets.symmetric(
                    horizontal: 12,
                    vertical: 14,
                  ),
                ),
                items:
                    [
                          'Sarah Johnson',
                          'Mike Chen',
                          'Alex Brown',
                          'Rachel Green',
                          'James Wilson',
                          'Leo Martinez',
                        ]
                        .map(
                          (name) =>
                              DropdownMenuItem(value: name, child: Text(name)),
                        )
                        .toList(),
                onChanged: (value) {},
              ),
              const SizedBox(height: 16),
              const Text(
                'Shift Date',
                style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
              ),
              const SizedBox(height: 8),
              TextFormField(
                decoration: InputDecoration(
                  labelText: 'Select Date',
                  labelStyle: const TextStyle(color: Color(0xFF64748B)),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                    borderSide: const BorderSide(color: Color(0xFFE2E8F0)),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                    borderSide: const BorderSide(color: Color(0xFFE2E8F0)),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                    borderSide: const BorderSide(color: Color(0xFF1E3A8A)),
                  ),
                  contentPadding: const EdgeInsets.symmetric(
                    horizontal: 12,
                    vertical: 14,
                  ),
                  suffixIcon: const Icon(
                    Icons.calendar_today,
                    size: 18,
                    color: Color(0xFF64748B),
                  ),
                ),
                readOnly: true,
                onTap: () async {
                  await showDatePicker(
                    context: context,
                    initialDate: DateTime.now(),
                    firstDate: DateTime.now(),
                    lastDate: DateTime.now().add(const Duration(days: 90)),
                  );
                },
              ),
              const SizedBox(height: 16),
              const Text(
                'Reason',
                style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
              ),
              const SizedBox(height: 8),
              TextFormField(
                decoration: InputDecoration(
                  hintText: 'Explain why you are giving away this shift',
                  hintStyle: const TextStyle(color: Color(0xFF94A3B8)),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                    borderSide: const BorderSide(color: Color(0xFFE2E8F0)),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                    borderSide: const BorderSide(color: Color(0xFFE2E8F0)),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                    borderSide: const BorderSide(color: Color(0xFF1E3A8A)),
                  ),
                  contentPadding: const EdgeInsets.symmetric(
                    horizontal: 12,
                    vertical: 14,
                  ),
                ),
                maxLines: 3,
              ),
              const SizedBox(height: 24),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.pop(context);
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text(
                          isEdit
                              ? 'Give away request updated'
                              : 'Give away request submitted',
                        ),
                        backgroundColor: const Color(0xFF1E3A8A),
                      ),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF1E3A8A),
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(vertical: 14),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  child: Text(
                    isEdit ? 'Update Request' : 'Submit Request',
                    style: const TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _showEditForm(BuildContext context, Request request) {
    if (request.type == 'Leave') {
      _showLeaveRequestForm(context, isEdit: true);
    } else if (request.type == 'Swap') {
      _showSwapRequestForm(context, isEdit: true);
    } else {
      _showGiveAwayRequestForm(context, isEdit: true);
    }
  }

  void _showShiftDetails(GiveAwayOffer offer) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        backgroundColor: Colors.white,
        title: Text(
          'Shift Details',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w600,
            color: const Color(0xFF1E293B),
          ),
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _detailItem('Date:', offer.date),
            _detailItem('Time:', offer.time),
            _detailItem('Position:', offer.position),
            _detailItem('Given by:', offer.fromEmployee),
            const SizedBox(height: 12),
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: const Color(0xFFF8FAFC),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Reason:',
                    style: TextStyle(
                      fontSize: 13,
                      fontWeight: FontWeight.w600,
                      color: Color(0xFF1E293B),
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    offer.reason,
                    style: const TextStyle(
                      fontSize: 13,
                      color: Color(0xFF475569),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            style: TextButton.styleFrom(
              foregroundColor: const Color(0xFF64748B),
            ),
            child: const Text('Close'),
          ),
        ],
      ),
    );
  }

  Widget _detailItem(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 80,
            child: Text(
              label,
              style: const TextStyle(
                fontSize: 13,
                fontWeight: FontWeight.w600,
                color: Color(0xFF64748B),
              ),
            ),
          ),
          Expanded(
            child: Text(
              value,
              style: const TextStyle(fontSize: 13, color: Color(0xFF1E293B)),
            ),
          ),
        ],
      ),
    );
  }

  void _showCancelConfirmation(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        backgroundColor: Colors.white,
        title: const Row(
          children: [
            Icon(Icons.warning, color: Color(0xFFF59E0B), size: 24),
            SizedBox(width: 12),
            Text(
              'Cancel Request?',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w600,
                color: Color(0xFF1E293B),
              ),
            ),
          ],
        ),
        content: const Text(
          'Are you sure you want to cancel this request? This action cannot be undone.',
          style: TextStyle(fontSize: 14, color: Color(0xFF64748B), height: 1.5),
        ),
        actions: [
          OutlinedButton(
            onPressed: () => Navigator.pop(context),
            style: OutlinedButton.styleFrom(
              foregroundColor: const Color(0xFF64748B),
              side: const BorderSide(color: Color(0xFFE2E8F0)),
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 10),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(6),
              ),
            ),
            child: const Text(
              'Keep Request',
              style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
            ),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.pop(context);
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('Request cancelled'),
                  backgroundColor: Color(0xFF1E3A8A),
                ),
              );
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFFEF4444),
              foregroundColor: Colors.white,
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 10),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(6),
              ),
            ),
            child: const Text(
              'Cancel Request',
              style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
            ),
          ),
        ],
      ),
    );
  }

  void _handleSwapResponse(String requestId, bool accepted) {
    setState(() {
      _swapOffers.removeWhere((offer) => offer.id == requestId);
    });
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(accepted ? 'Swap accepted' : 'Swap declined'),
        backgroundColor: const Color(0xFF1E3A8A),
      ),
    );
  }

  void _handleTakeShift(String requestId) {
    setState(() {
      _giveAwayOffers.removeWhere((offer) => offer.id == requestId);
    });
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Shift taken successfully'),
        backgroundColor: const Color(0xFF1E3A8A),
      ),
    );
  }
}

// Data Models
class Request {
  final String id;
  final String type;
  final String title;
  final String date;
  final String duration;
  final String status;
  final Color statusColor;
  final String employee;
  final String reason;

  Request({
    required this.id,
    required this.type,
    required this.title,
    required this.date,
    required this.duration,
    required this.status,
    required this.statusColor,
    required this.employee,
    required this.reason,
  });
}

class SwapOffer {
  final String id;
  final String fromEmployee;
  final String position;
  final String date;
  final String time;
  final String reason;
  final String status;

  SwapOffer({
    required this.id,
    required this.fromEmployee,
    required this.position,
    required this.date,
    required this.time,
    required this.reason,
    required this.status,
  });
}

class GiveAwayOffer {
  final String id;
  final String fromEmployee;
  final String position;
  final String date;
  final String time;
  final String reason;
  final String status;

  GiveAwayOffer({
    required this.id,
    required this.fromEmployee,
    required this.position,
    required this.date,
    required this.time,
    required this.reason,
    required this.status,
  });
}

class ApprovalRequest {
  final String id;
  final String type;
  final String employee;
  final String details;
  final String status;
  final Color statusColor;
  final String submittedDate;
  final String reason;

  ApprovalRequest({
    required this.id,
    required this.type,
    required this.employee,
    required this.details,
    required this.status,
    required this.statusColor,
    required this.submittedDate,
    required this.reason,
  });
}

// History Data Model
class HistoryItem {
  final String id;
  final String type;
  final String title;
  final String date;
  final String time;
  final String status;
  final Color statusColor;
  final String details;
  final String action;

  HistoryItem({
    required this.id,
    required this.type,
    required this.title,
    required this.date,
    required this.time,
    required this.status,
    required this.statusColor,
    required this.details,
    required this.action,
  });
}

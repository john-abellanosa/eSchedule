import 'package:flutter/material.dart';

void main() => runApp(const eSchedule());

/* --------------------------------------------- */
/* APP SHELL                                     */
/* --------------------------------------------- */
class eSchedule extends StatelessWidget {
  const eSchedule({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Manager Notifications',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
        primaryColor: const Color(0xFF1E88E5),
        scaffoldBackgroundColor: const Color(0xFFF8F9FA),
        fontFamily: 'Inter',
        appBarTheme: const AppBarTheme(
          elevation: 0,
          backgroundColor: Colors.white,
          titleTextStyle: TextStyle(
            color: Color(0xFF1A1D1F),
            fontSize: 20,
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
      home: const ManagerNotifications(),
    );
  }
}

/* --------------------------------------------- */
/* MAIN PAGE                                     */
/* --------------------------------------------- */
class ManagerNotifications extends StatefulWidget {
  const ManagerNotifications({Key? key}) : super(key: key);

  @override
  State<ManagerNotifications> createState() => _ManagerNotificationsState();
}

class _ManagerNotificationsState extends State<ManagerNotifications>
    with SingleTickerProviderStateMixin {
  late final TabController _tabController;

  final List<Map<String, dynamic>> notifications = [
    {
      'id': '1',
      'title': 'Shift Reminder',
      'message': 'Your shift starts at 10:00 AM at Kitchen station',
      'time': '30 min ago',
      'unread': true,
    },
    {
      'id': '2',
      'title': 'Swap Request Accepted',
      'message': 'Mike Chen accepted your swap request for Friday',
      'time': '2 hours ago',
      'unread': true,
    },
    {
      'id': '3',
      'title': 'New Swap Available',
      'message': 'Sarah Johnson needs coverage for Dec 13 shift',
      'time': '4 hours ago',
      'unread': true,
    },
    {
      'id': '4',
      'title': 'Schedule Updated',
      'message': 'Your schedule for next week has been published',
      'time': '1 day ago',
      'unread': false,
    },
    {
      'id': '5',
      'title': 'Time Off Approved',
      'message': 'Your time off request for Dec 20-22 has been approved',
      'time': '2 days ago',
      'unread': false,
    },
    {
      'id': '6',
      'title': 'Training Reminder',
      'message': 'Mandatory training session tomorrow at 10 AM',
      'time': '3 days ago',
      'unread': false,
    },
    {
      'id': '7',
      'title': 'Team Report',
      'message': 'Monthly team performance report is available',
      'time': '1 hour ago',
      'unread': true,
    },
    {
      'id': '8',
      'title': 'New Hire',
      'message': 'John Doe has joined the team',
      'time': '5 hours ago',
      'unread': false,
    },
  ];

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  /* --------------------------------------------- */
  /* BUILD                                         */
  /* --------------------------------------------- */
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8F9FA),
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Colors.white,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios),
          onPressed: () => Navigator.pop(context),
        ),
        titleSpacing: -8,
        title: const Text(
          'Notifications',
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(42),
          child: SizedBox(
            height: 42,
            child: Row(
              children: [
                // TABS (very tight, far left)
                SizedBox(
                  width: 140,
                  child: TabBar(
                    controller: _tabController,
                    indicatorColor: const Color(0xFF1E88E5),
                    labelColor: const Color(0xFF1E88E5),
                    unselectedLabelColor: const Color(0xFF9CA3AF),
                    labelPadding: EdgeInsets.zero,
                    tabs: const [
                      Tab(text: 'All'),
                      Tab(text: 'Unread'),
                    ],
                  ),
                ),
                const Spacer(),
                // MARK ALL READ (same row)
                Padding(
                  padding: const EdgeInsets.only(right: 12),
                  child: TextButton(
                    style: TextButton.styleFrom(
                      backgroundColor: const Color(0xFFEEEEEE),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(6),
                      ),
                      padding: const EdgeInsets.symmetric(
                        horizontal: 10,
                        vertical: 6,
                      ),
                    ),
                    onPressed: _markAllRead,
                    child: const Text(
                      'Mark all as read',
                      style: TextStyle(color: Color(0xFF6B7280), fontSize: 12),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [_buildList(showAll: true), _buildList(showAll: false)],
      ),
    );
  }

  /* --------------------------------------------- */
  /* LIST HELPERS                                  */
  /* --------------------------------------------- */
  Widget _buildList({required bool showAll}) {
    final list = showAll
        ? notifications
        : notifications.where((n) => n['unread'] == true).toList();

    if (list.isEmpty) return _emptyState(showAll ? 'all' : 'unread');

    return ListView.separated(
      padding: EdgeInsets.zero,
      itemCount: list.length,
      separatorBuilder: (_, __) => Divider(height: 1, color: Colors.grey[200]),
      itemBuilder: (_, i) => _row(list[i]),
    );
  }

  Widget _row(Map<String, dynamic> n) {
    final bool unread = n['unread'] as bool;
    return Container(
      color: unread ? const Color(0xFFF0F7FF) : Colors.transparent,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // CONTENT (left)
          Expanded(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(16, 12, 0, 12),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    n['title'] as String,
                    style: TextStyle(
                      fontSize: 15,
                      fontWeight: unread ? FontWeight.w700 : FontWeight.w600,
                      color: const Color(0xFF1A1D1F),
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    n['message'] as String,
                    style: const TextStyle(
                      fontSize: 13,
                      color: Color(0xFF4B5563),
                      height: 1.3,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Row(
                    children: [
                      Text(
                        n['time'] as String,
                        style: TextStyle(fontSize: 11, color: Colors.grey[500]),
                      ),
                      if (unread) ...[
                        const SizedBox(width: 8),
                        const SizedBox(
                          width: 8,
                          height: 8,
                          child: DecoratedBox(
                            decoration: BoxDecoration(
                              color: Color(0xFF1E88E5),
                              shape: BoxShape.circle,
                            ),
                          ),
                        ),
                      ],
                    ],
                  ),
                ],
              ),
            ),
          ),
          // CENTERED 3-DOTS MENU
          Center(
            child: PopupMenuButton<String>(
              icon: Icon(Icons.more_vert, color: Colors.grey[400], size: 18),
              onSelected: (v) => _handleMenu(v, n),
              itemBuilder: (_) => [
                PopupMenuItem(
                  value: 'mark',
                  child: Row(
                    children: [
                      Icon(
                        unread ? Icons.mark_email_read : Icons.drafts,
                        size: 16,
                        color: Colors.grey[600],
                      ),
                      const SizedBox(width: 8),
                      Text(unread ? 'Mark as read' : 'Mark as unread'),
                    ],
                  ),
                ),
                PopupMenuItem(
                  value: 'delete',
                  child: Row(
                    children: [
                      Icon(
                        Icons.delete_outline,
                        size: 16,
                        color: Colors.grey[600],
                      ),
                      const SizedBox(width: 8),
                      const Text('Delete'),
                    ],
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(width: 12),
        ],
      ),
    );
  }

  Widget _emptyState(String type) {
    final msg = type == 'unread'
        ? 'No unread notifications'
        : 'No notifications';
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.inbox, size: 48, color: Colors.grey[300]),
          const SizedBox(height: 16),
          Text(
            msg,
            style: TextStyle(
              fontSize: 15,
              color: Colors.grey[600],
              fontWeight: FontWeight.w500,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            'You\'re all caught up',
            style: TextStyle(fontSize: 13, color: Colors.grey[500]),
          ),
        ],
      ),
    );
  }

  /* --------------------------------------------- */
  /* ACTIONS                                       */
  /* --------------------------------------------- */
  void _handleMenu(String action, Map<String, dynamic> n) {
    switch (action) {
      case 'mark':
        setState(() => n['unread'] = !(n['unread'] as bool));
        break;
      case 'delete':
        setState(() => notifications.removeWhere((e) => e['id'] == n['id']));
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(const SnackBar(content: Text('Notification deleted')));
        break;
    }
  }

  void _markAllRead() => setState(() {
    for (final n in notifications) n['unread'] = false;
  });
}

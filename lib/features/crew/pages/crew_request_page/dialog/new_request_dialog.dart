import 'package:flutter/material.dart';
import 'package:escheduler/features/crew/pages/crew_request_page/widgets/input_widgets/input_widgets.dart';
import 'package:escheduler/features/crew/pages/crew_request_page/request_form/leave_request_form.dart';
import 'package:escheduler/features/crew/pages/crew_request_page/request_form/give_away_request_form.dart';
import 'package:escheduler/features/crew/pages/crew_request_page/request_form/swap_request_form.dart';
import 'package:escheduler/features/crew/pages/crew_request_page/request_form/off_duty_request_form.dart';

void showNewRequestDialog(BuildContext context) {
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
              showLeaveRequestForm(context);
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
              showSwapRequestForm(context);
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
              showGiveAwayRequestForm(context);
            },
          ),
          ListTile(
            contentPadding: EdgeInsets.zero,
            leading: const Icon(Icons.event_busy, color: Color(0xFF1E3A8A)),
            title: const Text(
              'Off Duty Request',
              style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
            ),
            subtitle: const Text('Request days off work'),
            onTap: () {
              Navigator.pop(context);
              showOffDutyRequestForm(context);
            },
          ),
        ],
      ),
    ),
  );
}

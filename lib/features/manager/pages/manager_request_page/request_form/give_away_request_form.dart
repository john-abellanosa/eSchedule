import 'package:flutter/material.dart';
import 'package:escheduler/features/manager/pages/manager_request_page/widgets/input_widgets/input_widgets.dart';

void showGiveAwayRequestForm(BuildContext context, {bool isEdit = false}) {
  TextEditingController dateController = TextEditingController();
  TextEditingController timeInController = TextEditingController();
  TextEditingController timeOutController = TextEditingController();
  TextEditingController reasonController = TextEditingController();
  String? position, receiver;

  showModalBottomSheet(
    context: context,
    isScrollControlled: true,
    backgroundColor: Colors.white,
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
    ),
    builder: (context) => StatefulBuilder(
      builder: (context, setModalState) {
        return Padding(
          padding: EdgeInsets.only(
            bottom: MediaQuery.of(context).viewInsets.bottom,
            top: 10,
          ),
          child: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    const Icon(
                      Icons.gesture,
                      color: Color(0xFF1E3A8A),
                      size: 20,
                    ),
                    const SizedBox(width: 12),
                    Text(
                      isEdit
                          ? 'Edit Give Away Request'
                          : 'New Give Away Request',
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 20),
                const Text(
                  'Shift Information',
                  style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w600,
                    color: Color(0xFF1E293B),
                  ),
                ),
                const SizedBox(height: 12),
                const Text(
                  'Schedule Date',
                  style: TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.w500,
                    color: Color(0xFF475569),
                  ),
                ),
                const SizedBox(height: 6),
                dateField(dateController, context, 'Select Date'),
                const SizedBox(height: 12),
                Row(
                  children: [
                    Expanded(
                      child: timeField(timeInController, context, 'Time In'),
                    ),
                    const SizedBox(width: 8),
                    Expanded(
                      child: timeField(timeOutController, context, 'Time Out'),
                    ),
                  ],
                ),
                const SizedBox(height: 12),
                const Text(
                  'Position',
                  style: TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.w500,
                    color: Color(0xFF475569),
                  ),
                ),
                const SizedBox(height: 6),
                dropdownField(
                  items: const [
                    'Service Manager',
                    'Manager In-Charge',
                    'B2B',
                    'Expediter',
                    'Shift Leader',
                  ],
                  onChanged: (v) => setModalState(() => position = v),
                ),
                const SizedBox(height: 20),
                const Text(
                  'Receiver Information',
                  style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w600,
                    color: Color(0xFF1E293B),
                  ),
                ),
                const SizedBox(height: 12),
                const Text(
                  'Receiver Name',
                  style: TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.w500,
                    color: Color(0xFF475569),
                  ),
                ),
                const SizedBox(height: 6),
                dropdownField(
                  items: const [
                    'Sarah Johnson',
                    'Mike Chen',
                    'Alex Brown',
                    'Rachel Green',
                    'Michael Rodriguez',
                    'Emily Wilson',
                    'David Kim',
                  ],
                  onChanged: (v) => setModalState(() => receiver = v),
                ),
                const SizedBox(height: 16),
                const Text(
                  'Reason',
                  style: TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.w500,
                    color: Color(0xFF475569),
                  ),
                ),
                const SizedBox(height: 6),
                textArea(
                  reasonController,
                  'Explain why you are giving away this shift',
                ),
                const SizedBox(height: 24),
                submitButton(() {
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
                }, isEdit ? 'Update Request' : 'Submit Request'),
                const SizedBox(height: 16),
              ],
            ),
          ),
        );
      },
    ),
  );
}

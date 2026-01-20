import 'package:flutter/material.dart';
import 'package:escheduler/features/crew/pages/crew_request_page/widgets/input_widgets/input_widgets.dart';

void showOffDutyRequestForm(BuildContext context, {bool isEdit = false}) {
  TextEditingController dateController = TextEditingController();
  TextEditingController reasonController = TextEditingController();
  String? duration;

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
        top: 20,
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
                  Icons.event_busy,
                  color: Color(0xFF1E3A8A),
                  size: 20,
                ),
                const SizedBox(width: 12),
                Text(
                  isEdit ? 'Edit Off Duty Request' : 'New Off Duty Request',
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),
            const Text(
              'Date',
              style: TextStyle(
                fontSize: 13,
                fontWeight: FontWeight.w500,
                color: Color(0xFF475569),
              ),
            ),
            const SizedBox(height: 6),
            dateField(dateController, context, 'Select Date'),
            const SizedBox(height: 16),
            const Text(
              'Duration',
              style: TextStyle(
                fontSize: 13,
                fontWeight: FontWeight.w500,
                color: Color(0xFF475569),
              ),
            ),
            const SizedBox(height: 6),
            dropdownField(
              items: const ['1 Day', '2 Days'],
              onChanged: (v) => duration = v,
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
            textArea(reasonController, 'Enter reason for off duty'),
            const SizedBox(height: 24),
            submitButton(() {
              Navigator.pop(context);
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(
                    isEdit
                        ? 'Off duty request updated'
                        : 'Off duty request submitted',
                  ),
                  backgroundColor: const Color(0xFF1E3A8A),
                ),
              );
            }, isEdit ? 'Update Request' : 'Submit Request'),
            const SizedBox(height: 16),
          ],
        ),
      ),
    ),
  );
}

import 'package:flutter/material.dart';
import 'package:escheduler/features/crew/pages/crew_request_page/widgets/input_widgets/input_widgets.dart';

void showSwapRequestForm(BuildContext context, {bool isEdit = false}) {
  TextEditingController swapDateController = TextEditingController();
  TextEditingController myTimeInController = TextEditingController();
  TextEditingController myTimeOutController = TextEditingController();
  TextEditingController partnerTimeInController = TextEditingController();
  TextEditingController partnerTimeOutController = TextEditingController();
  TextEditingController reasonController = TextEditingController();

  String? myPosition, swapPartner, partnerPosition;

  showModalBottomSheet(
    context: context,
    isScrollControlled: true,
    backgroundColor: Colors.white,
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
    ),
    builder: (context) => StatefulBuilder(
      builder: (BuildContext context, StateSetter setState) {
        return Padding(
          padding: EdgeInsets.only(
            bottom: MediaQuery.of(context).viewInsets.bottom,
            top: 30,
            left: 20,
            right: 20,
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Header
              Row(
                children: [
                  const Icon(
                    Icons.swap_horiz,
                    color: Color(0xFF1E3A8A),
                    size: 20,
                  ),
                  const SizedBox(width: 12),
                  Text(
                    isEdit ? 'Edit Swap Request' : 'New Swap Request',
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const Spacer(),
                  IconButton(
                    onPressed: () => Navigator.pop(context),
                    icon: const Icon(Icons.close, size: 20),
                  ),
                ],
              ),

              const SizedBox(height: 20),

              // Scrollable content
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'My Information',
                        style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.w600,
                          color: Color(0xFF1E293B),
                        ),
                      ),
                      const SizedBox(height: 12),
                      const Text(
                        'My Position',
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
                        onChanged: (v) {
                          setState(() => myPosition = v);
                        },
                      ),
                      const SizedBox(height: 12),
                      Row(
                        children: [
                          Expanded(
                            child: timeField(
                              myTimeInController,
                              context,
                              'My Time In',
                            ),
                          ),
                          const SizedBox(width: 8),
                          Expanded(
                            child: timeField(
                              myTimeOutController,
                              context,
                              'My Time Out',
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 20),
                      const Text(
                        'Swap Partner Information',
                        style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.w600,
                          color: Color(0xFF1E293B),
                        ),
                      ),
                      const SizedBox(height: 12),
                      const Text(
                        'Swap Partner',
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
                        onChanged: (v) {
                          setState(() => swapPartner = v);
                        },
                      ),
                      const SizedBox(height: 12),
                      const Text(
                        'Partner Position',
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
                        onChanged: (v) {
                          setState(() => partnerPosition = v);
                        },
                      ),
                      const SizedBox(height: 12),
                      Row(
                        children: [
                          Expanded(
                            child: timeField(
                              partnerTimeInController,
                              context,
                              'Partner Time In',
                            ),
                          ),
                          const SizedBox(width: 8),
                          Expanded(
                            child: timeField(
                              partnerTimeOutController,
                              context,
                              'Partner Time Out',
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 12),
                      const Text(
                        'Swap Date',
                        style: TextStyle(
                          fontSize: 13,
                          fontWeight: FontWeight.w500,
                          color: Color(0xFF475569),
                        ),
                      ),
                      const SizedBox(height: 6),
                      dateField(swapDateController, context, 'Select Date'),
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
                        'Explain why you want to swap shifts',
                      ),
                    ],
                  ),
                ),
              ),

              // Submit button
              const SizedBox(height: 20),
              submitButton(() {
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
              }, isEdit ? 'Update Request' : 'Submit Request'),
              const SizedBox(height: 16),
            ],
          ),
        );
      },
    ),
  );
}

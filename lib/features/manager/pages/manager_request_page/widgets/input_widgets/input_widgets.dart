import 'package:flutter/material.dart';

// 1.  _dropdownField  (signature unchanged)
Widget dropdownField({
  required List<String> items,
  String? value,
  required void Function(String?) onChanged,
  String? hint,
}) {
  return StatefulBuilder(
    builder: (context, setState) {
      return Focus(
        onFocusChange: (_) => setState(() {}),
        child: Builder(
          builder: (context) {
            final hasFocus = Focus.of(context).hasFocus;
            return Container(
              height: 36,
              decoration: BoxDecoration(
                color: const Color(0xFFF8FAFC),
                borderRadius: BorderRadius.circular(6),
                border: Border.all(
                  color: hasFocus
                      ? const Color(0xFF1E3A8A)
                      : const Color(0xFFE2E8F0),
                  width: hasFocus ? 1.25 : 1,
                ),
                boxShadow: hasFocus
                    ? [
                        BoxShadow(
                          color: const Color(0xFF1E3A8A).withOpacity(0.08),
                          blurRadius: 3,
                          offset: const Offset(0, 1),
                        ),
                      ]
                    : [],
              ),
              child: DropdownButtonHideUnderline(
                child: DropdownButtonFormField<String>(
                  value: value,
                  isExpanded: true,
                  decoration: const InputDecoration(
                    isDense: true,
                    contentPadding: EdgeInsets.symmetric(
                      horizontal: 10,
                      vertical: 6,
                    ),
                    border: InputBorder.none,
                    hintText: '',
                    fillColor: Colors.transparent,
                    filled: true,
                  ),
                  hint: hint != null
                      ? Text(
                          hint,
                          overflow: TextOverflow.ellipsis,
                          style: const TextStyle(
                            fontSize: 12,
                            color: Color(0xFF94A3B8),
                            fontWeight: FontWeight.w500,
                          ),
                        )
                      : null,
                  style: const TextStyle(
                    fontSize: 12.5,
                    height: 1.1,
                    color: Color(0xFF1E293B),
                    fontWeight: FontWeight.w600,
                  ),
                  dropdownColor: Colors.white,
                  icon: Icon(
                    Icons.arrow_drop_down,
                    size: 20,
                    color: hasFocus
                        ? const Color(0xFF1E3A8A)
                        : const Color(0xFF64748B),
                  ),
                  items: items
                      .map(
                        (e) => DropdownMenuItem(
                          value: e,
                          child: Text(
                            e,
                            overflow: TextOverflow.ellipsis,
                            style: const TextStyle(
                              fontSize: 12.5,
                              color: Color(0xFF1E293B),
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      )
                      .toList(),
                  onChanged: onChanged,
                ),
              ),
            );
          },
        ),
      );
    },
  );
}

// 2.  _dateField
Widget dateField(
  TextEditingController controller,
  BuildContext context,
  String label,
) {
  return StatefulBuilder(
    builder: (context, setState) {
      return Focus(
        onFocusChange: (_) => setState(() {}),
        child: Builder(
          builder: (context) {
            final hasFocus = Focus.of(context).hasFocus;
            return Container(
              height: 36,
              decoration: BoxDecoration(
                color: const Color(0xFFF8FAFC),
                borderRadius: BorderRadius.circular(6),
                border: Border.all(color: Colors.transparent, width: 0),
                boxShadow: hasFocus
                    ? [
                        BoxShadow(
                          color: const Color(0xFF1E3A8A).withOpacity(0.08),
                          blurRadius: 3,
                          offset: const Offset(0, 1),
                        ),
                      ]
                    : [],
              ),
              child: TextFormField(
                controller: controller,
                readOnly: true,
                style: const TextStyle(
                  fontSize: 12.5,
                  height: 1.1,
                  color: Color(0xFF1E293B),
                  fontWeight: FontWeight.w600,
                ),
                decoration: InputDecoration(
                  isDense: true,
                  labelText: label,
                  labelStyle: TextStyle(
                    fontSize: 12,
                    color: hasFocus
                        ? const Color(0xFF1E3A8A)
                        : const Color(0xFF64748B),
                    fontWeight: FontWeight.w600,
                  ),
                  floatingLabelStyle: const TextStyle(
                    fontSize: 12,
                    color: Color(0xFF1E3A8A),
                    fontWeight: FontWeight.w700,
                  ),
                  floatingLabelBehavior: FloatingLabelBehavior.auto,
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(6),
                    borderSide: const BorderSide(
                      color: Color(0xFFE2E8F0),
                      width: 1,
                    ),
                  ),
                  focusedBorder: const OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(6)),
                    borderSide: BorderSide(
                      color: Color(0xFF1E3A8A),
                      width: 1.25,
                    ),
                  ),
                  contentPadding: const EdgeInsets.symmetric(
                    horizontal: 10,
                    vertical: 8,
                  ),
                  suffixIcon: Icon(
                    Icons.calendar_today,
                    size: 18,
                    color: hasFocus
                        ? const Color(0xFF1E3A8A)
                        : const Color(0xFF64748B),
                  ),
                  fillColor: Colors.transparent,
                  filled: true,
                ),
                onTap: () async {
                  final date = await showDatePicker(
                    context: context,
                    initialDate: DateTime.now(),
                    firstDate: DateTime.now(),
                    lastDate: DateTime.now().add(const Duration(days: 365)),
                  );
                  if (date != null) {
                    controller.text = '${date.day}/${date.month}/${date.year}';
                  }
                },
              ),
            );
          },
        ),
      );
    },
  );
}

// 3.  _timeField
Widget timeField(
  TextEditingController controller,
  BuildContext context,
  String label,
) {
  return StatefulBuilder(
    builder: (context, setState) {
      return Focus(
        onFocusChange: (_) => setState(() {}),
        child: Builder(
          builder: (context) {
            final hasFocus = Focus.of(context).hasFocus;
            return Container(
              height: 36,
              decoration: BoxDecoration(
                color: const Color(0xFFF8FAFC),
                borderRadius: BorderRadius.circular(6),
                border: Border.all(color: Colors.transparent, width: 0),
                boxShadow: hasFocus
                    ? [
                        BoxShadow(
                          color: const Color(0xFF1E3A8A).withOpacity(0.08),
                          blurRadius: 3,
                          offset: const Offset(0, 1),
                        ),
                      ]
                    : [],
              ),
              child: TextFormField(
                controller: controller,
                readOnly: true,
                style: const TextStyle(
                  fontSize: 12.5,
                  height: 1.1,
                  color: Color(0xFF1E293B),
                  fontWeight: FontWeight.w600,
                ),
                decoration: InputDecoration(
                  isDense: true,
                  labelText: label,
                  labelStyle: TextStyle(
                    fontSize: 12,
                    color: hasFocus
                        ? const Color(0xFF1E3A8A)
                        : const Color(0xFF64748B),
                    fontWeight: FontWeight.w600,
                  ),
                  floatingLabelStyle: const TextStyle(
                    fontSize: 12,
                    color: Color(0xFF1E3A8A),
                    fontWeight: FontWeight.w700,
                  ),
                  floatingLabelBehavior: FloatingLabelBehavior.auto,
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(6),
                    borderSide: const BorderSide(
                      color: Color(0xFFE2E8F0),
                      width: 1,
                    ),
                  ),
                  focusedBorder: const OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(6)),
                    borderSide: BorderSide(
                      color: Color(0xFF1E3A8A),
                      width: 1.25,
                    ),
                  ),
                  contentPadding: const EdgeInsets.symmetric(
                    horizontal: 10,
                    vertical: 8,
                  ),
                  suffixIcon: Icon(
                    Icons.access_time,
                    size: 18,
                    color: hasFocus
                        ? const Color(0xFF1E3A8A)
                        : const Color(0xFF64748B),
                  ),
                  fillColor: Colors.transparent,
                  filled: true,
                ),
                onTap: () async {
                  final time = await showTimePicker(
                    context: context,
                    initialTime: TimeOfDay.now(),
                  );
                  if (time != null) controller.text = time.format(context);
                },
              ),
            );
          },
        ),
      );
    },
  );
}

// 4.  _textArea
Widget textArea(TextEditingController controller, String hint) {
  return StatefulBuilder(
    builder: (context, setState) {
      return Focus(
        onFocusChange: (_) => setState(() {}),
        child: Builder(
          builder: (context) {
            final hasFocus = Focus.of(context).hasFocus;
            return Container(
              constraints: const BoxConstraints(minHeight: 72),
              decoration: BoxDecoration(
                color: const Color(0xFFF8FAFC),
                borderRadius: BorderRadius.circular(6),
                border: Border.all(
                  color: hasFocus
                      ? const Color(0xFF1E3A8A)
                      : const Color(0xFFE2E8F0),
                  width: hasFocus ? 1.25 : 1,
                ),
                boxShadow: hasFocus
                    ? [
                        BoxShadow(
                          color: const Color(0xFF1E3A8A).withOpacity(0.08),
                          blurRadius: 3,
                          offset: const Offset(0, 1),
                        ),
                      ]
                    : [],
              ),
              child: TextFormField(
                controller: controller,
                minLines: 2,
                maxLines: 4,
                style: const TextStyle(
                  fontSize: 12.5,
                  height: 1.2,
                  color: Color(0xFF1E293B),
                  fontWeight: FontWeight.w600,
                ),
                decoration: InputDecoration(
                  isDense: true,
                  hintText: hint,
                  hintStyle: const TextStyle(
                    fontSize: 12,
                    color: Color(0xFF94A3B8),
                    fontWeight: FontWeight.w500,
                  ),
                  border: InputBorder.none,
                  contentPadding: const EdgeInsets.symmetric(
                    horizontal: 10,
                    vertical: 8,
                  ),
                  fillColor: Colors.transparent,
                  filled: true,
                ),
              ),
            );
          },
        ),
      );
    },
  );
}

// 5.  _submitButton
Widget submitButton(void Function() onPressed, String label) {
  return SizedBox(
    width: double.infinity,
    child: ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        backgroundColor: const Color(0xFF1E3A8A),
        foregroundColor: Colors.white,
        padding: const EdgeInsets.symmetric(vertical: 12),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      ),
      child: Text(
        label,
        style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w600),
      ),
    ),
  );
}

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../core/app_colors.dart';
import '../../../core/widgets/text/app_text.dart';
import '../controllers/administrators_controller.dart';

const Color _kLabel = Color(0xFF9C6B78); // uppercase mauve labels
const Color _kFieldBorder = Color(0xFFE7D6DA);

/// Shared warm form used by both "Edit user" and "Add user" dialogs.
/// Matches the uppercase-label Figma dialog.
class AdministratorFormDialog extends StatefulWidget {
  final String title;
  final String subtitle;
  final String submitLabel;
  final String initialName;
  final String initialEmail;
  final String initialPlan;

  const AdministratorFormDialog({
    super.key,
    required this.title,
    required this.subtitle,
    required this.submitLabel,
    this.initialName = '',
    this.initialEmail = '',
    this.initialPlan = 'Monthly – \$12/mo',
  });

  @override
  State<AdministratorFormDialog> createState() => _AdministratorFormDialogState();
}

class _AdministratorFormDialogState extends State<AdministratorFormDialog> {
  late final TextEditingController _name;
  late final TextEditingController _email;
  late final TextEditingController _note;
  late String _plan;
  int _freeMonths = 0;

  static const List<String> _plans = [
    'Monthly – \$12/mo',
    'Annual – \$119/yr',
    'Free',
  ];

  @override
  void initState() {
    super.initState();
    _name = TextEditingController(text: widget.initialName);
    _email = TextEditingController(text: widget.initialEmail);
    _note = TextEditingController();
    _plan = _plans.contains(widget.initialPlan) ? widget.initialPlan : _plans.first;
  }

  @override
  void dispose() {
    _name.dispose();
    _email.dispose();
    _note.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: Colors.transparent,
      insetPadding: const EdgeInsets.all(24),
      child: ConstrainedBox(
        constraints: const BoxConstraints(maxWidth: 440),
        child: Container(
          padding: const EdgeInsets.all(28),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(22),
            boxShadow: const [
              BoxShadow(color: Color(0x1A000000), blurRadius: 30, offset: Offset(0, 12)),
            ],
          ),
          child: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                AppText(data: widget.title, fontSize: 26, fontWeight: FontWeight.w700, fontFamily: 'Georgia'),
                const SizedBox(height: 8),
                AppText(data: widget.subtitle, fontSize: 16, fontWeight: FontWeight.w600, color: _kLabel, height: 1.35),
                const SizedBox(height: 24),
                _label('FULL NAME'),
                _input(controller: _name, hint: 'Enter full name'),
                const SizedBox(height: 20),
                _label('EMAIL'),
                _input(controller: _email, hint: 'Enter email address', keyboardType: TextInputType.emailAddress),
                const SizedBox(height: 20),
                _label('PLAN'),
                _planDropdown(),
                const SizedBox(height: 20),
                _label('FREE MONTHS TO ADD'),
                _stepper(),
                const SizedBox(height: 20),
                _label('ADMIN NOTE'),
                _input(controller: _note, hint: 'Internal note (not show to user)'),
                const SizedBox(height: 26),
                Row(
                  children: [
                    Expanded(child: _button(label: 'Cancel', filled: false, onTap: () => Get.back())),
                    const SizedBox(width: 14),
                    Expanded(
                      flex: 2,
                      child: _button(
                        label: widget.submitLabel,
                        filled: true,
                        onTap: () {
                          // TODO: persist via your API.
                          Get.back();
                          Get.snackbar('Saved', '${widget.submitLabel} applied.');
                        },
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _label(String text) => Padding(
        padding: const EdgeInsets.only(bottom: 10),
        child: AppText(data: text, fontSize: 13, fontWeight: FontWeight.w700, color: _kLabel, letterSpacing: 0.8),
      );

  Widget _input({required TextEditingController controller, required String hint, TextInputType? keyboardType}) {
    return TextField(
      controller: controller,
      keyboardType: keyboardType,
      style: const TextStyle(fontSize: 16, color: AppColors.textPrimary),
      decoration: InputDecoration(
        hintText: hint,
        hintStyle: const TextStyle(color: _kLabel, fontSize: 16),
        filled: true,
        fillColor: Colors.white,
        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: _kFieldBorder),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: AppColors.primary, width: 1.4),
        ),
      ),
    );
  }

  Widget _planDropdown() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      decoration: BoxDecoration(
        border: Border.all(color: _kFieldBorder),
        borderRadius: BorderRadius.circular(12),
      ),
      child: DropdownButtonHideUnderline(
        child: DropdownButton<String>(
          value: _plan,
          isExpanded: true,
          icon: const Icon(Icons.keyboard_arrow_down, color: _kLabel),
          style: const TextStyle(fontSize: 16, color: AppColors.textPrimary),
          items: _plans.map((p) => DropdownMenuItem(value: p, child: Text(p))).toList(),
          onChanged: (v) => setState(() => _plan = v ?? _plan),
        ),
      ),
    );
  }

  Widget _stepper() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
      decoration: BoxDecoration(
        border: Border.all(color: _kFieldBorder),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        children: [
          Expanded(child: AppText(data: '$_freeMonths', fontSize: 16, color: AppColors.textPrimary)),
          Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              InkWell(onTap: () => setState(() => _freeMonths++), child: const Icon(Icons.arrow_drop_up, color: _kLabel)),
              InkWell(onTap: () => setState(() => _freeMonths = _freeMonths > 0 ? _freeMonths - 1 : 0), child: const Icon(Icons.arrow_drop_down, color: _kLabel)),
            ],
          ),
        ],
      ),
    );
  }

  Widget _button({required String label, required bool filled, required VoidCallback onTap}) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(12),
      child: Container(
        height: 54,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: filled ? AppColors.sidebar : Colors.white,
          borderRadius: BorderRadius.circular(12),
          border: filled ? null : Border.all(color: AppColors.inputBorder),
        ),
        child: AppText(data: label, fontSize: 17, fontWeight: FontWeight.w700, color: filled ? Colors.white : AppColors.textPrimary),
      ),
    );
  }
}

class EditAdministratorDialog extends StatelessWidget {
  final AdministratorRow admin;
  const EditAdministratorDialog({super.key, required this.admin});

  @override
  Widget build(BuildContext context) {
    return AdministratorFormDialog(
      title: 'Edit user',
      subtitle: 'Changes are applied immediately. The user will receive an email notification.',
      submitLabel: 'Save Changes',
      initialName: admin.name,
      initialEmail: admin.email,
      initialPlan: admin.plan == 'Annual'
          ? 'Annual – \$119/yr'
          : admin.plan == 'Free'
              ? 'Free'
              : 'Monthly – \$12/mo',
    );
  }
}

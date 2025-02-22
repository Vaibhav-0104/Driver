import 'package:flutter/material.dart';
// ignore: depend_on_referenced_packages
import 'package:multi_select_flutter/multi_select_flutter.dart';

class SendNotificationScreen extends StatefulWidget {
  const SendNotificationScreen({super.key});

  @override
  State<SendNotificationScreen> createState() => _SendNotificationScreenState();
}

class _SendNotificationScreenState extends State<SendNotificationScreen> {
  final _formKey = GlobalKey<FormState>();
  String? _selectedNotificationType;
  final TextEditingController _messageController = TextEditingController();
  List<String> _selectedStudents = [];

  final List<String> _notificationTypes = [
    'Delay',
    'Emergency',
    'Route Change',
  ];

  final List<String> _students = [
    'John Doe',
    'Alice Smith',
    'Robert Brown',
    'Emily Johnson',
    'Michael Davis',
  ];

  bool _selectAll = false;

  void _sendNotification() {
    if (_formKey.currentState!.validate()) {
      String notificationType = _selectedNotificationType ?? 'N/A';
      String message = _messageController.text.trim();
      List<String> selected = _selectedStudents;

      showDialog(
        context: context,
        builder:
            (context) => AlertDialog(
              title: const Text("Notification Sent!"),
              content: Text(
                "**Type:** $notificationType\n **Message:** $message\n **Recipients:** ${selected.isNotEmpty ? selected.join(', ') : 'Entire Bus'}",
              ),
              actions: [
                TextButton(
                  onPressed: () => Navigator.pop(context),
                  child: const Text("OK"),
                ),
              ],
            ),
      );
      _messageController.clear();
      setState(() {
        _selectedStudents.clear();
        _selectAll = false;
      });
    }
  }

  void _toggleSelectAll(bool value) {
    setState(() {
      _selectAll = value;
      _selectedStudents = value ? List.from(_students) : [];
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade100,
      appBar: AppBar(
        title: const Text("Send Notification"),
        backgroundColor: Colors.blue.shade900,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Card(
          elevation: 4,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  _buildDropdownField(),
                  const SizedBox(height: 16),
                  _buildMessageField(),
                  const SizedBox(height: 16),
                  _buildSelectAllCheckbox(),
                  const SizedBox(height: 8),
                  _buildMultiSelectField(),
                  const SizedBox(height: 24),
                  _buildSendButton(),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildDropdownField() {
    return DropdownButtonFormField<String>(
      value: _selectedNotificationType,
      decoration: InputDecoration(
        labelText: 'Notification Type',
        prefixIcon: const Icon(Icons.notifications_active),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
      ),
      items:
          _notificationTypes
              .map((type) => DropdownMenuItem(value: type, child: Text(type)))
              .toList(),
      onChanged: (value) => setState(() => _selectedNotificationType = value),
      validator:
          (value) => value == null ? 'Please select notification type' : null,
    );
  }

  Widget _buildMessageField() {
    return TextFormField(
      controller: _messageController,
      maxLines: 4,
      decoration: InputDecoration(
        labelText: 'Message',
        prefixIcon: const Icon(Icons.message),
        alignLabelWithHint: true,
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
      ),
      validator:
          (value) =>
              value == null || value.isEmpty ? 'Message cannot be empty' : null,
    );
  }

  Widget _buildSelectAllCheckbox() {
    return CheckboxListTile(
      value: _selectAll,
      onChanged: (value) => _toggleSelectAll(value ?? false),
      title: const Text("Select All Students"),
      controlAffinity: ListTileControlAffinity.leading,
      activeColor: Colors.blue.shade800,
    );
  }

  Widget _buildMultiSelectField() {
    return MultiSelectDialogField(
      items:
          _students
              .map((student) => MultiSelectItem(student, student))
              .toList(),
      title: const Text("Select Students"),
      selectedColor: Colors.blue.shade800,
      buttonIcon: const Icon(Icons.people, color: Colors.blueGrey),
      buttonText: const Text("Select Students (Optional)"),
      searchable: true,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.grey),
      ),
      listType: MultiSelectListType.LIST,
      initialValue: _selectedStudents,
      onConfirm: (results) {
        setState(() {
          _selectedStudents = results.cast<String>();
          _selectAll = _selectedStudents.length == _students.length;
        });
      },
      chipDisplay: MultiSelectChipDisplay(
        chipColor: Colors.blue.shade100,
        textStyle: const TextStyle(color: Colors.black87),
      ),
    );
  }

  Widget _buildSendButton() {
    return ElevatedButton.icon(
      onPressed: _sendNotification,
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.blue.shade900,
        padding: const EdgeInsets.symmetric(vertical: 16),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      ),
      icon: const Icon(Icons.send),
      label: const Text("Send Notification", style: TextStyle(fontSize: 16)),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class ViewAttendanceScreen extends StatefulWidget {
  const ViewAttendanceScreen({super.key});

  @override
  State<ViewAttendanceScreen> createState() => _ViewAttendanceScreenState();
}

class _ViewAttendanceScreenState extends State<ViewAttendanceScreen> {
  DateTime _selectedDate = DateTime.now();
  final TextEditingController _searchController = TextEditingController();

  final List<Map<String, dynamic>> _allAttendance = [
    {'name': 'John Doe', 'status': 'Present'},
    {'name': 'Alice Johnson', 'status': 'Absent'},
    {'name': 'Michael Smith', 'status': 'Present'},
    {'name': 'Emma Williams', 'status': 'Absent'},
    {'name': 'Robert Brown', 'status': 'Present'},
    {'name': 'Sophia Davis', 'status': 'Present'},
    {'name': 'James Wilson', 'status': 'Absent'},
  ];

  List<Map<String, dynamic>> _filteredAttendance = [];

  @override
  void initState() {
    super.initState();
    _filteredAttendance = _allAttendance;
  }

  void _filterAttendance(String query) {
    setState(() {
      _filteredAttendance =
          _allAttendance
              .where(
                (student) =>
                    student['name'].toLowerCase().contains(query.toLowerCase()),
              )
              .toList();
    });
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: _selectedDate,
      firstDate: DateTime(2024, 1),
      lastDate: DateTime(2025, 12),
    );
    if (picked != null && picked != _selectedDate) {
      setState(() {
        _selectedDate = picked;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade100,
      appBar: AppBar(
        title: const Text("View Student Attendance"),
        backgroundColor: Colors.blue.shade900,
        elevation: 0,
      ),
      body: Column(
        children: [
          _buildDatePicker(context),
          _buildSearchBar(),
          Expanded(child: _buildAttendanceList()),
        ],
      ),
    );
  }

  Widget _buildDatePicker(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            "Selected Date: ${DateFormat('dd/MM/yyyy').format(_selectedDate)}",
            style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
          ),
          ElevatedButton.icon(
            onPressed: () => _selectDate(context),
            icon: const Icon(Icons.calendar_today),
            label: const Text("Pick Date"),
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.blue.shade800,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSearchBar() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: TextField(
        controller: _searchController,
        onChanged: _filterAttendance,
        decoration: InputDecoration(
          prefixIcon: const Icon(Icons.search),
          hintText: "Search student by name...",
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
        ),
      ),
    );
  }

  Widget _buildAttendanceList() {
    if (_filteredAttendance.isEmpty) {
      return const Center(
        child: Text(
          "No students found for the selected date.",
          style: TextStyle(fontSize: 16, color: Colors.grey),
        ),
      );
    }
    return ListView.separated(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      itemCount: _filteredAttendance.length,
      separatorBuilder: (context, index) => const Divider(),
      itemBuilder: (context, index) {
        final student = _filteredAttendance[index];
        return ListTile(
          tileColor:
              student['status'] == 'Present'
                  ? Colors.green.shade50
                  : Colors.red.shade50,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          contentPadding: const EdgeInsets.symmetric(
            horizontal: 16,
            vertical: 12,
          ),
          leading: CircleAvatar(
            backgroundColor:
                student['status'] == 'Present' ? Colors.green : Colors.red,
            child: Icon(
              student['status'] == 'Present' ? Icons.check : Icons.close,
              color: Colors.white,
            ),
          ),
          title: Text(
            student['name'],
            style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
          ),
          trailing: Text(
            student['status'],
            style: TextStyle(
              color:
                  student['status'] == 'Present'
                      ? Colors.green.shade800
                      : Colors.red.shade800,
              fontWeight: FontWeight.bold,
            ),
          ),
        );
      },
    );
  }
}

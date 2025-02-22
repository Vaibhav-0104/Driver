import 'package:flutter/material.dart';

class ViewStudentDetailsScreen extends StatefulWidget {
  const ViewStudentDetailsScreen({super.key});

  @override
  State<ViewStudentDetailsScreen> createState() =>
      _ViewStudentDetailsScreenState();
}

class _ViewStudentDetailsScreenState extends State<ViewStudentDetailsScreen> {
  final List<Map<String, dynamic>> _students = [
    {
      'id': 'STU001',
      'name': 'John Doe',
      'seat': 'A1',
      'class': 'B.Tech CSE',
      'phone': '+91-9876543210',
      'email': 'john@example.com',
    },
    {
      'id': 'STU002',
      'name': 'Alice Smith',
      'seat': 'A2',
      'class': 'B.Sc Physics',
      'phone': '+91-8765432109',
      'email': 'alice@example.com',
    },
    {
      'id': 'STU003',
      'name': 'Robert Brown',
      'seat': null,
      'class': 'MBA Finance',
      'phone': '+91-7890123456',
      'email': 'robert@example.com',
    },
    {
      'id': 'STU004',
      'name': 'Emily Johnson',
      'seat': 'B1',
      'class': 'BCA',
      'phone': '+91-7654321098',
      'email': 'emily@example.com',
    },
  ];

  List<Map<String, dynamic>> _filteredStudents = [];

  @override
  void initState() {
    super.initState();
    _filteredStudents = List.from(_students);
  }

  void _filterStudents(String query) {
    final filtered =
        _students.where((student) {
          final nameLower = student['name'].toLowerCase();
          final idLower = student['id'].toLowerCase();
          final classLower = student['class'].toLowerCase();
          final searchLower = query.toLowerCase();

          return nameLower.contains(searchLower) ||
              idLower.contains(searchLower) ||
              classLower.contains(searchLower);
        }).toList();

    setState(() {
      _filteredStudents = filtered;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade100,
      appBar: AppBar(
        title: const Text("View Student Details"),
        backgroundColor: Colors.blue.shade900,
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            _buildSearchBar(),
            const SizedBox(height: 16),
            Expanded(
              child: Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
                elevation: 4,
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child:
                        _filteredStudents.isNotEmpty
                            ? DataTable(
                              columns: const [
                                DataColumn(label: Text('Student ID')),
                                DataColumn(label: Text('Name')),
                                DataColumn(label: Text('Seat')),
                                DataColumn(label: Text('Class')),
                                DataColumn(label: Text('Phone')),
                                DataColumn(label: Text('Email')),
                              ],
                              rows:
                                  _filteredStudents
                                      .map(
                                        (student) => DataRow(
                                          cells: [
                                            DataCell(Text(student['id'] ?? '')),
                                            DataCell(
                                              Text(student['name'] ?? ''),
                                            ),
                                            DataCell(
                                              Text(
                                                student['seat'] ??
                                                    'Not Assigned',
                                              ),
                                            ),
                                            DataCell(
                                              Text(student['class'] ?? ''),
                                            ),
                                            DataCell(
                                              Text(student['phone'] ?? ''),
                                            ),
                                            DataCell(
                                              Text(student['email'] ?? ''),
                                            ),
                                          ],
                                        ),
                                      )
                                      .toList(),
                            )
                            : const Center(
                              child: Text(
                                "No students found.",
                                style: TextStyle(fontSize: 18),
                              ),
                            ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSearchBar() {
    return TextField(
      onChanged: _filterStudents,
      decoration: InputDecoration(
        hintText: 'Search by Name, ID, or Class...',
        prefixIcon: const Icon(Icons.search),
        filled: true,
        fillColor: Colors.white,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: BorderSide.none,
        ),
      ),
    );
  }
}

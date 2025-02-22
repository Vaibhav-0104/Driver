import 'package:flutter/material.dart';
import 'package:driver_panel/screen/login/driver_login_screen.dart';
import 'package:driver_panel/screen/student_details/view_student_details.dart';
import 'package:driver_panel/screen/notifications/send_notification_screen.dart';
import 'package:driver_panel/screen/notifications/view_notification_screen.dart';
import 'package:driver_panel/screen/attendance/view_student_attendance_screen.dart';

class DriverDashboardScreen extends StatefulWidget {
  const DriverDashboardScreen({super.key});

  @override
  _DriverDashboardScreenState createState() => _DriverDashboardScreenState();
}

class _DriverDashboardScreenState extends State<DriverDashboardScreen> {
  void _onItemTapped(int index) {
    switch (index) {
      case 1:
        _navigateTo(ViewStudentDetailsScreen());
        break;
      case 2:
        _navigateTo(SendNotificationScreen());
        break;
      case 3:
        _navigateTo(ViewNotificationsScreen());
        break;
      case 4:
        _navigateTo(ViewAttendanceScreen());
        break;
      case 5:
        _performLogout();
        break;
    }
  }

  void _navigateTo(Widget screen) {
    Navigator.push(context, MaterialPageRoute(builder: (context) => screen));
  }

  void _performLogout() {
    Navigator.of(context).pushReplacement(
      MaterialPageRoute(builder: (context) => DriverLoginScreen()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade100,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.blue.shade900,
        title: Text('Dashboard', style: TextStyle(color: Colors.white)),
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            DrawerHeader(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [Colors.blue.shade900, Colors.blue.shade700],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
              ),
              child: Text(
                'Driver Menu',
                style: TextStyle(color: Colors.white, fontSize: 24),
              ),
            ),
            _buildDrawerItem(Icons.person, "View Student Details", 1),
            _buildDrawerItem(Icons.send, "Send Notification", 2),
            _buildDrawerItem(Icons.notifications, "View Notification", 3),
            _buildDrawerItem(
              Icons.calendar_today,
              "View Student Attendance",
              4,
            ),
            _buildDrawerItem(Icons.logout, "Logout", 5),
          ],
        ),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildBusDetailsCard(),
            SizedBox(height: 16),
            _buildOverviewSection(),
            SizedBox(height: 16),
            _buildAttendanceSummaryCard(),
          ],
        ),
      ),
    );
  }

  Widget _buildDrawerItem(IconData icon, String title, int index) {
    return ListTile(
      leading: Icon(icon, color: Colors.blue.shade800),
      title: Text(title, style: TextStyle(fontWeight: FontWeight.bold)),
      onTap: () => _onItemTapped(index),
    );
  }

  Widget _buildBusDetailsCard() {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      elevation: 5,
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          gradient: LinearGradient(
            colors: [Colors.indigo.shade400, Colors.indigo.shade200],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        padding: EdgeInsets.all(20),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            _busDetailItem("Bus Number", "BUS-101"),
            _busDetailItem("Route", "City Center - Campus"),
            _busDetailItem("Capacity", "40 Students"),
          ],
        ),
      ),
    );
  }

  Widget _busDetailItem(String title, String value) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: TextStyle(color: Colors.white70, fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 5),
        Text(
          value,
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
      ],
    );
  }

  Widget _buildOverviewSection() {
    return Row(
      children: [
        _overviewCard("Total Students", "35"),
        SizedBox(width: 16),
        _overviewCard("Latest Notification", "Route Updated"),
      ],
    );
  }

  Widget _overviewCard(String title, String value) {
    return Expanded(
      child: Card(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        elevation: 4,
        child: Padding(
          padding: EdgeInsets.all(18),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: TextStyle(
                  color: Colors.grey,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 12),
              Text(
                value,
                style: TextStyle(
                  fontSize: 26,
                  fontWeight: FontWeight.bold,
                  color: Colors.blue.shade900,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildAttendanceSummaryCard() {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      elevation: 5,
      child: Padding(
        padding: EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Attendance Summary",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                _attendanceSummaryItem("Present", "30"),
                _attendanceSummaryItem("Absent", "5"),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _attendanceSummaryItem(String title, String value) {
    return Column(
      children: [
        Text(
          value,
          style: TextStyle(
            fontSize: 26,
            fontWeight: FontWeight.bold,
            color: Colors.green.shade600,
          ),
        ),
        SizedBox(height: 6),
        Text(title, style: TextStyle(color: Colors.grey)),
      ],
    );
  }
}

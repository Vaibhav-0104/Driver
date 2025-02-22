import 'package:flutter/material.dart';

class ViewNotificationsScreen extends StatefulWidget {
  const ViewNotificationsScreen({super.key});

  @override
  State<ViewNotificationsScreen> createState() =>
      _ViewNotificationsScreenState();
}

class _ViewNotificationsScreenState extends State<ViewNotificationsScreen> {
  final TextEditingController _searchController = TextEditingController();

  List<Map<String, dynamic>> _notifications = [
    {
      'type': 'Delay',
      'message': 'Bus 12 will be 15 minutes late due to traffic.',
      'date': DateTime(2025, 2, 20, 10, 30),
      'read': false,
    },
    {
      'type': 'Emergency',
      'message': 'Emergency maintenance required on Bus 8.',
      'date': DateTime(2025, 2, 19, 9, 15),
      'read': true,
    },
    {
      'type': 'Route Change',
      'message': 'Bus 3 will follow an alternative route today.',
      'date': DateTime(2025, 2, 18, 7, 45),
      'read': false,
    },
    {
      'type': 'Festival Greetings',
      'message': 'Happy Diwali! Wishing you a prosperous year ahead.',
      'date': DateTime(2025, 2, 10, 12, 0),
      'read': true,
    },
  ];

  List<Map<String, dynamic>> _filteredNotifications = [];

  @override
  void initState() {
    super.initState();
    _filteredNotifications = _notifications;
  }

  void _toggleReadStatus(int index) {
    setState(() {
      _filteredNotifications[index]['read'] =
          !_filteredNotifications[index]['read'];
    });
  }

  void _filterNotifications(String query) {
    setState(() {
      _filteredNotifications =
          _notifications
              .where(
                (notification) =>
                    notification['type'].toLowerCase().contains(
                      query.toLowerCase(),
                    ) ||
                    notification['message'].toLowerCase().contains(
                      query.toLowerCase(),
                    ),
              )
              .toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade100,
      appBar: AppBar(
        title: const Text("View Notifications"),
        backgroundColor: Colors.blue.shade900,
        elevation: 0,
      ),
      body: Column(
        children: [
          _buildSearchBar(),
          Expanded(child: _buildNotificationList()),
        ],
      ),
    );
  }

  Widget _buildSearchBar() {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: TextField(
        controller: _searchController,
        onChanged: _filterNotifications,
        decoration: InputDecoration(
          prefixIcon: const Icon(Icons.search),
          hintText: "Search notifications...",
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
        ),
      ),
    );
  }

  Widget _buildNotificationList() {
    if (_filteredNotifications.isEmpty) {
      return const Center(
        child: Text(
          "No notifications found.",
          style: TextStyle(fontSize: 16, color: Colors.grey),
        ),
      );
    }
    return ListView.separated(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      itemCount: _filteredNotifications.length,
      separatorBuilder: (context, index) => const Divider(),
      itemBuilder: (context, index) {
        final notification = _filteredNotifications[index];
        return ListTile(
          tileColor: notification['read'] ? Colors.grey.shade200 : Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          contentPadding: const EdgeInsets.symmetric(
            horizontal: 16,
            vertical: 12,
          ),
          title: Text(
            notification['type'],
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: Colors.blue.shade800,
            ),
          ),
          subtitle: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 4),
              Text(
                notification['message'],
                style: const TextStyle(color: Colors.black87),
              ),
              const SizedBox(height: 8),
              Text(
                _formatDate(notification['date']),
                style: const TextStyle(color: Colors.grey, fontSize: 12),
              ),
            ],
          ),
          trailing: IconButton(
            icon: Icon(
              notification['read']
                  ? Icons.mark_email_read
                  : Icons.mark_email_unread,
              color: notification['read'] ? Colors.green : Colors.red,
            ),
            onPressed: () => _toggleReadStatus(index),
            tooltip: notification['read'] ? "Mark as Unread" : "Mark as Read",
          ),
        );
      },
    );
  }

  String _formatDate(DateTime date) {
    return "${date.day}/${date.month}/${date.year} - ${date.hour}:${date.minute.toString().padLeft(2, '0')}";
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fluttertest/providers/events_provider.dart';
import '../models/event_list_item.dart';
import '../utils/formatters.dart';

class EventsScreen extends ConsumerStatefulWidget {
  const EventsScreen({super.key});

  @override
  ConsumerState<EventsScreen> createState() => _EventsScreenState();
}

class _EventsScreenState extends ConsumerState<EventsScreen>
    with SingleTickerProviderStateMixin {
  // Declare TabController
  late TabController _tabController;

  // Lists to store events
  List<EventListItem> upcomingEvents = [];
  List<EventListItem> historyEvents = [];

  @override
  void initState() {
    super.initState();
    // Initialize TabController with 2 tabs
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  void dispose() {
    _tabController
        .dispose(); // Dispose TabController when the widget is destroyed
    super.dispose();
  }

  void _updateEventLists(List<EventListItem> eventsList) {
    setState(() {
      upcomingEvents = eventsList.where((event) => event.isUpcoming).toList();
      historyEvents = eventsList.where((event) => !event.isUpcoming).toList();
    });
  }

  // Function to handle refresh
  Future<void> _onRefresh() async {
    // Trigger a refresh of the events provider
    ref.refresh(eventsProvider);
  }

  @override
  Widget build(BuildContext context) {
    final eventsAsyncValue = ref.watch(eventsProvider);

    // Handle loading and error states
    return eventsAsyncValue.when(
      loading: () => const Center(child: CircularProgressIndicator()),
      error: (error, stackTrace) => Center(child: Text('Error: $error')),
      data: (eventsList) {
        _updateEventLists(eventsList);

        return Scaffold(
          appBar: AppBar(title: const Text('Events'), centerTitle: true),
          body: Column(
            children: [
              // TabBar without AppBar
              TabBar(
                controller: _tabController,
                tabs: const [
                  Tab(text: 'Upcoming Events'),
                  Tab(text: 'Event History'),
                ],
              ),
              Expanded(
                child: RefreshIndicator(
                  onRefresh: _onRefresh,
                  child: TabBarView(
                    controller: _tabController,
                    children: [
                      // Upcoming Events Tab
                      _buildEventTab(upcomingEvents, "No upcoming events"),
                      // History Events Tab
                      _buildEventTab(historyEvents, "No history events"),
                    ],
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  // Widget to build the event list or show a message if empty
  Widget _buildEventTab(List<EventListItem> events, String emptyMessage) {
    return events.isEmpty
        ? _showNoDataMessage(emptyMessage)
        : _buildEventList(events);
  }

  // Widget to show a message when no data is available
  Widget _showNoDataMessage(String message) {
    return Center(
      child: Text(
        message,
        style: const TextStyle(fontSize: 16, color: Colors.grey),
      ),
    );
  }

  // Widget to build the event list
  Widget _buildEventList(List<EventListItem> events) {
    return ListView.builder(
      physics:
          const AlwaysScrollableScrollPhysics(), // Ensure the ListView is always scrollable
      itemCount: events.length,
      itemBuilder: (context, index) {
        final event = events[index];
        return _buildEventCard(event, context);
      },
    );
  }

  String _formatDate(DateTime startDate, DateTime endDate) {
    if (startDate.year == endDate.year &&
        startDate.month == endDate.month &&
        startDate.day == endDate.day) {
      return '${Formatters.formatDate(startDate)} At ${Formatters.formatTime(startDate)}';
    } else {
      Duration difference = endDate.difference(startDate);
      int days = difference.inDays;
      int hours = difference.inHours % 24;
      return '${Formatters.formatDate(startDate)} At ${Formatters.formatTime(startDate)} \nDuration: $days Days $hours Hours';
    }
  }

  Widget _buildEventCard(EventListItem eventItem, BuildContext context) {
    return Card(
      elevation: 4,
      margin: const EdgeInsets.only(bottom: 10),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: ListTile(
        contentPadding: const EdgeInsets.all(10),
        title: Text(
          eventItem.title,
          style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),
        subtitle: Text(_formatDate(eventItem.startDate, eventItem.endDate)),
        leading: Icon(
          Icons.time_to_leave,
          color: Theme.of(context).colorScheme.primary,
        ),
        trailing:
            eventItem.isUpcoming
                ? ElevatedButton(
                  onPressed: () => _onRequestEvent(context, eventItem),
                  child: const Text('Join'),
                )
                : null,
      ),
    );
  }

  // Handle event request action
  void _onRequestEvent(BuildContext context, EventListItem event) {
    showDialog(
      context: context,
      builder:
          (context) => AlertDialog(
            title: const Text('Join Event'),
            content: Text(
              'Do you want to accept the join request for ${event.title}?',
            ),
            actions: [
              TextButton(
                onPressed: () => Navigator.of(context).pop(),
                child: const Text('Cancel'),
              ),
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text(
                        'You have requested to join ${event.title}.',
                      ),
                    ),
                  );
                },
                child: const Text('Request'),
              ),
            ],
          ),
    );
  }
}

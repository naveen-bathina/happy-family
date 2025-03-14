import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fluttertest/models/todo_item.dart';
import 'package:fluttertest/providers/location_provider.dart';
import 'package:fluttertest/providers/todo_provider.dart';
import 'package:fluttertest/utils/formatters.dart';
import 'package:fluttertest/widgets/special_day_widget.dart';
import 'package:fluttertest/widgets/todo_card_widget.dart';

class HomePageScreen extends ConsumerStatefulWidget {
  const HomePageScreen({super.key});

  @override
  _HomePageScreenState createState() => _HomePageScreenState();
}

class _HomePageScreenState extends ConsumerState<HomePageScreen> {
  @override
  Widget build(BuildContext context) {
    String currentDate = Formatters.formatDateWithWeekDay(DateTime.now());
    String specialDay = "Happy Birthday, Jane!";

    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildGreetingSection(context),
            const SizedBox(height: 10),
            _buildLocationDateSection(currentDate, context),
            _buildSpecialDaySection(specialDay, context),
            const SizedBox(height: 20),
            Expanded(child: _buildRemindersAndTodoList()),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _showActionMenu(context),
        backgroundColor: Colors.orangeAccent,
        child: const Icon(Icons.add),
      ),
    );
  }

  /// Greeting Section
  Widget _buildGreetingSection(BuildContext context) {
    String greeting;
    int currentHour = DateTime.now().hour;
    if (currentHour < 12) {
      greeting = 'Good Morning, John!';
    } else if (currentHour < 18) {
      greeting = 'Good Afternoon, John!';
    } else {
      greeting = 'Good Evening, John!';
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(greeting, style: Theme.of(context).textTheme.headlineSmall),
        const SizedBox(height: 10),
        Text(
          'Here is what\'s happening in your family today:',
          style: Theme.of(context).textTheme.labelLarge,
        ),
      ],
    );
  }

  /// Location & Date Section
  Widget _buildLocationDateSection(String date, BuildContext context) {
    final cityAsyncValue = ref.watch(locationProvider);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            const Icon(Icons.location_pin, color: Colors.red, size: 24),
            const SizedBox(width: 5),
            cityAsyncValue.when(
              data:
                  (location) => Text(
                    location,
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
              error:
                  (error, _) => Text(
                    'Error: $error',
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
              loading:
                  () => Text(
                    'Loading...',
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
            ),
          ],
        ),
        const SizedBox(height: 5),
        Text(
          date,
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w400,
            color: Colors.grey[600],
          ),
        ),
      ],
    );
  }

  /// Special Day Section
  Widget _buildSpecialDaySection(String specialDay, BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10.0),
      child: SpecialDayWidget(specialDay: specialDay),
    );
  }

  /// Displays the Bottom Sheet for adding Reminders & To-Dos
  void _showActionMenu(BuildContext context) {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(12)),
      ),
      builder: (context) {
        return Padding(
          padding: const EdgeInsets.all(12.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ListTile(
                leading: const Icon(Icons.add_alarm),
                title: const Text("Add Reminder"),
                onTap: () {
                  Navigator.pop(context);
                  //_showAddReminderDialog(context);
                },
              ),
              ListTile(
                leading: const Icon(Icons.check_box),
                title: const Text("Add To-Do"),
                onTap: () {
                  Navigator.pop(context);
                  _showAddTodoDialog(context);
                },
              ),
              ListTile(
                leading: const Icon(Icons.refresh),
                title: const Text("Refresh"),
                onTap: () {
                  Navigator.pop(context);
                  _refreshContent();
                },
              ),
            ],
          ),
        );
      },
    );
  }

  /// Refresh Content (Invalidates Providers)
  void _refreshContent() {
    ref.invalidate(todoProvider);
    ref.invalidate(locationProvider);
  }

  /// To-Do Dialog with Due Date Picker
  void _showAddTodoDialog(BuildContext context) {
    final TextEditingController todoController = TextEditingController();
    DateTime? selectedDueDate;

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return StatefulBuilder(
          builder: (context, setState) {
            return AlertDialog(
              title: const Text("Add To-Do"),
              content: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  TextField(
                    controller: todoController,
                    decoration: const InputDecoration(
                      hintText: "Enter task...",
                    ),
                  ),
                  const SizedBox(height: 10),
                  Row(
                    children: [
                      const Icon(Icons.calendar_today, size: 20),
                      const SizedBox(width: 8),
                      Text(
                        selectedDueDate == null
                            ? "Select Due Date"
                            : Formatters.formatDateWithWeekDay(
                              selectedDueDate!,
                            ),
                        style: const TextStyle(fontSize: 16),
                      ),
                      const Spacer(),
                      IconButton(
                        icon: const Icon(
                          Icons.date_range,
                          color: Colors.blueAccent,
                        ),
                        onPressed: () async {
                          DateTime? pickedDate = await showDatePicker(
                            context: context,
                            initialDate: DateTime.now(),
                            firstDate: DateTime.now(),
                            lastDate: DateTime(2100),
                          );
                          if (pickedDate != null) {
                            setState(() {
                              selectedDueDate = pickedDate;
                            });
                          }
                        },
                      ),
                    ],
                  ),
                ],
              ),
              actions: [
                TextButton(
                  onPressed: () {
                    if (todoController.text.isNotEmpty &&
                        selectedDueDate != null) {
                      ref
                          .read(todoProvider.notifier)
                          .addTodo(
                            TodoItem(
                              id: DateTime.now().toString(),
                              title: todoController.text,
                              dueDate: selectedDueDate!,
                              isCompleted: false,
                              assignedTo: 'naveen.bathina',
                              assignedBy: 'naveen.bathina',
                            ),
                          );
                    }
                    Navigator.pop(context);
                  },
                  child: const Text("Add"),
                ),
                TextButton(
                  onPressed: () => Navigator.pop(context),
                  child: const Text("Cancel"),
                ),
              ],
            );
          },
        );
      },
    );
  }

  /// Builds To-Do List & Reminders
  Widget _buildRemindersAndTodoList() {
    return ListView(
      children: [
        _buildSectionHeader("Reminders"),
        _buildReminderCard('Pick up groceries', 'Today, 3:00 PM'),
        _buildReminderCard('Doctor\'s Appointment', 'Tomorrow, 10:00 AM'),
        const SizedBox(height: 20),
        _buildSectionHeader("To-Do List"),
        _buildTodoCards(),
      ],
    );
  }

  Widget _buildSectionHeader(String title) {
    return Text(
      title,
      style: const TextStyle(
        fontSize: 18,
        fontWeight: FontWeight.bold,
        color: Colors.blueAccent,
      ),
    );
  }

  Widget _buildReminderCard(String task, String time) {
    return Card(
      elevation: 4,
      margin: const EdgeInsets.only(bottom: 10),
      child: ListTile(
        title: Text(
          task,
          style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),
        subtitle: Text(time, style: TextStyle(color: Colors.grey[600])),
        leading: const Icon(Icons.notifications, color: Colors.orangeAccent),
        trailing: const Icon(Icons.check_circle, color: Colors.green),
      ),
    );
  }

  Widget _buildTodoCards() {
    final todoItems = ref.watch(
      todoProvider,
    ); // Directly get the List<TodoItem>

    if (todoItems.isEmpty) {
      return const Center(child: Text("No To-Dos yet. Add one!"));
    }

    return Column(
      children: todoItems.map((task) => TodoCard(task: task)).toList(),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fluttertest/providers/family_info_provider.dart';
import 'member_detail_screen.dart';

class FamilyInfoScreen extends ConsumerWidget {
  const FamilyInfoScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final familyInfoAsyncValue = ref.watch(familyInfoProvider);

    return Scaffold(
      body: SafeArea(
        child: familyInfoAsyncValue.when(
          data: (familyInfo) {
            return Column(
              children: [
                // Family name header
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  child: Text(
                    "${familyInfo.familyName} Family",
                    style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                      fontWeight: FontWeight.bold,
                      color: Theme.of(context).primaryColor,
                    ),
                  ),
                ),

                // Family image
                Card(
                  semanticContainer: true,
                  clipBehavior: Clip.antiAliasWithSaveLayer,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  elevation: 5,
                  margin: const EdgeInsets.all(10),
                  child: Image.network(
                    familyInfo.groupPhotoUrl,
                    fit: BoxFit.cover,
                    height: 200, // Set a fixed height for the image
                    width: double.infinity, // Make the image full width
                  ),
                ),

                // Members list
                Expanded(
                  child: ListView.builder(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    itemCount: familyInfo.familyMembers.length,
                    itemBuilder: (context, index) {
                      final member = familyInfo.familyMembers[index];
                      return Card(
                        margin: const EdgeInsets.only(bottom: 16),
                        elevation: 2,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: ListTile(
                          contentPadding: const EdgeInsets.all(16),
                          leading: CircleAvatar(
                            backgroundImage: NetworkImage(
                              member.displayPicture,
                            ),
                            backgroundColor: Theme.of(context).indicatorColor,
                            radius: 30,
                          ),
                          title: Text(
                            '${member.firstName} ${member.lastName}',
                            style: Theme.of(context).textTheme.titleMedium
                                ?.copyWith(fontWeight: FontWeight.bold),
                          ),
                          subtitle: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                member.role,
                                style: Theme.of(context).textTheme.bodyMedium,
                              ),
                              Text(
                                member.relation,
                                style: Theme.of(context).textTheme.bodyMedium,
                              ),
                            ],
                          ),
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder:
                                    (context) =>
                                        MemberDetailsScreen(member: member),
                              ),
                            );
                          },
                          trailing: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              // Chat button
                              IconButton(
                                icon: const Icon(
                                  Icons.chat,
                                  color: Colors.blue,
                                ),
                                onPressed: () {
                                  // Handle chat action
                                  print(
                                    'Chat with ${member.firstName} ${member.lastName}',
                                  );
                                },
                              ),
                              // Call button
                              IconButton(
                                icon: const Icon(
                                  Icons.call,
                                  color: Colors.green,
                                ),
                                onPressed: () {
                                  // Handle call action
                                  print(
                                    'Call ${member.firstName} ${member.lastName}',
                                  );
                                },
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ],
            );
          },
          error: (error, stackTrace) {
            return Center(
              child: Text(
                'Failed to load family information: $error',
                style: const TextStyle(fontSize: 16, color: Colors.red),
              ),
            );
          },
          loading: () {
            return const Center(child: CircularProgressIndicator());
          },
        ),
      ),
    );
  }
}

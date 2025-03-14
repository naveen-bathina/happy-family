import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fluttertest/providers/profile_provider.dart';

class ProfileScreen extends ConsumerWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final userProfileAsyncValue = ref.watch(profileProvider);

    return Scaffold(
      appBar: AppBar(title: const Text('Profile'), centerTitle: true),
      body: userProfileAsyncValue.when(
        data: (userProfile) {
          return SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 24),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Profile Picture
                Center(
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(100), // Rounded image
                    child: Image.network(
                      userProfile.displayPicture,
                      width: 120, // Responsive size
                      height: 120,
                      fit: BoxFit.cover,
                      errorBuilder: (context, error, stackTrace) {
                        return const Icon(
                          Icons.person,
                          size: 120,
                          color: Colors.grey,
                        );
                      },
                    ),
                  ),
                ),
                const SizedBox(height: 24),

                // Profile Details
                _buildProfileCard(
                  context: context,
                  title: 'Full Name',
                  value: '${userProfile.firstName} ${userProfile.lastName}',
                  icon: Icons.person,
                ),
                _buildProfileCard(
                  context: context,
                  title: 'Role',
                  value: userProfile.role,
                  icon: Icons.work,
                ),
                _buildProfileCard(
                  context: context,
                  title: 'Relation',
                  value: userProfile.relation,
                  icon: Icons.family_restroom,
                ),
                _buildProfileCard(
                  context: context,
                  title: 'Contact',
                  value: userProfile.contactNumber,
                  icon: Icons.phone,
                ),
                _buildProfileCard(
                  context: context,
                  title: 'Email',
                  value: userProfile.emailAddress,
                  icon: Icons.email,
                ),
                _buildProfileCard(
                  context: context,
                  title: 'Address',
                  value: userProfile.address,
                  icon: Icons.location_on,
                ),
              ],
            ),
          );
        },
        loading: () => const Center(child: CircularProgressIndicator()),
        error:
            (e, stack) => Center(
              child: Text(
                'Failed to load profile: $e',
                style: const TextStyle(fontSize: 16, color: Colors.red),
              ),
            ),
      ),
    );
  }

  // Helper function to build profile card with title and value
  Widget _buildProfileCard({
    required BuildContext context,
    required String title,
    required String value,
    required IconData icon,
  }) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 10),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      elevation: 4,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Row(
          children: [
            Icon(icon, size: 30, color: Theme.of(context).primaryColor),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.bold,
                      color: Theme.of(context).primaryColor,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    value,
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      color: Colors.black87,
                      fontSize: 16,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

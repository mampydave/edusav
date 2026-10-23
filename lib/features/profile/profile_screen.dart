import 'package:edusav/core/constants/app_colors.dart';
import 'package:edusav/features/auth/domain/auth_user.dart';
import 'package:edusav/features/auth/presentation/auth_controller.dart';
import 'package:edusav/features/profile/profile_providers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ProfileScreen extends ConsumerWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final authState = ref.watch(authControllerProvider);

    return Scaffold(
      appBar: AppBar(title: const Text('Mon profil')),
      body: authState.when(
        data: (state) {
          if (state is! AuthAuthenticated) {
            return const Center(child: Text('Aucun utilisateur connecté.'));
          }
          return _ProfileDetails(user: state.user);
        },
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (error, _) => Center(child: Text('Erreur : $error')),
      ),
    );
  }
}

class _ProfileDetails extends StatelessWidget {
  final AuthUser user;

  const _ProfileDetails({required this.user});

  @override
  Widget build(BuildContext context) {
    final initial = user.name.trim().isEmpty
        ? '?'
        : user.name.trim().substring(0, 1).toUpperCase();

    return ListView(
      padding: const EdgeInsets.all(24),
      children: [
        const SizedBox(height: 24),
        Center(
          child: CircleAvatar(
            radius: 44,
            backgroundColor: AppColors.primary,
            child: Text(
              initial,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 32,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ),
        const SizedBox(height: 16),
        Text(
          user.name,
          textAlign: TextAlign.center,
          style: Theme.of(context).textTheme.headlineSmall,
        ),
        const SizedBox(height: 32),
        _ProfileField(
          icon: Icons.person_outline,
          label: 'Nom',
          value: user.name,
        ),
        const Divider(height: 1),
        _ProfileField(
          icon: Icons.email_outlined,
          label: 'Adresse e-mail',
          value: user.email,
        ),
        const Divider(height: 1),
        Consumer(
          builder: (context, ref, _) {
            final roleNameAsync = ref.watch(profileRoleNameProvider);
            final hasRoleId = user.roleId?.trim().isNotEmpty ?? false;
            return roleNameAsync.when(
              data: (roleName) => _ProfileField(
                icon: Icons.badge_outlined,
                label: 'Rôle',
                value:
                    roleName ??
                    (hasRoleId ? 'Rôle introuvable' : 'Aucun rôle associé'),
              ),
              loading: () => const ListTile(
                leading: Icon(Icons.badge_outlined, color: AppColors.primary),
                title: Text('Rôle'),
                subtitle: LinearProgressIndicator(),
              ),
              error: (_, _) => _ProfileField(
                icon: Icons.badge_outlined,
                label: 'Rôle',
                value: user.roleName ?? 'Rôle indisponible',
              ),
            );
          },
        ),
      ],
    );
  }
}

class _ProfileField extends StatelessWidget {
  final IconData icon;
  final String label;
  final String value;

  const _ProfileField({
    required this.icon,
    required this.label,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      contentPadding: const EdgeInsets.symmetric(vertical: 8),
      leading: Icon(icon, color: AppColors.primary),
      title: Text(label, style: Theme.of(context).textTheme.labelMedium),
      subtitle: Text(value, style: Theme.of(context).textTheme.bodyLarge),
    );
  }
}

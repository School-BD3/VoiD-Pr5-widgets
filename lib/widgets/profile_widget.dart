import 'package:flutter/material.dart';
import '../models/user.dart';

class ProfileWidget extends StatelessWidget {
  final User user;
  final VoidCallback? onEditPressed;
  final bool isCompact;

  const ProfileWidget({
    super.key,
    required this.user,
    this.onEditPressed,
    this.isCompact = false,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Row(
          children: [
            CircleAvatar(
              radius: isCompact ? 24 : 36,
              backgroundImage: NetworkImage(user.avatarUrl),
              onBackgroundImageError: (_, _) {},
              child: null,
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    user.name,
                    style: theme.textTheme.titleMedium,
                  ),
                  if (!isCompact) ...[
                    const SizedBox(height: 4),
                    Text(
                      user.email,
                      style: theme.textTheme.bodyMedium,
                    ),
                  ],
                ],
              ),
            ),
            if (onEditPressed != null)
              IconButton(
                onPressed: onEditPressed,
                tooltip: 'Редактировать профиль',
                icon: const Icon(Icons.edit),
              ),
          ],
        ),
      ),
    );
  }
}
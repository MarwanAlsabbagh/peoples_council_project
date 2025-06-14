import 'package:flutter/material.dart';

import '../../models/issue_model.dart';

class IssueCard extends StatelessWidget {
  final Issue issue;
  final Function()? onDelete;

  const IssueCard({
    super.key,
    required this.issue,
    this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.only(bottom: 16),
      child: ListTile(
        title: Text(issue.title, style: const TextStyle(fontWeight: FontWeight.bold)),
        subtitle: Text(issue.description),
        trailing: onDelete != null
            ? IconButton(
          icon: const Icon(Icons.delete, color: Colors.red),
          onPressed: onDelete,
        )
            : null,
      ),
    );
  }
}
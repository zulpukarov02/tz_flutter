import 'package:flutter/material.dart';
import '../models/workspace.dart';

class WorkspaceCard extends StatelessWidget {
  final Workspace workspace;
  final Function(Workspace) onMorePressed;

  const WorkspaceCard(
      {super.key, required this.workspace, required this.onMorePressed});

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: 1.6,
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12.0),
        ),
        color: workspace.color,
        child: Stack(
          children: [
            Positioned(
              right: 4.0,
              top: 2.0,
              child: IconButton(
                icon: const Icon(
                  Icons.more_horiz,
                  size: 30,
                  color: Colors.white,
                ),
                onPressed: () {
                  onMorePressed(workspace);
                },
              ),
            ),
            Positioned(
              bottom: MediaQuery.of(context).size.height * 0.01,
              left: MediaQuery.of(context).size.width * 0.02,
              child: Text(
                workspace.name,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: MediaQuery.of(context).size.width * 0.035,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

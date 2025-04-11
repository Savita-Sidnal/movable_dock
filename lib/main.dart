import 'package:flutter/material.dart';

/// Starts the app and launches the MovableDock widget.
void main() {
  runApp(const MaterialApp(
    debugShowCheckedModeBanner: false,
    home: MovableDock(),
  ));
}

/// The main screen of the app showing a draggable dock.
class MovableDock extends StatefulWidget {
  const MovableDock({super.key});

  @override
  State<MovableDock> createState() => _MovableDockState();
}

/// State class for [MovableDock].
///
/// Manages the list of items in the dock and handles reordering.
class _MovableDockState extends State<MovableDock> {
  /// List of labels representing dock items (just simple characters for now).
  List<String> icons = ['A', 'B', 'C', 'D', 'E'];

  /// Handles the reordering logic when you drag a dock item.
  ///
  /// Moves the dragged item from [oldIndex] to [newIndex] in the list.
  void _onReorder(int oldIndex, int newIndex) {
    setState(() {
      // Fix the newIndex if you're dragging down the list.
      if (oldIndex < newIndex) {
        newIndex -= 1;
      }

      // Remove the item from its old spot and insert it at the new one.
      final item = icons.removeAt(oldIndex);
      icons.insert(newIndex, item);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Movable Dock'),
        centerTitle: true,
      ),
      body: Center(
        // This keeps the dock centered in the middle of the screen.
        child: SizedBox(
          height: 100,
          child: ReorderableListView(
            scrollDirection: Axis.horizontal,
            onReorder: _onReorder,
            // Build a list of dock items from our icons list.
            children: [
              for (int index = 0; index < icons.length; index++)
                _buildDockItem(index),
            ],
          ),
        ),
      ),
    );
  }

  /// Builds each dock item as a stylized animated square button.
  ///
  /// Includes a cool shadow, rounded corners, and smooth transitions.
  Widget _buildDockItem(int index) {
    return AnimatedContainer(
      key: ValueKey(icons[index]), // Required for reordering to work.
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeInOut,
      margin: const EdgeInsets.symmetric(horizontal: 8),
      width: 60,
      height: 60,
      decoration: BoxDecoration(
        color: Colors.blueAccent,
        borderRadius: BorderRadius.circular(16),
        boxShadow: const [
          BoxShadow(
            color: Colors.black26,
            blurRadius: 4,
            offset: Offset(2, 2),
          ),
        ],
      ),
      child: Center(
        child: Text(
          icons[index],
          style: const TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}

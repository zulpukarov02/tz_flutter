import 'package:flutter/material.dart';
import 'package:tz_flutter/pages/editsworks_page.dart';
import '../models/workspace.dart';
import '../widgets/workspace_card.dart';

class WorkspacesPage extends StatefulWidget {
  const WorkspacesPage({super.key});

  @override
  State<WorkspacesPage> createState() => _WorkspacesPageState();
}

class _WorkspacesPageState extends State<WorkspacesPage> {
  final List<Workspace> _workspaces = [
    Workspace('Savva', const Color(0xFFFF6B6B)),
    Workspace('Olluco', const Color(0xFFFF9A9A)),
    Workspace('Loona', const Color(0xFFAB92FF)),
    Workspace('Folk', const Color(0xFF75B9FF)),
    Workspace('White Rabbit', const Color(0xFF69FFEA)),
    Workspace('Sage', const Color(0xFF7BF39C)),
    Workspace('Maya', const Color(0xFFFFD56B)),
    Workspace('Jun', const Color(0xFFFF9D42)),
    Workspace('Onest', const Color(0xFFB280FF)),
    Workspace('Пробка на Цветном', const Color(0xFF58AFFF)),
  ];

  final TextEditingController _searchController = TextEditingController();
  String _searchQuery = '';

  @override
  void initState() {
    super.initState();
    _searchController.addListener(() {
      setState(() {
        _searchQuery = _searchController.text;
      });
    });
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 60, 57, 57).withOpacity(0.22),
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 18, 17, 17).withOpacity(0.9),
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.settings, color: Colors.white),
          onPressed: _showSettingsDialog,
        ),
        title: const Text('Рабочие пространства',
            style: TextStyle(color: Colors.white)),
        actions: [
          IconButton(
            icon: const Icon(Icons.add, color: Colors.white),
            onPressed: _addWorkspace,
          ),
        ],
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              controller: _searchController,
              decoration: InputDecoration(
                hintText: 'Поиск',
                prefixIcon: const Icon(Icons.search),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12.0),
                  borderSide: BorderSide.none,
                ),
                filled: true,
                fillColor: Colors.grey[200],
              ),
            ),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: LayoutBuilder(
                builder: (context, constraints) {
                  int crossAxisCount = 2;

                  if (constraints.maxWidth >= 600) {
                    crossAxisCount = 3;
                  }
                  if (constraints.maxWidth >= 900) {
                    crossAxisCount = 4;
                  }

                  final filteredWorkspaces = _workspaces
                      .where((workspace) => workspace.name
                          .toLowerCase()
                          .contains(_searchQuery.toLowerCase()))
                      .toList();

                  return GridView.builder(
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: crossAxisCount,
                      crossAxisSpacing: 8.0,
                      mainAxisSpacing: 8.0,
                      childAspectRatio: 1.6,
                    ),
                    itemCount: filteredWorkspaces.length,
                    itemBuilder: (context, index) {
                      return WorkspaceCard(
                        workspace: filteredWorkspaces[index],
                        onMorePressed: _showMoreOptions,
                      );
                    },
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _showSettingsDialog() {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Настройки'),
          content: const Text('Здесь будут настройки.'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('Закрыть'),
            ),
          ],
        );
      },
    );
  }

  void _addWorkspace() {
    setState(() {
      _workspaces.add(Workspace('Новое пространство', Colors.grey));
    });
  }

  void _showMoreOptions(Workspace workspace) {
    showModalBottomSheet(
      context: context,
      builder: (context) {
        return Wrap(
          children: [
            ListTile(
              leading: const Icon(Icons.edit),
              title: const Text('Редактировать'),
              onTap: () {
                Navigator.of(context).pop();
                _editWorkspace(workspace);
              },
            ),
            ListTile(
              leading: const Icon(Icons.delete),
              title: const Text('Удалить'),
              onTap: () {
                Navigator.of(context).pop();
                setState(() {
                  _workspaces.remove(workspace);
                });
              },
            ),
          ],
        );
      },
    );
  }

  void _editWorkspace(Workspace workspace) {
    showDialog(
      context: context,
      builder: (context) {
        return EditWorkspaceDialog(
          workspace: workspace,
          onSave: (name, color) {
            setState(() {
              final index = _workspaces.indexOf(workspace);
              _workspaces[index] = workspace.copyWith(name: name, color: color);
            });
          },
        );
      },
    );
  }
}



// import 'package:flutter/material.dart';
// import '../models/workspace.dart';
// import '../widgets/workspace_card.dart';

// class WorkspacesPage extends StatefulWidget {
//   const WorkspacesPage({super.key});

//   @override
//   State<WorkspacesPage> createState() => _WorkspacesPageState();
// }

// class _WorkspacesPageState extends State<WorkspacesPage> {
//   final List<Workspace> _workspaces = [
//     Workspace('Savva', const Color(0xFFFF6B6B)),
//     Workspace('Olluco', const Color(0xFFFF9A9A)),
//     Workspace('Loona', const Color(0xFFAB92FF)),
//     Workspace('Folk', const Color(0xFF75B9FF)),
//     Workspace('White Rabbit', const Color(0xFF69FFEA)),
//     Workspace('Sage', const Color(0xFF7BF39C)),
//     Workspace('Maya', const Color(0xFFFFD56B)),
//     Workspace('Jun', const Color(0xFFFF9D42)),
//     Workspace('Onest', const Color(0xFFB280FF)),
//     Workspace('Пробка на Цветном', const Color(0xFF58AFFF)),
//   ];

//   String _searchQuery = '';

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: const Color.fromARGB(255, 60, 57, 57).withOpacity(0.22),
//       appBar: AppBar(
//         backgroundColor: const Color.fromARGB(255, 18, 17, 17).withOpacity(0.9),
//         elevation: 0,
//         leading: IconButton(
//           icon: const Icon(Icons.settings, color: Colors.white),
//           onPressed: () {
//             _showSettingsDialog();
//           },
//         ),
//         title: const Text('Рабочие пространства',
//             style: TextStyle(color: Colors.white)),
//         actions: [
//           IconButton(
//             icon: const Icon(Icons.add, color: Colors.white),
//             onPressed: () {
//               _addWorkspace();
//             },
//           ),
//         ],
//       ),
//       body: Column(
//         children: [
//           Padding(
//             padding: const EdgeInsets.all(8.0),
//             child: TextField(
//               decoration: InputDecoration(
//                 hintText: 'Поиск',
//                 prefixIcon: const Icon(Icons.search),
//                 border: OutlineInputBorder(
//                   borderRadius: BorderRadius.circular(12.0),
//                   borderSide: BorderSide.none,
//                 ),
//                 filled: true,
//                 fillColor: Colors.grey[200],
//               ),
//               onChanged: (query) {
//                 setState(() {
//                   _searchQuery = query;
//                 });
//               },
//             ),
//           ),
//           Expanded(
//             child: Padding(
//               padding: const EdgeInsets.all(8.0),
//               child: LayoutBuilder(
//                 builder: (context, constraints) {
//                   int crossAxisCount = 2;

//                   if (constraints.maxWidth >= 600) {
//                     crossAxisCount = 3;
//                   }
//                   if (constraints.maxWidth >= 900) {
//                     crossAxisCount = 4;
//                   }

//                   final filteredWorkspaces = _workspaces
//                       .where((workspace) => workspace.name
//                           .toLowerCase()
//                           .contains(_searchQuery.toLowerCase()))
//                       .toList();

//                   return GridView.builder(
//                     gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
//                       crossAxisCount: crossAxisCount,
//                       crossAxisSpacing: 8.0,
//                       mainAxisSpacing: 8.0,
//                       childAspectRatio: 1.6,
//                     ),
//                     itemCount: filteredWorkspaces.length,
//                     itemBuilder: (context, index) {
//                       return WorkspaceCard(
//                         workspace: filteredWorkspaces[index],
//                         onMorePressed: _showMoreOptions,
//                       );
//                     },
//                   );
//                 },
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }

//   void _showSettingsDialog() {
//     showDialog(
//       context: context,
//       builder: (context) {
//         return AlertDialog(
//           title: const Text('Настройки'),
//           content: const Text('Здесь будут настройки.'),
//           actions: [
//             TextButton(
//               onPressed: () {
//                 Navigator.of(context).pop();
//               },
//               child: const Text('Закрыть'),
//             ),
//           ],
//         );
//       },
//     );
//   }

//   void _addWorkspace() {
//     setState(() {
//       _workspaces.add(Workspace('Новое пространство', Colors.grey));
//     });
//   }

//   void _showMoreOptions(Workspace workspace) {
//     showModalBottomSheet(
//       context: context,
//       builder: (context) {
//         return Wrap(
//           children: [
//             ListTile(
//               leading: const Icon(Icons.edit),
//               title: const Text('Редактировать'),
//               onTap: () {
//                 Navigator.of(context).pop();
//                 // Add edit action
//               },
//             ),
//             ListTile(
//               leading: const Icon(Icons.delete),
//               title: const Text('Удалить'),
//               onTap: () {
//                 Navigator.of(context).pop();
//                 setState(() {
//                   _workspaces.remove(workspace);
//                 });
//               },
//             ),
//           ],
//         );
//       },
//     );
//   }
// }

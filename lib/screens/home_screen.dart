// lib/screens/home_screen.dart (VERSI UI BARU & PROFESIONAL - DENGAN PERBAIKAN LOGOUT)

import 'dart:async';
import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:daily_planner/main.dart';
import 'package:daily_planner/screens/login_screen.dart';
import 'package:daily_planner/utils/app_colors.dart';
import 'package:intl/intl.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  Stream<List<Map<String, dynamic>>>? _tasksStream;

  @override
  void initState() {
    super.initState();
    _setupTasksStream();
  }

  void _setupTasksStream() {
    final userId = supabase.auth.currentUser!.id;
    _tasksStream = supabase
        .from('tasks')
        .stream(primaryKey: ['id'])
        .eq('user_id', userId)
        .order('created_at', ascending: false);
  }

  void _showAddTaskDialog() {
    final titleController = TextEditingController();
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
          title: const Text('Tugas Baru'),
          content: TextFormField(
            controller: titleController,
            autofocus: true,
            decoration: const InputDecoration(
              labelText: 'Apa rencanamu?',
              border: OutlineInputBorder(),
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text('Batal'),
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.primary,
                  foregroundColor: Colors.white),
              onPressed: () async {
                final title = titleController.text.trim();
                if (title.isEmpty) return;
                try {
                  await supabase.from('tasks').insert({'title': title});
                  if (mounted) Navigator.of(context).pop();
                } catch (error) {
                  if (mounted) Navigator.of(context).pop();
                }
              },
              child: const Text('Tambah'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('My Daily Planner'),
        actions: [
          IconButton(
            icon: const Icon(Icons.logout),
            tooltip: 'Logout',
            // --- PERBAIKAN LOGOUT DI SINI ---
            onPressed: () async {
              await supabase.auth.signOut();
              if (mounted) {
                Navigator.of(context).pushAndRemoveUntil(
                  MaterialPageRoute(builder: (context) => const LoginScreen()),
                  (route) => false,
                );
              }
            },
            // ---------------------------------
          )
        ],
      ),
      body: StreamBuilder<List<Map<String, dynamic>>>(
        stream: _tasksStream,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          final tasks = snapshot.data ?? [];
          if (tasks.isEmpty) {
            return const Center(
              child: Text(
                'Belum ada tugas.\nWaktunya produktif!',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 18, color: AppColors.textSecondary),
              ),
            );
          }
          return ListView.builder(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 24),
            itemCount: tasks.length,
            itemBuilder: (context, index) {
              final task = tasks[index];
              final isCompleted = task['is_completed'] as bool;
              final createdAt = DateTime.parse(task['created_at']);

              return Card(
                margin: const EdgeInsets.only(bottom: 16),
                elevation: 2,
                shadowColor: AppColors.primary.withOpacity(0.1),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12)),
                child: InkWell(
                  borderRadius: BorderRadius.circular(12),
                  onTap: () async {
                    await supabase
                        .from('tasks')
                        .update({'is_completed': !isCompleted})
                        .eq('id', task['id']);
                  },
                  child: Padding(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 8, vertical: 12),
                    child: Row(
                      children: [
                        Checkbox(
                          value: isCompleted,
                          onChanged: (bool? newValue) async {
                            await supabase
                                .from('tasks')
                                .update({'is_completed': newValue ?? false})
                                .eq('id', task['id']);
                          },
                          activeColor: AppColors.completed,
                          shape: const CircleBorder(),
                        ),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                task['title'],
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w500,
                                  decoration: isCompleted
                                      ? TextDecoration.lineThrough
                                      : null,
                                  color: isCompleted
                                      ? AppColors.textSecondary
                                      : AppColors.textPrimary,
                                ),
                              ),
                              const SizedBox(height: 4),
                              Text(
                                DateFormat('d MMM, HH:mm')
                                    .format(createdAt.toLocal()),
                                style: const TextStyle(
                                    fontSize: 12,
                                    color: AppColors.textSecondary),
                              ),
                            ],
                          ),
                        ),
                        IconButton(
                          icon: const Icon(Icons.delete_outline,
                              color: AppColors.accent),
                          onPressed: () async {
                            await supabase
                                .from('tasks')
                                .delete()
                                .eq('id', task['id']);
                          },
                        ),
                      ],
                    ),
                  ),
                ),
              );
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _showAddTaskDialog,
        child: const Icon(Icons.add),
        tooltip: 'Tambah Tugas',
      ),
    );
  }
}

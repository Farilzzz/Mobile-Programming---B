import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:aplikasi_gym/controller/workout_log_controller.dart';

class WorkoutLogPage extends StatelessWidget {
  const WorkoutLogPage({super.key});

  @override
  Widget build(BuildContext context) {

    final controller = Get.put(WorkoutLogController());

    return Scaffold(
      backgroundColor: const Color(0xFF1C1C1E),
      appBar: AppBar(
        title: const Text("Workout History", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
        backgroundColor: const Color(0xFF1C1C1E),
        iconTheme: const IconThemeData(color: Colors.white),
        centerTitle: true,
      ),
      
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => _showDialog(context, controller, null), // Mode Tambah
        backgroundColor: const Color(0xFF00F0FF),
        label: const Text("Manual Log", style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold)),
        icon: const Icon(Icons.add, color: Colors.black),
      ),

      body: Obx(() {
        if (controller.isLoading.value) {
          return const Center(child: CircularProgressIndicator(color: Color(0xFF00F0FF)));
        }

        if (controller.logList.isEmpty) {
          return const Center(child: Text("Belum ada latihan tercatat.", style: TextStyle(color: Colors.grey)));
        }

        return ListView.builder(
          padding: const EdgeInsets.only(bottom: 80, top: 20),
          itemCount: controller.logList.length,
          itemBuilder: (context, index) {
            final log = controller.logList[index];
            return _buildLogCard(context, log, controller);
          },
        );
      }),
    );
  }

  Widget _buildLogCard(BuildContext context, Map<String, dynamic> log, WorkoutLogController c) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
      decoration: BoxDecoration(
        color: const Color(0xFF2C2C2E),
        borderRadius: BorderRadius.circular(15),
      ),
      child: ListTile(
        contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        leading: Container(
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(color: const Color(0xFF00F0FF).withOpacity(0.1), borderRadius: BorderRadius.circular(10)),
          child: const Icon(Icons.fitness_center, color: Color(0xFF00F0FF)),
        ),
        title: Text(log['exercise_name'], style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
        subtitle: Text("${log['sets']} Sets x ${log['reps']} Reps • ${log['weight_kg']} kg", style: const TextStyle(color: Colors.grey)),
        trailing: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
    
            IconButton(
              icon: const Icon(Icons.edit, color: Colors.orange, size: 20),
              onPressed: () => _showDialog(context, c, log), // Mode Edit
            ),
    
            IconButton(
              icon: const Icon(Icons.delete, color: Colors.red, size: 20),
              onPressed: () => c.deleteLog(log['id']),
            ),
          ],
        ),
      ),
    );
  }


  void _showDialog(BuildContext context, WorkoutLogController c, Map<String, dynamic>? log) {
    bool isEdit = log != null;
    
 
    if (isEdit) {
      c.exerciseNameC.text = log['exercise_name'];
      c.weightC.text = log['weight_kg'].toString();
      c.repsC.text = log['reps'].toString();
      c.setsC.text = log['sets'].toString();
    } else {
      c.exerciseNameC.clear();
      c.weightC.clear();
      c.repsC.clear();
      c.setsC.clear();
    }

    Get.bottomSheet(
      Container(
        padding: const EdgeInsets.all(20),
        decoration: const BoxDecoration(
          color: Color(0xFF1C1C1E),
          borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(isEdit ? "Edit Log" : "Add Log", style: const TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold)),
            const SizedBox(height: 20),
            
            _inputField(c.exerciseNameC, "Exercise Name"),
            const SizedBox(height: 10),
            Row(children: [
              Expanded(child: _inputField(c.weightC, "Weight (kg)", isNumber: true)),
              const SizedBox(width: 10),
              Expanded(child: _inputField(c.repsC, "Reps", isNumber: true)),
              const SizedBox(width: 10),
              Expanded(child: _inputField(c.setsC, "Sets", isNumber: true)),
            ]),
            const SizedBox(height: 20),
            
            SizedBox(
              width: double.infinity,
              height: 50,
              child: ElevatedButton(
                onPressed: () {
                  if (isEdit) {
                    c.updateLog(log['id']);
                  } else {
                    c.addLog(); // Tambah Manual
                  }
                },
                style: ElevatedButton.styleFrom(backgroundColor: const Color(0xFF00F0FF)),
                child: Text(isEdit ? "Update" : "Save", style: const TextStyle(color: Colors.black, fontWeight: FontWeight.bold)),
              ),
            ),
            const SizedBox(height: 10),
          ],
        ),
      ),
      isScrollControlled: true,
    );
  }

  Widget _inputField(TextEditingController controller, String hint, {bool isNumber = false}) {
    return TextField(
      controller: controller,
      keyboardType: isNumber ? TextInputType.number : TextInputType.text,
      style: const TextStyle(color: Colors.white),
      decoration: InputDecoration(
        hintText: hint,
        hintStyle: const TextStyle(color: Colors.grey),
        filled: true,
        fillColor: const Color(0xFF2C2C2E),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(10), borderSide: BorderSide.none),
      ),
    );
  }
}
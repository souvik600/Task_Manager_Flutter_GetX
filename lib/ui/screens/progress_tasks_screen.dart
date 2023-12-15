import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import '../../data/models/task_count_summary_list_model.dart';
import '../../data/network_caller/network_caller.dart';
import '../../data/network_caller/network_response.dart';
import '../../data/utility/urls.dart';
import '../controllers/progress_task_controlar.dart';
import '../widgets/profile_summary_card.dart';
import '../widgets/task_item_card.dart';

class ProgressTasksScreen extends StatefulWidget {
  const ProgressTasksScreen({super.key});

  @override
  State<ProgressTasksScreen> createState() => _ProgressTasksScreenState();
}

class _ProgressTasksScreenState extends State<ProgressTasksScreen> {
  bool getTaskCountSummaryInProgress = false;
  TaskCountSummaryListModel taskCountSummaryListModel =
      TaskCountSummaryListModel();

  Future<void> getTaskCountSummaryList() async {
    getTaskCountSummaryInProgress = true;
    if (mounted) {
      setState(() {});
    }
    final NetworkResponse response =
        await NetworkCaller().getRequest(Urls.getTaskStatusCount);
    if (response.isSuccess) {
      taskCountSummaryListModel =
          TaskCountSummaryListModel.fromJson(response.jsonResponse);
    }
    getTaskCountSummaryInProgress = false;
    if (mounted) {
      setState(() {});
    }
  }

  @override
  void initState() {
    Get.find<ProgressTaskController>().getProgressTaskList();
    getTaskCountSummaryList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
      child: Column(
        children: [
          const ProfileSummaryCard(),
          Expanded(
            child: GetBuilder<ProgressTaskController>(
                builder: (progressTaskController) {
              return Visibility(
                visible:
                    progressTaskController.getProgressTaskInProgress == false,
                replacement: const Center(child: CircularProgressIndicator()),
                child: RefreshIndicator(
                  onRefresh: () => progressTaskController.getProgressTaskList(),
                  child: ListView.builder(
                    itemCount:
                        progressTaskController.taskListModel.taskList?.length ??
                            0,
                    itemBuilder: (context, index) {
                      return TaskItemCard(
                        task: progressTaskController
                            .taskListModel.taskList![index],
                        onStatusChange: () {
                          progressTaskController.getProgressTaskList();
                        },
                        showProgress: (inProgress) {},
                      );
                    },
                  ),
                ),
              );
            }),
          ),
        ],
      ),
    ));
  }
}

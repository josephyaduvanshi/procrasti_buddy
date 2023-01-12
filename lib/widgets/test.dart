void main() {
  String text =
      """Break tasks into smaller, manageable chunks: This can make the task seem less daunting and more achievable.

Set specific, measurable, and achievable goals: This will give you a clear idea of what you need to do and when, and help you stay focused.

Use a timer: Set a timer for a specific amount of time, and work on the task until the timer goes off.

Eliminate distractions: Try to minimize distractions while working, such as turning off your phone or closing unnecessary tabs.

Reward yourself: Give yourself a reward for completing a task or reaching a goal.

Prioritize: Prioritize your tasks based on their importance and urgency.

Use positive self-talk: Encourage yourself to get started on a task, and remind yourself of the benefits of completing it.

Use the Pomodoro Technique: Break your work into 25-minute intervals, called "Pomodoros", and take a short break after each one.

Just start: Sometimes, the hardest part of a task is getting started. Once you begin, you may find that it's not as difficult as you thought it would be.

Use a planner: Keep track of your tasks and deadlines in a planner or calendar.

Remove unnecessary tasks: Eliminate tasks that are not essential to your goals.

Keep your work area clean and organized: A cluttered space can make it difficult to focus and be productive.

Use a to-do list: Make a list of tasks you need to complete, and check them off as you go.

Take breaks: Taking short breaks throughout the day can help to refresh your mind and increase productivity.

Be accountable: Tell someone about your goals and ask them to hold you accountable for meeting them.

Find a goal or purpose: Connecting your task with a goal or purpose that is meaningful to you can help to increase motivation.

Get enough sleep: Adequate sleep is essential for maintaining focus and productivity.

Manage your time: Use your time effectively by planning and scheduling your tasks.

Stay motivated: Keep your motivation high by reminding yourself of the benefits of completing the task.

Look for inspiration: Look for inspiration and ideas in books, articles, or online resources.""";
  final a = text.split("\n");
  print(a);
  final b = [];
  for (int i = 0; i < text.length; i++) {
    b.add({
      "tip": a[i].toString().split(":")[0],
      "explanation": a[i].toString().split(":")[1],
    });
  }
  print(b);
}

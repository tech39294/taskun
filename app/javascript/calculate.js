document.addEventListener("turbolinks:load", function() {
  // タスクの期限が変更されたときに呼ばれる関数
  function calculateSubtaskDeadlines() {
    const taskDeadline = document.getElementById("task-cal-deadline").value; // タスクの期限の値を取得
    const taskDays = parseInt(document.querySelector(".task-deadline").dataset.days, 10); // タスク全体の必要日数を取得

    // サブタスクの要素ごとに処理を行う
    const subtaskElements = document.getElementsByClassName("subtask");
    let accumulatedDays = 0; // サブタスクの累計日数を初期化
    for (let i = 0; i < subtaskElements.length; i++) {
      const subtaskDeadlineElement = subtaskElements[i].querySelector(".subtask-deadline input"); // サブタスクの期限のinput要素を取得
      const subtaskDays = parseInt(subtaskElements[i].dataset.days, 10); // サブタスクの必要日数を取得

      // サブタスクの期限を逆算して設定
      const daysToAdd = accumulatedDays + subtaskDays; // 累計日数を加算
      const subtaskDeadline = calculateDeadline(taskDeadline, taskDays, daysToAdd); // タスクの期限から逆算してサブタスクの期限を計算
      subtaskDeadlineElement.value = subtaskDeadline; // サブタスクの期限のinput要素に設定

      accumulatedDays += subtaskDays; // 累計日数を更新
    }
  }

  // タスクの期限と逆算する日数から、サブタスクの期限を計算する関数
  function calculateDeadline(taskDeadline, taskDays, daysToAdd) {
    const taskDate = new Date(taskDeadline);
    const subtaskDate = new Date(taskDate.getTime() - (taskDays - daysToAdd) * 24 * 60 * 60 * 1000); // 日数をミリ秒に変換して減算
    const subtaskDeadline = subtaskDate.toISOString().split("T")[0]; // 日付部分のみ取得して文字列に変換
  
    return subtaskDeadline;
  }

  document.getElementById("task-cal-deadline").addEventListener("change", calculateSubtaskDeadlines);
});

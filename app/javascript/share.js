document.addEventListener("turbolinks:load", function() {
  const shareButton = document.querySelector(".share-button");
  const sharedDocumentArea = document.getElementById("shared-document");

  shareButton.addEventListener("click", function() {
    const taskTitle = document.querySelector(".task-title").textContent;
    const taskDeadline = document.querySelector(".task-deadline").textContent;
    const taskDate = new Date(taskDeadline);
    const taskFormattedDate = `${taskDate.getFullYear()}年${taskDate.getMonth() + 1}月${taskDate.getDate()}日`;

    const subtaskTitles = Array.from(document.querySelectorAll(".subtask-title")).map(subtask => subtask.textContent.trim());
    const subtaskDeadlines = Array.from(document.querySelectorAll(".subtask-deadline")).map(subtask => {
      const date = new Date(subtask.textContent);
      const year = date.getFullYear();
      const month = date.getMonth() + 1;
      const day = date.getDate();
      return `${year}年${month}月${day}日`;
    });

    let sharedDocument = `<p style="font-size: 18px; padding:20px; margin-top: 30px; border: 1px solid gray;">`;
    sharedDocument += `${taskTitle}は以下の日程で行う予定です。<br><br>`;
    sharedDocument += `${taskTitle}：${taskFormattedDate}<br>`;
    
    if (subtaskTitles.length > 0) {
      sharedDocument += subtaskTitles.map((title, deadline) => `${title}：${subtaskDeadlines[deadline]}`).join("<br>");
    }

    sharedDocument += `</p>`;

    sharedDocumentArea.innerHTML = sharedDocument;
  });
});
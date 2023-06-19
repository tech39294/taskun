window.addEventListener('load', function() {

  const tasks = Array.from(document.querySelectorAll('.task'));
  let alerts = '';

  tasks.forEach((task) => {
    const hiddenDivs = Array.from(task.querySelectorAll('.hidden'));

    hiddenDivs.forEach((hiddenDiv) => {
      const subtaskTitle = hiddenDiv.getAttribute('data-subtask-title');
      const subtaskDeadline = hiddenDiv.getAttribute('data-subtask-deadline');
      const deadlineDate = new Date(subtaskDeadline);
      const today = new Date();

      const diffTime = Math.abs(deadlineDate - today);
      const diffDays = Math.ceil(diffTime / (1000 * 60 * 60 * 24));
      
      alerts += `「${subtaskTitle}」の期限はあと${diffDays}日です。(${task.querySelector('.task-title').textContent.trim()})<br>`;
    });
  });

  if (alerts !== '') {
    const modal = document.createElement('div');
    modal.className = 'alert-modal';

    const titleElement = document.createElement("h2");
    titleElement.textContent = '期限アラート';
    titleElement.className = 'modal-title';
    modal.appendChild(titleElement);

    const alertTextsDiv = document.createElement('div');
    alertTextsDiv.className = 'alert';
    alertTextsDiv.innerHTML = alerts;
    modal.appendChild(alertTextsDiv);

    const closeButton = document.createElement('button');
    closeButton.textContent = '確認しました';
    closeButton.className = 'close-button';
    closeButton.addEventListener('click', () => {
      modal.style.display = 'none';
    });
    modal.appendChild(closeButton);
      
    document.body.appendChild(modal);
    }
});

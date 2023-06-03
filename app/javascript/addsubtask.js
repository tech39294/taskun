document.addEventListener("turbolinks:load", function() {
  const addSubtaskButton = document.querySelector('#add-subtask-button');
  const subtasksContainer = document.querySelector('#subtasks-container');

  let subtaskIndex = subtasksContainer.querySelectorAll('.subtask').length;

  addSubtaskButton.addEventListener('click', function() {
    const subtaskDiv = document.createElement('div');
    subtaskDiv.className = 'subtask';

    const subtaskDeadlineInput = document.createElement('input');
    subtaskDeadlineInput.type = 'date';
    subtaskDeadlineInput.name = `task[subtasks_attributes][${subtaskIndex}][subtask_deadline]`;
    subtaskDeadlineInput.placeholder = '期限';

    const subtaskTitleInput = document.createElement('input');
    subtaskTitleInput.type = 'text';
    subtaskTitleInput.name = `task[subtasks_attributes][${subtaskIndex}][subtask_title]`;
    subtaskTitleInput.placeholder = 'サブタスク名';

    const subtaskDeadlineDiv = document.createElement('div');
    subtaskDeadlineDiv.className = 'subtask-deadline';
    subtaskDeadlineDiv.appendChild(subtaskDeadlineInput);

    const subtaskTitleDiv = document.createElement('div');
    subtaskTitleDiv.className = 'subtask-title';
    subtaskTitleDiv.appendChild(subtaskTitleInput);

    subtaskDiv.appendChild(subtaskDeadlineDiv);
    subtaskDiv.appendChild(subtaskTitleDiv);

    subtasksContainer.appendChild(subtaskDiv);

    subtaskIndex++;
  });
});

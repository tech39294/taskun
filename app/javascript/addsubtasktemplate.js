document.addEventListener("turbolinks:load", function() {
  const addSubtaskButton = document.querySelector('#add-subtask-template-button');
  const subtasksContainer = document.querySelector('#subtasks-container');

  let subtaskIndex = subtasksContainer.querySelectorAll('.subtask').length;

  addSubtaskButton.addEventListener('click', function() {
    const subtaskDiv = document.createElement('div');
    subtaskDiv.className = 'subtask';

    const subtaskDaysInput = document.createElement('input');
    subtaskDaysInput.type = 'number';
    subtaskDaysInput.name = `task_template[subtask_templates_attributes][${subtaskIndex}][subtask_template_days]`;
    subtaskDaysInput.placeholder = '日数';

    const subtaskTitleInput = document.createElement('input');
    subtaskTitleInput.type = 'text';
    subtaskTitleInput.name = `task_template[subtask_templates_attributes][${subtaskIndex}][subtask_template_title]`;
    subtaskTitleInput.placeholder = 'サブタスク名';

    const subtaskDaysDiv = document.createElement('div');
    subtaskDaysDiv.className = 'subtask-template-days';
    subtaskDaysDiv.appendChild(subtaskDaysInput);

    const subtaskTitleDiv = document.createElement('div');
    subtaskTitleDiv.className = 'subtask-title';
    subtaskTitleDiv.appendChild(subtaskTitleInput);

    subtaskDiv.appendChild(subtaskDaysDiv);
    subtaskDiv.appendChild(subtaskTitleDiv);

    subtasksContainer.appendChild(subtaskDiv);

    subtaskIndex++;
  });
});

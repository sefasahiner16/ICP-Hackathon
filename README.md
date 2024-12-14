# ICP-Hackathon

# ToDoList Project

A simple ToDoList application built using Motoko. This application allows you to create, update, delete, and manage tasks. Each task can have a title, description, category, priority, and completion status.

## Features

- **Create Tasks**: Add new tasks with a title, description, category, and priority.
- **Update Tasks**: Modify existing tasks with new information.
- **Toggle Completion**: Mark tasks as completed or non-completed.
- **Delete Tasks**: Remove tasks from the list.
- **View Tasks**: Filter tasks based on their completion status and priority.

## Data Structures

### Task

A task contains the following attributes:

- `title`: The title of the task (text).
- `description`: A brief description of the task (text).
- `isCompleted`: A boolean value indicating whether the task is completed.
- `category`: The category of the task (either Work, Personal, Shopping, Health, or Other).
- `priority`: The priority of the task (High, Medium, Low).

### TaskId

A unique identifier for each task of type `Nat32`.

### Priority

Defines three possible priority levels:

- `#High`
- `#Medium`
- `#Low`

### Category

Defines five possible categories for tasks:

- `#Work`
- `#Personal`
- `#Shopping`
- `#Health`
- `#Other`

## Functions

### `createTask`
Creates a new task with the given title, description, category, and priority. Returns the unique task ID.

**Arguments**:
- `title`: The title of the task.
- `description`: The description of the task.
- `category`: The category of the task.
- `priority`: The priority of the task.

**Returns**: `TaskId` (unique identifier for the task).

### `getTask`
Fetches a task by its ID.

**Arguments**:
- `id`: The task ID.

**Returns**: `?Task` (the task, or `null` if not found).

### `updateTask`
Updates an existing task with a new title, description, category, and priority.

**Arguments**:
- `id`: The task ID.
- `title`: The new title.
- `description`: The new description.
- `category`: The new category.
- `priority`: The new priority.

**Returns**: `Bool` (true if the update was successful, false if the task does not exist).

### `toggleComplete`
Toggles the completion status of a task.

**Arguments**:
- `id`: The task ID.

**Returns**: `Bool` (true if the task was found and updated, false if the task does not exist).

### `deleteTask`
Deletes a task by its ID.

**Arguments**:
- `id`: The task ID.

**Returns**: `Bool` (true if the task was deleted, false if the task does not exist).

### `getCompleted`
Fetches all completed tasks.

**Returns**: A list of completed tasks.

### `getNonCompleted`
Fetches all non-completed tasks.

**Returns**: A list of non-completed tasks.

### `getTasksByPriority`
Fetches all tasks, sorted by their priority (High, Medium, Low).

**Returns**: A list of tasks sorted by priority.

## How to Run

1. Clone the repository:
   ```bash
   git clone https://github.com/sefasahiner16/ToDoList-motoko.git

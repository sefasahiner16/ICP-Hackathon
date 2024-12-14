import Nat32 "mo:base/Nat32";
import Trie "mo:base/Trie";
//import Option "mo:base/Option";
import Text "mo:base/Text";
//import Result "mo:base/Result";
import List "mo:base/List";


actor ToDoList {

    public type Task = {
        title: Text;
        description: Text;
        isCompleted: Bool;
        category : Category;
        priority: Priority;
    };

    public type Priority = {
        #High;
        #Medium;
        #Low;
    };

    public type Category = {
    #Work;
    #Personal;
    #Shopping;
    #Health;
    #Other;
    };

    public type TaskId = Nat32;

    private stable var next : TaskId = 0;
    private stable var tasks : Trie.Trie<TaskId, Task> = Trie.empty();

    // Create a new task
    public func createTask(title: Text, description: Text, category: Category, priority: Priority) : async TaskId {
        let newTask : Task = {
            title = title;
            description = description;
            isCompleted = false;
            priority = priority;
            category = category;
        };

        let id = next;
        next += 1;

        tasks := Trie.replace(
            tasks,
            key(id),
            Nat32.equal,
            ?newTask
        ).0;

        return id;
    };

    // Get a task by ID
    public func getTask(id : TaskId) : async ?Task {
        let result = Trie.find(
            tasks,
            key(id),
            Nat32.equal
        );
        return result;
    };

    // Update a task
    public func updateTask(id : TaskId, title: Text, description: Text, category : Category,priority: Priority) : async Bool {
        let result = Trie.find(tasks, key(id), Nat32.equal);
        
        switch(result) {
            case null { return false };
            case (?task) {
                let updatedTask : Task = {
                    title = title;
                    description = description;
                    isCompleted = task.isCompleted;
                    category = category;
                    priority = priority;
                };
                tasks := Trie.replace(tasks, key(id), Nat32.equal, ?updatedTask).0;
                return true;
            };
        };
    };

    // Toggle task completion
    public func toggleComplete(id: TaskId) : async Bool {
        let result = Trie.find(tasks, key(id), Nat32.equal);
        
        switch(result) {
            case null { return false };
            case (?task) {
                let updatedTask : Task = {
                    title = task.title;
                    description = task.description;
                    isCompleted = not task.isCompleted;
                    category = task.category;
                    priority = task.priority;
                };
                tasks := Trie.replace(tasks, key(id), Nat32.equal, ?updatedTask).0;
                return true;
            };
        };
    };

    // Delete a task
    public func deleteTask(id: TaskId) : async Bool {
        let result = Trie.find(tasks, key(id), Nat32.equal);
        
        switch(result) {
            case null { return false };
            case (?_) {
                tasks := Trie.replace(tasks, key(id), Nat32.equal, null).0;
                return true;
            };
        };
    };

    // Get all completed tasks
public func getCompleted() : async [Task] {
    var completedTasks : List.List<Task> = List.nil();
    
    for ((id, task) in Trie.iter(tasks)) {
        if (task.isCompleted) {
            completedTasks := List.push(task, completedTasks);
        };
    };
    
    return List.toArray(completedTasks);
};

// Get all non-completed tasks
public func getNonCompleted() : async [Task] {
    var nonCompletedTasks : List.List<Task> = List.nil();
    
    for ((id, task) in Trie.iter(tasks)) {
        if (not task.isCompleted) {
            nonCompletedTasks := List.push(task, nonCompletedTasks);
        };
    };
    
    return List.toArray(nonCompletedTasks);
};

// Get tasks sorted by priority
public func getTasksByPriority() : async [Task] {
    var highPriority : List.List<Task> = List.nil();
    var mediumPriority : List.List<Task> = List.nil();
    var lowPriority : List.List<Task> = List.nil();
    
    for ((id, task) in Trie.iter(tasks)) {
        switch(task.priority) {
            case (#High) {
                highPriority := List.push(task, highPriority);
            };
            case (#Medium) {
                mediumPriority := List.push(task, mediumPriority);
            };
            case (#Low) {
                lowPriority := List.push(task, lowPriority);
            };
        };
    };
    
    // Combine all priorities (High -> Medium -> Low)
    var allTasks = highPriority;
    allTasks := List.append(allTasks, mediumPriority);
    allTasks := List.append(allTasks, lowPriority);
    
    return List.toArray(allTasks);
};

    private func key(x: TaskId) : Trie.Key<TaskId> {
        { hash = x; key = x };
    };
};

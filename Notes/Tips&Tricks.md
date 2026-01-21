## 🎯 Tips & Tricks
*(For best practices and optimization techniques)*

---

### 1. Computed Properties & Expensive Instances Placement
- **General Best Practice:**  
	- Place computed properties and expensive instances (e.g., `Date`, `DateFormatter`, `Calendar`) as high as possible in the view hierarchy for better performance.
    - For instances that are created only once (e.g., `Calendar`, `DateFormatter`), consider declaring them as static properties within a helper struct to ensure a single, shared instance.

- **Why?**
	- Performance Optimization:
		- Computed properties recalculate on every view update.
		- Expensive instances (like `DateFormatter`) are recreated unnecessarily if defined inside child views.
	- Benefits of High Placement:
		- Fewer recalculations (only when parent state changes)
		- Avoid redundant work in child views
		- Reduced workload during SwiftUI’s diffing/render cycle
		- Consistent formatting (shared instances prevent mismatches)
- **When Child Placement May Be Better:**
	- The computation is view-specific (e.g., presentation formatting)
	- Child views update more frequently than parents (e.g., list rows responding to taps)
	- The calculation is lightweight (CPU cost < responsiveness benefit)
	- You need reactive updates tied to child interactions
- **What Happens If You Misplace Them?**
	- Too Low (Unnecessary Recreation):
		- Wasted CPU cycles (recomputing the same values)
		- Memory churn (recreating heavy objects like DateFormatter)
		- Potential UI lag during rapid view updates
	- Too High (Stale Updates):
		- Delayed UI responsiveness (parent doesn't recompute as often as needed)
		- Broken interactivity (e.g., taps not updating visuals immediately)
		- Excessive parent-level recomputations (if forced to update frequently)
	- Critical Note:
		- Placing them in the same view as an `@Query` will trigger recomputation on every model context change, as `@Query` refetches data with each modification.

---

### 2. Property Wrappers Guide

- `@State`
    - **Ownership**: Owned and managed by the view where it's declared
    - **Purpose**:
        - Stores mutable state for **value types** (structs, enums, primitives)
        - Manages **reference types** created in the view (e.g., `@State var user = User()`)
    - **Lifetime**: Persists across view updates but resets when parent view is recreated
    - **Use Case**: 
        - Simple UI state management (toggles, text fields)
        - Local view-specific state that doesn't need sharing (Like `EditHabitView`)
    - **Notes**:
        - Not for persistent data storage (use `@Query` or `@AppStorage` instead)

- `@Binding`
    - **Connection**: Creates a two-way binding to **value-type** state
    - **Usage**:
        - Share state between parent-child views
        - Modify parent's `@State` property from child view
    - **Characteristics**:
        - Derived from existing state (using `$` syntax)
        - Doesn't own the data - acts as a conduit
    - **Notes**:
        - Must apply to all nested child views even if just passing by.

- `@Bindable`
    - **Purpose**: Enables two-way bindings for properties of `@Observable` classes
    - **Usage**:
        - Pass observable objects to child views
        - Create bindings to individual properties
    - **When to Use**:
        - Need to bind to specific properties in SwiftUI controls
        - Working with iOS 17+ Observation framework
    - **When to Avoid**: 
        - Not needed if child view only needs read access (Like just passing by)
        - If mutating through methods (e.g., `log.count += 1`)


- Key Differences
    |     Wrapper    |  Ownership  |     Type     |    Mutation     |
    |----------------|-------------|--------------|-----------------|
    | `@State`       |    Owner    |    Value & Reference types     |     Direct      |
    | `@Binding`     |  Reference  |  Value types | Through binding |
    | `@Bindable`    |  Referenc   | Observable class properties    | Through binding |

---

### 3. The Singleton Design Pattern

- **What it does**:
    A design pattern that ensures a class has only one instance and provides a single, global point of access to that instance.

- **How It Works**:
    You create a `static` constant property within the class itself, which holds the single instance. This property is initialized only once, the first time it is accessed.

- **Example (`NotificationManager.swift`)**:

    ```swift
    class NotificationManager {
        // The static 'instance' property makes this a Singleton.
        static let instance = NotificationManager()

        // The initializer can be made private to prevent creating other instances.
        private init() {}

        func requestAuthorization() {
            // ...
        }
    }

    // You can now access the single instance from anywhere in the app:
    NotificationManager.instance.requestAuthorization()
    ```

- **Why and When to Use It**:
    Use a Singleton when you need exactly one object to coordinate actions across the system. It's particularly useful for managing shared resources or global state.

    - **Shared Resources**: Ideal for managing access to a shared resource like a database connection, a network manager, or a manager for user settings. In the "Undo" app, it's used for the `NotificationManager` to handle all local notifications centrally.
    - **Global Access**: Provides a convenient global access point, so you don't have to pass the instance around through multiple layers of your app.
    - **Configuration**: Useful for objects that store configuration settings or manage the state for the entire application.

- **Key Considerations**:

    - **Overuse**: Singletons can be overused. If a class doesn't truly represent a unique, global resource, it might be better to manage its lifecycle in a more controlled way (e.g., through dependency injection).
    - **Testing**: They can make unit testing more difficult because they introduce global state, making it hard to isolate components for testing.

---

### 4. Optimizing Repeated Lookups with Sets

- **What it does**:
    A performance optimization technique that drastically reduces the time complexity of checking if an item exists in a collection, transforming it from a linear search **O(n)** to an instant lookup **O(1)**.
- **How It Works**:
    We convert an existing Array into a `Set` before entering a loop. Because Sets use hash values to index their contents, checking `contains()` becomes a constant operation, regardless of how many items are in the list.
- **The Optimized Approach (Recommended)**:
    ```swift
    // ✅ Fast: O(1) Lookups
    // We convert the array to a Set ONCE.
    let completedDates = Set(logs.filter{$0.isCompleted}.map{calendar.startOfDay(for: $0.date)})

    // The loop runs instantly because .contains() on a Set is O(1)
    while completedDates.contains(checkDate) {
        streak += 1
        checkDate = DateUtils.previousDay(from: checkDate)
    }
    ```
- **The Unoptimized Alternative (What to Avoid)**:
    ```swift
    // ❌ Slow: O(n²) Performance
    // We keep the data as a standard Array.
    let completedDatesArray = logs.filter{$0.isCompleted}.map{calendar.startOfDay(for: $0.date)}

    // CRITICAL ISSUE: .contains() on an Array has to scan the list item-by-item O(n).
    // Doing this inside a while loop creates O(n) * O(n) = O(n²) complexity.
    while completedDatesArray.contains(checkDate) {
        streak += 1
        checkDate = DateUtils.previousDay(from: checkDate)
    }
    ```
- **Breaking Down the One-Liner**:
    The line `Set(logs.filter...map...)` is a functional chain that performs three distinct steps. Here is the "Classic Code" equivalent of what is actually happening under the hood:
    ```swift
    // 1. Create an empty Set to hold our results
    var completedDates = Set<Date>()

    // 2. Iterate through every log (The Filter & Map phase)
    for log in logs {
        // FILTER: Only care about logs where the habit was actually done
        if log.isCompleted {
            // MAP: Transform the log object into a standardized Date (Midnight)
            let dateOnly = calendar.startOfDay(for: log.date)

            // 3. Insert into Set (handling duplicates automatically)
            completedDates.insert(dateOnly)
        }
    }
    ```
- **Why and When to Use It**:
    Use this pattern whenever you have a list of items and you need to check for existence multiple times (e.g., inside a `for` or `while` loop).
    - **Nested Loops**: If you check an array inside a loop, you are performing **O(n²)** work. Using a Set reduces this to **O(n)**.
    - **Large Datasets**: As your data grows (e.g., years of habit logs), Array lookups get slower. Set lookups remain instant.
    - **Filtering**: Ideal for algorithms like streaks, calendar matching, or removing duplicates.
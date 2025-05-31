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
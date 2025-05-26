## 🧠 Deep Dives
*(For breaking down existing implementations)*

---

### 1. `isCompleted(for:calendar:) -> Bool` Model Method
- **What it does**:
	Checks whether there is a completed log entry for the specified date.

- **Parameters**:
	- `date`: The date to check for completed logs.
	- `calendar`: The calendar to use for date comparison (defaults to user's current calendar, e.g., `Calendar.gregorian`).

- **Returns**:
	- `true` if a completed log exists for the given date, `false` otherwise.

- **Code**:
	```swift
	func isCompleted(for date: Date, calendar: Calendar = .current) -> Bool {
        // First check if logs array exists - if not, then no logs means not completed
        guard let logs = logs else { return false }
        
        // Iterate through all available logs
        for log in logs {
            // Check if this log's date is the same day as our target date
            let isSameDay = calendar.isDate(log.date, inSameDayAs: date)
            
            // If same day AND log is marked completed, we found what we need
            if isSameDay && log.isCompleted {
                return true
            }
        }
        
        // If we checked all logs and didn't find a matching completed one
        return false
    }

- **Key Insights**:
	- Manually comparing dates is error-prone due to:
		- Time zones
		- Daylight saving time
		- Different calendar systems
		- etc.
	- To handle all these edge cases correctly, we use the built-in `Calendar` instance.
	- The calendar comparison:
		- Ignores time components (hours, minutes, seconds)
		- Respects calendar settings (Time zone, locale, and calendar system)

---

### 2. `log(for:modelContext:calendar:) -> HabitLog` Model Method
- **What it does**:
	Retrieves or creates a `HabitLog` for the specified date associated with this habit.

- **Parameters**:
	- `date`: The target date for the log entry.
	- `context`: The model context (Passable into functions).
	- `calendar`: (Optional) Calendar for date comparison. Defaults to the user's current calendar.

- **Returns**:
	- An existing log if one exists for the specified date, otherwise a newly created log.

- **Key Insights**:
	- The function first checks for an existing log matching the date. If none exists, it creates a new log, inserts it into the database, and associates it with this habit.
	- Association between `HabitLog` and `Habit` is established through:
		- The new log's `habit` property points to self.
		- The log is appended to `self.logs`.

- **Code**:
	```swift
	func log(for date: Date, modelContext: ModelContext, calendar: Calendar = .current) -> HabitLog {
        // Attempt to find an existing log for the requested date
        if let existingLog = logs?.first(where: { log in
            calendar.isDate(log.date, inSameDayAs: date)
        }) {
            return existingLog
        }
        
        // Create and configure a new log if none exists
        let newLog = HabitLog(date: date, habit: self)
        modelContext.insert(newLog)
        self.logs?.append(newLog)
        return newLog
    }

---

### 3. `weekDays` Computed Property
- **What it does**:
	Returns an array of `Date` objects representing the last 7 weekdays (including today) relative to a given `today` date.

- **Code**:
	```swift
	private var weekDays: [Date] {  
    (0..<7).reversed().compactMap { calendar.date(byAdding: .day, value: -$0, to: today) }  
	}  

- **Breakdown**:
	| Component | Explanation |
	| ----------- | ----------- |
	| `(0..<7)` | Creates a range from `0` to `6` (inclusive of `0`, exclusive of `7`). |
	| `.reversed()` | Reverses the range, converting `[0, 1, 2, 3, 4, 5, 6]` → `[6, 5, 4, 3, 2, 1, 0]`. |
	| `.compactMap { ... }` | [LL#1](LearningLogs.md) |
	| `calendar.date(byAdding: .day, value: -$0, to: today)` | Computes a new date by subtracting `$0` days from `today`.<br>For each value in `[6, 5, ..., 0]`:<br>• `today - 6 days` (oldest date)<br>• `today - 5 days`<br>• `...`<br>• `today - 0 days` (today itself) |

- **Key Insights**:
	- Order: The array starts with the oldest date (`today - 6 days`) and ends with `today`.
	- Time Sensitivity: Depends on the `calendar` and `today` properties (ensure they’re correctly initialized).
	- Edge Cases: If `today` is invalid, `compactMap` ensures `nil` values are excluded.

---

### 4. `dayLetter` Computed Property
- **What it does**:
	Converts a `Date` into its capitalized weekday initial (e.g., "M" for Monday).

- **Code**:
	```swift
	private var dayLetter: String {
		DateFormatter().shortWeekdaySymbols[
			Calendar.current.component(.weekday, from: Date()) - 1
		].prefix(1).uppercased()
	}

- **Breakdown**:
	| Component | Description | Example | Notes |
	| ----------- | ----------- | ----------- | ----------- |
	| `Calendar.current.component(.weekday, from: Date())` | Returns the weekday number (`1-7`) from a `Date` object | `1 = Sunday`<br>`2 = Monday` | - |
	| **Index Adjustment** (`- 1`) | Converts the weekday number (`1-7`) to a zero-based index (`0-6`) | `1 (Sunday) → 0` | Needed because `shortWeekdaySymbols` uses 0-based indices (`0-6`) |
	| `DateFormatter().shortWeekdaySymbols[...]` | Gets localized abbreviated weekday name | `"Mon"` (English)<br>`"Lun"` (Spanish) | [LL#2](LearningLogs.md) |
	| `.prefix(1).uppercased()` | Extracts and capitalizes first letter | `"Mon" → "M"` | Consistent single-letter output |

- **Key Insights**:
	- Safety:
		Weekday numbers are always `1-7`, so no out-of-bounds errors.
	- Calendar-Agnostic:
		Works regardless of the calendar's first weekday (Sunday/Monday/etc.).
	- Localization-Ready:
	Uses the system’s `shortWeekdaySymbols` (no hardcoded values).


---

### 5. `action` closure parameter
- **Type Requirement**:
	- `DayCompletionView` expects `action: () -> Void` (no parameters, no return):
		```swift
		struct DayCompletionView: View {
			let action: () -> Void
		}
    
    - But `toggleCompletion(for:)` requires a `Date` parameter and uses the `modelContext`:
		```swift
		func toggleCompletion(for date: Date) {
			let log = habit.log(for: date, modelContext: modelContext)
			log.isCompleted.toggle()
		}

- **How It Works**:
	The closure captures the current `weekDay` value from the `ForEach` iteration
    Creates a parameter-less closure that "remembers" its specific `weekDay`

- **Execution Flow**:
	`Button Tap` → Calls closure `()` → Runs `toggleCompletion(for: capturedWeekDay)`

- **Equivalent Swift Code**:
	```swift
	let action: () -> Void = { [weekDay] in
    	self.toggleCompletion(for: weekDay)
    }

---
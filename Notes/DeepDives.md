## 🧠 Deep Dives
*(For breaking down existing implementations)*

---

### 1. 

---

### 2. `dayLetter` Computed Property
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

### 3. 
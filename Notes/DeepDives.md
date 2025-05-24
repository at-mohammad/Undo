## 🧠 Deep Dives
*(For breaking down existing implementations)*

---

### 1. `dayLetter` Computed Property
- **What it does**:
	Converts a date into its capitalized weekday initial (e.g., "M" for Monday).

- **Code**:
	```swift
	private var dayLetter: String {
		DateFormatter().shortWeekdaySymbols[
			Calendar.current.component(.weekday, from: date) - 1
		].prefix(1).uppercased()
	}

- **Breakdown**:
	- `Calendar.current.component(.weekday, from: date)`:
		Returns the weekday number (1-7) from a date, where:
			```swift
				1 = Sunday  
				2 = Monday  
				...  
				7 = Saturday
	- Index Adjustment (`- 1`):
		Converts the weekday number (`1-7`) to a zero-based index (`0-6`) for array access.
		Why? `shortWeekdaySymbols` is an array (indices `0-6`).
	- `DateFormatter().shortWeekdaySymbols[...]`:
		Fetches the abbreviated weekday name (e.g., "Mon" for Monday).
		Localization: Automatically adapts to the device's language (e.g., "Lun" for Spanish).
	- .prefix(1).uppercased():
		Takes the first letter of the symbol and capitalizes it (e.g., "Mon" → "M").

- **Key Insights**:
	- Safety:
		Weekday numbers are always 1-7, so no out-of-bounds errors.
	- Calendar-Agnostic:
		Works regardless of the calendar's first weekday (Sunday/Monday/etc.).
	- Localization-Ready:
	Uses the system’s shortWeekdaySymbols (no hardcoded values).
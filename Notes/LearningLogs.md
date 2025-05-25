## 📚 Learning Logs
*(For new concepts I'm learning for the first time)*

---

### 1. `compactMap`
- **What it does**:
  Like `map`, but filters out `nil` results and unwraps optionals.
- **Example**:
  ```swift
  ["1", "2", "x"].map { Int($0) } // [Optional(1), Optional(2), nil]
  ["1", "2", "x"].compactMap { Int($0) } // [1, 2] (no nil)
  ```

---

### 2. `shortWeekdaySymbols` Property of `DateFormatter`
- **Description**:  
  Returns an array containing short symbolic representations of weekdays (typically 3-letter abbreviations) in the current locale's calendar system.

- **Important Notes**:
  - The array index corresponds to weekday numbers (0 = Sunday, 1 = Monday, ..., 6 = Saturday)
  - The actual values depend on the device's current locale and calendar
  - For consistent results, consider setting the `locale` property of your `DateFormatter`

- **Example**:
  ```swift
  let formatter = DateFormatter()
  let weekdays = formatter.shortWeekdaySymbols
  
  print(weekdays[0]) // "Sun"
  print(weekdays[1]) // "Mon"
  // ...
  print(weekdays[6]) // "Sat"

---

### 3. 
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
- **What it does**:  
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

### 3. `Dictionary(uniqueKeysWithValues:)`
- **Description**:
  A Swift dictionary initializer that creates a new dictionary from a sequence of key-value pairs.
- **How It Works**:
	- Input: It takes a sequence (like an `Array` or `Range`) as input
	- Output: It converts this sequence into a dictionary where:
		- The first element becomes a key
		- The second element becomes the corresponding value
- **Important Notes**:
	- Unique Keys Requirement:
		- All keys must be unique (hence the name `uniqueKeysWithValues`)
		- If there are duplicate keys, it will crash at runtime
	- **Performance**:
		- This is an efficient way to create a dictionary when you have parallel arrays of keys and values
		- More efficient than creating an empty dictionary and adding values one by one

---

### 4. `TabView`
- **Description**:
  - A view that switches between multiple child views
- **How It Works**:
  - Creates a container for tab-based navigation
  - Manages tab switching and displays the active tab's content
- **Tab Order**:
  - First tab is default selection on launch
  - Order determines leading-to-trailing arrangement
- **Important Notes**:
  - Supports programmatic selection (using `@State` + `selection` parameter)
  - Loads views lazily by default
  - Preserves view state when switching tabs

---

### 5. `calendar.date(byAdding:value:to:)`
- **Description**:
  - A `Calendar` method used to accurately calculate past or future dates by adding or subtracting specific calendar components.
- **How It Works**:
  - Input: It takes a time component (like `.day`), a value (negative to go back in time), and a reference `Date`.
  - Output: It returns a new `Date` that is shifted by that exact calendar amount, preserving the time of day.
- **Important Notes**:
  - The method returns an optional, but force unwrapping (`!`) is safe for standard operations like "yesterday" since valid dates always have a predecessor.

---

### 6. `.shadow(color:radius:x:y:)`
- **Description**:
  A view modifier that applies a shadow to the view.
- **How It Works**:
  Adds visual depth by simulating elevation above the background surface.
- **Parameters**:
  - `color`: The color of the shadow (supports opacity).
  - `radius`: The size of the blur; higher values create softer, more diffused shadows.
  - `x`: The horizontal offset (positive moves right, negative moves left).
  - `y`: The vertical offset (positive moves down, negative moves up).
- **Visual Logic**:
  - The offsets (`x` and `y`) simulate the angle of the light source relative to the object.
  - A positive `y` value (e.g., `y: 5`) pushes the shadow downwards. This creates the illusion that the light source is positioned **above** the object, casting the shadow on the floor beneath it.
- **Example**:
  ```swift
  .shadow(color: .black, radius: 4, x: 0, y: 5)
  ```

---

### 7. `date.formatted(.dateTime.weekday(.wide))`

- **Description**:
  Displays the full name of the day of the week (e.g., "Monday") derived from a `Date` object.
- **How It Works**:
  It uses the modern Swift `FormatStyle` API (iOS 15+) to convert a raw `Date` into a string. It extracts only the specific component requested (the weekday) while adhering to the user's device locale settings.
- **Parameters (Chain)**:
  - `.formatted(...)`: The method that converts non-string data (like Dates) into a String.
  - `.dateTime`: Specifies that the formatting logic is for Date/Time (as opposed to Currency or Numbers).
  - `.weekday`: Restricts the output to only show the day of the week.
  - `.wide`: The style argument; requests the full spelling (e.g., "Friday"). Other options include `.abbreviated` ("Fri") or `.narrow` ("F").
- **Localization**: This method is locale-aware. If the user’s device is set to Spanish, `.wide` will output "viernes" automatically; no manual translation files are needed.
- **Example**:
  ```swift
  Text(date.formatted(.dateTime.weekday(.wide))) // Renders: "Thursday"
  Text(date.formatted(.dateTime.month().day())) // Renders: Oct 24
  ```

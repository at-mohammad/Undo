//  Notes.md
/  Undo
/  Created by AbdelRahman Mohammad on 24/05/2025.
//

## 📚 Learning Log

### `compactMap` (New!)
- **What it does**:
  Like `map`, but filters out `nil` results and unwraps optionals.
- **Example**:
  ```swift
  ["1", "2", "x"].compactMap { Int($0) } // [1, 2] (no nil!)
what about this line

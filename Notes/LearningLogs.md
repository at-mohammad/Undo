## 📚 Learning Logs
*(For new concepts I'm learning for the first time)*

### 1. `compactMap`
- **What it does**:
  Like `map`, but filters out `nil` results and unwraps optionals.
- **Example**:
  ```swift
  ["1", "2", "x"].compactMap { Int($0) } // [1, 2] (no nil!)
  ```

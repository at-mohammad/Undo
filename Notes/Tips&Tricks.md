## 🎯 Tips & Tricks
*(For best practices and optimization techniques)*

---

### 1. Computed Properties $ Expensive Instances Placement
- **General Best Practice:**  
	Place computed properties and expensive instances (e.g., `Date`, `DateFormatter`, `Calendar`) as high as possible in the view hierarchy for better performance.

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
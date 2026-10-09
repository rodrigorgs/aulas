**Investigation:**

`AnalysisDriver.removeFile` is extremely expensive because it acts as a "nuke" operation that completely destroys the `AnalysisDriver` and `FileSystemState` caches, rather than simply untracking the file. 

Here is the exact chain of events:

1. **`FileTracker.removeFile` destroys the File System State:**
   - It calls `_fsState.removeFile(path)`. Inside `FileSystemState`, this method unconditionally delegates to `_clearFiles()`, which drops the *entire* file state cache. This includes wiping all `_pathToFile`, `_uriToFile`, `knownFiles`, and `unlinkedUnitStore` mappings regardless of whether they import the removed file or not.

2. **`FileTracker.removeFile` schedules a full re-analysis:**
   - After clearing `FileSystemState`, it executes `_pendingFiles.addAll(addedFiles);`. This schedules *every single tracked file* in the driver to be re-analyzed from scratch. (As noted by the `// TODO(paulberry)`).

3. **`AnalysisDriver._applyPendingFileChanges` destroys the Library Context:**
   - Under `case _FileChangeKind.remove:`, it immediately invokes `clearLibraryContext()`. (As noted by your `// TODO(scheglov)`).
   - This destroys the entire `LibraryContext`, clearing the `AnalysisSession` and entire Element Factory cache.

4. **`AnalysisDriver.removeFile` clears resolved caches unconditionally:**
   - It executes `_priorityResults.clear()` and `_resolvedLibraryCache.clear()` completely wiping them rather than specifically removing the untracked path.

Essentially, `removeFile` takes the whole driver back to a completely cold state as if it just restarted, which is why it takes a massive amount of time to execute.

---

**Proposed Solution Plan:**

The overall directive is to restrict `removeFile` to simply "stop proactively analyzing this file", leaving `changeFile` and GC patterns to handle file content changes and memory management natively.

**Step 1. Decouple Tracking from State Purging in `FileTracker`**
- **Remove `_fsState.removeFile(path)`:** A file being removed from `addedFiles` doesn't mean it should be forcefully evicted from `FileSystemState` (other files might still import it). If it actually was deleted from disk, standard file watching will trigger `changeFile(path)`, which properly computes impact and invalidates dependent file states natively.
- **Remove `_pendingFiles.addAll(addedFiles)`:** There is no need to re-analyze untouched added files just because one file dropped out of tracking.

**Step 2. Stop Wiping `LibraryContext` in `AnalysisDriver`**
- **Remove `clearLibraryContext()` in `_applyPendingFileChanges`:** The Element Factory cache should remain intact when untracking a priority file. If the file was deleted, the fine-grained dependency tracking system will invalidate the necessary parts of the `LibraryContext` natively during the associated `changeFile` action. There's no need to arbitrarily kill the whole context.

**Step 3. Localize Cache Cleaning in `AnalysisDriver.removeFile`**
- Change `_priorityResults.clear()` to `_priorityResults.remove(path)`.
- Change `_resolvedLibraryCache.clear()` to `_resolvedLibraryCache.remove(path)`.

**Step 4. (Optional) Retire `FileSystemState.removeFile`**
- Since `fsState` naturally holds onto files via imports—and garbage collects unreachable ones statically via `fsState.removeUnusedFiles()`—the explicit "nuking" method `fsState.removeFile(path)` (`_clearFiles()`) can likely be removed entirely from the codebase once `FileTracker` stops relying on it.

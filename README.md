# KernelPatches
Patches base aosp kernel on common-android13-5.10 

```
repo init -u https://android.googlesource.com/kernel/manifest -b common-android14-5.15
```

```
commit 003b47a3f5e11317cf42a89aa8f13a3dab3e4374 (m/common-android13-5.10, aosp/android13-5.10)
Author: Suren Baghdasaryan <surenb@google.com>
Date:   Thu Feb 8 14:19:04 2024 -0800

    ANDROID: introduce a vendor hook to allow speculative swap pagefaults
    
    Since SPF is an out-of-tree feature, the risks of changing its behavior
    are higher. Add a vendor hook to enable speculative swap pagefaults. By
    default it's disabled and should not cause troubles for current users.
    
    Bug: 322762567
    Change-Id: I3df7c545aa27d2707ee51ea42368f785c5faa735
    Signed-off-by: Suren Baghdasaryan <surenb@google.com>

commit 8a1558b1e2e21fdc48d3e72406edf49fe39e701e
Author: Suren Baghdasaryan <surenb@google.com>
Date:   Thu Feb 8 13:45:31 2024 -0800

    ANDROID: mm: allow limited speculative page faulting in do_swap_page()
    
    Speculative page handling was disabled in do_swap_page() because it was
    unsafe to call migration_entry_wait(). Another calls which are not safe
    without taking mmap_lock are ksm_might_need_to_copy() because it relies
    on the VMA being stable and readahead. However if we avoid these cases,
    the rest seems to be safe. Relax the check to avoid only these unsafe
    cases and allow speculation otherwise.
    
    Bug: 322762567
    Change-Id: Ic1fda0a5549088d5f37004dbacf3193116a5f868
    Signed-off-by: Suren Baghdasaryan <surenb@google.com>
```

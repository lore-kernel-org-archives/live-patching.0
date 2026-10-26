Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.216.41
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793009989;
	b=tDj277oDXxwT5PJQ4ND3LoopL5NtOiuhYQMI+TcPgSV4hl5XwG7pjklf2ZQROvTQnpCv
	 VH892eWGPBhoTkGVpETM7q6bM2g4BscIFfxLJGUY84gmY5h1Ez90IhyCpF+yNNRLAH70n
	 8nB/qqxaAXA3KcNtBUANAfODycb3wdpQHG7wzRJexUiA7HtCHFSdkFGKZwA/ovKuJ8xpC
	 FGd1OqM6jXKOcxCrev56QuVFiD5HCNV7UlkjxGxdQopBll+wKBP6QcGe5WOoezyODGzHD
	 1mYV3qlp4YL45MfvRCXrW98VRWdmFCJ3Fon6KD8NLeXM48dDfIioOZXRzVDxIEULvTQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793009989;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=JcLVMf0LdAgz1MITUUpbIuy28Su1zCV5t3JnvS/Uxao=;
	b=HLZnYAK+EViMIG00ATw9wUmd1sl9wbBGT797gSgutFmWBUdZxVMuYQ9i2iGTWsZF/yB6
	 xqeOpAqe8WDXARDp2vovaFFWfQXaFpwyYx31rhGnO13zdTDb4qWL9tFYtizTciHQRQRTn
	 32NS/lE3zu3WidEeWU2tyuCrasKCwY7/LRmvyDEO/5MrSnfq82FH/cLcflswu4R6Atv25
	 81c+6iaTM/eGjk7ixvCpuLVEVRv1M2vJLZg3fAJz/aKzUsCB2RzhWceTmlVX9wv+gb31e
	 wyUI0W8YYMAyFo0w6CH2T6o2973RRGqVwbv4gOZ3ao6+pWC+ryP2ncoyjdacHdUwnJw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=dLHFiG+z;
	arc=none smtp.remote-ip=209.85.216.41
Received: from mail-pj1-f41.google.com (mail-pj1-f41.google.com [209.85.216.41])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2802D606A321
	for <live-patching@vger.kernel.org>; Mon, 26 Oct 2026 10:19:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 2802D606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=dLHFiG+z
Received: by mail-pj1-f41.google.com with SMTP id 98e67ed59e1d1-3ac9f49b984so1724044a91.1
        for <live-patching@vger.kernel.org>; Mon, 26 Oct 2026 03:19:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1793009987; x=1793614787; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=JcLVMf0LdAgz1MITUUpbIuy28Su1zCV5t3JnvS/Uxao=;
        b=dLHFiG+zOlZ4s1Rb7flbzHW9lsjBeS4mN/xLIG7fiTPNaQ8+bV5Gl/eVkes7/VKBiB
         wxuBnXvFnGW0a7iFstgmOudmvw7WWK0gB5TlUYetXbOEL2ryQkU7iyejfTIRzezJgNDy
         067PF+vz0b7ESyb2uRrhq6fDToImXQFujNOXmKPso54ymBuglAyG2etxFyrgZPuTDs8F
         Uf6wLc3Gd17dB6muhDJe47mLIKbfrydN60+5f6YN7fcq1rOIcQHyyvjOkpexslhMxyzP
         0Y0CyrYJfRKuPWLkBbvmhpyPYy4SPAFWEl8voqAKfJQbxzIydriJMZjVK1j/h1DDIuUD
         3HDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793009987; x=1793614787;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=JcLVMf0LdAgz1MITUUpbIuy28Su1zCV5t3JnvS/Uxao=;
        b=anCvxGgGZWJN5dDLQ2PgtWlcHWjKarNT+jiViBvVT5QoKbVKK3pin3hEtrfL9X1Ox2
         EfIKacDSPSGz53yIE84ZSHo2k7VDiVNvRGwEFVxojgX/bG1JM+Sn4qSzysKxUZU59C9T
         BLPXD0TNA8K9CEcIF6P7pX231ajR/jafbr2YY7RqeQ40EWSCQnsfBUG4ozZ4cJdHjv7g
         XLaAS0G+gzD8554OskJlBKMnIE9nZn5uFhf6goZjvnP65wQOL7SntzwG7D/sVyPv5vtV
         +9UqoQ3vWyflMBlGpsHSSn251ar6YuXm+QpjJ00FYlN0wQHU+uw6RRH4bhrmJWQkU32e
         3Cmw==
X-Forwarded-Encrypted: i=1; AKwUvBymvCwLgx1VjQ8kSqtdMFOMRWgPqlZ7G3XXEgS+tOBByIJejqWIlxrcdv8hyFPzepjUxBZfc7yjqH/5swix@vger.kernel.org
X-Gm-Message-State: AFq9FYKRRu3Ti7yc+U39193mc7gduGXH1KGmBhE9+Q7i6cFkzOCUpYfV
	tl660V0rzNlwim0fEbb2s4JOjneVdSqpxQL4800upBB+HbnhcubuZbHD
X-Gm-Gg: AYBFou1kfWycPHxImtEsghOFExlf2OHGVYrQ4lOw/tpt/7AlX6X1VKrS97RhR3/Qvaj
	0CPTz1M0lJArZ12BsSqIf4IN53GsbOV+1GcFqOGosXZXVJGIpM8p8FmbUBT+XeZ9sggVceOFa/I
	W3QDGMnQq38Gx1YvBrIFikXSpcAUGssgk8l130JToJrgu7XOUjdWDuolG+NnKPQJRZnnbyxQ9fD
	VJf35GxJnbOozL1QZTlhMVVhs0eK5Pcox3P2+qQ3uAP+YquRt9nWAUXK8aChmbHEJn94jl8VYgi
	XDXeC20ZG4VUv0LVoeXZC5WS3kwsNmKR+YRaWwgCX8MfZY4I95OOkZOlo+cGhqklFjBW6pu7zVD
	WwgtCGgwgYJe7Z6YH40O1m5Wzdhozww1JK/7lsgpC7me4KDumxqzQ7p48dmd+RQk14i1xqKHeI6
	NKdgbzJzV4oRNohb6eOsg+7n5uJ1tOd5Ruji+oOZkGitDi0jqth5KWHVRVilIqW1agKh5yVtzI4
	9NLp2Mnz4/ODnclpxfaIStGwoOTJhx09XVzrwCUeVTXzKqiZEp8GNq7bFTWBuFDIiya7NI/TfJS
	hQ==
X-Received: by 2002:a17:90b:3c05:b0:3ac:36c7:c144 with SMTP id 98e67ed59e1d1-3adeb5e3aa7mr3143254a91.28.1793009987407;
        Mon, 26 Oct 2026 03:19:47 -0700 (PDT)
Received: from anatasluo-Precision-5560 ([2408:820c:d29:db90:8486:5157:635e:e0f0])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3adeba32e38sm8477565a91.2.2026.10.26.03.19.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Oct 2026 03:19:46 -0700 (PDT)
From: Longjun Luo <luolongjuna@gmail.com>
To: jpoimboe@kernel.org,
	peterz@infradead.org
Cc: mbenes@suse.cz,
	pmladek@suse.com,
	joe.lawrence@redhat.com,
	song@kernel.org,
	puranjay@kernel.org,
	nathan@kernel.org,
	ndesaulniers@google.com,
	morbo@google.com,
	justinstitt@google.com,
	live-patching@vger.kernel.org,
	llvm@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Longjun Luo <luolongjuna@gmail.com>
Subject: [RFC PATCH 0/3] objtool/klp: DWARF-based cross-build symbol correlation
Date: Mon, 26 Oct 2026 18:19:13 +0800
Message-ID: <20261026101916.3823942-1-luolongjuna@gmail.com>
X-Mailer: git-send-email 2.53.0
X-Mailing-List: live-patching@vger.kernel.org
List-Id: <live-patching.vger.kernel.org>
List-Post: <mailto:live-patching@vger.kernel.org>
List-Help: <mailto:live-patching+help@vger.kernel.org>
List-Subscribe: <mailto:live-patching+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:live-patching+unsubscribe@vger.kernel.org>
List-Owner: <mailto:live-patching+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Motivation
----------

I have been working on a general-purpose livepatching mechanism,
non-intrusive (transparent to build systems) and mainly for C/C++
userspace programs.

During this work, I found that LTO optimizations make cross-build
symbol correlation particularly challenging, as the ELF symbol table
(`STT_FILE` and symbol names) lacks sufficient context to reliably
distinguish symbols across builds.

In traditional per-object diffing (`kpatch-build`), comparing
individual `.o` files naturally isolates each translation unit. LTO
crosses these boundaries and can change symbol binding through
promotion or internalization. This series continues object-level
diffing by using the DWARF DIE tree to disambiguate symbols.

To support LTO on `vmlinux.o`, `klp-build` precomputes per-symbol
checksums in `klp-checksum` and then correlates symbols in `klp-diff`
through a multi-stage heuristic pipeline:
  1. Lockstep pairing of all `STT_FILE` symbols across both objects.
  2. An iterative loop alternating between a 4-level filtering funnel
     in `find_twin()` (demangled name -> `is_tu_local_sym()` ->
     `same_file()` -> size/checksum) and `.llvm.<hash>` suffix
     propagation via `suffix_map` and `find_twin_suffixed()`.
  3. A last-resort relative-position match among remaining same-named
     candidates in `find_twin_positional()`.

This approach is effective for most kernel patches and matches all
comparable twins in my baseline `vmlinux.o` audits (see Evaluation).
In some scenarios, however, LTO optimizations can still break its
assumptions, leading to missed correlations or silently pairing
unrelated symbols.

This RFC proposes a DWARF-derived `(source, scope, name)` identity to
complete the symbol representation layer in `klp-build`, strengthening
symbol correlation and laying a foundation for subsequent stages.

The series contains three patches:
  1/3: Symbol identity and correlation.
  2/3: Reference checksums using symbol identity.
  3/3: Regression tests.

Limitations of ELF-only Correlation
-----------------------------------

The following minimized reproducers illustrate correlation failures
I found while analyzing kernel builds and common kernel patterns.

1. Missing lexical scope (`scope` is needed) [GCC, non-LTO]

   In `fs/jfs/inode.c`, `jfs_commit_inode()` and `jfs_dirty_inode()`
   each define `static int noisy = 5` to limit error messages.

   A small error-reporting patch adds the inode number to the existing
   `jfs_commit_inode()` diagnostic, and limits repeated writeback errors:

     int jfs_commit_inode(struct inode *inode, int wait)
     {
         static int noisy = 5;
         ...
    -    jfs_err("jfs_commit_inode(0x%p) called on read-only volume",
    -            inode);
    +    jfs_err("jfs_commit_inode(0x%p), ino=%llu on read-only volume",
    +            inode, inode->i_ino);
         ...
     }

     int jfs_write_inode(struct inode *inode, struct writeback_control *wbc)
     {
    +    static atomic_t noisy = ATOMIC_INIT(5);
         ...
         if (jfs_commit_inode(inode, wait)) {
    -        jfs_err("jfs_write_inode: jfs_commit_inode failed!");
    +        if (atomic_dec_if_positive(&noisy) >= 0)
    +            jfs_err("jfs_write_inode: commit failed for inode %llu",
    +                    inode->i_ino);
             return -EIO;
         }
         ...
     }

   Building the real `fs/jfs/inode.o` with GCC 16.2.1 and
   `CONFIG_JFS_DEBUG=y` gives:

     Owning function       Original name  Patched name
     --------------------  -------------  ------------
     jfs_commit_inode      noisy.1        noisy.2
     jfs_dirty_inode       noisy.0        noisy.0
     jfs_write_inode       absent         noisy.1

   Expected:    preserve the existing counters; allocate only the new
                `jfs_write_inode()` counter.

   Actual:      Two `no correlation` warnings, but the livepatch builds
                and loads successfully. The replaced `jfs_commit_inode()`
                references a fresh `noisy.2` and emits the diagnostic
                five more times after the original warning budget is
                exhausted.

   This series: preserves the original counter through its function
                scope; no further diagnostics are emitted after applying
                the livepatch.

   Cause:       Under GCC, all three 4-byte objects (initialized to 5)
                strip to `demangled_name = "noisy"` under the same
                `STT_FILE` without function scope; when the candidate
                count changes from two to three, positional matching
                gives up. The same naming pattern also occurs with the
                two function-local `DEFINE_MUTEX(mutex)` instances in
                `kernel/sched/rt.c`.

2. ThinLTO promotion shift swaps cross-TU state (`source` is needed)
   [Clang/LLD 23.1.0 ThinLTO]

   With the kernel's default ThinLTO flags
   (`-always-rename-promoted-locals=false` and `-import-instr-limit=5`)
   and unchanged link inputs and order:

   Before (orig):
     /* a.c */ static volatile int state[4];
               int a_get(unsigned int i) { return state[i]; }
     /* b.c */ int target(unsigned int i) { return a_get(i) + d_get(i); }
     /* d.c */ static volatile int state[4];
               int d_get(unsigned int i) { return state[i]; }
     /* Both a_get() and d_get() are imported into b.c:
      *   a.c state -> STB_GLOBAL: "state"
      *   d.c state -> STB_GLOBAL: "state.llvm.<H>" */

   After (patched, adding a bounds check to `a_get()`):
     /* a.c */ static volatile int state[4];
               int a_get(unsigned int i) {
    +              if (i >= 4) return 0;
                   return state[i];
               }
     /* a_get() is no longer imported; d.c's state claims "state":
      *   a.c state -> STB_LOCAL:  "state"
      *   d.c state -> STB_GLOBAL: "state" */

   Expected:    patched `a_get()` continues referencing `a.c`'s `state`.

   Actual:      `klp-diff` exits 0 with no warning and swaps the two
                state identities: with `a.c:state[0] = 64` and
                `d.c:state[0] = 32`, `a_get(0)` returns 32 instead of 64,
                and the inlined `d_get()` in untouched `b.c` binds to
                `a.c`'s array.

   This series: `a_get(0)` returns the expected 64.

   Cause:       Under `-always-rename-promoted-locals=false`, ThinLTO
                keeps the unsuffixed `STB_GLOBAL` name for the first
                promoted static of each name in link order and gives
                the others `.llvm.<H>` suffixes. When import decisions
                shift, the unsuffixed name moves to another TU's
                symbol, and `is_tu_local_sym()` treats both as
                non-TU-local.

   In a real ThinLTO kernel build, this same shift moves the unsuffixed
   `m_start/m_next/m_stop/m_show` `seq_operations` callbacks from
   `fs/namespace.c` to `kernel/module/procfs.c` when a 30-line patch under
   `kernel/module/` reuses the `procfs.c` iterator. `klp-diff` marks all
   eight callbacks as changed (including four in untouched
   `fs/namespace.c`) and exits successfully without warnings. Loading
   the generated module fails on duplicate `m_start,1` sysfs registration.
   This series includes only the intended changes
   (`read_file_mod_stats()` and `modules_seq_ops()`) and loads and rolls
   back cleanly.

3. Loss of `STT_FILE` boundaries [Clang Full LTO]

   Before (orig):
     /* left.c  */ static volatile int state;
                   int left_fn(void) { return ++state; }
     /* right.c */ static volatile int state;
                   __attribute__((noinline)) static int helper(void) {
                       return ++state;
                   }
                   int right_fn(void) { return helper(); }
     /* Full LTO ELF: STT_FILE is "ld-temp.o", 1 local "helper" */

   After (patched):
     /* left.c extracts ++state into a same-named noinline helper(): */
     /* left.c  */ static volatile int state;
    +              __attribute__((noinline)) static int helper(void) {
    +                  return ++state;
    +              }
    +              int left_fn(void) { return helper(); }
     /* right.c is unchanged */
     /* Full LTO ELF: STT_FILE is "ld-temp.o", 2 local "helper" symbols
      *               with identical size and checksum */

   Expected:    `right.c:helper` correlates with orig;
                `left.c:helper` is new.

   Actual:      Warns `no correlation: helper`; unchanged `right.c:helper`
                loses correlation and both helpers are cloned as new
                functions.

   This series: correlates `right.c:helper` with orig and avoids copying
                the unchanged helper (both livepatches preserve the
                counters at runtime).

   Cause:       Full LTO merges all IR modules before codegen, collapsing
                `STT_FILE` into a single `ld-temp.o` without per-TU
                `.llvm.<hash>` suffixes, so ELF symbols lose their
                defining TU boundaries.

Proposed Design: (source, scope, name) Identity
-----------------------------------------------

DWARF entries are matched to ELF symbols directly by relocated
`(section, offset)` address. From an in-memory perspective, each ELF
symbol is identified by `(source, scope, name)`:

  - `source`: The physical translation unit (CU) that emits the instance
    into memory (for `DW_AT_external` symbols, as opposed to unstable
    ELF `st_bind`, `source` is set to `""`; `STT_FILE` is used only as
    a fallback when DWARF is unavailable).
  - `scope`: The slash-delimited chain of named enclosing scopes recorded
    by DWARF for the in-memory instance (e.g., `"/"` or `"/func/"`).
  - `name`:
      a. `demangled_name`: objtool's normalized name with compiler
         suffixes stripped.
      b. `symbol name`: the raw symbol name from the ELF symbol table.

Symbol correlation proceeds in two steps (see Patch 1 for details):

  1. Group symbols into `(source, scope, demangled_name)` hash buckets
     and apply centralized ELF suffix compatibility rules within each
     bucket.
  2. Accept only unique, deterministic twins within the bucket (first by
     compatible name, then using size and checksum for remaining
     unchanged candidates), verified bidirectionally (`orig <-> patched`)
     without positional fallback.

This series requires libdw, adds `-g` to the klp-build compilation, and
currently rejects split DWARF.

Example (`source` and `scope` reflect post-optimization DWARF):

  /* include/header.h */
  static inline int record(int x) {
      if (x > 0) {
          static int state;
          return ++state;
      }
      return 0;
  }

  /* net/a.c */
  int tx(int x) { return record(x); }

From a static source-text view, `state` is written in `include/header.h`
inside an `if` lexical block, and `record()` is inlined into `tx()`.
From the in-memory DWARF perspective:
  - `source` is `"net/a.c"` (the physical CU that allocates `state` in
    memory, not `"include/header.h"`).
  - `scope` is `"/record/"`: the scope construction follows the owning
    subprogram and skips unnamed lexical blocks. Inlining into `tx()`
    does not change the variable's owning scope.

Symbol Correlation Evaluation
-----------------------------

This series accepts unique, bidirectional 1:1 matches without
positional guessing. In a cross-audit of x86-64 `vmlinux.o` builds,
I compared klp-build's twins with those independently derived using
my standalone DWARF-based symbol identity tool. The results agree on
all comparable twin pairs:

  Build pair                         Comparable pairs  Discrepancies
  ---------------------------------  ----------------  -------------
  Clang ThinLTO: getpid                        91,300              0
  Clang ThinLTO: ACPICA                        91,300              0
  Clang Full LTO: version_show                 91,171              0
  GCC non-LTO: version_show                    95,337              0

The builds use DWARF 5: ThinLTO uses Clang/LLD 22.1.8
on Linux 7.3-rc7 `24a19b953e2a`; GCC 16.2.1 / GNU ld 2.46.1 and
Clang/LLD 22.1.8 Full LTO use mainline `4403278e4ea2`.

Within this set, the twins retained by this series agree with those
derived from my tool. In the ThinLTO builds, this series leaves 363
data symbols per side uncorrelated that klp-build pairs heuristically:

  DWARF information                      Count  Follow-up
  -------------------------------------  -----  -------------------------
  Available (pieces/value expressions)      89  Extend reader support.
  Incomplete (anonymous lexical scopes)    154  Detect ambiguity and
                                                reject.
  Absent (C compound literals)             120  Compare references from
                                                changed functions; reuse
                                                unchanged objects.

These symbols are reported as `no correlation` instead of being paired
by guesswork. Until the follow-ups land, changed functions that
reference them still get cloned copies, as in Case 1 with the existing
`klp-build`. I have tested follow-up patches for the table above and
will post them separately.

The upstream and added tests report 51 pass / 3 fail / 7 skip with GCC
and 57 pass / 3 fail / 1 skip with Clang (the three failures are policy
rejections of linkage flips and duplicate-TU compilations), and the
kernel cases above were verified in QEMU (apply, behavior, and rollback).

The `(source, scope, name)` tuple also strengthens `klp-checksum`'s
representation layer. Compressing references into a `demangled_name`
digest loses resolution and misses switches between same-named targets
of different origin or linkage [1]. Hashing `source/scope/demangled_name`
(Patch 2) resolves this while keeping compiler suffix changes
transparent, confirmed by runtime tests across two GCC cases and one
ThinLTO case.

For `klp checksum --dry-run` on `vmlinux.o`, the time and peak RSS go
from 4.546 s / 3984.8 MiB to 13.752 s / 5825.3 MiB with this series,
or 10.823 s / 4870.0 MiB with the optimized reader.

Compared with the comparison approach used in my userspace
implementation, `klp-checksum`'s single-object digest is faster and
simpler; adding the tuple preserves these advantages while recovering
target-identity precision.

On the pre-checksummed ThinLTO `vmlinux.o` pair (~1.081 GiB per input,
353.8 MiB `.debug_info`), `objtool klp diff` medians from three warm runs
on an Intel Core i7-11850H (30.6 GiB RAM, libdw 0.196) are:

  Version                      Elapsed time  CPU time    Peak RSS
  ---------------------------  ------------  --------  ----------
  klp-build baseline                3.816 s   3.814 s  3566.3 MiB
  This series                      22.404 s  22.399 s  5470.3 MiB
  Optimized (single-threaded)      16.441 s  16.437 s  3714.0 MiB

This series prioritizes readability and correctness. The single-threaded
optimized prototype produces the same twin tables and patch outputs as
this series. It takes 16.441 s and adds 147.7 MiB (+4.1%) of peak memory
over the baseline. These optimizations will be submitted separately.

DWARF Reliability & Scenarios
-----------------------------

Correlation uses CU paths, named scopes, `DW_AT_external` and fixed
addresses from the DWARF DIE tree. It does not require CFI, line tables
or dynamic location lists. This reduces dependence on compiler-specific
flags and version-dependent naming behavior (as seen in Case 2 between
LLVM 22.1.8 and LLVM 23.1.0).

In my userspace livepatching implementation, I evaluated the identity
model across 17 security-fix cases in 15 C/C++ projects:

  - Databases & Caches:   Redis, PostgreSQL, MariaDB
  - Web & Network:        Nginx, Squid, BIND, OpenSSH, Samba, Netatalk
  - System & Libraries:   glibc, OpenSSL, QEMU, GStreamer, Poppler, libjxl
  - Build Configurations: DWARF 4/5;
                          GCC (non-LTO, single/multi-partition LTO);
                          Clang/LLD (non-LTO, Full LTO, ThinLTO)
  - Distributions: Debian 13, Fedora 44, openEuler 24.03 LTS SP3,
                   openSUSE Leap 16.0, RHEL UBI 10.2, Ubuntu 24.04
  - Toolchains: GCC 12-16 and Clang 17-22

For Nginx CVE-2026-27654, all 30 configurations across six distributions
and five compiler/LTO modes completed patch application, behavior
verification and rollback. The Redis and OpenSSH cases also completed
application and rollback tests across all six distributions.

Strict cross-verification during this work also led to several upstream
toolchain bug reports, fixes and a DWARF proposal [2-9]. All of these
corner cases are either fixed upstream or mitigated in my standalone
tool and this series, confirming that DWARF DIE trees from current
toolchains provide sufficient and reliable information for this
correlation approach.

More broadly, symbol correlation across build stages under LTO is a common
problem across several domains, such as target-symbol resolution in
`klp-build` (`.klp.symid` / `sympos`) and profile correlation in
AutoFDO, where this same identity model can also be applied.

Related Work & References
-------------------------

Related work includes my earlier kpatch-build contributions [10-11]
and my reports and fixes in GCC, LLVM, GNU binutils, GDB, LLDB and
AutoFDO, covering DWARF generation, address interpretation and source
attribution [2-9].

[1]  klp-checksum reference target ambiguity report:
     https://lore.kernel.org/live-patching/20260910085218.66565-1-luolongjuna@gmail.com/
[2]  GCC PR126355 (address-bearing DIEs for IPA-ICF wrappers, merged):
     https://gcc.gnu.org/bugzilla/show_bug.cgi?id=126355
[3]  GCC PR126348 (abstract-origin TU provenance across LTO partitions):
     https://gcc.gnu.org/bugzilla/show_bug.cgi?id=126348
[4]  DWARF 6 proposal (separate definition address from linker bindings):
     https://lists.dwarfstd.org/pipermail/dwarf-discuss/2026-September/002859.html
[5]  LLDB #233545 (fix overridden weak function lookup, open PR):
     https://github.com/llvm/llvm-project/pull/233545
[6]  GDB PR34741 (overridden weak definition address resolution):
     https://sourceware.org/bugzilla/show_bug.cgi?id=34741
[7]  LLVM #225358 (fix misleading inline attribution in store merging):
     https://github.com/llvm/llvm-project/pull/225358
[8]  AutoFDO #267 (fix absolute DWARF 5 range handling, merged):
     https://github.com/google/autofdo/pull/267
[9]  GNU AS (fix CU source selection for preprocessed assembly):
     https://sourceware.org/pipermail/binutils/2026-October/152209.html
[10] kpatch #1301 (fix missing .rela section handling, merged):
     https://github.com/dynup/kpatch/pull/1301
[11] kpatch #1303 (strengthen section-change relocation check, merged):
     https://github.com/dynup/kpatch/pull/1303

Longjun Luo (3):
  objtool/klp: Correlate symbols using DWARF identity
  objtool/klp: Include symbol identities in reference checksums
  objtool/klp: Test DWARF identities and reference checksums

 scripts/livepatch/klp-build                   |   5 +-
 tools/objtool/Build                           |   4 +-
 tools/objtool/Makefile                        |  12 +-
 tools/objtool/elf.c                           |  33 +-
 tools/objtool/include/objtool/elf.h           |  34 +-
 tools/objtool/include/objtool/klp-dwarf.h     |  21 +
 tools/objtool/include/objtool/klp-identity.h  |  26 +
 tools/objtool/include/objtool/klp.h           |   2 +
 tools/objtool/klp-checksum.c                  |  25 +-
 tools/objtool/klp-diff.c                      | 563 ++++---------
 tools/objtool/klp-dwarf.c                     | 778 ++++++++++++++++++
 tools/objtool/klp-identity.c                  | 177 ++++
 .../tests/generic/fixtures/identity/common.h  |  15 +
 .../generic/fixtures/identity/consumer.c      |  30 +
 .../tests/generic/fixtures/identity/entries.c |  10 +
 .../generic/fixtures/identity/full_left.c     |  16 +
 .../generic/fixtures/identity/full_right.c    |   6 +
 .../generic/fixtures/identity/move_left.c     |   9 +
 .../generic/fixtures/identity/move_right.c    |   8 +
 .../generic/fixtures/identity/new/same.c      |   6 +
 .../generic/fixtures/identity/new_driver.c    |  15 +
 .../generic/fixtures/identity/new_provider.c  |   4 +
 .../generic/fixtures/identity/old/same.c      |   6 +
 .../fixtures/identity/promotion_bounds_a.c    |  12 +
 .../fixtures/identity/promotion_bounds_b.c    |  12 +
 .../fixtures/identity/promotion_bounds_d.c    |   8 +
 .../generic/fixtures/identity/provider.c      |   9 +
 .../generic/fixtures/identity/readonly.c      |  30 +
 .../tests/generic/fixtures/identity/record.h  |   8 +
 .../tests/generic/fixtures/identity/rx.c      |   4 +
 .../generic/fixtures/identity/source_driver.c |  11 +
 .../generic/fixtures/identity/static_scope.c  |  31 +
 .../fixtures/identity/static_scope_reorder.c  |  31 +
 .../tests/generic/fixtures/identity/tx.c      |   4 +
 .../generic/test-checksum-identity-source.sh  |  24 +
 .../tests/generic/test-checksum-identity.sh   |  31 +
 .../tests/generic/test-identity-full-lto.sh   |  28 +
 .../tests/generic/test-identity-new-tu.sh     |  22 +
 .../generic/test-identity-readonly-address.sh |  23 +
 .../tests/generic/test-identity-source.sh     |  26 +
 .../generic/test-identity-static-scope.sh     |  35 +
 .../test-identity-thinlto-name-drift.sh       |  65 ++
 .../test-identity-thinlto-promotion.sh        |  25 +
 .../tests/generic/test-thinlto-ambiguity.sh   |   2 +-
 .../tests/generic/test-thinlto-local.sh       |   4 +-
 tools/objtool/tests/identity-lib.sh           |  65 ++
 tools/objtool/tests/lib.sh                    |   7 +-
 47 files changed, 1865 insertions(+), 457 deletions(-)
 create mode 100644 tools/objtool/include/objtool/klp-dwarf.h
 create mode 100644 tools/objtool/include/objtool/klp-identity.h
 create mode 100644 tools/objtool/klp-dwarf.c
 create mode 100644 tools/objtool/klp-identity.c
 create mode 100644 tools/objtool/tests/generic/fixtures/identity/common.h
 create mode 100644 tools/objtool/tests/generic/fixtures/identity/consumer.c
 create mode 100644 tools/objtool/tests/generic/fixtures/identity/entries.c
 create mode 100644 tools/objtool/tests/generic/fixtures/identity/full_left.c
 create mode 100644 tools/objtool/tests/generic/fixtures/identity/full_right.c
 create mode 100644 tools/objtool/tests/generic/fixtures/identity/move_left.c
 create mode 100644 tools/objtool/tests/generic/fixtures/identity/move_right.c
 create mode 100644 tools/objtool/tests/generic/fixtures/identity/new/same.c
 create mode 100644 tools/objtool/tests/generic/fixtures/identity/new_driver.c
 create mode 100644 tools/objtool/tests/generic/fixtures/identity/new_provider.c
 create mode 100644 tools/objtool/tests/generic/fixtures/identity/old/same.c
 create mode 100644 tools/objtool/tests/generic/fixtures/identity/promotion_bounds_a.c
 create mode 100644 tools/objtool/tests/generic/fixtures/identity/promotion_bounds_b.c
 create mode 100644 tools/objtool/tests/generic/fixtures/identity/promotion_bounds_d.c
 create mode 100644 tools/objtool/tests/generic/fixtures/identity/provider.c
 create mode 100644 tools/objtool/tests/generic/fixtures/identity/readonly.c
 create mode 100644 tools/objtool/tests/generic/fixtures/identity/record.h
 create mode 100644 tools/objtool/tests/generic/fixtures/identity/rx.c
 create mode 100644 tools/objtool/tests/generic/fixtures/identity/source_driver.c
 create mode 100644 tools/objtool/tests/generic/fixtures/identity/static_scope.c
 create mode 100644 tools/objtool/tests/generic/fixtures/identity/static_scope_reorder.c
 create mode 100644 tools/objtool/tests/generic/fixtures/identity/tx.c
 create mode 100755 tools/objtool/tests/generic/test-checksum-identity-source.sh
 create mode 100755 tools/objtool/tests/generic/test-checksum-identity.sh
 create mode 100755 tools/objtool/tests/generic/test-identity-full-lto.sh
 create mode 100755 tools/objtool/tests/generic/test-identity-new-tu.sh
 create mode 100755 tools/objtool/tests/generic/test-identity-readonly-address.sh
 create mode 100755 tools/objtool/tests/generic/test-identity-source.sh
 create mode 100755 tools/objtool/tests/generic/test-identity-static-scope.sh
 create mode 100755 tools/objtool/tests/generic/test-identity-thinlto-name-drift.sh
 create mode 100755 tools/objtool/tests/generic/test-identity-thinlto-promotion.sh
 create mode 100644 tools/objtool/tests/identity-lib.sh


base-commit: 945537271df1e3680be9b32af7041ac20f1184fb
-- 
2.53.0


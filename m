Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793219081;
	b=hKak8sAF3nhMHqN8Fg645LQeJdDpog7LrNep9NhO4GDbOFPj92xOGeI9VNvwavYOuN/X
	 h6BmzljGGM2Zt9VZzjPHhaLFXrrkZ46kmtvqJm4fgytGttQTJCED2GxWGVY4mPvtLI1d/
	 9CCBXIrXCVI/rsZvNZ0uJr1hanHR8A870VYmFdSdYuTY86pQev16YztFrpjTJfnVuvEQx
	 CBEPF6l8/ooxQOhCofXPtsCeNwQAqBV7tzTOEqtfn0R0uojuY0H61pox3RSbRwkp2Epjn
	 lxBWKHpXenBg7JFfZDfc2n4e+RNLt1fq1oTciP7sX5RPjZNgnLxTmS5Q/TaWWI2Fk/g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793219081;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=u4urUBov1eZqcMpIJ/Tj6M04Gf2envv5H6YtqmBFamY=;
	b=orW3j45p7x2+2L9UyWKpoBkigmbPFT3wSFArCcX3iaWGvaKq2v03iBLVbA1mDepklRhx
	 2ZVJ60JRA7aKSZdGKDxHlpf4C1Eog9fzz92ZKEhARmnFrAjkojwHUT3dCGABquLGb6+nV
	 XU/f+uWatBoX3h5upeL6lE8Vai3igSj51i8WC2pT9XIU5nrjQqt2aejWV6kEwBO/PIa7L
	 IQKsjckwdA1aNWHBzQFx3VoxCVPqVzEYQgFy0JL3QgwDqsbs0Gr8Ikr0c62q2/A4P6KvA
	 EMI3pETcM5HUHFyAZI9Rm/XSaQ6w31ofomsU5nHQI69ihfEO81sBlQyWQ5Skobc4mcg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=blXyuh+P;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CC58606A31A;
	Wed, 28 Oct 2026 20:24:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=blXyuh+P
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 275C91F01825;
	Wed, 28 Oct 2026 20:24:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793219081;
	bh=u4urUBov1eZqcMpIJ/Tj6M04Gf2envv5H6YtqmBFamY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=blXyuh+PjkRhZe7spmbVSmp0qqS35VcKAIWt8bWIp2QDxBfqkJR1r1ULwFxS0VNxK
	 ILV5bJvHE5DvwuqSRTcFE8EMmMqAIn4+tKAXWk7jFgNhMWxx+pAfz3H1I4CM4SwBs8
	 TWQ4dwcjyEj1bJAPnl77zk3e16yPxFLz5ibRc9iAw3t5efn1ihNLs1gu99Wulaw2wC
	 UATuW5deY/8nTJTUV60G30CMFWco6CW3o0O3t13O8FN06LI7PQNVLiYhvGXAuAVRfE
	 R8VX7x1Lp9IPP4+OM7KXUIuRnM+Dis1/qAnxNm2kmd9RubVstdJuIpYvFg3lK9iLKT
	 OxhphYyBle9KQ==
Date: Wed, 28 Oct 2026 13:24:38 -0700
From: Josh Poimboeuf <jpoimboe@kernel.org>
To: Longjun Luo <luolongjuna@gmail.com>
Cc: peterz@infradead.org, mbenes@suse.cz, pmladek@suse.com, 
	joe.lawrence@redhat.com, song@kernel.org, puranjay@kernel.org, nathan@kernel.org, 
	ndesaulniers@google.com, morbo@google.com, justinstitt@google.com, 
	live-patching@vger.kernel.org, llvm@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH 0/3] objtool/klp: DWARF-based cross-build symbol
 correlation
Message-ID: <auJEeLI8tW7eo-p9@jpoimboe>
References: <20261026101916.3823942-1-luolongjuna@gmail.com>
X-Mailing-List: live-patching@vger.kernel.org
List-Id: <live-patching.vger.kernel.org>
List-Post: <mailto:live-patching@vger.kernel.org>
List-Help: <mailto:live-patching+help@vger.kernel.org>
List-Subscribe: <mailto:live-patching+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:live-patching+unsubscribe@vger.kernel.org>
List-Owner: <mailto:live-patching+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20261026101916.3823942-1-luolongjuna@gmail.com>

On Mon, Oct 26, 2026 at 06:19:13PM +0800, Longjun Luo wrote:
> Motivation
> ----------
> 
> I have been working on a general-purpose livepatching mechanism,
> non-intrusive (transparent to build systems) and mainly for C/C++
> userspace programs.
> 
> During this work, I found that LTO optimizations make cross-build
> symbol correlation particularly challenging, as the ELF symbol table
> (`STT_FILE` and symbol names) lacks sufficient context to reliably
> distinguish symbols across builds.
> 
> In traditional per-object diffing (`kpatch-build`), comparing
> individual `.o` files naturally isolates each translation unit. LTO
> crosses these boundaries and can change symbol binding through
> promotion or internalization. This series continues object-level
> diffing by using the DWARF DIE tree to disambiguate symbols.
> 
> To support LTO on `vmlinux.o`, `klp-build` precomputes per-symbol
> checksums in `klp-checksum` and then correlates symbols in `klp-diff`
> through a multi-stage heuristic pipeline:
>   1. Lockstep pairing of all `STT_FILE` symbols across both objects.
>   2. An iterative loop alternating between a 4-level filtering funnel
>      in `find_twin()` (demangled name -> `is_tu_local_sym()` ->
>      `same_file()` -> size/checksum) and `.llvm.<hash>` suffix
>      propagation via `suffix_map` and `find_twin_suffixed()`.
>   3. A last-resort relative-position match among remaining same-named
>      candidates in `find_twin_positional()`.
> 
> This approach is effective for most kernel patches and matches all
> comparable twins in my baseline `vmlinux.o` audits (see Evaluation).
> In some scenarios, however, LTO optimizations can still break its
> assumptions, leading to missed correlations or silently pairing
> unrelated symbols.
> 
> This RFC proposes a DWARF-derived `(source, scope, name)` identity to
> complete the symbol representation layer in `klp-build`, strengthening
> symbol correlation and laying a foundation for subsequent stages.
> 
> The series contains three patches:
>   1/3: Symbol identity and correlation.
>   2/3: Reference checksums using symbol identity.
>   3/3: Regression tests.

Thanks!  This is a very interesting approach.

> Limitations of ELF-only Correlation
> -----------------------------------
> 
> The following minimized reproducers illustrate correlation failures
> I found while analyzing kernel builds and common kernel patterns.
> 
> 1. Missing lexical scope (`scope` is needed) [GCC, non-LTO]
> 
>    In `fs/jfs/inode.c`, `jfs_commit_inode()` and `jfs_dirty_inode()`
>    each define `static int noisy = 5` to limit error messages.
> 
>    A small error-reporting patch adds the inode number to the existing
>    `jfs_commit_inode()` diagnostic, and limits repeated writeback errors:
> 
>      int jfs_commit_inode(struct inode *inode, int wait)
>      {
>          static int noisy = 5;
>          ...
>     -    jfs_err("jfs_commit_inode(0x%p) called on read-only volume",
>     -            inode);
>     +    jfs_err("jfs_commit_inode(0x%p), ino=%llu on read-only volume",
>     +            inode, inode->i_ino);
>          ...
>      }
> 
>      int jfs_write_inode(struct inode *inode, struct writeback_control *wbc)
>      {
>     +    static atomic_t noisy = ATOMIC_INIT(5);
>          ...
>          if (jfs_commit_inode(inode, wait)) {
>     -        jfs_err("jfs_write_inode: jfs_commit_inode failed!");
>     +        if (atomic_dec_if_positive(&noisy) >= 0)
>     +            jfs_err("jfs_write_inode: commit failed for inode %llu",
>     +                    inode->i_ino);
>              return -EIO;
>          }
>          ...
>      }
> 
>    Building the real `fs/jfs/inode.o` with GCC 16.2.1 and
>    `CONFIG_JFS_DEBUG=y` gives:
> 
>      Owning function       Original name  Patched name
>      --------------------  -------------  ------------
>      jfs_commit_inode      noisy.1        noisy.2
>      jfs_dirty_inode       noisy.0        noisy.0
>      jfs_write_inode       absent         noisy.1
> 
>    Expected:    preserve the existing counters; allocate only the new
>                 `jfs_write_inode()` counter.
> 
>    Actual:      Two `no correlation` warnings, but the livepatch builds
>                 and loads successfully. The replaced `jfs_commit_inode()`
>                 references a fresh `noisy.2` and emits the diagnostic
>                 five more times after the original warning budget is
>                 exhausted.
> 
>    This series: preserves the original counter through its function
>                 scope; no further diagnostics are emitted after applying
>                 the livepatch.
> 
>    Cause:       Under GCC, all three 4-byte objects (initialized to 5)
>                 strip to `demangled_name = "noisy"` under the same
>                 `STT_FILE` without function scope; when the candidate
>                 count changes from two to three, positional matching
>                 gives up. The same naming pattern also occurs with the
>                 two function-local `DEFINE_MUTEX(mutex)` instances in
>                 `kernel/sched/rt.c`.

This case could be improved by distinguishing static local variables by
the function which references them (no DWARF needed).

BTW, we might want to consider upgrading "no correlation" to an error
unless the patch author explicitly adds some kind of annotation which
says a given missing correlation is expected.  Ideally they should be
rare unless a patch is removing or renaming symbols.

> 2. ThinLTO promotion shift swaps cross-TU state (`source` is needed)
>    [Clang/LLD 23.1.0 ThinLTO]
> 
>    With the kernel's default ThinLTO flags
>    (`-always-rename-promoted-locals=false` and `-import-instr-limit=5`)
>    and unchanged link inputs and order:
> 
>    Before (orig):
>      /* a.c */ static volatile int state[4];
>                int a_get(unsigned int i) { return state[i]; }
>      /* b.c */ int target(unsigned int i) { return a_get(i) + d_get(i); }
>      /* d.c */ static volatile int state[4];
>                int d_get(unsigned int i) { return state[i]; }
>      /* Both a_get() and d_get() are imported into b.c:
>       *   a.c state -> STB_GLOBAL: "state"
>       *   d.c state -> STB_GLOBAL: "state.llvm.<H>" */
> 
>    After (patched, adding a bounds check to `a_get()`):
>      /* a.c */ static volatile int state[4];
>                int a_get(unsigned int i) {
>     +              if (i >= 4) return 0;
>                    return state[i];
>                }
>      /* a_get() is no longer imported; d.c's state claims "state":
>       *   a.c state -> STB_LOCAL:  "state"
>       *   d.c state -> STB_GLOBAL: "state" */
> 
>    Expected:    patched `a_get()` continues referencing `a.c`'s `state`.
> 
>    Actual:      `klp-diff` exits 0 with no warning and swaps the two
>                 state identities: with `a.c:state[0] = 64` and
>                 `d.c:state[0] = 32`, `a_get(0)` returns 32 instead of 64,
>                 and the inlined `d_get()` in untouched `b.c` binds to
>                 `a.c`'s array.
> 
>    This series: `a_get(0)` returns the expected 64.
> 
>    Cause:       Under `-always-rename-promoted-locals=false`, ThinLTO
>                 keeps the unsuffixed `STB_GLOBAL` name for the first
>                 promoted static of each name in link order and gives
>                 the others `.llvm.<H>` suffixes. When import decisions
>                 shift, the unsuffixed name moves to another TU's
>                 symbol, and `is_tu_local_sym()` treats both as
>                 non-TU-local.
> 
>    In a real ThinLTO kernel build, this same shift moves the unsuffixed
>    `m_start/m_next/m_stop/m_show` `seq_operations` callbacks from
>    `fs/namespace.c` to `kernel/module/procfs.c` when a 30-line patch under
>    `kernel/module/` reuses the `procfs.c` iterator. `klp-diff` marks all
>    eight callbacks as changed (including four in untouched
>    `fs/namespace.c`) and exits successfully without warnings. Loading
>    the generated module fails on duplicate `m_start,1` sysfs registration.
>    This series includes only the intended changes
>    (`read_file_mod_stats()` and `modules_seq_ops()`) and loads and rolls
>    back cleanly.

Hm, this issue is caused by -always-rename-promoted-locals=false.  We
should probably revert that flag, at least until if/when this series
gets merged.

> 3. Loss of `STT_FILE` boundaries [Clang Full LTO]
> 
>    Before (orig):
>      /* left.c  */ static volatile int state;
>                    int left_fn(void) { return ++state; }
>      /* right.c */ static volatile int state;
>                    __attribute__((noinline)) static int helper(void) {
>                        return ++state;
>                    }
>                    int right_fn(void) { return helper(); }
>      /* Full LTO ELF: STT_FILE is "ld-temp.o", 1 local "helper" */
> 
>    After (patched):
>      /* left.c extracts ++state into a same-named noinline helper(): */
>      /* left.c  */ static volatile int state;
>     +              __attribute__((noinline)) static int helper(void) {
>     +                  return ++state;
>     +              }
>     +              int left_fn(void) { return helper(); }
>      /* right.c is unchanged */
>      /* Full LTO ELF: STT_FILE is "ld-temp.o", 2 local "helper" symbols
>       *               with identical size and checksum */
> 
>    Expected:    `right.c:helper` correlates with orig;
>                 `left.c:helper` is new.
> 
>    Actual:      Warns `no correlation: helper`; unchanged `right.c:helper`
>                 loses correlation and both helpers are cloned as new
>                 functions.
> 
>    This series: correlates `right.c:helper` with orig and avoids copying
>                 the unchanged helper (both livepatches preserve the
>                 counters at runtime).
> 
>    Cause:       Full LTO merges all IR modules before codegen, collapsing
>                 `STT_FILE` into a single `ld-temp.o` without per-TU
>                 `.llvm.<hash>` suffixes, so ELF symbols lose their
>                 defining TU boundaries.

Right, so full LTO collapses all the STT_FILE symbols into one.  Is
anybody actually using full LTO?  We could make klp-build reject it.

> Proposed Design: (source, scope, name) Identity
> -----------------------------------------------
> 
> DWARF entries are matched to ELF symbols directly by relocated
> `(section, offset)` address. From an in-memory perspective, each ELF
> symbol is identified by `(source, scope, name)`:
> 
>   - `source`: The physical translation unit (CU) that emits the instance
>     into memory (for `DW_AT_external` symbols, as opposed to unstable
>     ELF `st_bind`, `source` is set to `""`; `STT_FILE` is used only as
>     a fallback when DWARF is unavailable).
>   - `scope`: The slash-delimited chain of named enclosing scopes recorded
>     by DWARF for the in-memory instance (e.g., `"/"` or `"/func/"`).
>   - `name`:
>       a. `demangled_name`: objtool's normalized name with compiler
>          suffixes stripped.
>       b. `symbol name`: the raw symbol name from the ELF symbol table.
> 
> Symbol correlation proceeds in two steps (see Patch 1 for details):
> 
>   1. Group symbols into `(source, scope, demangled_name)` hash buckets
>      and apply centralized ELF suffix compatibility rules within each
>      bucket.
>   2. Accept only unique, deterministic twins within the bucket (first by
>      compatible name, then using size and checksum for remaining
>      unchanged candidates), verified bidirectionally (`orig <-> patched`)
>      without positional fallback.
> 
> This series requires libdw, adds `-g` to the klp-build compilation, and
> currently rejects split DWARF.

It may be simpler and cleaner to just have klp-build depend on
CONFIG_DEBUG_INFO.  Assuming all or most livepatch users have that
enabled already?  Would need to support split/reduced as well.

> Example (`source` and `scope` reflect post-optimization DWARF):
> 
>   /* include/header.h */
>   static inline int record(int x) {
>       if (x > 0) {
>           static int state;
>           return ++state;
>       }
>       return 0;
>   }
> 
>   /* net/a.c */
>   int tx(int x) { return record(x); }
> 
> From a static source-text view, `state` is written in `include/header.h`
> inside an `if` lexical block, and `record()` is inlined into `tx()`.
> From the in-memory DWARF perspective:
>   - `source` is `"net/a.c"` (the physical CU that allocates `state` in
>     memory, not `"include/header.h"`).
>   - `scope` is `"/record/"`: the scope construction follows the owning
>     subprogram and skips unnamed lexical blocks. Inlining into `tx()`
>     does not change the variable's owning scope.
> 
> Symbol Correlation Evaluation
> -----------------------------
> 
> This series accepts unique, bidirectional 1:1 matches without
> positional guessing. In a cross-audit of x86-64 `vmlinux.o` builds,
> I compared klp-build's twins with those independently derived using
> my standalone DWARF-based symbol identity tool. The results agree on
> all comparable twin pairs:
> 
>   Build pair                         Comparable pairs  Discrepancies
>   ---------------------------------  ----------------  -------------
>   Clang ThinLTO: getpid                        91,300              0
>   Clang ThinLTO: ACPICA                        91,300              0
>   Clang Full LTO: version_show                 91,171              0
>   GCC non-LTO: version_show                    95,337              0
> 
> The builds use DWARF 5: ThinLTO uses Clang/LLD 22.1.8
> on Linux 7.3-rc7 `24a19b953e2a`; GCC 16.2.1 / GNU ld 2.46.1 and
> Clang/LLD 22.1.8 Full LTO use mainline `4403278e4ea2`.
> 
> Within this set, the twins retained by this series agree with those
> derived from my tool. In the ThinLTO builds, this series leaves 363
> data symbols per side uncorrelated that klp-build pairs heuristically:
> 
>   DWARF information                      Count  Follow-up
>   -------------------------------------  -----  -------------------------
>   Available (pieces/value expressions)      89  Extend reader support.
>   Incomplete (anonymous lexical scopes)    154  Detect ambiguity and
>                                                 reject.
>   Absent (C compound literals)             120  Compare references from
>                                                 changed functions; reuse
>                                                 unchanged objects.
> 
> These symbols are reported as `no correlation` instead of being paired
> by guesswork. Until the follow-ups land, changed functions that
> reference them still get cloned copies, as in Case 1 with the existing
> `klp-build`. I have tested follow-up patches for the table above and
> will post them separately.

Well for example, static locals defined in macros are very common (e.g.,
__msg, DO_ONCE, __print_once).  With this series and my "one line" patch
which adds a line to every .c file, I'm seeing thousands of "no
correlation" warnings with both GCC and Clang.  For example:

  drivers/gpu/drm/radeon/radeon.o: warning: objtool: no correlation: r100_reloc_pitch_offset.__print_once
  drivers/gpu/drm/radeon/radeon.o: warning: objtool: no correlation: r100_reloc_pitch_offset.__print_once.26
  ...

I don't think "deject ambiguity and reject" would work here.

> The upstream and added tests report 51 pass / 3 fail / 7 skip with GCC
> and 57 pass / 3 fail / 1 skip with Clang (the three failures are policy
> rejections of linkage flips and duplicate-TU compilations), and the
> kernel cases above were verified in QEMU (apply, behavior, and rollback).
> 
> The `(source, scope, name)` tuple also strengthens `klp-checksum`'s
> representation layer. Compressing references into a `demangled_name`
> digest loses resolution and misses switches between same-named targets
> of different origin or linkage [1]. Hashing `source/scope/demangled_name`
> (Patch 2) resolves this while keeping compiler suffix changes
> transparent, confirmed by runtime tests across two GCC cases and one
> ThinLTO case.
> 
> For `klp checksum --dry-run` on `vmlinux.o`, the time and peak RSS go
> from 4.546 s / 3984.8 MiB to 13.752 s / 5825.3 MiB with this series,
> or 10.823 s / 4870.0 MiB with the optimized reader.
> 
> Compared with the comparison approach used in my userspace
> implementation, `klp-checksum`'s single-object digest is faster and
> simpler; adding the tuple preserves these advantages while recovering
> target-identity precision.
> 
> On the pre-checksummed ThinLTO `vmlinux.o` pair (~1.081 GiB per input,
> 353.8 MiB `.debug_info`), `objtool klp diff` medians from three warm runs
> on an Intel Core i7-11850H (30.6 GiB RAM, libdw 0.196) are:
> 
>   Version                      Elapsed time  CPU time    Peak RSS
>   ---------------------------  ------------  --------  ----------
>   klp-build baseline                3.816 s   3.814 s  3566.3 MiB
>   This series                      22.404 s  22.399 s  5470.3 MiB
>   Optimized (single-threaded)      16.441 s  16.437 s  3714.0 MiB
> 
> This series prioritizes readability and correctness. The single-threaded
> optimized prototype produces the same twin tables and patch outputs as
> this series. It takes 16.441 s and adds 147.7 MiB (+4.1%) of peak memory
> over the baseline. These optimizations will be submitted separately.

The performance impact is concerning (but not a deal breaker I suppose).

> DWARF Reliability & Scenarios
> -----------------------------
> 
> Correlation uses CU paths, named scopes, `DW_AT_external` and fixed
> addresses from the DWARF DIE tree. It does not require CFI, line tables
> or dynamic location lists. This reduces dependence on compiler-specific
> flags and version-dependent naming behavior (as seen in Case 2 between
> LLVM 22.1.8 and LLVM 23.1.0).
> 
> In my userspace livepatching implementation, I evaluated the identity
> model across 17 security-fix cases in 15 C/C++ projects:
> 
>   - Databases & Caches:   Redis, PostgreSQL, MariaDB
>   - Web & Network:        Nginx, Squid, BIND, OpenSSH, Samba, Netatalk
>   - System & Libraries:   glibc, OpenSSL, QEMU, GStreamer, Poppler, libjxl
>   - Build Configurations: DWARF 4/5;
>                           GCC (non-LTO, single/multi-partition LTO);
>                           Clang/LLD (non-LTO, Full LTO, ThinLTO)
>   - Distributions: Debian 13, Fedora 44, openEuler 24.03 LTS SP3,
>                    openSUSE Leap 16.0, RHEL UBI 10.2, Ubuntu 24.04
>   - Toolchains: GCC 12-16 and Clang 17-22
> 
> For Nginx CVE-2026-27654, all 30 configurations across six distributions
> and five compiler/LTO modes completed patch application, behavior
> verification and rollback. The Redis and OpenSSH cases also completed
> application and rollback tests across all six distributions.
> 
> Strict cross-verification during this work also led to several upstream
> toolchain bug reports, fixes and a DWARF proposal [2-9]. All of these
> corner cases are either fixed upstream or mitigated in my standalone
> tool and this series, confirming that DWARF DIE trees from current
> toolchains provide sufficient and reliable information for this
> correlation approach.
> 
> More broadly, symbol correlation across build stages under LTO is a common
> problem across several domains, such as target-symbol resolution in
> `klp-build` (`.klp.symid` / `sympos`) and profile correlation in
> AutoFDO, where this same identity model can also be applied.

The number of toolchain bugs is concerning (but not surprising).

-- 
Josh

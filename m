Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.210.177
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793799143;
	b=J4JXd1pFCxBh5LYa93OhzvOt26NO25e5FtWVmGPH4p136J6RDyth7D5eWZZm9gxam7Oq
	 3Hs7601OhPwZ4E4KUOyzwN/OgND7XC7FOIdwKlDMDSVHvwfxzzsxdHSxPC1tbB61Cxe9+
	 cFYkg/tpcDfoR4JYGCgpbxQpZOgeM5ofTW5lXjj7rov/RVnshe+OGAdZ18CbZEqh3cPvo
	 NuvTN1HdKVf/YxV+KZGd6WHgN+jaDzk1s0u/LrejPBqmgG39h4pJI2Ug1cUHhkCQ6Yowg
	 iSHg1KJjqRGjXOO5FOAdZoTtWsNtjKi9+M0MytvWHJfV2d5346SuldFA7b3yyVYEpbA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793799143;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=eHz0bSTTIqHFQqM0rnZCLvD3lIt8RuNG8fTVt2242Zo=;
	b=a5KzXTaNnlYBn8Iq7smhy802w0ju5fLawxV1tvCeyqRj/4GHimYz6Yn8xm/6PBMFbhQS
	 mIcq/gw3rL3Kt1y02vvLVJROoed7yGYW/eZbrFomufDeXvUJTAfPl2F3Q1Box7Y4rqU/S
	 rk05ibsgJRiFIQhlBW//Bh/h5YaB/Hz2uxTlsGgGNgLDs5LTpbnCJw8m2zt72T5YfpGws
	 G1606/7Z4tgSYnIJ8uoAs56H86aVQbkZ+AEDLygPXWSBeFO0XQdDrzgg4YLw4IZGBhnD9
	 gEdwW5OmvyuNjfBhWERvFEhB4LAkHA7PN87sCWcpo3P86AmLOObKWrzTmQHCEjGsslg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=AkC0Lhj4;
	arc=none smtp.remote-ip=209.85.210.177
Received: from mail-pf1-f177.google.com (mail-pf1-f177.google.com [209.85.210.177])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C35CE606A326
	for <live-patching@vger.kernel.org>; Wed,  4 Nov 2026 13:32:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C35CE606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=AkC0Lhj4
Received: by mail-pf1-f177.google.com with SMTP id d2e1a72fcca58-8a06b44bd01so513249b3a.0
        for <live-patching@vger.kernel.org>; Wed, 04 Nov 2026 05:32:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793799133; x=1794403933; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=eHz0bSTTIqHFQqM0rnZCLvD3lIt8RuNG8fTVt2242Zo=;
        b=AkC0Lhj4TklLNlHdJSJPBwoeYPygzDJVhwqwjrf4hs4EE4UGBR2QLgCkUaVd/Jmi6u
         N4xKttG+LKkHYTqQKpNq3y1zkl/0eFyCQKvd3nGNSQey6RJCJMtQcruRVkBrliYUxcyo
         9NnsZiiYxiP6cRpDmGGD0b7yVMV+22ULhinK9EGN+dyrpEra+t7tU1v4yEL8CxHuq4Sr
         STz9FX2ILTZlL3rtplQBKnLXKbWebhbQMxbDJlIyH/LrQH8wiivlyePV9Sy4KHRlTHq8
         YNZLPIrh+h8djvw7CgmipF2RNbcQ7WyScWITy6kQHqLixETNdDYHgfXTBDDtjYZnH0Od
         aVdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793799133; x=1794403933;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=eHz0bSTTIqHFQqM0rnZCLvD3lIt8RuNG8fTVt2242Zo=;
        b=PJb77m7uREVBNUtpDDojN8umMU5SvSPIFPqDZK8X6XsWRL011sWAfykZb8WwSx7V8z
         SAEYJesaXdizMif3VYZiHZ4nzydG6292qr6Kd/YCAiB9YYsVAywaF99hV+CDtyrqrHHK
         ZWooPouavvBw8n6uAvW/aA1DbQHxgV2+STaKHMC9xmm5y9QWTgVIqzxRTQ3K2lldThay
         lRkLgu0BxJy6ED9Z1Sk+iKg1g4OcRMhD9HlKJdCY+EewaGfbKjMpEayqasb90B8fCRFP
         WSGCuupVrdrqo9ApC0tz3kQSVTiLfjWnwpZPQOADBZDykbEtamqoA+vfpF6DMlQm81o9
         zDvQ==
X-Forwarded-Encrypted: i=1; AKwUvBz8Z/KHMUHkzfIp5HDTfaDgtMkvFuK4rgp9iIVBwM49CPmQPjit/AB3JDPA4Zs45b7evkMAzRGwURsjtzQY@vger.kernel.org
X-Gm-Message-State: APuU4Z+pE+4uGGjwGOr24ClXubPs4Hlk7F41xmjdg5HM069NeEni5Tnf
	44tflC3N+4qmc5/JOu4X9pEk8inxvelIjlKK2WaHH1GY6LFci34Q5Qty
X-Gm-Gg: AYBFou0fRk0jGKNV/cSXrGEVzl5fYnnDmNeAeo5jflRaFAzL3N24u3ajqJyim1GPqKA
	azcIebKffI7sJPehgM4ZT+iSDkaxwLHq/bywgZ8klWXcdoKsBEIJ+J5F1dQmPwD4LXKW2Ks+hgh
	cxNqnyWOB5wIHaShQCnlapkw+Nk/udlcANZfc3VP5OyC+DICEPCaI32BObk+jHY7sIZet0FQGfN
	9gKl6eErvDeKAC4UWGxsispx98y/Fhf3xlVbBsC8KTjgdOp1AWVOvBt1bTxBwQmzI3FDYJ85d1N
	Q4X53rPlHwVPNOqaxWvKF/WaMO7YHbVcrhb4TU1kANcDMt5otNlThctO2DVGQLImFFrxEodvk75
	KRXZIcbOKL+kNTvod1yJzoLglwx/jFBqQBn1v72z5qlQafeWyXpOWCVhrB35op1ouV9WzNiSVJT
	3v0VxHHCkXzWoOrvZFPhDtFBo6TKnIa3b9dTdJokQWW3LNqp6OxemBW2vzVqpHibqjxIxvU9QOT
	Z6hO3j976YqK01AIqB92Ze1MwrCVvkY1xbj80GQWFTNteRzG/bftJpvP3vvhAOjcUwLoir3IreQ
	tnJEOgFurxVtVGs9zSbxl9byzD6ApJOTMYvEeEJW/lSQ8y3+Rw==
X-Received: by 2002:a05:6a00:1389:b0:881:8b53:f66 with SMTP id d2e1a72fcca58-8a9bc34c20fmr14041841b3a.24.1793799132120;
        Wed, 04 Nov 2026 05:32:12 -0800 (PST)
Received: from anatasluo-Precision-5560 ([139.226.166.21])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-8b09a7ce84fsm911369b3a.13.2026.11.04.05.32.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Nov 2026 05:32:11 -0800 (PST)
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
Subject: [RFC PATCH v2 00/11] objtool/klp: DWARF-based cross-build symbol correlation
Date: Wed,  4 Nov 2026 21:31:46 +0800
Message-ID: <20261104133158.3187525-1-luolongjuna@gmail.com>
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

v1 [1] introduced a DWARF-based symbol identity as the representation
layer for cross-build symbol correlation. Building on that representation,
v2 shows how `klp-build`'s existing single-object checksums and reference
context are used to extend symbol-twin matching in stages, and how the
resulting twins and remaining unmatched symbols are audited and
classified.

Existing ELF-only correlation can produce incorrect patches in three
cases: connecting patched code to a different same-named symbol (incorrect
twins), duplicating existing static state as a new variable (copied static
state), and missing changes in referenced targets (missed reference
changes). Across the regression suite, the baseline fails 13 tests on
both GCC and Clang. In 6 cases per compiler, it miscorrelates symbols or
misses changes without diagnosing the incorrect result. v2 passes all
13 of those tests on each compiler.

This is a design-review RFC, not a merge-ready series. The identity
representation and twin algorithm are presented together for review;
the proposed integration path is discussed in "Open Questions and Next
Steps". v2 reports an error on ambiguous data references in patched code;
Case D describes the state-inheritance boundary and proposed annotations.

The series contains 11 patches:

- Patches 1-3: Standalone fixes independent of DWARF (wide-string
  truncation, compound-literal content checksums, and preserving trailing
  digits in identifiers), which can be prepared as a separate fix series.
- Patches 4-6: DWARF identity reader, reduced/split DWARF support, and
  the `CONFIG_DEBUG_INFO` build check, without switching the correlation
  algorithm yet.
- Patches 7-10: Correlating by identity triple and checksum (Patch 7),
  including identities in reference checksums (Patch 8), extending twins
  through references from unchanged functions (Patch 9), and checking
  unmatched data references (Patch 10).
- Patch 11: Regression test suite covering symbol identities, LTO, DWARF
  variants, and state preservation.

Responses to v1 Review (Guide)
------------------------------

Thanks to Josh for reviewing v1. v2 responds as follows:

1. `CONFIG_DEBUG_INFO` and split/reduced DWARF: as suggested, `klp-build`
   now requires `CONFIG_DEBUG_INFO` and uses Kbuild's debug flags
   (Patch 6). Reduced and split DWARF are supported (Patch 5). See
   "Compatibility Limits and Build Requirements".

2. Repeated macro statics and the one-line test: building on the
   referencing-function idea, unchanged-function references resolve
   repeated statics (Patch 9). The tree-wide test reduces v1's
   `no correlation` warnings from 682/764 to zero (GCC/Clang). See
   "Evaluation and Performance Overhead".

3. Upgrading `no correlation` to an error and explicit annotations:
   following this direction, v2 rejects ambiguous data references and
   allows verified new data (Patch 10). See Case D for the
   state-inheritance boundary, its kernel-wide impact, and proposed
   annotations.

4. Referencing functions, ThinLTO naming flags, and Full LTO: in ELF, the
   referencing function only approximates the defining scope, and
   `STT_FILE` and `.llvm.<hash>` suffixes only approximate the defining
   TU. Definition identity distinguishes inlined helpers' state and
   survives LTO renaming and `STT_FILE` merging; see Cases A-B.

5. Toolchain reliability and performance: v2 cross-checks DWARF against
   ELF and measures checksum/diff costs, including a separate memory
   prototype. See "Design Overview", "Evaluation and Performance
   Overhead", and "Open Questions and Next Steps".

Design Overview: Staged Matching and Verification of Symbol Twins
-----------------------------------------------------------------

Background and Motivation
~~~~~~~~~~~~~~~~~~~~~~~~~

This design grew out of shared challenges in kernel and userspace
livepatching. In production kernel livepatching, patches are commonly
managed cumulatively to avoid hook conflicts across patches; over a
maintenance cycle, a single cumulative patch can accumulate changes from
dozens of fixes. Under LTO, these stacked edits can shift global inlining,
cross-TU promotion, and function-cloning decisions, perturbing the symbol
table far beyond the edited functions and breaking heuristic correlation.
Meanwhile, complex C++ scopes and optimizations in userspace livepatching
similarly require a strict separation between definition ownership and the
actual referencer (v1 summarized my evaluation across 17 security-fix
cases in 15 C/C++ projects and 6 distributions [1]).

This motivated a correlation mechanism grounded in definition ownership
and reference context. In adapting it to the kernel, v2 directly reuses
`klp-build`'s existing single-object checksum pipeline to summarize
context, incorporating referenced target identities and compound-literal
contents into the digest.

Supplementing and Cross-Checking ELF with DWARF
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

This design takes ELF as the ground truth for emitted code and storage,
using DWARF to supplement and cross-check ELF information: ELF provides
the emitted symbols, sizes, bindings, and relocations, while DWARF
supplies the defining TU (`source`) and lexical scope (`scope`). Starting
from each ELF symbol, the reader looks up the DWARF definition and
verifies agreement on symbol names, storage coverage, and `STT_FILE`
versus CU paths; conflicts are reported, while missing information is
routed to controlled fallback and reference checks. These cross-checks
helped identify both upstream toolchain DWARF issues [2-6] and existing
ELF/checksum corner cases (Patches 1-3 and the `FIXME`s in
Patches 1 and 4).

The reader explicitly handles known DWARF issues affecting kernel
builds, so those cases require no compiler changes or backports.

Because the `(source, scope, name)` triple follows directly from standard
DWARF semantics, it also provides a clean target for upstream compiler
DWARF tests. Correlation can then rely on the triple and stable
optimization representations (such as address pieces and shrunk storage)
rather than compiler-specific suffix conventions. This can make livepatch
generation substantially less sensitive to changes in compiler naming and
optimization decisions.

Symbol Classification by DWARF Attribution
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

Ideally, the `(source, scope, name)` triple alone would uniquely pair
symbols across builds in both directions; in practice, the distinguishing
power provided by DWARF varies. Before describing the twin algorithm,
admitted symbols fall into three categories:

- Complete identity: Named functions and static variables whose triple is
  unique within their minimal `(source, scope)`. The vast majority of
  symbols fall into this category and match directly, serving as the
  trustworthy foundation for subsequent context-based propagation.
- Non-unique identity: Repeated `static`s within the same named scope, or
  multiple storage pieces split from a single definition by optimization,
  can share a triple and require checksum and reference context to
  disambiguate. Anonymous-block representation choices and
  state-inheritance boundaries are covered in Case D.
- Absent identity: Symbols with no definition attribution in DWARF,
  primarily C compound literals with static storage duration
  (`.compoundliteral.N` / `__compound_literal.N`) and a small number of
  top-level assembly or special-mechanism symbols.

Four-Stage Twin Construction and Unmatched Reference Checks
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

Based on this classification, symbol twins are built and verified in four
successive stages (Stages 1-4):

- Stage 1 (Unique identity match): Within the same identity bucket, pair
  the unique compatible candidate in both directions.

- Stage 2 (Intra-identity checksum disambiguation): Among remaining
  candidates in the same identity bucket, use symbol length and checksum
  to pair the unique unchanged candidate in both directions.

- Stage 3 (Reference extension and verification via unchanged functions):
  For paired functions with equal checksums, compare relocation layouts in
  order and extend twins to compatible referenced targets. Existing twins
  must agree with these references; any conflict aborts patch generation.
  This cross-checks Stages 1 and 2, catching switches between instances of
  the same identity that leave the function checksum unchanged.

- Stage 4 (Controlled ELF `FILE`/name fallback): For remaining unpaired
  symbols, pair only when `FILE`/name is unique in both directions and raw
  symbol names, bindings, and DWARF availability agree on both sides;
  fallbacks outside the known whitelist emit a warning.

Data aliases reuse their representative symbol's twin. After the four
stages complete and changed functions are identified, the tool checks
unmatched data references when constructing the patch (Patch 10) to
separate verified new data from ambiguous references that must be
rejected. The acceptance rules for ordinary static data and compound
objects are detailed in Case D.

Problem Classes and Handling Boundaries
---------------------------------------

Cases A-C illustrate incorrect twins, existing state treated as new, and
missed reference changes. Case D discusses the handling boundary for state
inheritance and why references beyond current disambiguation evidence must
be rejected.

Case A. Incorrect twins: same name, different owner
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

Case 2 in v1 [1] showed a real kernel example (Clang/LLD 23.1.0, ThinLTO):
a patch adds `modules_seq_ops()` and uses it in `read_file_mod_stats()`.
Cross-TU import decisions shift, moving the unsuffixed names of
`m_start`/`m_next`/`m_stop`/`m_show` between `fs/namespace.c` and
`kernel/module/procfs.c`. The baseline silently pairs the two iterator
sets against each other and reports 8 extra changed functions (4 in
untouched `fs/namespace.c`), producing a module that fails to load on a
duplicate `m_start,1` registration; v2 reports only
`read_file_mod_stats()` as changed and `modules_seq_ops()` as new.

v2 adds a test covering simultaneous edits in two TUs (Clang/LLD
23.0.0git, ThinLTO). `a.c` and `d.c` each define
`static volatile int state[4]`, and `target()` in `b.c` calls both
accessors; the patch adds a bounds check and an index mask:

    /* a.c */
    int a_get(unsigned int index)
    {
+       if (index >= 4)
+           return 0;
        return state[index];
    }

    /* d.c */
    int d_get(unsigned int index)
    {
-       return state[index];
+       return state[index & 3];
    }

Both accessors should keep using their respective old arrays. However, the
bounds check stops `a_get()` from being imported into `b.c`, turning its
array from a promoted global back into a local; under the kernel's
`-always-rename-promoted-locals=false`, the plain global name `state`
previously held by `a.c` moves to `d.c`. The baseline wires patched
`a_get()` to `d.c`'s old array and the inlined `d_get()` in `target()` to
`a.c`'s old array.

To test the effect of reverting that flag directly, I compared keeping and
restoring suffixes on the same LLVM 23 toolchain, source, and
`import-instr-limit=5`. The table varies
`-always-rename-promoted-locals`; modifying only `a.c` gives the same
result as modifying both TUs:

  Flag value                Baseline result             v2 result
  ------------------------  --------------------------  --------------------
  false (kernel default)    No warning; swaps arrays    Uses each TU's array
  true                      2 warnings; new arrays      Uses each TU's array

Although reverting the flag prevents the plain-name shift, the baseline's
`suffix_map` relies on another already-paired promoted symbol in the same
TU to map old and new `.llvm.<hash>` suffixes. Here, `a.c`'s array is
local and unsuffixed again while `d.c`'s hash changes with the edit, so
the baseline still loses correlation and reallocates both states
(Clang/LLD 22.1.8 behaves the same way under its default suffix naming;
see `test-identity-thinlto-name-drift.sh`). Toggling the compiler naming
flag cannot replace defining-TU attribution, and it also shows why DWARF
cannot be consulted only on name collisions: under plain-name drift, the
miscorrelated name is already unique.

Miscorrelation is not limited to LTO. In `test-identity-static-replace.sh`
(GCC, non-LTO), a patch removes `retired()` and adds `added()`. Each
function has a local `static volatile long count`, as does `unchanged()`:

-   long retired(long value)
-   {
-       static volatile long count;
-       return count += value;
-   }
-
    long unchanged(long value)
    {
        static volatile long count;
        return count += value;
    }
+
+   long added(long value)
+   {
+       static volatile long count;
+       return count += value;
+   }

GCC emits two `count.N` symbols before and after the patch. The baseline
warns about the removed function but pairs `added()`'s new counter with
`unchanged()`'s live counter by symbol-table position. In v2, the new
counter's scope `/added/` has no original candidate, so it gets new
storage.

Case B. Existing state treated as new: referencing function != defining scope
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

Case 1 in v1 [1] showed JFS's same-named `noisy` counters (GCC 16.2.1,
non-LTO): adding a counter renumbers existing instances, causing the
baseline to copy old state into the patch and reviving an exhausted
5-message warning budget; v2 reuses the original storage via function
scope (`test-identity-static-scope.sh`). An inlined-initializer test in v2
further separates "who references it" from "who defines it".

In `test-identity-inline-helpers.sh`, two `always_inline` helpers each
define a block-local `static volatile int done` via `ONCE_INIT` to guard
one-time seed initialization:

    static inline __attribute__((always_inline)) long initialize_rx(long value)
    {
        ONCE_INIT(rx_seed, 1);
        return value ^ rx_seed;
    }

    static inline __attribute__((always_inline)) long initialize_tx(long value)
    {
        ONCE_INIT(tx_seed, 2);
        return value ^ tx_seed;
    }

Originally `target()` only calls RX; the patch adds TX before it, with no
other unchanged caller available to recover old state:

    long target(long value)
    {
+       value = initialize_tx(value);
        return initialize_rx(value);
    }

Only TX should get a new `done` flag while RX keeps its original flag.
Under GCC 16.2.1 non-LTO, the baseline warns and copies both flags,
allowing RX initialization to run again; v2 allocates only TX's flag and
binds RX's reference to the original storage (under Clang 22.1.8 non-LTO,
the baseline also correlates it because the symbol name encodes the
function).

After inlining, both `done` flags are referenced by outer `target()` in
ELF, so grouping by referencing function cannot distinguish them; their
DWARF defining scopes remain `/initialize_rx/` and `/initialize_tx/`,
allowing v2 to distinguish new and existing state in a modified function
without author annotations. Full LTO's merged `STT_FILE` entries are
handled by the same definition identity; see v1 [1] Case 3 and
`test-identity-full-lto.sh`.

Case C. Missed reference changes: identities in checksums and references
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

Hashing only the normalized target name misses switches between same-named
targets in different TUs or scopes. v2 hashes the target's identity triple
into both function and data reference checksums; see
`test-checksum-identity.sh` and `test-checksum-identity-source.sh`.

Multiple split instances can still share one identity. In
`test-identity-pieces.sh` (Clang 22.1.8, non-LTO), the compiler splits
`static struct { long first, second; } state` into two 8-byte objects,
`state.0` and `state.1`. Unchanged `set()` and `sum()` access both fields,
while the patch switches the field read by `target()`:

    long target(void)
    {
-       return state.first;
+       return state.second;
    }

The instruction bytes are identical, and both `state.0` and `state.1` have
the same normalized name and DWARF triple, so the baseline checksum is
unchanged and `target()` is omitted from the patch. In v2, Stage 3 uses
the references from unchanged `set()` and `sum()` to establish each
piece's twin, and then detects a twin conflict when checking `target()`'s
reference. Equal function checksums alone are not sufficient; relocation
references must still agree with established twins.

Case D. Handling boundary: inheritance of static state
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

An anonymous block can narrow visibility without changing storage or use:

        int *a;
-       static int b = 0; a = &b;
+       { static int b = 0; a = &b; }
        return (*a)++;

In this example, GCC 16.2.1 and Clang 22.1.8 (non-LTO, `-O0` and `-O2`)
produce byte-identical stripped objects for both forms. A livepatch should
keep using the same state. The triple therefore records named scopes,
without anonymous-block depth or ordinals.

When multiple same-named `static`s exist within the same named scope,
their state-inheritance mapping must be determined. Denote the old
instances by A, B and the new instances by X, Y: positional pairing
chooses A->X and B->Y, whereas the author may have deleted A and added X
while keeping only B->Y. When their types and initial values are
identical, neither source definitions nor compiled positions distinguish
the two intents. Whether X should inherit A's live state or start from its
initial value requires author intent; even a human reviewer cannot make a
unique choice from the binary alone.

v2 first resolves what existing evidence can prove: when a function is
unchanged, twins are extended along its references; another unchanged
caller can also establish those twins (`test-identity-inline-state.sh`).
For remaining unpaired ordinary data, symbols with a DWARF identity and no
old candidate are treated as new, whereas references with existing
same-identity candidates report an error.

`test-identity-once-insert.sh` (GCC 16.2.1, Clang 22.1.8, non-LTO) shows
the consequence when a patch inserts a new initializer between two
existing ones:

    long target(long value)
    {
        ONCE_INIT(first, 1);
+       ONCE_INIT(extra, 3);
        ONCE_INIT(second, 2);
-       return value ^ first ^ second;
+       return value ^ first ^ second ^ extra;
    }

Each `ONCE_INIT` expansion defines a block-local `static done`. The test
requires `first` and `second` to keep their old flags and only `extra` to
get a new flag. The baseline warns and copies all three `done` flags,
allowing the old initializations to run again; v2 rejects the unresolved
reference and reports the function, offset, and old candidate:

    orig.o: error: objtool: target+0x2: unresolved data reference:
        done.2 (.../once_insert.c, /target/, done), old candidate done.0[4]

Symbol-table order itself can also change without adding or removing
`static`s. In `test-identity-branch-hint.sh` (GCC, Clang, non-LTO), merely
flipping branch-probability hints reorders the two counters in the symbol
table and causes the baseline to swap them silently. The ACPICA kernel
test patch hits the same boundary (Clang/LLD 22.1.8, ThinLTO): the two
1-byte BSS flags `_done` and `_done.2` in `acpi_ex_system_do_stall` share
the same triple and initial value; the baseline pairs them by position,
whereas v2 reports an error when the modified function references the
ambiguous instances.

Adding another `NL_SET_ERR_MSG()` call to a function that already has one
(GCC 16.2.1, non-LTO) produces two `__msg` objects with the same identity;
the baseline matches the old `__msg` by unchanged content and copies only
the new one, whereas v2 rejects the reference because an old candidate
with the same identity exists. Dedicated rules can be added for objects
known to be used only for diagnostic messages, provided object usage is
well-defined; by contrast, in `test-identity-readonly-address.sh`, the
address of a read-only descriptor is itself part of the interface.

Static compound literals lack a source definition identity and face a
similar ambiguity between new allocation and modified storage. v2
currently reuses a unique unchanged candidate within the reference context
and rejects the rest, as changed content alone cannot distinguish a new
literal from an edit to an existing one.

To quantify how often this boundary is reached in a full kernel, I kept
data and references fixed in the audited ThinLTO `vmlinux.o` build and
perturbed each main function's checksum one by one to simulate modifying
that function: out of 67,673 main functions, only 62 (0.09%) trigger an
unresolved data reference error, and only 33 (0.05%) involve writable data
sections.

For these rare cases, I plan a separate RFC for two annotations
prototyped locally, following the source-annotation model of kpatch's
`KPATCH_IGNORE_FUNCTION()` [8]. `KLP_NEW_STATIC()` would mark enclosed
state as new; `KLP_DEL_STATIC()` would omit the operation while retaining
a matching placeholder. Remaining instances would be paired by
DWARF declaration position, with their relative source order preserved.

Standalone Fixes Independent of DWARF (Patches 1-3)
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

Patches 1-3 fix wide-string truncation (`test-checksum-wide-string.sh`),
compound-literal contents omitted from reference checksums
(`test-identity-compound.sh`), and identifier digits lost when stripping
suffixes (`test-identity-thinlto-crc32.sh`). On a real DisplayPort PSR
table edit, the baseline misses the change, while v2 detects
`drm_dp_psr_setup_time()` as changed.

Evaluation and Performance Overhead
-----------------------------------

One-Line Patch Tests
~~~~~~~~~~~~~~~~~~~~

To test the macro-`static` issue raised in v1 review, I added a blank line
at the top of each `.c` file, first under `drivers/gpu/drm/radeon` (103
files), then tree-wide. Both tests used `fix-patch-lines`,
`CONFIG_LIVEPATCH=y`, `CONFIG_DRM_RADEON=m`, and DWARF 5. Radeon used
non-LTO; the tree-wide builds used GCC non-LTO / Clang ThinLTO and covered
`vmlinux.o` plus 16 modules. v1 and v2 ran checksum and diff on the same
build artifacts:

  Build                     v1 no-corr  v2 no-corr  v2 errors  v2 changed/new
  ------------------------  ----------  ----------  ---------  --------------
  GCC 16.2.1, tree-wide            682           0          0           0 / 0
  Clang 22.1.8, tree-wide          764           0         1*         -- / --
  GCC 16.2.1, Radeon               400           0          0           0 / 0
  Clang 22.1.8, Radeon             399           0          0           0 / 0

Radeon audit logs confirm that Stage 3 pairs all 400/399 `__print_once`
symbols, including 45 in `r100.o` and both flags in
`r100_reloc_pitch_offset()`.

* The tree-wide edit includes vDSO sources, which `klp-build` normally
  rejects. In this direct objtool test, all 16 Clang modules pass;
  `vmlinux.o` stops at `changed data: raw_data` because only the embedded
  vDSO build IDs differ. The baseline and v1 reject the same input. `--`
  marks the unfinished changed/new check; correlation completed with zero
  warnings.

Whole-Object vmlinux.o Audit and Multi-Config Self-Comparison
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

Across three full `vmlinux.o` build pairs, v2 establishes twins for all
admitted functions, leaves 0 unmatched ordinary symbols, and leaves only
compound objects unused by the patched code, with 0 `no correlation` or
`FILE`/source warnings.

Both tools recompute checksums and run diff on the same `vmlinux.o` build
artifacts against `klp-build` at `945537271df1` (audit counters are
collected via a separate local patch; exit status, diagnostics, and output
bytes are identical to the uninstrumented tool). The table counts nonzero
admitted symbols on the patched side (excluding special sections and
`dont_correlate` symbols), recording newly established twins at each
stage:

  New twins / final disposition  ThinLTO  Full LTO  GCC non-LTO
  -----------------------------  -------  --------  -----------
  Identity: address match         101414    101172       104204
  Identity: name fallback              4         4         1593
  Identity: assembly CU              182       189           82
  Identity + checksum               1012      1012         1014
  Unchanged-func references         2500      2511         2402
  ELF FILE/name fallback              65        65           64
  Alias resolution                     0         0            7
  Unmatched compound objects         334       334          347
  Other unmatched symbols              0         0            0
  Total admitted symbols          105511    105287       109713

The first three rows break down Stage 1 by DWARF lookup method. In the
ThinLTO pair, reference extension pairs 2,215 functions (including 2,210
static-call trampolines) and 285 data symbols, while the ELF fallback adds
65 known-mechanism pairs. All inputs are x86-64 DWARF 5 builds: ThinLTO
`getpid` uses Clang/LLD 22.1.8 on `24a19b953e2a`; Full LTO and GCC non-LTO
`version_show` use Clang/LLD 22.1.8 and GCC 16.2.1 on `4403278e4ea2`
(object-level audit rerun).

In addition, the fixture suite covers full/reduced DWARF 4/5 and DWARF 4
`.dwp` lookup with original `.dwo` files removed; 6 kernel build inputs
(GCC non-LTO and Clang ThinLTO, each with normal, reduced, and split
DWARF 5) also pass self-comparison with 0 unresolved ordinary symbols and
0 warnings (split kernel self-comparisons read the original `.dwo` files).

Regression Test Suite Comparison
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

Results on the 81-test suite for the baseline and v2 are shown below (all
skips are declared compiler restrictions; 0 runtime probe skips):

  Compiler      Tool      Pass  Fail  Skip
  ------------  --------  ----  ----  ----
  GCC 16.2.1    Baseline    58    13    10
  GCC 16.2.1    v2          68     3    10
  Clang 22.1.8  Baseline    65    13     3
  Clang 22.1.8  v2          75     3     3

Expected ambiguity rejections count as passes. All 13 baseline failures
pass under v2. In baseline diff, 6 tests per compiler miscorrelate or miss
changes without diagnosing the incorrect result.

The table keeps raw test failures: `compound` fails its function-checksum
assertion but reports `changed data` if baseline diff continues; GCC's
`weak-cold` fails because its assertion does not recognize the baseline's
`.klp.sym` reference format. The 3 v2 failures are intentional compatibility
rejections (see "Compatibility Limits and Build Requirements").

The suite can be run on the patched tree with:

    make -C tools/objtool
    CC=gcc OBJTOOL="$PWD/tools/objtool/objtool" \
        bash tools/objtool/tests/run-tests.sh
    CC=clang OBJTOOL="$PWD/tools/objtool/objtool" \
        bash tools/objtool/tests/run-tests.sh

Performance and Memory Overhead
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

Performance was measured on the ThinLTO `getpid` build pair (~1.081 GiB
per `vmlinux.o`) on an Intel Core i7-11850H with 30.6 GiB RAM and libdw
0.196, using 1 warmup and the median of 3 serial alternating runs (audit
logging disabled; `klp diff` reads precomputed checksums from the
respective tool, and `klp checksum` uses `--dry-run`):

  Operation     Tool                Time (s)  Peak RSS (MiB)
  ------------  ------------------  --------  --------------
  klp diff      Baseline                3.62            3566
  klp diff      v2                     28.71            5604
  klp diff      Memory prototype       26.73            3968
  klp checksum  Baseline                4.48            3971
  klp checksum  v2                     15.15            6006
  klp checksum  Memory prototype       13.88            5149

v2 adds ~25 s to `diff` and ~11 s to single-side `checksum`, alongside the
two full kernel builds performed by `klp-build`. A separate memory
prototype reduces peak RSS by 29% for `diff` and 14% for `checksum`
without changing matching rules or DWARF checks. It preserves all 81
per-test outcomes. On 13 retained kernel cases, checksums, recorded twins,
diagnostics and output bytes are identical to v2. The prototype remains
in a separate branch.

Compatibility Limits and Build Requirements
-------------------------------------------

Two Compatibility Limits (3 Policy Test Failures)
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

The 3 test failures under v2 reflect deliberate policy boundaries:

- Source-level linkage flips (`local-to-global-flip`): Converting a
  TU-local definition into an external one (or vice versa) changes the
  `source` qualifier in its identity and affects subsequent name
  resolution, so this series rejects it. When a patch needs to expose a
  local helper, it can keep the `static` definition and add a thin global
  wrapper.
- Duplicate compilation instances (`sympos`, `sympos-vmlinux`): These two
  tests compile the same source file into multiple objects in one link,
  producing instances with identical definition identities and raw ELF
  names. The triple does not distinguish duplicate build instances, and
  this series avoids depending on link order so correlation remains
  unaffected by newly added source files and LTO repartitioning.

Build Requirements and Remaining Limitations
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

`klp-build` requires `CONFIG_DEBUG_INFO` and reuses Kbuild's debug flags.
`objtool klp` now requires `libdw` in addition to `libxxhash`. If either
library is missing, objtool still builds without klp support.

With `CONFIG_DEBUG_INFO_SPLIT`, `klp-build` uses `llvm-dwp` by default to
save matching `.dwo` files in a `.dwp` package. The `libdw >= 0.191`
requirement applies only to DWP lookup.

The remaining toolchain and inherited implementation limitations are:

- `llvm-dwp` 22.1.8 hangs on some GCC DWARF 5 inputs containing
  `DW_FORM_implicit_const` (such as `lib/bsearch.dwo`), blocking `.dwp`
  packaging on those inputs.
- LLD Full LTO with `--plugin-opt=dwo_dir` requires
  `-mllvm -split-dwarf-cross-cu-references=true` to preserve per-TU paths
  (Kbuild does not enable this mode).
- The existing ELF reader (`elf.c`) can attach an overridden weak
  definition's local `foo.cold` to the surviving strong `foo`, causing
  both the baseline and this series to miss cold-only edits. This series
  preserves separate CU identities for both cold fragments and records the
  parent-attachment issue as a `FIXME` for a separate fix.

Open Questions and Next Steps
-----------------------------

This is a substantial change: 1,755 of the 4,010 added lines are tests,
and about 1,300 implement the DWARF reader and identity layer. Before
preparing a merge-ready series, I would like explicit maintainer guidance
on how to stage its integration. My proposed sequence is:

- Submit Patches 1-3 separately with their regression tests.
- Prepare the identity representation, DWARF reader, and ELF cross-checks
  as a foundation that can be reviewed separately from twin matching.
- Integrate the matching changes in Patches 7-10 together: reference
  extension pairs repeated statics, and the reference checks reject
  remaining ambiguous data references.
- Submit the memory optimizations separately and pursue explicit state
  annotations in a separate RFC.

This RFC retains upstream expectations for the three policy tests to
make the behavior changes visible. For the merge-ready series, I will
update their assertions to reflect the agreed policy and move Patch 11's
tests alongside the changes they cover.

I plan to add triple-based DWARF correctness tests in upstream compilers,
using known source definitions and optimization variants to check
coverage, non-conflict, and attribution accuracy (with clones, pieces,
anonymous scopes, and folding checked according to their respective
semantics) without locking in a specific DIE layout or suffix scheme. My
earlier bug reports and fixes on IPA-ICF, weak-override attribution, and
assembly CU selection [2-6] provide concrete test inputs, and the same
attribution model applies to consumers such as AutoFDO [7].

I would appreciate feedback on four questions:

1. Would maintainers prefer to integrate the identity representation and
   reader first, then evolve twin matching in a follow-up series, or keep
   them together for integration?
2. Is constraining candidates by the identity triple and extending twins
   via checksums and unchanged-function references the right foundation
   for correlation, and how should the final ELF fallback be bounded?
3. Is the handling boundary in Case D reasonable, and should explicit
   state annotations (such as `KLP_NEW_STATIC()` / `KLP_DEL_STATIC()`) be
   pursued in a separate RFC?
4. How should we structure upstream compiler tests around the identity
   triple to protect both DWARF producers and livepatch consumers?

Changes Since v1
----------------

Compared with v1, v2 adds reference-based twin extension through unchanged
functions, unmatched data reference checks, compound-literal content
checksums, reduced/split DWARF support, assembly and constrained name
lookup, data-alias reuse, and explicit ELF fallback diagnostics; it also
fixes wide-string truncation, trailing digits in identifiers, and
`__UNIQUE_ID` counter shifts.

Related Work & References
-------------------------

[1] RFC v1 (including userspace evaluation and kernel runtime cases):
    https://lore.kernel.org/all/20261026101916.3823942-1-luolongjuna@gmail.com/
[2] GCC PR126355 (address-bearing DIEs for IPA-ICF wrappers,
    fixed for GCC 17):
    https://gcc.gnu.org/bugzilla/show_bug.cgi?id=126355
[3] GCC PR126348 (abstract-origin TU attribution across LTO partitions,
    patch under review):
    https://gcc.gnu.org/bugzilla/show_bug.cgi?id=126348
[4] GDB PR34741 (overridden weak definition address resolution):
    https://sourceware.org/bugzilla/show_bug.cgi?id=34741
[5] LLDB #233545 (fix overridden weak function lookup):
    https://github.com/llvm/llvm-project/pull/233545
[6] GNU AS (CU source selection for preprocessed assembly):
    https://sourceware.org/pipermail/binutils/2026-October/152209.html
[7] AutoFDO #267 (fix absolute DWARF 5 range handling, merged):
    https://github.com/google/autofdo/pull/267
[8] kpatch source annotations (ignoring specified functions or sections):
    https://github.com/dynup/kpatch/blob/master/kmod/patch/kpatch-macros.h

Longjun Luo (11):
  objtool/klp: Fix checksums and copying of wide strings
  objtool/klp: Hash compound literals by content
  objtool/klp: Preserve identifier digits when stripping suffixes
  objtool/klp: Read symbol identities from DWARF
  objtool/klp: Support reduced and split DWARF
  klp-build: Require CONFIG_DEBUG_INFO
  objtool/klp: Correlate symbols using DWARF identities
  objtool/klp: Include symbol identities in reference checksums
  objtool/klp: Extend twins through unchanged function references
  objtool/klp: Check unmatched data references
  objtool/klp: Test symbol identity and state preservation

 scripts/livepatch/klp-build                   |   23 +-
 tools/objtool/Build                           |    4 +-
 .../objtool/Documentation/klp-test-design.txt |    6 +-
 tools/objtool/Makefile                        |   12 +-
 tools/objtool/elf.c                           |  100 +-
 tools/objtool/include/objtool/elf.h           |   43 +-
 tools/objtool/include/objtool/klp-dwarf.h     |   22 +
 tools/objtool/include/objtool/klp-identity.h  |   26 +
 tools/objtool/include/objtool/klp.h           |    3 +
 tools/objtool/klp-checksum.c                  |  155 ++-
 tools/objtool/klp-diff.c                      | 1041 ++++++++------
 tools/objtool/klp-dwarf.c                     | 1206 +++++++++++++++++
 tools/objtool/klp-identity.c                  |   94 ++
 .../tests/generic/fixtures/identity/alias.c   |   25 +
 .../generic/fixtures/identity/block_data.c    |   22 +
 .../generic/fixtures/identity/branch_hint.c   |   28 +
 .../generic/fixtures/identity/cold_strong.c   |   13 +
 .../generic/fixtures/identity/cold_user.c     |   15 +
 .../generic/fixtures/identity/cold_weak.c     |   10 +
 .../tests/generic/fixtures/identity/common.h  |   15 +
 .../generic/fixtures/identity/compound.c      |   65 +
 .../generic/fixtures/identity/consumer.c      |   30 +
 .../tests/generic/fixtures/identity/entries.c |   10 +
 .../generic/fixtures/identity/full_left.c     |   16 +
 .../generic/fixtures/identity/full_right.c    |    6 +
 .../generic/fixtures/identity/icf_left/same.c |   16 +
 .../fixtures/identity/icf_right/same.c        |   16 +
 .../fixtures/identity/inline_helpers.c        |   27 +
 .../tests/generic/fixtures/identity/lookup.c  |   13 +
 .../generic/fixtures/identity/metadata.c      |   24 +
 .../generic/fixtures/identity/move_left.c     |    9 +
 .../generic/fixtures/identity/move_right.c    |    8 +
 .../generic/fixtures/identity/new/same.c      |    6 +
 .../generic/fixtures/identity/new_driver.c    |   15 +
 .../generic/fixtures/identity/new_provider.c  |    4 +
 .../generic/fixtures/identity/old/same.c      |    6 +
 .../tests/generic/fixtures/identity/once.h    |   16 +
 .../generic/fixtures/identity/once_inline.c   |   28 +
 .../generic/fixtures/identity/once_insert.c   |   21 +
 .../tests/generic/fixtures/identity/pieces.c  |   28 +
 .../fixtures/identity/promotion_bounds_a.c    |   12 +
 .../fixtures/identity/promotion_bounds_b.c    |   12 +
 .../fixtures/identity/promotion_bounds_d.c    |   12 +
 .../fixtures/identity/promotion_crc32.c       |    8 +
 .../fixtures/identity/promotion_crc32_user.c  |   15 +
 .../generic/fixtures/identity/provider.c      |    9 +
 .../generic/fixtures/identity/readonly.c      |   30 +
 .../tests/generic/fixtures/identity/record.h  |    8 +
 .../tests/generic/fixtures/identity/rx.c      |    4 +
 .../tests/generic/fixtures/identity/shrink.c  |   19 +
 .../generic/fixtures/identity/source_driver.c |   11 +
 .../fixtures/identity/static_replace.c        |   29 +
 .../generic/fixtures/identity/static_scope.c  |   31 +
 .../fixtures/identity/static_scope_reorder.c  |   31 +
 .../tests/generic/fixtures/identity/tx.c      |    4 +
 .../generic/fixtures/identity/unique_id.c     |   50 +
 .../generic/fixtures/identity/wide_string.c   |   36 +
 .../generic/test-checksum-identity-source.sh  |   24 +
 .../tests/generic/test-checksum-identity.sh   |   32 +
 .../generic/test-checksum-wide-string.sh      |   39 +
 .../tests/generic/test-identity-alias.sh      |   26 +
 .../tests/generic/test-identity-block-data.sh |   12 +
 .../generic/test-identity-branch-hint.sh      |   18 +
 .../tests/generic/test-identity-compound.sh   |   33 +
 .../tests/generic/test-identity-dwarf.sh      |   34 +
 .../tests/generic/test-identity-full-lto.sh   |   30 +
 .../tests/generic/test-identity-icf.sh        |   23 +
 .../generic/test-identity-inline-helpers.sh   |   25 +
 .../generic/test-identity-inline-state.sh     |   21 +
 .../tests/generic/test-identity-metadata.sh   |   20 +
 .../tests/generic/test-identity-new-tu.sh     |   24 +
 .../generic/test-identity-once-insert.sh      |   19 +
 .../tests/generic/test-identity-pieces.sh     |   27 +
 .../generic/test-identity-readonly-address.sh |   23 +
 .../tests/generic/test-identity-shrink.sh     |   19 +
 .../tests/generic/test-identity-source.sh     |   29 +
 .../tests/generic/test-identity-split.sh      |   34 +
 .../generic/test-identity-static-replace.sh   |   20 +
 .../generic/test-identity-static-scope.sh     |   35 +
 .../generic/test-identity-thinlto-crc32.sh    |   23 +
 .../test-identity-thinlto-name-drift.sh       |   79 ++
 .../test-identity-thinlto-promotion.sh        |   26 +
 .../tests/generic/test-identity-unique-id.sh  |   31 +
 .../tests/generic/test-identity-weak-cold.sh  |   35 +
 .../tests/generic/test-thinlto-ambiguity.sh   |    2 +-
 .../tests/generic/test-thinlto-local.sh       |    4 +-
 tools/objtool/tests/identity-lib.sh           |   65 +
 tools/objtool/tests/lib.sh                    |    7 +-
 .../tests/x86/fixtures/identity_assembly.S    |   33 +
 .../tests/x86/fixtures/warn_reference.c       |   36 +
 .../tests/x86/test-identity-assembly.sh       |   19 +
 .../objtool/tests/x86/test-warn-reference.sh  |   21 +
 92 files changed, 4010 insertions(+), 486 deletions(-)
 create mode 100644 tools/objtool/include/objtool/klp-dwarf.h
 create mode 100644 tools/objtool/include/objtool/klp-identity.h
 create mode 100644 tools/objtool/klp-dwarf.c
 create mode 100644 tools/objtool/klp-identity.c
 create mode 100644 tools/objtool/tests/generic/fixtures/identity/alias.c
 create mode 100644 tools/objtool/tests/generic/fixtures/identity/block_data.c
 create mode 100644 tools/objtool/tests/generic/fixtures/identity/branch_hint.c
 create mode 100644 tools/objtool/tests/generic/fixtures/identity/cold_strong.c
 create mode 100644 tools/objtool/tests/generic/fixtures/identity/cold_user.c
 create mode 100644 tools/objtool/tests/generic/fixtures/identity/cold_weak.c
 create mode 100644 tools/objtool/tests/generic/fixtures/identity/common.h
 create mode 100644 tools/objtool/tests/generic/fixtures/identity/compound.c
 create mode 100644 tools/objtool/tests/generic/fixtures/identity/consumer.c
 create mode 100644 tools/objtool/tests/generic/fixtures/identity/entries.c
 create mode 100644 tools/objtool/tests/generic/fixtures/identity/full_left.c
 create mode 100644 tools/objtool/tests/generic/fixtures/identity/full_right.c
 create mode 100644 tools/objtool/tests/generic/fixtures/identity/icf_left/same.c
 create mode 100644 tools/objtool/tests/generic/fixtures/identity/icf_right/same.c
 create mode 100644 tools/objtool/tests/generic/fixtures/identity/inline_helpers.c
 create mode 100644 tools/objtool/tests/generic/fixtures/identity/lookup.c
 create mode 100644 tools/objtool/tests/generic/fixtures/identity/metadata.c
 create mode 100644 tools/objtool/tests/generic/fixtures/identity/move_left.c
 create mode 100644 tools/objtool/tests/generic/fixtures/identity/move_right.c
 create mode 100644 tools/objtool/tests/generic/fixtures/identity/new/same.c
 create mode 100644 tools/objtool/tests/generic/fixtures/identity/new_driver.c
 create mode 100644 tools/objtool/tests/generic/fixtures/identity/new_provider.c
 create mode 100644 tools/objtool/tests/generic/fixtures/identity/old/same.c
 create mode 100644 tools/objtool/tests/generic/fixtures/identity/once.h
 create mode 100644 tools/objtool/tests/generic/fixtures/identity/once_inline.c
 create mode 100644 tools/objtool/tests/generic/fixtures/identity/once_insert.c
 create mode 100644 tools/objtool/tests/generic/fixtures/identity/pieces.c
 create mode 100644 tools/objtool/tests/generic/fixtures/identity/promotion_bounds_a.c
 create mode 100644 tools/objtool/tests/generic/fixtures/identity/promotion_bounds_b.c
 create mode 100644 tools/objtool/tests/generic/fixtures/identity/promotion_bounds_d.c
 create mode 100644 tools/objtool/tests/generic/fixtures/identity/promotion_crc32.c
 create mode 100644 tools/objtool/tests/generic/fixtures/identity/promotion_crc32_user.c
 create mode 100644 tools/objtool/tests/generic/fixtures/identity/provider.c
 create mode 100644 tools/objtool/tests/generic/fixtures/identity/readonly.c
 create mode 100644 tools/objtool/tests/generic/fixtures/identity/record.h
 create mode 100644 tools/objtool/tests/generic/fixtures/identity/rx.c
 create mode 100644 tools/objtool/tests/generic/fixtures/identity/shrink.c
 create mode 100644 tools/objtool/tests/generic/fixtures/identity/source_driver.c
 create mode 100644 tools/objtool/tests/generic/fixtures/identity/static_replace.c
 create mode 100644 tools/objtool/tests/generic/fixtures/identity/static_scope.c
 create mode 100644 tools/objtool/tests/generic/fixtures/identity/static_scope_reorder.c
 create mode 100644 tools/objtool/tests/generic/fixtures/identity/tx.c
 create mode 100644 tools/objtool/tests/generic/fixtures/identity/unique_id.c
 create mode 100644 tools/objtool/tests/generic/fixtures/identity/wide_string.c
 create mode 100755 tools/objtool/tests/generic/test-checksum-identity-source.sh
 create mode 100755 tools/objtool/tests/generic/test-checksum-identity.sh
 create mode 100755 tools/objtool/tests/generic/test-checksum-wide-string.sh
 create mode 100755 tools/objtool/tests/generic/test-identity-alias.sh
 create mode 100755 tools/objtool/tests/generic/test-identity-block-data.sh
 create mode 100755 tools/objtool/tests/generic/test-identity-branch-hint.sh
 create mode 100755 tools/objtool/tests/generic/test-identity-compound.sh
 create mode 100755 tools/objtool/tests/generic/test-identity-dwarf.sh
 create mode 100755 tools/objtool/tests/generic/test-identity-full-lto.sh
 create mode 100755 tools/objtool/tests/generic/test-identity-icf.sh
 create mode 100755 tools/objtool/tests/generic/test-identity-inline-helpers.sh
 create mode 100755 tools/objtool/tests/generic/test-identity-inline-state.sh
 create mode 100755 tools/objtool/tests/generic/test-identity-metadata.sh
 create mode 100755 tools/objtool/tests/generic/test-identity-new-tu.sh
 create mode 100755 tools/objtool/tests/generic/test-identity-once-insert.sh
 create mode 100755 tools/objtool/tests/generic/test-identity-pieces.sh
 create mode 100755 tools/objtool/tests/generic/test-identity-readonly-address.sh
 create mode 100755 tools/objtool/tests/generic/test-identity-shrink.sh
 create mode 100755 tools/objtool/tests/generic/test-identity-source.sh
 create mode 100755 tools/objtool/tests/generic/test-identity-split.sh
 create mode 100755 tools/objtool/tests/generic/test-identity-static-replace.sh
 create mode 100755 tools/objtool/tests/generic/test-identity-static-scope.sh
 create mode 100755 tools/objtool/tests/generic/test-identity-thinlto-crc32.sh
 create mode 100755 tools/objtool/tests/generic/test-identity-thinlto-name-drift.sh
 create mode 100755 tools/objtool/tests/generic/test-identity-thinlto-promotion.sh
 create mode 100755 tools/objtool/tests/generic/test-identity-unique-id.sh
 create mode 100755 tools/objtool/tests/generic/test-identity-weak-cold.sh
 create mode 100644 tools/objtool/tests/identity-lib.sh
 create mode 100644 tools/objtool/tests/x86/fixtures/identity_assembly.S
 create mode 100644 tools/objtool/tests/x86/fixtures/warn_reference.c
 create mode 100755 tools/objtool/tests/x86/test-identity-assembly.sh
 create mode 100755 tools/objtool/tests/x86/test-warn-reference.sh


base-commit: 945537271df1e3680be9b32af7041ac20f1184fb
-- 
2.55.0


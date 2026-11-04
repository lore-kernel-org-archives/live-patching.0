Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.210.171
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793799164;
	b=NmE+gxjq5Bn3kwY8stHzCwGAFnrKuB4KitsoS9KXksY9jDWlb6qUSySejw/FcBTnUVoU
	 nUN/81kXaaK3Ut26lr/Xz2UInC9z7vvHPLzlbVvqs6g31QDZvdqSKwigdkbsIJ3QWilFL
	 Lm+aSRFQpydtKpTA0w3Vo1NBdVHvYlKUOyxY5NmiCjRLRy9vdYWyxn9FbAesinTAVhv/D
	 GvFhgxGkfklIOGzniZwAPTgnn7g2JicKS+naNemKTjqKchdDSrTjvRhDbiGqZ9OCiWmxs
	 DI6ugnmTNI5D7shYD7Jgd1X1Yv70y1kSauCMp9Jisw+I3xb7swJ9lzjw6pZt3lTIvWA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793799164;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=0MivBmeREXA6Z3fHdh+SbjQxmO7h+43RlnHAUjYhb8M=;
	b=a8AphoGxvGRfI5XF3JCxDOn6KEZlpgQKVwB1b0HoaUqFom2WcLKo8VP2+jEgdaRKf/7W
	 G04UBhy9GlfOsmX2f7VyLKsK4wVFEbpVDVLx2Bo23BoAAp50Vic84vX7Ahw85vrYNilrI
	 +s8Q1QCFyx3WLIR5FN7ojnCLKKNIA6IvGMM/ZmFi8yb3p0GnG7zMC+AqbGZ1uPApr1e+X
	 7+9BQzusPO3aaPganArFYv6XexsCgKSWe7pgXUrMK/MS2xG4H9wKHV2HLvL05rwlEKrrA
	 8IDQ3WgKMluhCy//XMjCXS9vtm8H1K5DtlX+TLe8KoJ95PdbgaaHZgwR+NUHTUrtJNQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=CEC759hT;
	arc=none smtp.remote-ip=209.85.210.171
Received: from mail-pf1-f171.google.com (mail-pf1-f171.google.com [209.85.210.171])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96AA6606A329
	for <live-patching@vger.kernel.org>; Wed,  4 Nov 2026 13:32:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 96AA6606A329
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=CEC759hT
Received: by mail-pf1-f171.google.com with SMTP id d2e1a72fcca58-8a05b210703so407758b3a.0
        for <live-patching@vger.kernel.org>; Wed, 04 Nov 2026 05:32:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793799163; x=1794403963; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=0MivBmeREXA6Z3fHdh+SbjQxmO7h+43RlnHAUjYhb8M=;
        b=CEC759hTxHP0bJYvUrs3JmYInLIte6vrHbHYN4FpK9yMofUmXAeM8RvK3M3T1UTEDj
         rpRHGBr33PXDxKxEnG5hxFfgh5sPFTd87a5JlHZGJKvZaKAQF33+AbrumepSHv8hxRVU
         yjFvyiaU4xG1C4AQZo7bF7SWdU+dOCCYdaOCIPvop8VWCJtWek/u/W8XpHZLl4mg8pF3
         m2MK8YfsfJWTxFjJMGLj6FMLPYf/HnFfSsABUzYki/TTnfir6gYtloIQMw89dz1hJ509
         1oxFZmgz2GoAVWTCy0JB7goz8/vsuB46li6b7Gg6nOWD9aZGLKxYBdat5+wv6ey1tG3d
         Ha1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793799163; x=1794403963;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=0MivBmeREXA6Z3fHdh+SbjQxmO7h+43RlnHAUjYhb8M=;
        b=gnACMlJ8NNnwvYY/Rq/1Jeffx0tlvLXzggt4hnZ0Rp3Ki4xcIwTwX7nvCaWlHLFnlL
         lYGlwbrR0lvM/6kQGVSoxHU6C+A0vQlcsG7oTlMapR5YK01xAQhpGCN2oSebGckqV/x6
         oENYQaV/wfukQ9tGxFiNi6wI1TuC7oA2fuvV2rCcwz3S61sURmRs2wcfObnM+Mh3HznY
         7jietkKCJ3YOpd1CmVDtyaarT/o1HlEkXhk/rL6kCdB//SF6XFgChLwbkllovNyuP1Jh
         x/0VCwBDlsqu2YH0+YwQuSWsQ1AqlnastCYxff7zdHehvfnLMLTyZuBUHe99iNcQh+mV
         L+BA==
X-Forwarded-Encrypted: i=1; AKwUvBzJWvmx6GlpwVzpTAASAcJLCFdjIEaAqYu6uB++XUizJy+JW+2POjjU3zFhFTJHiVbtGZAGXNKmoWEb8xK8@vger.kernel.org
X-Gm-Message-State: APuU4Z8Fe0rTXJoHbXamk+fJpleWNkDL/FRoFtlyNq4h65n0dXQFgkuQ
	3G42t0jI+c0D0lx0TlQLviuEtJjP99IUkCr1oP5gPKTWi/1rNoqwfxNN
X-Gm-Gg: AYBFou0dEBfG34JcvlkcSssD9bfSVADgxSaHuXVTKcg+YitB8zdDLs4ZgxD8Q+WLV0d
	6qGbOrxfT6rEFedI/VSS9TI1zlMPPq8Ueg/qbNu4OS99Zo2g+0NSn47QlOPnwOfuyXjoZSfBucE
	J0bqFyPJDsPxF6XI9v1rGGrCEtp1vxk736iWqJfhmzZgLdjXJIcnfEIF4X4aSfI/S3/8bPE3SvM
	4Z9bcncb9kgWxtbyPOYGJoq6llPyiSi+yVlkfKcb2hd7gowpI79/PXVul15cYC8rFRQp6LKKhfF
	ycsEpJ/obofWBGVY4HdDYCR1FSCUCuNiqienbBPmFqT+EPZMgnqwvyxKxiCbpzG4kplXNgXxxKa
	65oNpZNvHet+xerbnrvOHfCBoTOgibkyrqJve466U8m0McEeh0bLdqygeoqIB6MNjGeMDWpO32v
	fwZ1kQstkqHtD+QKPMRJh4AAiO/pNo5mxixZWwgTGHU6kYrYAWXmITzC9D4clJ/rWJ5SOlvSEqz
	RY/+xyxiOu1RCiJfC04vCdudgvksWnJYscxb/sUgEOOFXMTAJJkHngvAZrplW61Jkz/2C10j2xk
	nIFw1AZlLTS4+xwAcJp/OLDS9voWS/l30fZ42IqdKT9U4ioSyA==
X-Received: by 2002:a05:6a00:99a:b0:89f:7ac5:9d54 with SMTP id d2e1a72fcca58-8a9bdcc5a0cmr14718274b3a.17.1793799162871;
        Wed, 04 Nov 2026 05:32:42 -0800 (PST)
Received: from anatasluo-Precision-5560 ([139.226.166.21])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-8b09a7ce84fsm911369b3a.13.2026.11.04.05.32.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Nov 2026 05:32:42 -0800 (PST)
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
Subject: [RFC PATCH v2 05/11] objtool/klp: Support reduced and split DWARF
Date: Wed,  4 Nov 2026 21:31:51 +0800
Message-ID: <20261104133158.3187525-6-luolongjuna@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261104133158.3187525-1-luolongjuna@gmail.com>
References: <20261104133158.3187525-1-luolongjuna@gmail.com>
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

Read split CUs through libdw and save matching DWO files in a DWP before
another build overwrites them. Keep the DWP beside each saved object.
Reading saved DWP files requires libdw 0.191 or newer.

Read fixed-width array bounds as unsigned so reduced type information
does not make nonempty arrays appear empty.

Full LTO with --plugin-opt=dwo_dir requires
-mllvm -split-dwarf-cross-cu-references=true to preserve separate CUs
and their source paths. Kbuild does not enable this DWO output mode.

Validated the available objtool tests with GCC 16.2.1 and Clang
22.1.8. No failures.

Assisted-by: LLM
Signed-off-by: Longjun Luo <luolongjuna@gmail.com>
---
 scripts/livepatch/klp-build | 18 +++++++++++++++
 tools/objtool/klp-dwarf.c   | 45 ++++++++++++++++++++++++++++---------
 2 files changed, 53 insertions(+), 10 deletions(-)

diff --git a/scripts/livepatch/klp-build b/scripts/livepatch/klp-build
index e373928123e8..95bea5b2057e 100755
--- a/scripts/livepatch/klp-build
+++ b/scripts/livepatch/klp-build
@@ -34,6 +34,7 @@ SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
 FIX_PATCH_LINES="$SCRIPT_DIR/fix-patch-lines"
 
 OBJTOOL="$PWD/tools/objtool/objtool"
+DWP="${DWP:-llvm-dwp}"
 CONFIG="$PWD/.config"
 TMP_DIR="$PWD/klp-tmp"
 
@@ -265,6 +266,11 @@ validate_config() {
 	[[ -v CONFIG_KLP_BUILD ]] ||			\
 		die "CONFIG_KLP_BUILD not enabled"
 
+	if [[ -v CONFIG_DEBUG_INFO_SPLIT ]]; then
+		command -v "$DWP" &>/dev/null ||
+			die "split DWARF requires llvm-dwp (or set DWP)"
+	fi
+
 	[[ -v CONFIG_GCC_PLUGIN_LATENT_ENTROPY ]] &&	\
 		die "kernel option 'CONFIG_GCC_PLUGIN_LATENT_ENTROPY' not supported"
 
@@ -588,6 +594,15 @@ find_objects() {
 		    -printf '%P\n'
 }
 
+# Save the matching DWOs before the next build overwrites them.
+save_split_dwarf() {
+	local file="$1"
+	local dest="$2"
+
+	[[ -v CONFIG_DEBUG_INFO_SPLIT ]] || return 0
+	"$DWP" -e "$file" -o "$dest.dwp" || die "cannot save split DWARF for $file"
+}
+
 # Copy all .o archives to $ORIG_DIR
 copy_orig_objects() {
 	local files=()
@@ -608,6 +623,7 @@ copy_orig_objects() {
 
 		mkdir -p "$orig_dir"
 		cp -f "$file" "$orig_dir"
+		save_split_dwarf "$file" "$orig_file"
 	done
 	xtrace_restore
 
@@ -647,6 +663,7 @@ copy_patched_objects() {
 
 		mkdir -p "$patched_dir"
 		cp -f "$file" "$patched_dir"
+		save_split_dwarf "$file" "$patched_file"
 		found=1
 	done
 	xtrace_restore
@@ -680,6 +697,7 @@ generate_checksums() {
 
 		mkdir -p "$(dirname "$dest")"
 		cp -f "$file" "$dest"
+		[[ -f "$file.dwp" ]] && cp -f "$file.dwp" "$dest.dwp"
 		"$OBJTOOL" klp checksum "$dest"
 	done
 
diff --git a/tools/objtool/klp-dwarf.c b/tools/objtool/klp-dwarf.c
index 99b098ee7904..98d00ea19b7c 100644
--- a/tools/objtool/klp-dwarf.c
+++ b/tools/objtool/klp-dwarf.c
@@ -138,6 +138,10 @@ static void normalize_source(char *path)
 	*write = '\0';
 }
 
+/*
+ * Full LTO with --plugin-opt=dwo_dir can merge CUs and lose TU source
+ * paths. Kbuild does not enable this output mode.
+ */
 static int read_unit_source(struct identity_cu *cu, Dwarf_Die *die)
 {
 	Dwarf_Attribute attr;
@@ -146,12 +150,12 @@ static int read_unit_source(struct identity_cu *cu, Dwarf_Die *die)
 
 	if (dwarf_tag(die) != DW_TAG_compile_unit)
 		return 0;
-	if (dwarf_attr(die, DW_AT_name, &attr)) {
+	if (dwarf_attr_integrate(die, DW_AT_name, &attr)) {
 		name = dwarf_formstring(&attr);
 		if (!name)
 			return die_error(die, "invalid compilation unit name");
 	}
-	if (dwarf_attr(die, DW_AT_comp_dir, &attr)) {
+	if (dwarf_attr_integrate(die, DW_AT_comp_dir, &attr)) {
 		dir = dwarf_formstring(&attr);
 		if (!dir)
 			return die_error(die, "invalid compilation directory");
@@ -472,6 +476,23 @@ static int add_address(struct identity_reader *reader, struct identity_die *entr
 	return 0;
 }
 
+/*
+ * Reduced DWARF can omit the element size of idt_table. Reading its
+ * DW_FORM_data1 upper bound (255) as -1 would misidentify it as empty.
+ */
+static int read_array_bound(Dwarf_Attribute *attr, Dwarf_Sword *bound)
+{
+	Dwarf_Word value;
+
+	if (dwarf_whatform(attr) == DW_FORM_sdata ||
+	    dwarf_whatform(attr) == DW_FORM_implicit_const)
+		return dwarf_formsdata(attr, bound);
+	if (dwarf_formudata(attr, &value) || value > INT64_MAX)
+		return -1;
+	*bound = value;
+	return 0;
+}
+
 /*
  * The empty features[] in virtio_input.c can share an address with the
  * nonempty features[] in trans_virtio.c. Exclude the empty object's DIE
@@ -498,10 +519,10 @@ static bool is_empty_type(Dwarf_Die *type)
 			return true;
 		lower = 0;
 		if (dwarf_attr(&range, DW_AT_lower_bound, &attr) &&
-		    dwarf_formsdata(&attr, &lower))
+		    read_array_bound(&attr, &lower))
 			continue;
 		if (dwarf_attr(&range, DW_AT_upper_bound, &attr) &&
-		    !dwarf_formsdata(&attr, &upper) && upper < lower)
+		    !read_array_bound(&attr, &upper) && upper < lower)
 			return true;
 	} while (!dwarf_siblingof(&range, &range));
 	return false;
@@ -752,7 +773,7 @@ static int build_identities(struct identity_reader *reader)
 	static const Dwfl_Callbacks callbacks = { .section_address = dwfl_offline_section_address };
 	Dwfl *dwfl = dwfl_begin(&callbacks);
 	Dwarf_CU *cu = NULL, *next;
-	Dwarf_Die die;
+	Dwarf_Die die, split;
 	Dwarf *dwarf;
 	struct identity_die *entry;
 	unsigned int bucket;
@@ -767,11 +788,15 @@ static int build_identities(struct identity_reader *reader)
 	dwarf = dwfl_module_getdwarf(reader->module, &reader->bias);
 	if (!dwarf || check_relocations(dwarf))
 		goto out;
-	while (!(ret = dwarf_get_units(dwarf, cu, &next, NULL, &unit_type, &die, NULL))) {
-		if (unit_type == DW_UT_skeleton ||
-		    unit_type == DW_UT_split_compile || unit_type == DW_UT_split_type) {
-			ret = die_error(&die, "split DWARF is not supported yet");
-			goto out;
+	while (!(ret = dwarf_get_units(dwarf, cu, &next, NULL, &unit_type, &die, &split))) {
+		if (unit_type == DW_UT_skeleton) {
+			/* libdw checks the DWO ID and resolves addresses through the skeleton. */
+			if (!split.addr) {
+				ret = die_error(&die,
+						"missing or mismatched split DWARF file (saved .dwp files require libdw >= 0.191)");
+				goto out;
+			}
+			die = split;
 		}
 		if (!is_unit(dwarf_tag(&die))) {
 			ret = die_error(&die, "invalid unit root");
-- 
2.55.0


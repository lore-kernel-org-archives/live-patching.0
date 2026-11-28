Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795829190;
	b=qhEI44TMnEwu4EB8ZoLBJxiRSQBVNVNfP6uhNiltW92XYSEgsVtEAwnj4bWBvbQP6mgM
	 VYLCqI7bhbnBp0H3vPmlAn9lxNL3OAX+KuqWujrFXUncgyRovhZu3ez+MAbj+UzB964lH
	 kF/+1h5b2yjoEo7v9R798DMjah1pPD+nvpVX+LIdf435/O+VetDxuOI99UJ7t/iFBH+nh
	 q1wiwnjto9yS2CCLEEZW/s42/V95s1S1zE1fdsVuhErkkde5CLJTtMvic1ivJPLlppVQp
	 2CGTVEc5im8qKFmOiwSgyvwBBjrRe3EwMMaSBRoYf3YsmRw1MgVjHK1ld2aLulI2ZGA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795829190;
	h=Received:DKIM-Signature:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Message-Id:X-B4-Tracking:X-Change-ID:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=OmT7hzdOIctTRNXQ+a0RQQtL3fnzQMZ5/L5lNB+m98I=;
	b=jD/6/pXmrgEkbuk562zHnnB6Feg4fJpYKYyezeytDJuErPNp76CLUI4sJM8AieadQaj1
	 o8GQiio446ZJ/GOKD7cVQ2kIhsHIoeGWm6yHFcDhaNCAmPFWaDPx6hiE7lM+C3nHP5Cw9
	 Nzyctqe1IxSUV1ihOVBjWfS7dR9Ax2mARjVbkdlpbKdR98d9FvYKtthdwaXi4uE/UjXpe
	 GW8IpJV9JX+s4iKlclUr+w3sItFgv8YvM2sGghg4WXiw4gL4rIM+qmRInJPwnbLY9KYZO
	 NABR49Dk6K5HoFp8E6f2Poddh6l81iagpQtBPyX/MK5RA2fWgezToc7cCU6qSBZN/+Q==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ch9xj6Oy;
	arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BA8D606A31E;
	Sat, 28 Nov 2026 01:26:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ch9xj6Oy
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
	t=1795829189;
	b=DT+8OUJhfYj6Z01RbQ5pcR5o70gCc2ejCiw4/c9gytU75k3GRCxu5nS2Bo67x1G3OWbZ
	 O6a+aeWwfDXdIVcY5rNGlOkcxVTXmNs92ao9Sg0FTPwUxINOZcI1fLZ78UYBSsESuzoq8
	 yfoKgIuiQ34p0dPaBa4XwGQ/s4I1ku+cl9lnd9+6y51uMThAFnsb5mJjXHI7HKVpFmclS
	 5TzSJVTegYQQMh+rWxO9iD5Gb7260scJBH2ZGxUrvHLFw9djgm562NFDDaIUw14k5RE16
	 8K/o/sPJq75omYZuIai0nwnJTQkaUPOalES+MAtYPxAuQhaloRuYZHKkKnaM0vq6H1w==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
	c=relaxed/relaxed; t=1795829189;
	h=DKIM-Signature:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Message-Id:X-B4-Tracking:X-Change-ID:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=OmT7hzdOIctTRNXQ+a0RQQtL3fnzQMZ5/L5lNB+m98I=;
	b=Sp4nQeW3Co0ntzSBqlKQR1I1TRY2GY1Bi90v5rkAxHbyy27F9QBTSc6sZc3BOnSUn13w
	 +znuW6+OwcgNRtUcDf4iA7OhjQf01aCLiHyduKQ5zsOt3spT9WTjc92ucRiTRtvX4hKcZ
	 gk0u30xMpozQLyrGOBFIFGgXxIoBD1ztH9FOjJZnpAkyWBEM6pPSm/jOYVCL/HZnBORWT
	 2IbkIGtTtxybrKNaFg5pHlgQP3WZNtGgtDU8BEW9UrHW9+ZiyljwNh3+0LHw+gx478tmo
	 KM1FrJT1veBiZ8w0sq1z2dS9zbzVsfHFhPGf8XE18VA5cxtgyBSquJPZXdZ0kQDxXxw==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
	arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.kernel.org (Postfix) with ESMTPS id 460B31F00893;
	Sat, 28 Nov 2026 01:26:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795829189;
	bh=OmT7hzdOIctTRNXQ+a0RQQtL3fnzQMZ5/L5lNB+m98I=;
	h=From:Date:Subject:To:Cc:Reply-To;
	b=ch9xj6Oyf4WIZwBDfrS51ok4cfItzGCw1+wiNUgU4xXg6Z+/EWJtI+8YWFLevNUf/
	 sekF2EyE5JM3n5mZOEGBYqBhGZwbNYg+ynCK0tD+3gRTKsfsK5GxxeSm20SACIly9S
	 0VjqclJr4kbkmzS7RvXl4vhB1hitm0/AgCNmz63njgM+y+O1595URHm6xGwTmQSFqa
	 MvMA/KZMC6P//5sPYuvyDndyNTekak1ayarSpKbXjlsUd3CDFE5EBr5ihso2JUYVFY
	 eU74ySBJKB1JHEbaR3vKnqFdeF10MAJmKRIn47Eo0V58G/rEPGp3O5xg5ODZbfZxn4
	 uXgsBZAY6EH7w==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
	by lkml.kernel.org (Postfix) with ESMTP id C7E7D4DEEF;
	Sat, 28 Nov 2026 01:26:28 +0000 (UTC)
From: Binoy Ravindran via B4 Relay <devnull+binoy.vt.edu@kernel.org>
Date: Fri, 27 Nov 2026 20:26:09 -0500
Subject: [PATCH] objtool/klp: Copy constant pool entries for local labels
X-Mailing-List: live-patching@vger.kernel.org
List-Id: <live-patching.vger.kernel.org>
List-Post: <mailto:live-patching@vger.kernel.org>
List-Help: <mailto:live-patching+help@vger.kernel.org>
List-Subscribe: <mailto:live-patching+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:live-patching+unsubscribe@vger.kernel.org>
List-Owner: <mailto:live-patching+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Message-Id: <20261127-objtool-klp-cst-v1-1-dc19b08c8676@vt.edu>
X-B4-Tracking: v=1; b=H4sIALAtCmsC/yXMTQqDMBBA4avIrB1I4h/tVcRFTMc6KkYysRTEu
 zfW5bd47wChwCTwzA4I9GFhvyboPAM32vVNyK9kMMrUWpsGfT9F7xeclw2dRKwKa0pVNoOiB6R
 qCzTw939su9uy9xO5eG3gPH8AF2gMcwAAAA==
X-Change-ID: 20261127-objtool-klp-cst-53a24047f0e9
To: Josh Poimboeuf <jpoimboe@kernel.org>, 
 Peter Zijlstra <peterz@infradead.org>, Song Liu <song@kernel.org>
Cc: linux-kernel@vger.kernel.org, live-patching@vger.kernel.org, 
 Binoy Ravindran <binoy@vt.edu>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1795829188; l=3839;
 i=binoy@vt.edu; s=20261123; h=from:subject:message-id;
 bh=g6HRbPb1IGu2InqS4C2jJUK6JDCQL7R1Kycv7BvVqMg=;
 b=S7QM5+ShXq94f+j5vazW2vbjBTc+Tw02491KJe6OG0xJF2Uqqmu9qme/pREbm6wCkIYrEwMvH
 TM70xkRCUVFCaFFT39mWLC/CaAcbxAnoZZHflRaWUrLE/TcKRNLDWdy
X-Developer-Key: i=binoy@vt.edu; a=ed25519;
 pk=4cNdKPHP0InmhK/9bb7Tm2ZMUXUvLGfw1pmVt5b98fA=
X-Endpoint-Received: by B4 Relay for binoy@vt.edu/20261123 with
 auth_id=1622
X-Original-From: Binoy Ravindran <binoy@vt.edu>
Reply-To: binoy@vt.edu
Content-Transfer-Encoding: 7bit

From: Binoy Ravindran <binoy@vt.edu>

The compiler refers to a constant in a .rodata.cst* pool through a local
label such as .LC32. The label has no size. Since commit 51e1dfce24c8
("objtool/klp: Don't correlate .rodata.cst* constant pool objects"),
klp-diff clones such a label together with its data. But
__clone_symbol() copies data only for a symbol with a nonzero length or
for a section symbol. For a .LC label it copies nothing and places the
label at the current end of the output section.

The patched function then reads whatever ends up at that place when the
module is linked. Building livepatches with klp-build for recent fixes
on v7.4-rc2 (x86-64, GCC 12), three of 54 modules read the wrong 2-byte
constant:

  fib_table_insert()          .LC32  expected 0x0000, reads 0x6e00
  ieee80211_rx_mgmt_beacon()  .LC68  expected 0x0000, reads 0x6e00
  cfg80211_inform_bss_data()  .LC9   expected 0x1000, reads 0x0000

In each case the bytes come from the end of an unrelated string in the
module's .rodata. The modules load and patch without any warning. We
confirmed this in a running kernel: with the first module loaded, the
patched fib_table_insert() loads 0x6e00.

A label in a SHF_MERGE constant pool names one entry of sh_entsize
bytes. Copy that entry when the label has no size. With this change, all
three modules hold the compiler's constants.

Fixes: 51e1dfce24c8 ("objtool/klp: Don't correlate .rodata.cst* constant pool objects")
Assisted-by: Claude:claude-opus-5-5
Signed-off-by: Binoy Ravindran <binoy@vt.edu>
---
A small problem in __clone_symbol(): a .LC label in a .rodata.cst*
pool has no size, so its constant is never copied into the livepatch
module, and the patched function reads whatever bytes follow. Details
and the three affected modules are in the patch.

Tested on v7.4-rc2 (x86-64, GCC 12): with the fix, the three modules
hold the compiler's constants, and three unaffected modules are
unchanged. The patch applies to tip objtool/core and to mainline.
---
 tools/objtool/klp-diff.c | 15 +++++++++++++--
 1 file changed, 13 insertions(+), 2 deletions(-)

diff --git a/tools/objtool/klp-diff.c b/tools/objtool/klp-diff.c
index 95d0d86666d7..f8a638b29a26 100644
--- a/tools/objtool/klp-diff.c
+++ b/tools/objtool/klp-diff.c
@@ -923,6 +923,7 @@ static struct symbol *__clone_symbol(struct elf *elf, struct symbol *patched_sym
 
 	if (data_too && !is_undef_sym(patched_sym)) {
 		struct section *patched_sec = patched_sym->sec;
+		size_t len = patched_sym->len;
 
 		out_sec = find_section_by_name(elf, patched_sec->name);
 		if (!out_sec) {
@@ -946,7 +947,17 @@ static struct symbol *__clone_symbol(struct elf *elf, struct symbol *patched_sym
 		if (!is_sec_sym(patched_sym))
 			offset = ALIGN(sec_size(out_sec), out_sec->sh.sh_addralign);
 
-		if (patched_sym->len || is_sec_sym(patched_sym)) {
+		/*
+		 * A local label in a constant pool (.rodata.cst*) has no size,
+		 * but it names one entry of sh_entsize bytes.  Copy that entry,
+		 * or the label ends up pointing at whatever data follows it.
+		 */
+		if (!len && !is_sec_sym(patched_sym) &&
+		    (patched_sec->sh.sh_flags & SHF_MERGE) &&
+		    !is_string_sec(patched_sec) && patched_sec->sh.sh_entsize)
+			len = patched_sec->sh.sh_entsize;
+
+		if (len || is_sec_sym(patched_sym)) {
 			void *data = NULL;
 			size_t size;
 
@@ -957,7 +968,7 @@ static struct symbol *__clone_symbol(struct elf *elf, struct symbol *patched_sym
 			if (is_sec_sym(patched_sym))
 				size = sec_size(patched_sym->sec);
 			else
-				size = patched_sym->len;
+				size = len;
 
 			if (!elf_add_data(elf, out_sec, data, size))
 				return NULL;

---
base-commit: b99a5337da3c847db216476d645b69acd714c3ba
change-id: 20261127-objtool-klp-cst-53a24047f0e9

Best regards,
--  
Binoy Ravindran <binoy@vt.edu>



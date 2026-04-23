Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 830E43D6CC2;
	Thu, 23 Apr 2026 04:04:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776917073; cv=none; b=tshwHzc+C0AAGPod6VNzrLMiIyWXJyj0Y95xmloAHuQexwRI0RzHzjHiYbe1AaFQp6s8HZZE2Ywq6NBIZrRqGAK4V0aqF1tvyAGiOL2c4c7t+9a1gqvrG0ug4j4Jmsekd6vKpAOTkgH5z8ADsCT6qIyLM7xEGwmM+pY0wPVCG1Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776917073; c=relaxed/simple;
	bh=0rrESB7Tw2th22oQqKf55qbbRHuSPvTcbVTjD/fC290=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=nWCdW9Ga2Goi0huVYxBZLH1bx9D3yH5GcfyBBPosL/zTzRUoNuV1VHSeqZtngW6QZNld9wUomSjm4xc52HJDYr4pNk+bzkCorBwkE20uYEdgWNA+3xSANEM7gGQSGBINtkOg+5JUO5CYMC9gepUrDr6on232ipIXGLOrvwE22OA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NI2csMWY; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NI2csMWY"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CF550C2BCB4;
	Thu, 23 Apr 2026 04:04:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776917073;
	bh=0rrESB7Tw2th22oQqKf55qbbRHuSPvTcbVTjD/fC290=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=NI2csMWY0m2KHlosfoeo9wEfVaEvSTNfoc2yn3xfMJbUSZ69lbPOEwbHyQ8v0PpdB
	 ebv970LuBdJhotr3PvrREVPQ3a0oCfFtrFfn0ZgYMVVctqhNZXoutDAV7vaH5vqQ2Y
	 LDtaVUmuv+RpKxR9ZOYPlQxezRk7H5CIiRJNVrPPl+R/SLjjvO5pMSB4AzhgWV0YlV
	 FmuYOAviDvT8VpfIkEezGJnmFvDOxyl8hTNslbmx7+EMMOdfFAHuTXGKI02rnybugP
	 Qdz6j22eRWmXDS6C3x7KVcFUCd5Qvfd0leZQ+FlZGwsY8KDjV8OsxRshLmrv6OxxoE
	 YrXvPO5tsuiLw==
From: Josh Poimboeuf <jpoimboe@kernel.org>
To: x86@kernel.org
Cc: linux-kernel@vger.kernel.org,
	live-patching@vger.kernel.org,
	Peter Zijlstra <peterz@infradead.org>,
	Joe Lawrence <joe.lawrence@redhat.com>,
	Song Liu <song@kernel.org>,
	Miroslav Benes <mbenes@suse.cz>,
	Petr Mladek <pmladek@suse.com>
Subject: [PATCH 19/48] klp-build: Fix checksum comparison for changed offsets
Date: Wed, 22 Apr 2026 21:03:47 -0700
Message-ID: <128563f2a525de0ab3518f826d4719149e5712cf.1776916871.git.jpoimboe@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <cover.1776916871.git.jpoimboe@kernel.org>
References: <cover.1776916871.git.jpoimboe@kernel.org>
Precedence: bulk
X-Mailing-List: live-patching@vger.kernel.org
List-Id: <live-patching.vger.kernel.org>
List-Subscribe: <mailto:live-patching+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:live-patching+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The klp-build -f/--show-first-changed feature uses diff to compare
checksum log lines between original and patched objects.  However, diff
compares entire lines, including the offset field.  When a function is
at a different section offset, the offset field differs even though the
instruction checksum is identical, causing the wrong instruction to be
printed.

Only compare the checksum field when looking for the first changed
instruction.  Also print both the original and patched offsets when they
differ.

Fixes: 78be9facfb5e ("livepatch/klp-build: Add --show-first-changed option to show function divergence")
Signed-off-by: Josh Poimboeuf <jpoimboe@kernel.org>
---
 scripts/livepatch/klp-build | 30 +++++++++++++++++++++++-------
 1 file changed, 23 insertions(+), 7 deletions(-)

diff --git a/scripts/livepatch/klp-build b/scripts/livepatch/klp-build
index 81b35fc10877..2b8b3c338a87 100755
--- a/scripts/livepatch/klp-build
+++ b/scripts/livepatch/klp-build
@@ -727,13 +727,29 @@ diff_checksums() {
 		)
 
 		for func in ${funcs[$file]}; do
-			diff <( grep0 -E "^DEBUG: .*checksum: $func " "$orig_log"    | sed "s|$ORIG_DIR/||")	\
-			     <( grep0 -E "^DEBUG: .*checksum: $func " "$patched_log" | sed "s|$PATCHED_DIR/||")	\
-				| gawk '/^< DEBUG: / {
-					gsub(/:/, "")
-					printf "%s: %s: %s\n", $3, $5, $6
-					exit
-			}' || true
+			local -a orig patched
+			paste <(grep0 -E "^DEBUG: .*checksum: $func " "$orig_log") \
+			      <(grep0 -E "^DEBUG: .*checksum: $func " "$patched_log") |
+			while IFS=$'\t' read -r orig patched; do
+				read -ra orig <<< "$orig"
+				read -ra patched <<< "$patched"
+
+				if [[ ${#patched[@]} -eq 0 ]]; then
+					printf "%s: %s: %s (removed)\n" "${orig[1]%:}" "${orig[3]}" "${orig[-2]}"
+					break
+				elif [[ ${#orig[@]} -eq 0 ]]; then
+					printf "%s: %s: %s (added)\n" "${patched[1]%:}" "${patched[3]}" "${patched[-2]}"
+					break
+				fi
+
+				[[ "${orig[-1]}" == "${patched[-1]}" ]] && continue
+
+				printf "%s: %s: %s" "${orig[1]%:}" "${orig[3]}" "${orig[-2]}"
+				[[ "${orig[-2]}" != "${patched[-2]}" ]] && \
+					printf " (patched: %s)" "${patched[-2]}"
+				printf "\n"
+				break
+			done || true
 		done
 	done
 }
-- 
2.53.0


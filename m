Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B28D1340283;
	Fri,  1 May 2026 04:09:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777608541; cv=none; b=V2JDKBsTQqczex8mJbV2mTBIMsHBP1FjYb3+cEkwIjHLXpP9ggKLU21WIBwOvUmWKe3UcEPDvigwYXzz5061+Vf9XWaLp/f8wee03K41LGGKuj2Q0A3EHFpT4LhGoiOv5mDauadOhTR3w2SgMVDaSuZTgwUO4OLIaIgs9juDehM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777608541; c=relaxed/simple;
	bh=LeLdvkaGeI52MJHHJIpetvWxTUeyqHasZJ3P0shfBW0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=LJxfjlC+OLZLtWu26RyjJIowLrFF1c/gl3WXJok6ohcuRRH8KoJdNbDWafWVsClLIsdQ/yp1fMzTrBh4fuOBrxOj2v3JAbiMUTV+nMScIXP7YwsRLkhxq7MjWF99V3F/zQeNL8rb2Xh6xRLvRmSMzHtcLIAty+dskPj0zseUkpg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gr0NV+ou; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gr0NV+ou"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 44782C2BCB8;
	Fri,  1 May 2026 04:09:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777608541;
	bh=LeLdvkaGeI52MJHHJIpetvWxTUeyqHasZJ3P0shfBW0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=gr0NV+oueqyr35nIEvXkHWv507vcgMgN/O0z8qg7U46qhn+uWqlkFy/U+hTAtGiYL
	 Gx/qnhMmTyoJsCFJZnGrl+t2cb6KcMRXjF+hBBWC3M+RFQ2SJK1N5EBuBNnoipaC/o
	 up/JJMPzpLO2VRrhns/GXOTpTMieW/Uw6rhioyXvhU/+mZQhv4b6xzIR9zVVPAFBBw
	 eYaBUcblOC+/8TNp58W4YYXzK3sYAJFiiFJmESd+qIDY8ZTgk3IS/99K6I4+11OLEA
	 s401gVXx5SS4R5vcEdDSxz+Soqpxu1mdtwHy6ezwZfbOQp3YdHM6RGwq4ivvyDe/Eu
	 9SKkm1CxvORLw==
From: Josh Poimboeuf <jpoimboe@kernel.org>
To: x86@kernel.org
Cc: linux-kernel@vger.kernel.org,
	live-patching@vger.kernel.org,
	Peter Zijlstra <peterz@infradead.org>,
	Joe Lawrence <joe.lawrence@redhat.com>,
	Song Liu <song@kernel.org>,
	Miroslav Benes <mbenes@suse.cz>,
	Petr Mladek <pmladek@suse.com>
Subject: [PATCH v2 24/53] klp-build: Fix checksum comparison for changed offsets
Date: Thu, 30 Apr 2026 21:08:12 -0700
Message-ID: <6392d4f0c8837ccc0498a1c79a2d9534dacfce82.1777575752.git.jpoimboe@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <cover.1777575752.git.jpoimboe@kernel.org>
References: <cover.1777575752.git.jpoimboe@kernel.org>
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
index e19d93b78fcb..8f0ea56f2640 100755
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
+			while IFS= read -r line; do
+				read -ra orig <<< "${line%%$'\t'*}"
+				read -ra patched <<< "${line#*$'\t'}"
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


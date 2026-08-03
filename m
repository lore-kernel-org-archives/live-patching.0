Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8AAD1371CE9;
	Mon,  3 Aug 2026 03:24:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785727492; cv=none; b=hxXJqxBlXUCXucnsMyvQUYqnpQAhKNSx4Ch7DMsNfHdxmIE6ePPhAW5bGNAOCxeUbN3mWU9qc42QyroQegCADNXMeXm483rNOfbtQS/ac2Lk4e+IBo+KvhL6/rIKIrWrCt9VmGtrYCYtApJGSotSwgHRbFGbPZlrAUDBDYL/ek4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785727492; c=relaxed/simple;
	bh=ZfKdhuQ63JpBsiVElOpGCQjExO5iDWBD+S7OmVWm+xA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Jw1dce/RHcdmkiRstjEhukYgYzMqS52hnaXbeVgpn8aliEuvtj5SHvDYszJj9w6++bW4vFcjy4S7CHs1XQtz+mtlhE9/mcBMJamJaOet7qVXRI1hsaZ7kby+0qDi888VYn4K1mvmEN6+BVM5N5HM91fG/DYyPUnHvavFVVOed1U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OzrkaYa/; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OzrkaYa/"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BA12F1F00A3D;
	Mon,  3 Aug 2026 03:24:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785727491;
	bh=1bdLKP+qYFZbiCIwjRRJtgUZeoEpaDmDYlf6aXshcZo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=OzrkaYa/n2Gnv1GYkol2GxnCQ/Lr0Yk4WAbExE9TDaPAZF6LiCumBIsXqXH4qFRBY
	 jKAs6YGayrmPlXCPwjHm5AmtEuDxQKn7xhhXN3n6ZuuOZHbAerWjvzYOWekOpNrccq
	 DPoqZoyKjc7NeB3Uot56yIQrxuYJ+4vUfMed0naJfThIBxedHJzl8PsLGnEf/Rzz3W
	 wA4Qt1V8GGnqldYSAC8IPiISWxuRz+6z1B6fsg55ATjldpXBQQ5pK6GPYqfPYJPSCs
	 ZEswH2zwMMXjYJ2m16mlg9koc5XyU+Qd+M9VA4+LP0e+23/e7VbTtSXhqIszyi2E5A
	 DOx51sI6vZ4xw==
From: Josh Poimboeuf <jpoimboe@kernel.org>
To: x86@kernel.org
Cc: linux-kernel@vger.kernel.org,
	live-patching@vger.kernel.org,
	Peter Zijlstra <peterz@infradead.org>,
	Joe Lawrence <joe.lawrence@redhat.com>,
	Miroslav Benes <mbenes@suse.cz>,
	Petr Mladek <pmladek@suse.com>,
	Song Liu <song@kernel.org>,
	Luis Chamberlain <mcgrof@kernel.org>,
	Petr Pavlu <petr.pavlu@suse.com>,
	Daniel Gomez <da.gomez@kernel.org>,
	Sami Tolvanen <samitolvanen@google.com>,
	linux-modules@vger.kernel.org
Subject: [PATCH 04/14] objtool/klp: Skip hidden directories when finding objects
Date: Sun,  2 Aug 2026 20:24:26 -0700
Message-ID: <6c8eaa9feb17e3811f4ef7733fd7288b7f489183.1785727106.git.jpoimboe@kernel.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <cover.1785727106.git.jpoimboe@kernel.org>
References: <cover.1785727106.git.jpoimboe@kernel.org>
Precedence: bulk
X-Mailing-List: live-patching@vger.kernel.org
List-Id: <live-patching.vger.kernel.org>
List-Subscribe: <mailto:live-patching+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:live-patching+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

klp-build's find_objects() scans the whole tree for vmlinux.o and .ko
files, pruning only klp-tmp/ and .git/.  Development tools can leave
other dot-directories in the tree.  Kernel objects never live under
hidden directories, so prune them all.

Signed-off-by: Josh Poimboeuf <jpoimboe@kernel.org>
---
 scripts/livepatch/klp-build | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/scripts/livepatch/klp-build b/scripts/livepatch/klp-build
index c4a7acf8edc3..a8c103ce7763 100755
--- a/scripts/livepatch/klp-build
+++ b/scripts/livepatch/klp-build
@@ -575,8 +575,9 @@ find_objects() {
 	local opts=("$@")
 
 	# Find root-level vmlinux.o and non-root-level .ko files,
-	# excluding klp-tmp/ and .git/
-	find "$PWD" \( -path "$TMP_DIR" -o -path "$PWD/.git" -o -regex "$PWD/[^/][^/]*\.ko" \) -prune -o \
+	# excluding klp-tmp/ and hidden directories.
+	find "$PWD" -mindepth 1 \
+		    \( -path "$TMP_DIR" -o -name ".*" -o -regex "$PWD/[^/][^/]*\.ko" \) -prune -o \
 		    -type f "${opts[@]}"				\
 		    \( -name "*.ko" -o -path "$PWD/vmlinux.o" \)	\
 		    -printf '%P\n'
-- 
2.54.0


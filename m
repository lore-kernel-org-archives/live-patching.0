Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14BD02F90C9;
	Mon,  3 Aug 2026 05:49:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785736185; cv=none; b=ZvzZNXyGglOTo0J0ZXZFg4EUJxfivHFT6aGxbjtAjhQpIUwFdQfa7bN4ytRaPo1j2B7/qcWHVLRj1u/wc+YbUTHsdvcnO/Oej01tZXffjXee5F6BvoqtmG9Z2GYcq0ONKJ39MfybhIeqC2N/vocgK0SiIuW60fL7JSN6X5JQ8Z8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785736185; c=relaxed/simple;
	bh=u/jDR5mq/x07L+IfntGRE8PjEWBMyTWHGXCnypMqhrg=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=UsHb9BAdG72hmQmkZ7VKe8sesqZbQiL/cKhPlUJfMd/crUK4Nx0kiYgtNPsvSDoNoU8TuRm/D+XDJgGXgz794ODR7rPAB99N6YKE76f1dGuVJl8UBE2iKGzUyXy5IgQVS2vDoRoTTNxc62FDeaJa+nJOuplTtsapLuaSQBEbzyY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=A0oAyiw/; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=8fwTNYb5; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="A0oAyiw/";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="8fwTNYb5"
Date: Mon, 03 Aug 2026 05:49:40 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1785736182;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=xCmRkJCRyf2CUjmbH8iN5lsvRRhLvCmRxTq44W96wWU=;
	b=A0oAyiw/vL/2akLojeJ3dpDvTluR8JXDlbBoIPLhlkLBgyr1E1EaW4xF9+iuTqxTKo+Tvc
	xvR1kdShOuXBybHFAGC5reME1tiE32+behwP7aAmuFlDQQGoS9Y8Sjdq9OVpqK1Uc3uVtX
	fgqpOqfALMiku5WmrxSxvMynQTf0mPeBKUzZ8tdxS1wCL3Y2GOiW1MyC4nTDfmx2XfcOzn
	N1pwuaUrLygoF4jJM4Ndh70ZGcmP9InwmvOOVWoQaR/cNUOqJLUx+bso9pFJUPS3uW4EQE
	yrDc5/WUfx+L1GkZhtH7JFt4sihjYMO/pvUqZ4k+yPxJqkAMG5xM2ww+YBZ0EA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1785736182;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=xCmRkJCRyf2CUjmbH8iN5lsvRRhLvCmRxTq44W96wWU=;
	b=8fwTNYb5zuhtM4++mhSh+dvTNez0gsX+SJANkQs8jBc8cDpXoJ/s3tUXCGER363GRYF3XL
	75y4LsYoO/x5mkDQ==
From: "tip-bot2 for Josh Poimboeuf" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject:
 [tip: objtool/core] objtool/klp: Skip hidden directories when finding objects
Cc: Josh Poimboeuf <jpoimboe@kernel.org>, Ingo Molnar <mingo@kernel.org>,
 live-patching@vger.kernel.org, x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To:
 <6c8eaa9feb17e3811f4ef7733fd7288b7f489183.1785727106.git.jpoimboe@kernel.org>
References:
 <6c8eaa9feb17e3811f4ef7733fd7288b7f489183.1785727106.git.jpoimboe@kernel.org>
Precedence: bulk
X-Mailing-List: live-patching@vger.kernel.org
List-Id: <live-patching.vger.kernel.org>
List-Subscribe: <mailto:live-patching+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:live-patching+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <178573618066.1210945.4032033151463996796.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@kernel.org> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the objtool/core branch of tip:

Commit-ID:     f5f762fc93d0b81d30b815a2f96320909ad10eb3
Gitweb:        https://git.kernel.org/tip/f5f762fc93d0b81d30b815a2f96320909ad=
10eb3
Author:        Josh Poimboeuf <jpoimboe@kernel.org>
AuthorDate:    Sun, 02 Aug 2026 20:24:26 -07:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Mon, 03 Aug 2026 07:12:39 +02:00

objtool/klp: Skip hidden directories when finding objects

klp-build's find_objects() scans the whole tree for vmlinux.o and .ko
files, pruning only klp-tmp/ and .git/.  Development tools can leave
other dot-directories in the tree.  Kernel objects never live under
hidden directories, so prune them all.

Signed-off-by: Josh Poimboeuf <jpoimboe@kernel.org>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Cc: live-patching@vger.kernel.org
Link: https://patch.msgid.link/6c8eaa9feb17e3811f4ef7733fd7288b7f489183.17857=
27106.git.jpoimboe@kernel.org
---
 scripts/livepatch/klp-build | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/scripts/livepatch/klp-build b/scripts/livepatch/klp-build
index c4a7acf..a8c103c 100755
--- a/scripts/livepatch/klp-build
+++ b/scripts/livepatch/klp-build
@@ -575,8 +575,9 @@ find_objects() {
 	local opts=3D("$@")
=20
 	# Find root-level vmlinux.o and non-root-level .ko files,
-	# excluding klp-tmp/ and .git/
-	find "$PWD" \( -path "$TMP_DIR" -o -path "$PWD/.git" -o -regex "$PWD/[^/][^=
/]*\.ko" \) -prune -o \
+	# excluding klp-tmp/ and hidden directories.
+	find "$PWD" -mindepth 1 \
+		    \( -path "$TMP_DIR" -o -name ".*" -o -regex "$PWD/[^/][^/]*\.ko" \) -p=
rune -o \
 		    -type f "${opts[@]}"				\
 		    \( -name "*.ko" -o -path "$PWD/vmlinux.o" \)	\
 		    -printf '%P\n'

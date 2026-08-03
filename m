Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7079E2F90C9;
	Mon,  3 Aug 2026 05:49:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785736193; cv=none; b=O1nT5/jePYmfJ7C4I3qWtgNmZSd9XubXlx653jNmcWaLrMbIizzPW4rT/dBU+xymxrAtOtiq+GOP/FF1YZJJvixyjrmszGaV1pVqQ6jrSrhCyf6jJFg0djm6lGMP6Vw++FEQreJt8ndvPCaticMqYK07wHDCPczjSZCnd8czSU0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785736193; c=relaxed/simple;
	bh=a4l9qbox4Nu27rU1L1JLmPKd6XPyYbo9MOx2NVQVXwQ=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=gkWhZomF1nkwI4Gpnwpc/X+GZw5R6ag0miJ23HeXHohU/0Rmz2jlf5WW86n38kXU+wiNU8bR38OW2bLtp19CsSrfVoHxMuVwdoaVBTnMHK2KYCCp/S55WshICnXNjwlaSS9ndH4on2wrvGDVeeOCFWHBkR2VMj9IpSyGpRF9NSk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=EkNClFdZ; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=zcdfLrhd; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="EkNClFdZ";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="zcdfLrhd"
Date: Mon, 03 Aug 2026 05:49:45 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1785736186;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=4KBcke+7AA1gNsHFTlEqEBMYRnRJ1G3r58t/HZ6NWd8=;
	b=EkNClFdZgUgqun/i5xAzMNEt+iUMvZMGpOCTJlJlptjS/tMwvKXevz7nviHD9p+f8JggQe
	ljxZ+ZZSOu9LOJxWyF64jRgn5C4S+TKkyxlEh1vAhOwWnC0b6Fdyo9Nl32b8kRj5DYrYU4
	U9sn3Z8KqMwSwBdrWRVw7aqD/cZPl4RKE6CwEw4n+RgumxXrhST1f6d7TMRzi8mv6Tyhqk
	wS9QrDO6MaVE0q/KPru8yPFWYW7lcQ0XuK2qmnRTMm3dSijRpu5A0fFcz4dSzfx4NNAwUQ
	/l8RjVySFgBI1av7KDhybe0fdiapL+VxQGi9B9KpmOYOYzhdtvIW6DDQPqxn2A==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1785736186;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=4KBcke+7AA1gNsHFTlEqEBMYRnRJ1G3r58t/HZ6NWd8=;
	b=zcdfLrhd95x0CF+ixqCoJVTHrPHr+RCEU8jN/+FzK8bXms/uCG0tFdDxfSdsgY1P2jBqje
	MSELgLW5/T1+pHBQ==
From: "tip-bot2 for Josh Poimboeuf" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: objtool/core] objtool/klp: Fix module name normalization for
 paths with dots
Cc: Sashiko <sashiko-bot@kernel.org>, Josh Poimboeuf <jpoimboe@kernel.org>,
 Ingo Molnar <mingo@kernel.org>, live-patching@vger.kernel.org, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To:
 <9017b4609553bed16674e8f924d34691cbc2b2c1.1785727106.git.jpoimboe@kernel.org>
References:
 <9017b4609553bed16674e8f924d34691cbc2b2c1.1785727106.git.jpoimboe@kernel.org>
Precedence: bulk
X-Mailing-List: live-patching@vger.kernel.org
List-Id: <live-patching.vger.kernel.org>
List-Subscribe: <mailto:live-patching+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:live-patching+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <178573618517.1210945.6163112616985750312.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@kernel.org> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the objtool/core branch of tip:

Commit-ID:     165affd6f095323d953b0ed5823ec4d0db3b7d0d
Gitweb:        https://git.kernel.org/tip/165affd6f095323d953b0ed5823ec4d0db3=
b7d0d
Author:        Josh Poimboeuf <jpoimboe@kernel.org>
AuthorDate:    Sun, 02 Aug 2026 20:24:23 -07:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Mon, 03 Aug 2026 07:12:38 +02:00

objtool/klp: Fix module name normalization for paths with dots

When .modinfo has no "name=3D" tag, __find_modname() falls back to
converting the object's build-tree path to a runtime module name by
stripping directory components, converting '-' to '_' and truncating the
file extension.

It does all that in a single pass over the entire path, so the first dot
anywhere in the path ends the name.  For an object built in a directory
whose name contains a dot, e.g. "drivers/foo-1.0/bar.o", the result is a
bogus module name.

Strip the directory components up front so only the basename is scanned
for the extension separator.

Fixes: dd590d4d57eb ("objtool/klp: Introduce klp diff subcommand for diffing =
object files")
Reported-by: Sashiko <sashiko-bot@kernel.org>
Signed-off-by: Josh Poimboeuf <jpoimboe@kernel.org>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Cc: live-patching@vger.kernel.org
Link: https://patch.msgid.link/9017b4609553bed16674e8f924d34691cbc2b2c1.17857=
27106.git.jpoimboe@kernel.org
---
 tools/objtool/klp-diff.c | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/tools/objtool/klp-diff.c b/tools/objtool/klp-diff.c
index f8787d7..aeb99d5 100644
--- a/tools/objtool/klp-diff.c
+++ b/tools/objtool/klp-diff.c
@@ -1140,7 +1140,7 @@ static struct export *find_export(struct symbol *sym)
 static const char *__find_modname(struct elfs *e)
 {
 	struct section *sec;
-	char *name;
+	char *name, *slash;
=20
 	sec =3D find_section_by_name(e->orig, ".modinfo");
 	if (!sec) {
@@ -1158,10 +1158,12 @@ static const char *__find_modname(struct elfs *e)
 		return NULL;
 	}
=20
+	slash =3D strrchr(name, '/');
+	if (slash)
+		name =3D slash + 1;
+
 	for (char *c =3D name; *c; c++) {
-		if (*c =3D=3D '/')
-			name =3D c + 1;
-		else if (*c =3D=3D '-')
+		if (*c =3D=3D '-')
 			*c =3D '_';
 		else if (*c =3D=3D '.') {
 			*c =3D '\0';

Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1E193D88E7;
	Thu, 23 Apr 2026 04:04:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776917075; cv=none; b=iaqMT1Gr60mmpd/Gah8lGx8JlWfWMgn466+zoDYK447opw7AoxgGpjcEd/Ti4T1ueusjePWoaFwQo1KSLu5mp8qzyMqivIF8DAWebbORlj4HPe/ea9ynk36wP9Z0heyIb5WuuUMBX1twKwCr/kVcJwuT7tz1eZoFhYkP+US6ARE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776917075; c=relaxed/simple;
	bh=LObtQ0w+WobgTBSWD0xjzwXpJVrz7inT8xZhCcIsA/w=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ULOAyP3cagCyd9byE3QEOIBaoF8kU6DvdNbqqwWseQTGWlsARgiN+Ghm9x4787TiyCbITHy7ipQt1y/XR5HCU5V+avH5o9gUlu0cAcBWPgkccgt++7LiiLWQzqPKcT/VwxHr2rXy0xRProjrayY0b56UKojQhKXaxNxMQFuW1F8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RZFxCeaL; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RZFxCeaL"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 39F0FC2BCB7;
	Thu, 23 Apr 2026 04:04:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776917075;
	bh=LObtQ0w+WobgTBSWD0xjzwXpJVrz7inT8xZhCcIsA/w=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=RZFxCeaLvAuLkpJlvYHeVDUwOIVz+z1S7TrVYT40dVm8nmD+EI0LDX0DGEE2uvOKr
	 ywDeAlP3zFtZvM3N82lUsoSE6NAQXU+FwLoq0Y80NLrQeiWtkFJkskCupk6DazNL+L
	 WzokQqjOsfmTfjsOpxObTGi/0rtHsUBfrZDLwYBpdb8aiZxmw4lTXFv8NY8zrzb97Q
	 GaRqynFn05PI5g9IcezDDmsqCz7Z3tkTMIc0dm0YM6GpTPPa4ZUVO29V5McLzj0UVv
	 wDBIjiqEXTaQivfMLi8yAaZDNmCewKXNYnXtcAvPsWNqGMeMUnruUV3Z5QBUG2qszI
	 iTbZRxMhquwMQ==
From: Josh Poimboeuf <jpoimboe@kernel.org>
To: x86@kernel.org
Cc: linux-kernel@vger.kernel.org,
	live-patching@vger.kernel.org,
	Peter Zijlstra <peterz@infradead.org>,
	Joe Lawrence <joe.lawrence@redhat.com>,
	Song Liu <song@kernel.org>,
	Miroslav Benes <mbenes@suse.cz>,
	Petr Mladek <pmladek@suse.com>
Subject: [PATCH 24/48] klp-build: Reject patches to vDSO
Date: Wed, 22 Apr 2026 21:03:52 -0700
Message-ID: <b3c113988fbc73f0a988c5cc41cd009cb09a4ed3.1776916871.git.jpoimboe@kernel.org>
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

vDSO code runs in userspace and can't be livepatched.  Such patches also
cause spurious "new function" errors due to generated files like
vdso*-image.c having unstable line numbers across builds.

Signed-off-by: Josh Poimboeuf <jpoimboe@kernel.org>
---
 scripts/livepatch/klp-build | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/scripts/livepatch/klp-build b/scripts/livepatch/klp-build
index 60231cf49e5c..deb1723b70de 100755
--- a/scripts/livepatch/klp-build
+++ b/scripts/livepatch/klp-build
@@ -357,7 +357,7 @@ check_unsupported_patches() {
 
 		for file in "${files[@]}"; do
 			case "$file" in
-				lib/*|*.S)
+				lib/*|*/vdso/*|*.S)
 					die "${patch}: unsupported patch to $file"
 					;;
 			esac
-- 
2.53.0


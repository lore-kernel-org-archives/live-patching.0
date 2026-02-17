Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37CF336C0CF
	for <live-patching@vger.kernel.org>; Tue, 17 Feb 2026 16:07:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771344432; cv=none; b=NI2dcLexpgChwCqbm1kf2GhpDVjBQalP9hFBGL24Vjivo4gW/XEyKGA4QSdqR5BP0O0faGHCblvkumaPb96/BrY1vS/LqUJA+zd0DwJcD79q1YA6LXxAu6Qfop2n3Hv7LeZ8UpX51TLVTXrRkIEqONHaKsr+3nGcpSXX/x51DvA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771344432; c=relaxed/simple;
	bh=0RJtU4p63k4kRrcRRRAgQnF/ZpVzv9IvcfjduFy8ai4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-type; b=KOWtqzzyl8azg0jfSHrF1faDRMVE6Ph7TWvLu+rwKp85vkyz6INEkTbfVrH1T/AvAcAKxnH0nmClhSv+aFXl1oBQ18GsKJ4kRVslLq4e+CEke5D+ESogI9YgVk5eatgK/z9NOXJziZJv8TUNY8S4/Ce/2G8GkvYs0F92THfwSUk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=R+j0knWJ; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="R+j0knWJ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1771344430;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=e5VCdXtUlvIBgTcv7wMBUvwohWkwzMzNhk5IZs4fcd8=;
	b=R+j0knWJZEJNAk+Sw8wovP93KE1XuWEuYysoK7NztJ0CWDjST5rmNeB2w5//3d08nO4Y8T
	lr1aaBCI7Oak/Rim9RAD46DfOTE8T+tkBwdZcwrdKnvcNMJCowKFtNR+a7X9NzaWF048Uk
	917P1+Bwox3kqoGr3fUmNfKCKGwvCcU=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-352-AO9sUMz9NVGLMFFK11xQoQ-1; Tue,
 17 Feb 2026 11:07:08 -0500
X-MC-Unique: AO9sUMz9NVGLMFFK11xQoQ-1
X-Mimecast-MFC-AGG-ID: AO9sUMz9NVGLMFFK11xQoQ_1771344427
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 834F6195605C;
	Tue, 17 Feb 2026 16:07:07 +0000 (UTC)
Received: from jolawren-thinkpadp1gen7.ibmlowe.csb (unknown [10.22.80.197])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 3380030001A5;
	Tue, 17 Feb 2026 16:07:06 +0000 (UTC)
From: Joe Lawrence <joe.lawrence@redhat.com>
To: live-patching@vger.kernel.org
Cc: Josh Poimboeuf <jpoimboe@kernel.org>,
	Song Liu <song@kernel.org>,
	Jiri Kosina <jikos@kernel.org>,
	Miroslav Benes <mbenes@suse.cz>,
	Petr Mladek <pmladek@suse.com>
Subject: [PATCH v3 11/13] livepatch/klp-build: add terminal color output
Date: Tue, 17 Feb 2026 11:06:42 -0500
Message-ID: <20260217160645.3434685-12-joe.lawrence@redhat.com>
In-Reply-To: <20260217160645.3434685-1-joe.lawrence@redhat.com>
References: <20260217160645.3434685-1-joe.lawrence@redhat.com>
Precedence: bulk
X-Mailing-List: live-patching@vger.kernel.org
List-Id: <live-patching.vger.kernel.org>
List-Subscribe: <mailto:live-patching+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:live-patching+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-type: text/plain
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4

Improve the readability of klp-build output by implementing a basic
color scheme.  When the standard output and error are connected to a
terminal, highlight status messages in bold, warnings in yellow, and
errors in red.

Signed-off-by: Joe Lawrence <joe.lawrence@redhat.com>
---
 scripts/livepatch/klp-build | 15 ++++++++++++---
 1 file changed, 12 insertions(+), 3 deletions(-)

diff --git a/scripts/livepatch/klp-build b/scripts/livepatch/klp-build
index 80703ec4d775..fd104ace29e6 100755
--- a/scripts/livepatch/klp-build
+++ b/scripts/livepatch/klp-build
@@ -52,6 +52,15 @@ PATCH_TMP_DIR="$TMP_DIR/tmp"
 
 KLP_DIFF_LOG="$DIFF_DIR/diff.log"
 
+# Terminal output colors
+read -r COLOR_RESET COLOR_BOLD COLOR_ERROR COLOR_WARN <<< ""
+if [[ -t 1 && -t 2 ]]; then
+	COLOR_RESET="\033[0m"
+	COLOR_BOLD="\033[1m"
+	COLOR_ERROR="\033[0;31m"
+	COLOR_WARN="\033[0;33m"
+fi
+
 grep0() {
 	# shellcheck disable=SC2317
 	command grep "$@" || true
@@ -65,15 +74,15 @@ grep() {
 }
 
 status() {
-	echo "$*"
+	echo -e "${COLOR_BOLD}$*${COLOR_RESET}"
 }
 
 warn() {
-	echo "error: $SCRIPT: $*" >&2
+	echo -e "${COLOR_WARN}warn${COLOR_RESET}: $SCRIPT: $*" >&2
 }
 
 die() {
-	warn "$@"
+	echo -e "${COLOR_ERROR}error${COLOR_RESET}: $SCRIPT: $*" >&2
 	exit 1
 }
 
-- 
2.53.0


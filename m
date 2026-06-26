Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74F283BFACC
	for <live-patching@vger.kernel.org>; Fri, 26 Jun 2026 21:21:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782508913; cv=none; b=j77HSLBt5rsD7V1bLTxIacyd/kKtrJFV1QZ+/klh0J9V14E9/dQsHth12OX7bXTTXVBQ6ayhR9zognrHjxg3FtLJ+xRAQqfPoKfLpx9vjyrHLMDTtJ05GoMES2IxuEDDucTLA1LzVCrvuxbGxKHb42+X0oGW0G24/VtVuO5MV34=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782508913; c=relaxed/simple;
	bh=IQ+YlRTkhOtS5j7y3KCmiif4l9ioHYIvTflD4F3rLlE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-type; b=eEFg4piBIgYBFoyjXSyWfnEjAv47HHAHDIkcAoNcKuu6QZVPLhx+xaCgzOlO0ipqNEHPA5GZJjcp3UciuUO6b2ktraSOLEMaP2JjvgePIdDXu23E9iijMnSf0z2/BpFX+Bxn+1loordiZPlCDTYYAPtuoaBG1ChNIL25B9Fy3fs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=bqwKhIkN; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="bqwKhIkN"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1782508908;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=LrTWomlBk7S9jw5Ip9X2ez9NPEgRX+ioaewKXBGxPnM=;
	b=bqwKhIkN699yHsr4oD9leBb8mQ+erOqU5fiVvMmTp6kj0owN9fj3QdjyZ1ti/sf0x5HGAh
	l0Vzz7po/ijgI88wcV+RZeFPqxleiR2lXSICcXuN3peR3Pa7neV/u3/j4U8HJroX2vKOT3
	4wfZ2OvZbjvhWx45upc6d+xWKS13cYg=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-444-OAJViUvuOu-mBthn0kTrYg-1; Fri,
 26 Jun 2026 17:21:45 -0400
X-MC-Unique: OAJViUvuOu-mBthn0kTrYg-1
X-Mimecast-MFC-AGG-ID: OAJViUvuOu-mBthn0kTrYg_1782508904
Received: from mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.95])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 6FF481954AF7;
	Fri, 26 Jun 2026 21:21:44 +0000 (UTC)
Received: from jolawren-thinkpadp1gen7.ibmlowe.csb (unknown [10.22.80.46])
	by mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id AA382364CC;
	Fri, 26 Jun 2026 21:21:43 +0000 (UTC)
From: Joe Lawrence <joe.lawrence@redhat.com>
To: linux-perf-users@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	live-patching@vger.kernel.org
Cc: Petr Mladek <pmladek@suse.com>
Subject: [PATCH v2 2/2] perf symbols: skip livepatch symbols in kcore_copy kallsyms processing
Date: Fri, 26 Jun 2026 17:21:40 -0400
Message-ID: <20260626212140.1380094-3-joe.lawrence@redhat.com>
In-Reply-To: <20260626212140.1380094-1-joe.lawrence@redhat.com>
References: <20260626212140.1380094-1-joe.lawrence@redhat.com>
Precedence: bulk
X-Mailing-List: live-patching@vger.kernel.org
List-Id: <live-patching.vger.kernel.org>
List-Subscribe: <mailto:live-patching+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:live-patching+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-type: text/plain
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.6 on 10.30.177.95

Livepatch symbols (.klp.sym.*) carry a [module] tag but resolve to core
kernel text addresses.  When kcore_copy__process_kallsyms() encounters
these symbols, they are treated as module symbols, pulling the
first_module_symbol down to a kernel text address.

This corrupts the module memory range used to build the kcore PT_LOAD
segments.  For example, with a kpatch module containing a
".klp.sym.vmlinux.arch_release_task_struct,0" livepatch symbol loaded:

  kernel symbols
    ...
    ffffffffb4a41120  arch_release_task_struct
    ...                 ^
    ...                 | aliased by .klp.sym
    ...                 | drags first_module_symbol here
                        |
    (43M gap)           | bloated kcore segment
                        |
  module symbols        |
    ffffffffc047b000  <-- correct first_module_symbol
    ...
    ...

This causes the module PT_LOAD segment to start at the .klp.sym address
and not the real first module address, bloating the kcore copy:

  Baseline (no livepatch):   VirtAddr ffffffffc047b000, 8.5M
  Bloated  (with livepatch): VirtAddr ffffffffb4a41000, 54M
  Post-fix (with livepatch): VirtAddr ffffffffc047b000, 8.9M

Filter livepatch symbols early in kcore_copy__process_kallsyms() before
they can affect module boundary tracking.

Reported-by: Sashiko <sashiko-bot@kernel.org>
Link: https://sashiko.dev/#/patchset/20260624201254.472576-1-joe.lawrence@redhat.com?part=1
Signed-off-by: Joe Lawrence <joe.lawrence@redhat.com>
---
 tools/perf/util/symbol-elf.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/tools/perf/util/symbol-elf.c b/tools/perf/util/symbol-elf.c
index 39562bdec8b9..f6f6b54da131 100644
--- a/tools/perf/util/symbol-elf.c
+++ b/tools/perf/util/symbol-elf.c
@@ -2216,6 +2216,10 @@ static int kcore_copy__process_kallsyms(void *arg, const char *name, char type,
 	if (!kallsyms__is_function(type))
 		return 0;
 
+	/* Ignore livepatch symbols */
+	if (is_livepatch_symbol(name))
+		return 0;
+
 	if (strchr(name, '[')) {
 		if (!kci->first_module_symbol || start < kci->first_module_symbol)
 			kci->first_module_symbol = start;
-- 
2.54.0


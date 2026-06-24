Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BE9E3A1DB
	for <live-patching@vger.kernel.org>; Wed, 24 Jun 2026 20:13:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782331984; cv=none; b=k8KEcrCdBtvjhSs3m/fhxW54SY10DwsVQ3dW67LnLjvwuwlWb+4kjGDEtr6l8o4XyYiiEG+XI0gCVzO6SCYEgZD6Zejv/emnYX40eXjjdBQBZOfeGoUkL2bARSkxe6x0CS1eRTKOm6yOarJZLgRdlWlxyFYKk7dbUi7UKbzYs94=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782331984; c=relaxed/simple;
	bh=YY1C5v75W3mnHcnXZ+5t8u6QmuYSf91omqmWfC6cA0o=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-type; b=QIPMdADpx4FQCYP13IkWHNPJo64zM1mKb1HFpLzTpf9WgFn25VsAaHapIPC5joF6iMNDWcPFSouym5I+Ms7xGj+QOAyfqC7DeRVjN0I3jYu1xTdX1rDH732Lcu5wcrMPm43nRpiEHaN+iRujqX7Av70tW+77Nj8RVPv9SQytPTU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Sc0zcAS3; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Sc0zcAS3"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1782331982;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=W0GXuJv5UDxvc9Rlg8693/s/vmTKfkYVUYav87nVFDc=;
	b=Sc0zcAS32sL9arZy8IkQ4NVOhxiqJTHo4lJ/ILONsF+7de3LLVlIX3phomSeSq3GH88wnz
	qB7Swc0HheGiRtLzBISOJzK+0PEo9b5BlEY++GmUB0GTeJuLBRFKBiPLumF/KAa+v1VBon
	LHar2xHLHV8aiEMFwAagsOOx/HMPf18=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-8-cEqbm0HuNk-sscslkSV8cw-1; Wed,
 24 Jun 2026 16:13:00 -0400
X-MC-Unique: cEqbm0HuNk-sscslkSV8cw-1
X-Mimecast-MFC-AGG-ID: cEqbm0HuNk-sscslkSV8cw_1782331979
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 471631955E91;
	Wed, 24 Jun 2026 20:12:59 +0000 (UTC)
Received: from jolawren-thinkpadp1gen7.ibmlowe.csb (unknown [10.22.80.46])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 713C730002DD;
	Wed, 24 Jun 2026 20:12:58 +0000 (UTC)
From: Joe Lawrence <joe.lawrence@redhat.com>
To: linux-perf-users@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	live-patching@vger.kernel.org
Subject: [PATCH] perf symbols: ignore livepatch symbols
Date: Wed, 24 Jun 2026 16:12:54 -0400
Message-ID: <20260624201254.472576-1-joe.lawrence@redhat.com>
Precedence: bulk
X-Mailing-List: live-patching@vger.kernel.org
List-Id: <live-patching.vger.kernel.org>
List-Subscribe: <mailto:live-patching+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:live-patching+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-type: text/plain
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4

Livepatch modules contain special symbols (prefixed by ".klp.sym.") that
act as relocation placeholders.  Once resolved, they point to the same
addresses as the original kernel symbols they reference. [1]

These special symbols confuse the 'vmlinux symtab matches kallsyms' perf
test as kallsyms may report multiple symbols sharing a single kernel
address.  For example:

  kallsyms (without livepatch)
  ----------------------------
  ffffffff81a41110 T __pfx_arch_release_task_struct
> ffffffff81a41120 T arch_release_task_struct
  ffffffff81a41140 T __pfx_exit_thread
  ffffffff81a41150 T exit_thread

  kallsyms (with livepatch loaded)
  ---------------------------------
  ffffffff81a41110 T __pfx_arch_release_task_struct
> ffffffff81a41120 T arch_release_task_struct
  ffffffff81a41140 T __pfx_exit_thread
  ffffffff81a41150 T exit_thread
> ffffffff81a41120 w .klp.sym.vmlinux.arch_release_task_struct,0  [kpatch_5_14_0_570_94_1_1_3]

When perf loads kallsyms, both symbols are inserted into the
symbol table at the same address, corrupting symbol end-address
calculations and causing test failures.

Filter out symbols prefixed with ".klp.sym." when loading kallsyms, as
they alias existing kernel symbols.

Link: https://docs.kernel.org/livepatch/module-elf-format.html#livepatch-symbols [1]
Reported-and-tested-by: Ben Procknow <bprockno@redhat.com>
Signed-off-by: Joe Lawrence <joe.lawrence@redhat.com>
---
 tools/perf/util/symbol.c | 4 ++++
 1 file changed, 4 insertions(+)

From Ben's tests:

  Without patch:
  ./tools/perf/perf test 1
   1: vmlinux symtab matches kallsyms                                 : FAILED!

  With patch:
  ./tools/perf/perf test 1
   1: vmlinux symtab matches kallsyms                                 : Ok

diff --git a/tools/perf/util/symbol.c b/tools/perf/util/symbol.c
index fcaeeddbbb6b..eeaed3f5cf50 100644
--- a/tools/perf/util/symbol.c
+++ b/tools/perf/util/symbol.c
@@ -774,6 +774,10 @@ static int map__process_kallsym_symbol(void *arg, const char *name,
 	if (name[0] == '$')
 		return 0;
 
+	/* Ignore livepatch symbols */
+	if (strstarts(name, ".klp.sym."))
+		return 0;
+
 	/*
 	 * module symbols are not sorted so we add all
 	 * symbols, setting length to 0, and rely on
-- 
2.54.0


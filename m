Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A61D53BFE33
	for <live-patching@vger.kernel.org>; Fri, 26 Jun 2026 21:21:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782508914; cv=none; b=LDY3Ya+W7+j55AwQ4y2Vl+z5tD3CsXDfGlkNH5VpoRy34jvzAiGoRAjjJ/5hYoGdjfzU6lzTO3NvWfov2UsvRhES1Qw0YXavU8vapLCPnqtTCNWp/aGYU2F4bQ4s7yG9/WvIGJtoaq051ph2jd51aRacFbeH6hc2SversThqXxs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782508914; c=relaxed/simple;
	bh=6GVTC47qlV1pQumjALukweWv4s/9l+o+NFaGVbsi4M0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-type; b=uooCq4KRR9iknUxmLf1wkYQ/2RgJmL6Kkc20H+6DQi7TFc87l4+6kv9qQdQot2s7HwnyCdcjdWHDRQ2g2ib/XKnTlfK0HUSDU41h40ILFCwceeJUo6AoI0OgZ0HFsne8rplppvruJ0EF0IvH1vr4twfh8vmF6RYJFl+6V7/Y6zk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=f7fl6MTM; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="f7fl6MTM"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1782508908;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=q3NBEytlStUojtnwwOhPBFn4LsuQQbV+BpKsigqLdc0=;
	b=f7fl6MTMfjfvWtYGfRkpvVp4GQ+3ZYo+WVMChgp+RPN4RRWrNYv7uSn8Fl4C/Gluox3Gjk
	XAqM19NyckclthIZc4qCjhQ1/UIu1BtWn6sNAXajberRrzpOS8+R4P4Dk3G7AWNJ9G0dxO
	MULYbAOMXCbIyqFb4SIR+75HQSOPrqw=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-139-bJzWEoOdMKG_YfANMYEk-w-1; Fri,
 26 Jun 2026 17:21:43 -0400
X-MC-Unique: bJzWEoOdMKG_YfANMYEk-w-1
X-Mimecast-MFC-AGG-ID: bJzWEoOdMKG_YfANMYEk-w_1782508902
Received: from mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.95])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 8F1D518003FC;
	Fri, 26 Jun 2026 21:21:42 +0000 (UTC)
Received: from jolawren-thinkpadp1gen7.ibmlowe.csb (unknown [10.22.80.46])
	by mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 9C5B21774;
	Fri, 26 Jun 2026 21:21:41 +0000 (UTC)
From: Joe Lawrence <joe.lawrence@redhat.com>
To: linux-perf-users@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	live-patching@vger.kernel.org
Cc: Petr Mladek <pmladek@suse.com>
Subject: [PATCH v2 0/2] perf symbols: skip livepatch symbols
Date: Fri, 26 Jun 2026 17:21:38 -0400
Message-ID: <20260626212140.1380094-1-joe.lawrence@redhat.com>
Precedence: bulk
X-Mailing-List: live-patching@vger.kernel.org
List-Id: <live-patching.vger.kernel.org>
List-Subscribe: <mailto:live-patching+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:live-patching+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-type: text/plain
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.6 on 10.30.177.95

This patchset fixes two minor perf bugs when livepatches containing
special so-called livepatch symbols are loaded.  In both cases, perf
should ignore these symbols as they resolve as relocations to kernel
addresses and not module space.

- Patch 1 fixes `perf test 1`
- Patch 2 fixes `perf record --kcore` bloat


Testing notes
=============

("perf symbols: skip livepatch symbols when loading kallsyms"):

  Without patch:
  ./tools/perf/perf test 1
    1: vmlinux symtab matches kallsyms                     : FAILED!

  With patch:
  ./tools/perf/perf test 1
    1: vmlinux symtab matches kallsyms                     : Ok

("perf symbols: skip livepatch symbols in kcore_copy")

  1. Baseline = pre-patch perf, no livepatch
  ------------------------------------------
  
  $ ./tools/perf/perf record --kcore -a -o /tmp/baseline.data -- sleep 1
  [ perf record: Woken up 1 times to write data ]
  [ perf record: Captured and wrote 0.221 MB /tmp/baseline.data (1717 samples) ]
  
  $ tree --noreport -h /tmp/baseline.data
  /tmp/baseline.data
  |-- [ 235K]  data
  `-- [   50]  kcore_dir
      |-- [  11M]  kallsyms
      |-- [  25M]  kcore
      `-- [ 1.7K]  modules
  
  
  2. Bloated kcore = pre-patch perf, with livepatch
  -------------------------------------------------
  
  $ insmod kpatch-5_14_0-570_94_1-1-3.ko
  $ ./tools/perf/perf record --kcore -a -o /tmp/klp-bloated.data -- sleep 1
  [ perf record: Woken up 1 times to write data ]
  [ perf record: Captured and wrote 0.274 MB /tmp/klp-bloated.data (2757 samples) ]
  
  $ tree --noreport  -h /tmp/klp-bloated.data
  /tmp/klp-bloated.data
  |-- [ 288K]  data
  `-- [   50]  kcore_dir
      |-- [  11M]  kallsyms
      |-- [  68M]  kcore
      `-- [ 1.8K]  modules
  
  
  3. Post-fix = patched perf, with livepatch
  ------------------------------------------
  
  [ kpatch-5_14_0-570_94_1-1-3.ko still loaded from test (2) ]
  
  $ ./tools/perf/perf record --kcore -a -o /tmp/postfix.data -- sleep 1
  [ perf record: Woken up 1 times to write data ]
  [ perf record: Captured and wrote 0.274 MB /tmp/postfix.data (2763 samples) ]
  
  $ tree --noreport -h /tmp/postfix.data
  /tmp/postfix.data
  |-- [ 289K]  data
  `-- [   50]  kcore_dir
      |-- [  11M]  kallsyms
      |-- [  25M]  kcore
      `-- [ 1.8K]  modules

Changes
=======

v2:
- Move klp symbol check into tools/perf/util/symbol.h alongside similar
  is_ignored_kernel_symbol() check [Petr]
- Use KLP_SYM_PREFIX instead of inlining it [Petr]
- Add similar check to kcore_copy__process_kallsyms() [Sashiko]

- Note: Sashiko flagged a pre-existing off-by-one in kallsyms__parse()
  where the symbol-name loop could write past symbol_name[] on overlong
  entries. That issue is unrelated to livepatch symbols and was already
  fixed by Rui Qi's 68018df3f55e ("perf: Fix off-by-one stack buffer
  overflow in kallsyms__parse()").

v1: https://lore.kernel.org/linux-perf-users/ajzwjNncrI3Bob_o@pathway.suse.cz/T/#t

Joe Lawrence (2):
  perf symbols: skip livepatch symbols when loading kallsyms
  perf symbols: skip livepatch symbols in kcore_copy kallsyms processing

 tools/perf/util/symbol-elf.c |  4 ++++
 tools/perf/util/symbol.c     |  4 ++--
 tools/perf/util/symbol.h     | 12 ++++++++++++
 3 files changed, 18 insertions(+), 2 deletions(-)

-- 
2.54.0


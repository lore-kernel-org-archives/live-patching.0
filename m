Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FA163B440E
	for <live-patching@vger.kernel.org>; Wed, 26 Aug 2026 19:50:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787773819; cv=none; b=eWK6rrgCHcbUEEt/onXmeW8GhZOOCTmgNlCdiPifNCOLFCqzxJsl3Meyi5cJ9JyYGvmn/n5LYonqBU8+41ITK0GEZEctoe2zIviUoboo+o4IDRDRRhs5e4+lucRNcec6g2AXDDQp/HnsXxTETLO2kkjCmhl4lfL22cu6jqzkC5I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787773819; c=relaxed/simple;
	bh=Zr17BLBytyCMtTnik7Sa/+RuCVVxUHe6LH7VhiZgjyg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-type; b=JV9XsHhWRsbJVpLmtTOViMhaUoVa2M89jBtw2c2V28XFzWZUPxLuQlDtuf/3nl2izlt6Iq2RnSMgLl1a1CPPz/trgq5X7ujhX9VkvdwkllI5tmXf0+zKza4Xae03aVT9liwL0me4E6OFUwnudlkMjeSFoGwPSYnI8XecrlPD+RE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=RAc6VKKK; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="RAc6VKKK"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1787773807;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=x2Hq/QWQbpG4At735XAGNoEzPTRIYGWehGLFJ20cxQc=;
	b=RAc6VKKKvCA7IH4mlgabAXa5kmfR+YdRqEeB8jOWXOpj0OFLFU+5KqMyncbBZYgK7JLNjK
	0IgVhazYGCA1dO65xDfJa4r/bPaeArDBW8BYT9gDgGFRlbc+9fOj5XtqTNitMwEz+y7Ue5
	IUui/7BXnBlPzecg1tyTq7RUNUkUKWA=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-683-d2LdWybgNnmQho4M8HMGUA-1; Wed,
 26 Aug 2026 15:50:04 -0400
X-MC-Unique: d2LdWybgNnmQho4M8HMGUA-1
X-Mimecast-MFC-AGG-ID: d2LdWybgNnmQho4M8HMGUA_1787773803
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 21AF71844064;
	Wed, 26 Aug 2026 19:50:03 +0000 (UTC)
Received: from jolawren-thinkpadp1gen7.redhat.corp (headnet05.pony-001.prod.iad2.dc.redhat.com [10.2.32.117])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id E557E3000239;
	Wed, 26 Aug 2026 19:50:01 +0000 (UTC)
From: Joe Lawrence <joe.lawrence@redhat.com>
To: live-patching@vger.kernel.org
Cc: Josh Poimboeuf <jpoimboe@kernel.org>,
	Song Liu <song@kernel.org>,
	Miroslav Benes <mbenes@suse.cz>,
	Petr Mladek <pmladek@suse.com>,
	Yafang Shao <laoar.shao@gmail.com>
Subject: [RFC PATCH v2 0/7] klp-build: OOT module support
Date: Wed, 26 Aug 2026 15:49:53 -0400
Message-ID: <20260826195000.455905-1-joe.lawrence@redhat.com>
Precedence: bulk
X-Mailing-List: live-patching@vger.kernel.org
List-Id: <live-patching.vger.kernel.org>
List-Subscribe: <mailto:live-patching+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:live-patching+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-type: text/plain
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4

This is RFCv2 of out-of-tree (OOT) module support for klp-build,
expanding on the original 4-patch series.  VERY lightly tested and coded
and most likely dangerous.  I'm posting to get feedback on the approach.
Brace for impact, Sashiko.


Motivation
----------

The initial RFC was motivated by stable, repeatable testing of 'objtool
klp diff'.  Standard in-tree drivers undergo frequent refactoring and
API churn, making them unreliable for producing consistent binary
patterns.  Smaller, targeted OOT test modules provide a stable baseline
for faster iteration before committing to an in-tree test case.

Feedback on v1 highlighted several production use cases for OOT in
general:

- Yafang Shao noted a real-world attempt to livepatch an OOT Mellanox
  driver in production that failed due to complex build dependencies.

- Song Liu noted that livepatching OOT modules in production is also a
  real use case at Meta, and that making it easy would likely see
  regular use.

- Song also observed (offlist) that the livepatch replace-set series
  would benefit from OOT support: replace-sets allow vendor and customer
  livepatches to coexist, where vendors patch the core kernel/distro
  modules while customers patch third-party, OOT drivers.

This feedback drove the addition of the "advanced" --orig-dir /
--patched-dir workflow (patches 6-7) for OOT drivers whose build systems
cannot be driven easily via `make M=`.


Series overview
---------------

Patches 1-4 are objtool prerequisites:
1 - Simplify read_exports() error handling (addresses Sashiko review)
2 - Add --symvers option to klp diff for custom Module.symvers paths
3 - Allow special section entry size overrides (allows tests to use
    objtool for cross-target/config processing)
4 - Embed target architecture in usage string (helps tests verify
    cross-target objtool)

Patch 5 provides baseline OOT capability:
5 - Add --oot-dir for simple modules built via 'make M=...'

At this point (patches 1-5), in-tree test and repro modules would be
supported via simple OOT dir builds.

Patches 6-7 extend OOT support for complex, real-world drivers:
6 - Add --orig-dir/--patched-dir for user-supplied pre-built objects
7 - Validate user-supplied objects (compiler match, -ffunction-sections)

The advanced workflow (patches 6-7) delegates the build process entirely
to the user, requiring only that objects are compiled with
-ffunction-sections and -fdata-sections.  klp-build then performs binary
comparison, symbol extraction, and livepatch assembly as usual.

As noted in the commit messages, output correctness depends directly on
the consistency of the inputs.  This is a HUGE footgun-rich space, but
provides flexibility for non-standard vendor build systems.


Changes
-------

RFC -> RFCv2
- Added read_exports() cleanup patch [Sashiko]
- Added pre-built object support for advanced OOT workflows [Song, Yafang]

RFC: https://lore.kernel.org/live-patching/20260512221102.2720763-1-joe.lawrence@redhat.com/

Joe Lawrence (7):
  objtool/klp: simplify read_exports file handling
  objtool/klp: add --symvers option to klp diff
  objtool/klp: allow special section entry size overrides
  objtool: add target architecture to usage
  livepatch/klp-build: add basic out-of-tree module support
  livepatch/klp-build: add pre-built object support for advanced OOT
    workflows
  livepatch/klp-build: add validation for user-supplied OOT objects

 scripts/livepatch/klp-build   | 229 ++++++++++++++++++++++++++++++----
 tools/objtool/Makefile        |   3 +-
 tools/objtool/builtin-check.c |   3 +-
 tools/objtool/klp-diff.c      |  68 ++++++++--
 4 files changed, 263 insertions(+), 40 deletions(-)


base-commit: d8a2860b4a366bfa8acb3d64da2c546ea26d2091
-- 
2.55.0


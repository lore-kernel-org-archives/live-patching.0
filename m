Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B6FC13777E
	for <live-patching@vger.kernel.org>; Tue, 16 Jun 2026 20:25:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781641544; cv=none; b=cxpUPYI2rWd323VWeBmC/kPf4WlOzBU8mmEMCHEBR+Rmtc9bQjgUDwBRYr/SHBwNKuEOsyg78DASZdBHswWx3IowlAO7Umv3KGFeDI66V5GoZZLEfZiDqL1auuARfB4XQZ949nRo9SGOiX6Z1m6+p9RNqVSHN5B4ACQWR+dieko=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781641544; c=relaxed/simple;
	bh=zDNK5ZqQMYrZXp6ABMRYkVEkb3b7i7li8MPklziaLJc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mS5VhM51IfUTYDqLgk2NYQLdTeR0TKyac7FFY05jhZGo/hXb0FBgitzbKZ7BTpHS3g4l7D1Wo7V6HqppNlYlbvDy2AGNj75A3PBI0CMbMHIrRxuZs7j0p4M8fjrBsXMam+8iCAFlLAlkeoT834Fg6cEvN4+2xWsAznQjYV643xo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=VodroHdh; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="VodroHdh"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1781641542;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=6JjfP5ZkD7ap+fAfiV1Q23yVpJnnVyn2SWS3KHehySU=;
	b=VodroHdhKCWM6c0ADDTiwerDqMPCZNDuYRzAlsne7pF/pi+z3E04ZAQohciMXnQErmkrQF
	wWmC39/tycL0GWflD3kgJQGrtDK2ABOzIKUUKXujDegTIySqz/B602OneNQdSirmUAlApI
	zBgY1p7ykQAbUVB13kJgNTwfasdE2tw=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-496-afh6__HHMweu_5TQ5TdnDQ-1; Tue,
 16 Jun 2026 16:25:36 -0400
X-MC-Unique: afh6__HHMweu_5TQ5TdnDQ-1
X-Mimecast-MFC-AGG-ID: afh6__HHMweu_5TQ5TdnDQ_1781641535
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 33EED180034A;
	Tue, 16 Jun 2026 20:25:35 +0000 (UTC)
Received: from redhat.com (unknown [10.22.81.115])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id A4B56180056E;
	Tue, 16 Jun 2026 20:25:33 +0000 (UTC)
Date: Tue, 16 Jun 2026 16:25:31 -0400
From: Joe Lawrence <joe.lawrence@redhat.com>
To: Yafang Shao <laoar.shao@gmail.com>
Cc: jpoimboe@kernel.org, jikos@kernel.org, mbenes@suse.cz, pmladek@suse.com,
	song@kernel.org, live-patching@vger.kernel.org
Subject: Re: [PATCH v3 0/7] livepatch: Introduce replace set support
Message-ID: <ajGxOwpnyjBrRQzP@redhat.com>
References: <20260607131659.29281-1-laoar.shao@gmail.com>
Precedence: bulk
X-Mailing-List: live-patching@vger.kernel.org
List-Id: <live-patching.vger.kernel.org>
List-Subscribe: <mailto:live-patching+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:live-patching+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260607131659.29281-1-laoar.shao@gmail.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93

On Sun, Jun 07, 2026 at 09:16:52PM +0800, Yafang Shao wrote:
> We previously proposed a BPF+livepatch method to enable rapid
> experimentation with new kernel features without interrupting production
> workloads:
> 
>   https://lore.kernel.org/live-patching/20260402092607.96430-1-laoar.shao@gmail.com/
> 
> In the resulting discussion, Song and Petr suggested adding a "replace set"
> to support scenarios where specific livepatches can be selectively replaced
> or skipped.
> 
> This patch introduces 'replace_set' to provide finer-grained control over
> livepatch management. The core rules and behaviors of a replace_set are
> defined as follows:
> - Livepatches sharing the same replace_set can mutually replace each
>   other.
> - Only one livepatch within a given replace_set can be active at a time.
> - Livepatches belonging to different replace_sets can coexist on the
>   system.
> - Livepatches in different replace_sets are prohibited from modifying the
>   same function.
> - Livepatches in different replace_sets cannot use the same state ID.
> 
> Additionally, this design deprecates the traditional non-atomic-replace
> model. Previously, setting 'replace' to 0 was the only way to keep
> certain livepatches persistent on the system, forcing developers to
> disable atomic replacement entirely. With the introduction of replace_set,
> developers now have a selective option to keep specific livepatches
> persistent while maintaining atomic replacement capabilities elsewhere.
> 
> At present, KLP state, shadow variables, and callbacks are not integrated
> with the new replace_set mechanism in this patchset. Support for these
> features is deferred until Petr's klp-state-transfer infrastructure is
> completed and merged:
> 
>   https://github.com/pmladek/linux/tree/klp-state-transfer-v1-iter12
> 
> v2->v3:
> - Address the feedback from Sachiko AI
>  - Fix the pre-existing NULL pointer dereference issue
>  - Move klp_find_func into core.h
>  - Don't deprecate stack_order completely
> 
> v2: https://lore.kernel.org/live-patching/20260529034542.68766-1-laoar.shao@gmail.com/
> 
> v1->v2:
> - Incorporate feedback from Petr:
>   - Initialize replace_set to 0 by default
>   - Improve documentation
>   - Enforce that livepatches in different replace_sets cannot use the same
>     state->id.
>   - Enforce that livepatches in different replace_sets cannot modify the
>     same function.
>   - Ensure consistent capitalization and naming usage of KLP_REPLACE_SET.
> - Incorporate feedback from Sachiko AI:
>   - Skip the klp_transition patch during klp_force_transition().
> 
> v1 (RFC): https://lore.kernel.org/live-patching/20260513143321.26185-1-laoar.shao@gmail.com/
> 
> Yafang Shao (7):
>   livepatch: Fix NULL pointer dereference in klp_find_func()
>   livepatch: Move klp_find_func() into core.h
>   livepatch: Support scoped atomic replace using replace_set
>   livepatch: Deprecate stack_order
>   selftests/livepatch: Update tests for replace_set
>   selftests/livepatch: Add test for state ID conflict across
>     replace_sets
>   selftests/livepatch: Add test for function conflict across
>     replace_sets
> 
>  .../ABI/removed/sysfs-kernel-livepatch        |   9 +
>  .../ABI/testing/sysfs-kernel-livepatch        |  14 +-
>  .../livepatch/cumulative-patches.rst          |  23 ++-
>  Documentation/livepatch/livepatch.rst         |  21 ++-
>  include/linux/livepatch.h                     |   5 +-
>  kernel/livepatch/core.c                       |  65 ++-----
>  kernel/livepatch/core.h                       |  21 +++
>  kernel/livepatch/state.c                      |  51 ++++--
>  kernel/livepatch/transition.c                 |  11 +-
>  scripts/livepatch/init.c                      |   6 +-
>  scripts/livepatch/klp-build                   |  16 +-
>  .../selftests/livepatch/test-callbacks.sh     |  33 ++--
>  .../selftests/livepatch/test-livepatch.sh     | 159 +++++++----------
>  .../testing/selftests/livepatch/test-state.sh |  34 ++++
>  .../testing/selftests/livepatch/test-sysfs.sh |  91 ++--------
>  .../selftests/livepatch/test_modules/Makefile |   2 +
>  .../test_modules/test_klp_atomic_replace.c    |  10 +-
>  .../test_modules/test_klp_atomic_replace2.c   |  55 ++++++
>  .../test_modules/test_klp_callbacks_demo.c    |   6 +
>  .../test_modules/test_klp_callbacks_demo2.c   |  10 +-
>  .../test_modules/test_klp_livepatch.c         |   6 +
>  .../livepatch/test_modules/test_klp_state.c   |   4 +-
>  .../livepatch/test_modules/test_klp_state2.c  |   4 +-
>  .../livepatch/test_modules/test_klp_state4.c  | 163 ++++++++++++++++++
>  24 files changed, 507 insertions(+), 312 deletions(-)
>  create mode 100644 Documentation/ABI/removed/sysfs-kernel-livepatch
>  create mode 100644 tools/testing/selftests/livepatch/test_modules/test_klp_atomic_replace2.c
>  create mode 100644 tools/testing/selftests/livepatch/test_modules/test_klp_state4.c
> 
> -- 
> 2.52.0
> 

Hi Yafang,

Thanks for implementing this.  Supporting both replace and non-replace
style patches has always been a headache for me when reading through the
code, or worse, actual end user cases.  A few minor nitpicks:

After applying the series, Documentation/livepatch/system-state.rst
still references the old non-replace model.  Section 2 states that
"Non-cumulative livepatches are allowed to touch already modified
system states," which is no longer true.  The introductions in both
system-state.rst and cumulative-patches.rst also frame atomic replace
as opt-in.  Petr's proposed documentation rewrites cover some of
this, but system-state.rst section 2 needs updating as well.

See also my replies to specific patches/replies, mainly around the
supercedes feature discussion.

--
Joe


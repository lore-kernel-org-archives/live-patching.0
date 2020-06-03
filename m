Return-Path: <SRS0=d+mo=7Q=vger.kernel.org=live-patching-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 61149C433E0
	for <live-patching@archiver.kernel.org>; Wed,  3 Jun 2020 20:42:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3B091207D3
	for <live-patching@archiver.kernel.org>; Wed,  3 Jun 2020 20:42:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1591216939;
	bh=rgIDUtx4gnXafsKf4tEIintiRIoSRYzk7KDiatMjQfE=;
	h=Date:From:To:cc:Subject:List-ID:From;
	b=K0BSM5tncYQ9NsiTkBpQ2w6RiSg/YLddvgOVr6PnDZCb0xS326qe3+/K9ZElSwJaK
	 Vr3Y7Qpvg2GEyeAnKh0Z5yX5tFTpk901Nig70rLLu8G8wOOLGHuIUOm57ok7iCzyRy
	 /P0C0ZNz6JU0c+1KDG90BsNV8Ws6NqUmSumhPimQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726184AbgFCUmT (ORCPT
        <rfc822;live-patching@archiver.kernel.org>);
        Wed, 3 Jun 2020 16:42:19 -0400
Received: from mail.kernel.org ([198.145.29.99]:37584 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725922AbgFCUmS (ORCPT <rfc822;live-patching@vger.kernel.org>);
        Wed, 3 Jun 2020 16:42:18 -0400
Received: from pobox.suse.cz (nat1.prg.suse.com [195.250.132.148])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9FC452077D;
        Wed,  3 Jun 2020 20:42:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1591216938;
        bh=rgIDUtx4gnXafsKf4tEIintiRIoSRYzk7KDiatMjQfE=;
        h=Date:From:To:cc:Subject:From;
        b=eANFuzemT/yH+Ov2ksJh3+VWEWJH9YQQeObtKkT475K52lLEu6iZDIw/gOsws2v3b
         24jfMACpLXug1lv7vODzgHfVDG0PWqqi4bDNCqLPHBjtABpvMjXFpahN2lvcWF7huz
         VXzfw7Ok/zkmFcL2z7jzTS2Wbrnwx2HGrSrR8DpQ=
Date:   Wed, 3 Jun 2020 22:42:14 +0200 (CEST)
From:   Jiri Kosina <jikos@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
cc:     Josh Poimboeuf <jpoimboe@redhat.com>,
        Miroslav Benes <mbenes@suse.cz>,
        Petr Mladek <pmladek@suse.com>,
        Joe Lawrence <joe.lawrence@redhat.com>,
        linux-kernel@vger.kernel.org, live-patching@vger.kernel.org
Subject: [GIT PULL] livepatching for 5.8
Message-ID: <nycvar.YFH.7.76.2006032232540.13242@cbobk.fhfr.pm>
User-Agent: Alpine 2.21 (LSU 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: live-patching-owner@vger.kernel.org
Precedence: bulk
List-ID: <live-patching.vger.kernel.org>
X-Mailing-List: live-patching@vger.kernel.org

Linus,

please pull from

  git://git.kernel.org/pub/scm/linux/kernel/git/livepatching/livepatching.git for-linus

to receive livepatching subsystem updates for 5.8.

You are going to get a minor conflict with modules tree; the correct 
resolution is documented at

	http://lore.kernel.org/r/20200508180524.6995b07e@canb.auug.org.au

Alternatively, I can just prepare a branch for you to pull with the 
conflict resolved.

Thanks.

=====
- simplifications and improvements for issues Peter Ziljstra found during 
  his previous work on W^X cleanups. This allows us to remove livepatch 
  arch-specific .klp.arch sections and add proper support for jump labels
  in patched code. Also, this patchset removes the last 
  module_disable_ro() usage in the tree. Patches from Josh Poimboeuf and 
  Peter Zijlstra
- a few other minor cleanups  
=====

----------------------------------------------------------------
Jiri Kosina (1):
      livepatch: add arch-specific headers to MAINTAINERS

Josh Poimboeuf (8):
      livepatch: Disallow vmlinux.ko
      livepatch: Apply vmlinux-specific KLP relocations early
      livepatch: Prevent module-specific KLP rela sections from referencing vmlinux symbols
      s390: Change s390_kernel_write() return type to match memcpy()
      livepatch: Remove module_disable_ro() usage
      module: Remove module_disable_ro()
      x86/module: Use text_mutex in apply_relocate_add()
      module: Make module_enable_ro() static again

Kamalesh Babulal (1):
      MAINTAINERS: add lib/livepatch to LIVE PATCHING

Lukas Bulwahn (1):
      MAINTAINERS: adjust to livepatch .klp.arch removal

Peter Zijlstra (3):
      livepatch: Remove .klp.arch
      s390/module: Use s390_kernel_write() for late relocations
      x86/module: Use text_poke() for late relocations

Samuel Zou (1):
      livepatch: Make klp_apply_object_relocs static

 Documentation/livepatch/module-elf-format.rst |  15 +--
 MAINTAINERS                                   |   4 +-
 arch/s390/include/asm/uaccess.h               |   2 +-
 arch/s390/kernel/module.c                     | 147 ++++++++++++---------
 arch/s390/mm/maccess.c                        |   9 +-
 arch/um/kernel/um_arch.c                      |  16 +++
 arch/x86/kernel/Makefile                      |   1 -
 arch/x86/kernel/livepatch.c                   |  53 --------
 arch/x86/kernel/module.c                      |  43 ++++++-
 include/linux/livepatch.h                     |  17 ++-
 include/linux/module.h                        |   8 --
 kernel/livepatch/core.c                       | 178 ++++++++++++++++----------
 kernel/module.c                               |  26 ++--
 13 files changed, 283 insertions(+), 236 deletions(-)
 delete mode 100644 arch/x86/kernel/livepatch.c

-- 
Jiri Kosina
SUSE Labs


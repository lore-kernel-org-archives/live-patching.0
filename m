Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59AEA426D18
	for <live-patching@vger.kernel.org>; Fri, 10 Jul 2026 15:30:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783697457; cv=none; b=YT00B9/aGmQUqk20PzCacEhnb2BFN2RtlOJlPnW8HTjkOAsvlvriAlbnVFen08pI0LbEocS5ioEW39iZeyxjKJxXUnb8wV49UPyTx5lZBRJHj1WS+27KxKv1YJwtxHTXZQzFJP4wF1B2VqOVXDchFPz9Doq50kCuq5zwNGJfTsc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783697457; c=relaxed/simple;
	bh=6D0bYmb9vZegfdMg+//HExNwenYnsZ1ut+zep41d+lI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-type; b=QFPzgxWNFkzzG+6NqTMYfpQASBzu4C/600k3XC3c+skchyy72ssvCgxm4ip7NC21CoZ/pkzq9q4FZw7k8LlSFB40xK079FqJ0TgwdiQi1U9UlKeoAAeolf6TCfcEPVMLZXonZys2DBcSEVLZWB2xuLAb2zLgOde728rTDGe2Wss=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=T8vell2W; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="T8vell2W"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1783697454;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=PSuw1KTZMIZEHY5vQDqQEDoRw7vaXwg5efrajhEM0pY=;
	b=T8vell2WF6GPUJj1ixurKNjNjJTCF7/5duLJqEp1lpEslDWSQfBZrERUx3/TnlaBkxgbC6
	NOicZ7BcoceJWcNHKjrSRh/bYmRKhA2/h29TgjB1zmbnskx4rQ7WQNlvqbN9Wr8wCI4/+5
	p6un9is0BUh5R2qse3eWhYBUJ9aK1Jc=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-665-MFI8O26iPw-iNx68Viy9kg-1; Fri,
 10 Jul 2026 11:30:49 -0400
X-MC-Unique: MFI8O26iPw-iNx68Viy9kg-1
X-Mimecast-MFC-AGG-ID: MFI8O26iPw-iNx68Viy9kg_1783697446
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id C185018052E7;
	Fri, 10 Jul 2026 15:30:46 +0000 (UTC)
Received: from jolawren-thinkpadp1gen7.ibmlowe.csb (unknown [10.22.80.46])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 4387F1800594;
	Fri, 10 Jul 2026 15:30:45 +0000 (UTC)
From: Joe Lawrence <joe.lawrence@redhat.com>
To: live-patching@vger.kernel.org
Cc: Ben Procknow <bprockno@redhat.com>,
	Jiri Kosina <jikos@kernel.org>,
	Josh Poimboeuf <jpoimboe@kernel.org>,
	Miroslav Benes <mbenes@suse.cz>,
	Petr Mladek <pmladek@suse.com>,
	Song Liu <song@kernel.org>
Subject: [PATCH 0/1] Mitigate klp-build data sympos bug
Date: Fri, 10 Jul 2026 11:30:41 -0400
Message-ID: <20260710153042.3156788-1-joe.lawrence@redhat.com>
Precedence: bulk
X-Mailing-List: live-patching@vger.kernel.org
List-Id: <live-patching.vger.kernel.org>
List-Subscribe: <mailto:live-patching+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:live-patching+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-type: text/plain
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93

Hi Josh,

This is an upstream reproducer of a downstream bug report from Ben.  He
encountered a sympos bug on rhel-10 with the same pwq_cache variable.
Here I distilled it down to minimal (upstream) reproducer config and
patch.

From what I can tell, function symbols already have a "HACK" disclaimer
around their workaround -- the attached patch tries to extend the same
idea to data symbols.  It may not have 100% coverage, and it's certainly
brittle as it assumes ordering as per the linker script.  But the idea
is to band-aid the problem until a more robust fix is ready.

The comment in find_sympos() suggests leveraging the checksum mechanism
as a better fix, but perhaps we could also pass the vmlinux file through
and read the ordering from the post-linked object?  I can work on that
for a v2, but in the meantime do you think this bandaid would be
sufficient for at least downstream use?


Config
======

Basic default x86 configuration and livepatch dependencies:

  $ make defconfig
  $ ./scripts/config --file .config \
             --set-val CONFIG_FTRACE y \
             --set-val CONFIG_KALLSYMS_ALL y \
             --set-val CONFIG_FUNCTION_TRACER y \
             --set-val CONFIG_DYNAMIC_FTRACE y \
             --set-val CONFIG_DYNAMIC_DEBUG y \
             --set-val CONFIG_LIVEPATCH y
  $ make olddefconfig


Base kernel and livepatch build
===============================

Build the reference kernel:

  $ make -j$(nproc)

and a minimal patch to fs/eventpoll.c :: ep_unregister_pollwait() to
provoke klp-relocation reference to pwq_cache:

  $ cat test.patch
  diff --git a/fs/eventpoll.c b/fs/eventpoll.c
  index 1234567..abcdefg 100644
  --- a/fs/eventpoll.c
  +++ b/fs/eventpoll.c
  @@ -684,6 +684,7 @@ static void ep_unregister_pollwait(struct eventpoll *ep, struct epitem *epi)
          while ((pwq = *p) != NULL) {
                  *p = pwq->next;
                  ep_remove_wait_queue(pwq);
  +               WARN_ON_ONCE(!pwq_cache);
                  kmem_cache_free(pwq_cache, pwq);
          }
   }

  $ ./scripts/livepatch/klp-build -T test.patch 
  Validating patch(es)
  Building original kernel
  Copying original object files
  Fixing patch(es)
  Building patched kernel
  Copying patched object files
  Generating original checksums
  Generating patched checksums
  Diffing objects
  vmlinux.o: new function: ep_unregister_pollwait.isra.0
  vmlinux.o: changed function: ep_remove
  vmlinux.o: changed function: ep_clear_and_put
  vmlinux.o: changed function: eventpoll_release_file
  Building patch module: livepatch-test.ko
  SUCCESS

sympos inspection
=================

klp-build assigns sympos=2 to the pwq_cache klp-relocation:

  $ readelf --wide --relocs livepatch-test.ko | grep -w '.klp.sym.vmlinux.pwq_cache'
  0000000000000008  0000006600000001 R_X86_64_64            0000000000000000 .klp.sym.vmlinux.pwq_cache,2 - 4
  0000000000000069  0000006600000002 R_X86_64_PC32          0000000000000000 .klp.sym.vmlinux.pwq_cache,2 - 4

but check out the ordering difference between vmlinux.o and the
post-linked vmlinux [sympos denoted]:

  vmlinux.o (symbol table order, what objtool uses):

    $ objdump -t vmlinux.o | awk '/\.c$/{file=$NF}; /pwq_cache/{print file": "$0}' | column -t
    workqueue.c:  0000000000012ae0  l  O  .bss                  0000000000000008  pwq_cache      << sympos=1
    eventpoll.c:  000000000000fb40  l  O  .data..ro_after_init  0000000000000008  pwq_cache      << sympos=2

  vmlinux (address order, what kallsyms uses *):

    $ objdump -t vmlinux | awk '/\.c$/{file=$NF}; /pwq_cache/{print file": "$0}' | column -t | sort -k2
    eventpoll.c:  ffffffff82b77b40  l  O  .rodata  0000000000000008  pwq_cache                   << sympos=1
    workqueue.c:  ffffffff83a85ae0  l  O  .bss     0000000000000008  pwq_cache                   << sympos=2
    * Note: .data..ro_after_init becomes .rodata after linking

With that, I think find_sympos() needs the same considerations for data
symbols as it currently has for function symbols.
 
Joe Lawrence (1):
  objtool/klp: fix symbol ordering for data symbols

 tools/objtool/klp-diff.c | 40 ++++++++++++++++++++++++++++++++++++++++
 1 file changed, 40 insertions(+)

-- 
2.54.0


Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2AD75345EDF;
	Sat, 15 Aug 2026 09:56:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786787799; cv=none; b=Y6fEzEE62tZeXXJIZhFBSyFs7rNrWnw54efGFepJMiMnaEPr9WvJRV3Wq1TInw0T0NQIz29dpLlfWwbD73lHABn3Q3okfOMofD7xmko+S5pn/uE8NXDFYCcOUOoDmgALwlrQExmtXt2IDpMpugvfZ6Z7QWAzYGuoprPixIfNDWA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786787799; c=relaxed/simple;
	bh=uNDnjlDvKPG70TratPQzZmQAY3TaLErjROBSTX7w5HY=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=Q5zqfY3L0o243+CnrEdeEH2gOFW57Fjow6gu9dCnsNTQc4UMV5sN82g7ih+pNz7B9BTXnlwlQPTsijJBE4BKYnaA6oSfkibuiVg2xKktBVW4Ndz1GNvgik8TokHv+F8inTAkfq1NhtyDHGs4cBKcEp4pMp+I4SqDCnai/Bsf30M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=L/oICSpH; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="L/oICSpH"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E2FDE1F00A3D;
	Sat, 15 Aug 2026 09:56:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786787797;
	bh=h8iB9CL9H56AsWLWFYl9WTRB72BfvQk27blvdGiG6aA=;
	h=Date:From:To:Cc:In-Reply-To:References:Subject;
	b=L/oICSpHL2htwCSLHg0j2olxelmKQ6LemBN9HsjR+5XWP1hXEDJzEaBDOlcqPnkB4
	 pCDoKkkfLfQcXs/mJ7HUSf+u27BZCFYgBUdThNmj9vi0uiJRE06AiSm5XLOf8SNDqi
	 LEUWdK/yqWs4Fxyg3fpeqzW52B/f4RmfIZ8CLiX2TT4xraRiiLB+YPiGkPux0ZPmu/
	 CE0k3ZhwwqyTaCSDk2g/CjYpaTfpAQL9i/T/7GH8BQbwsZdo0fjDQtS18zFKDv8lNY
	 oYoZiWa29fQnp3sILwZ+3jDAM5A7p/qawHyQIj5qQ37NVzEZI5FnVq9kv0eNTRpQsr
	 in/tCc5SGdgjg==
Received: from ams-compute-02.internal (ams-compute-02.internal [10.64.2.62])
	by mailfauth.ams.internal (Postfix) with ESMTP id 6DD5E1980045;
	Sat, 15 Aug 2026 05:56:35 -0400 (EDT)
Received: from ams-imap-11 ([10.64.2.31])
  by ams-compute-02.internal (MEProxy); Sat, 15 Aug 2026 05:56:35 -0400
X-ME-Sender: <xms:0DeAasum-5ZZrUIQFtx2br4ibarKj_fCMSllYBjanvXxSKGaxFNe5g>
    <xme:0DeAakQ6swmH_Au_dwEktcAP-Y1TASKZYIYDlaRLq4aLf099i337BPBVdGvq9RKXQ
    XsFkHyTFnB8FI6HyQGOqoCbtfEjte6be9Z0YJPLLZd-lvokoJRwIg>
X-ME-Proxy-Cause: dmFkZTFAuNCeEMW1VZsk3N7nJ7FTcPUlmBAIVDXKd94kL40rK668Sal6yRseJvtMcPr6gT
    GUEQjJzLqdPY31I48yMJe280VaWtgDwXFq8AxDYPOp7XFhkALnCMTlDmWzenCfMWYPPkCU
    o5eGqaU+GBxjcDva9JVSjncnVy6jvtlb0f4b2BMUyv+BEHDbHpSjSJFjX3EQhv6xbccHJG
    7W6XiLbxA6ezzBnXoXy4RVQF3oJ2YShIyGr7Kq9C6XZhoI2PpzkKcaW7+nyYwfPkWdvakU
    exujjLhz8wgaJUZY1Z+JKeBl/Qw0q8w4VhF2pDJ2nrs6F0xhy06gsLPkCdvBrhpLKSIwjx
    ntuozu13E+hIgRbHlzNXxzdGWeBdHSWLISWfOsE/D42l3SltMmRxpM4TgoTyEh9ZnQ/kVG
    f2jfdeQ0mTEH9z5JeoM4aQKnk9LRpZIQm+mvE3O33zndlFqO1nYYNjSxU1Gc2NBQ2m7s0q
    z1MpV05jvXR0Xv3r1fPPId/CjFamr5mqhIvuABcfWz4i7wqeq+brVw0d0Tw/NKKUNXZLUN
    hzE7XRTRRPA3cHyZuURaDzxcr5APmnNbJy6Q9Du+HWOq80bAjprnj0R+JqdxV6L73HNzuw
    4JndE5ZvBNjxQVBA/jU4TKbtN0/GKy/zlIo/NuOJGxVKsiNEF/bK7UyDcACQ
X-ME-Proxy: <xmx:0zeAapyE9qt4py2GaFwQsOtFZnLnE8ey_hdOdYm_rYZbtoGJYGZLfg>
    <xmx:0zeAairqUAzUQwfW2G4jGlMnKsp4vB0lK5YlD2yzg_9oB1ymsgDaZw>
    <xmx:0zeAar2tjAvoWIEZ13sB0D1X2wrUjIr9c5lbMPfzTwXUkWcjUo6FRQ>
    <xmx:0zeAarBFcpvt6Bxh-Q0gR1l0S4JSxGFNETALmq8HVv7-XBNhWzC2-Q>
    <xmx:0zeAasPRMJdaz4JsSKW8dNeQmF8R-h-yq7AUEFMDrubyqVxXJT_TjdHI>
Feedback-ID: ice86485a:Fastmail
Received: by mailuser.ams.internal (Postfix, from userid 501)
	id 688EDF8006E; Sat, 15 Aug 2026 05:56:32 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: live-patching@vger.kernel.org
List-Id: <live-patching.vger.kernel.org>
List-Subscribe: <mailto:live-patching+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:live-patching+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Sat, 15 Aug 2026 12:56:11 +0300
From: "Ard Biesheuvel" <ardb@kernel.org>
To: "Josh Poimboeuf" <jpoimboe@kernel.org>,
 "Catalin Marinas" <catalin.marinas@arm.com>, "Will Deacon" <will@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 live-patching@vger.kernel.org, "Song Liu" <song@kernel.org>,
 "Miroslav Benes" <mbenes@suse.cz>, "Petr Mladek" <pmladek@suse.com>,
 "Joe Lawrence" <joe.lawrence@redhat.com>,
 "Mark Rutland" <mark.rutland@arm.com>, "Mark Brown" <broonie@kernel.org>,
 "Nick Desaulniers" <ndesaulniers@google.com>, "Kees Cook" <kees@kernel.org>,
 "Nathan Chancellor" <nathan@kernel.org>, linux-toolchains@vger.kernel.org
Message-Id: <6bc20c00-21a9-4315-8ec3-33c7ad6ae95f@app.fastmail.com>
In-Reply-To: 
 <2ff1b2482406c61ca5979d6284ba5f948a3fbc20.1786768375.git.jpoimboe@kernel.org>
References: <cover.1786768375.git.jpoimboe@kernel.org>
 <2ff1b2482406c61ca5979d6284ba5f948a3fbc20.1786768375.git.jpoimboe@kernel.org>
Subject: Re: [PATCH 02/12] arm64/module: Fix BTI exceptions caused by omitted landing
 pads in Clang 21
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

Hi Josh,

On Sat, 15 Aug 2026, at 07:45, Josh Poimboeuf wrote:
> The following BTI exception was seen when loading a livepatch module:
>
>   Internal error: Oops - BTI: 0000000036000001 [#1]  SMP
>   pstate: 634004c9 (nZCv daIF +PAN -UAO +TCO +DIT -SSBS BTYPE=jc)
>   pc : kill_orphaned_pgrp+0x0/0x150
>   lr : do_exit+0x498/0xaf0 [livepatch_combined]
>
> The problem is that the patch module's do_exit() is branching to a
> static function in vmlinux using a module PLT veneer (indirect branch),
> but the target function doesn't have a BTI landing pad.
>
> Clang 21+ omits the landing pad for static functions which can only be
> reached by a direct branch.  But livepatch modules use klp relocations
> to reference arbitrary kernel symbols, and with
> CONFIG_RANDOMIZE_MODULE_REGION_FULL the module is far enough away that
> every call to vmlinux needs a PLT.
>
> Note this problem is actually not specific to livepatch.  It's possible
> for any module's .init section to be allocated > 128MB away from its
> .text section.  So calls from .init to .text via a PLT can trigger a BTI
> exception when the target function doesn't have a landing pad.
>
> GCC has always omitted the landing pad when possible, so kernel BTI is
> already considered incompatible with GCC since commit c0a454b9044f
> ("arm64/bti: Disable in kernel BTI when cross section thunks are
> broken").
>
> When missing landing pads are detected, allocate a page close to the
> target which can be used to hold BTI veneers which receive PLT veneer
> indirect branches and direct branch to the final target:
>

This does not work for cross-section calls from .init.text to .text.

If .init.text is far away from .text, it is likely because .text
ended up in the 128M 'near' module region, and .init.text did not.
(They tend to end up in direct branching range of each otherwise.)

Given that the module init code is typically small, I don't think
it is safe to assume that allocating a single page close enough to
.text is going to be possible if allocating the space for .init.*
was not.

IOW, the fix I proposed for cross-section calls is still needed
with this approach.


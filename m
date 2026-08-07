Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE3A02D2397;
	Fri,  7 Aug 2026 22:56:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786143374; cv=none; b=Fr4hM1D1aVd9RbbRsmCfPafIvPyeTxzL5J9/JuEjqsuy5lreYoOlAjz/AVUyMIhsLFXyfLGDSIZ85erhCqpsYokA1C0jgm1n+oTfunBLN6RFsFXjIu+IKtEXvWEZIhqeegyvIUKGCAS2huR0R9fBw4pyvsIrQI+qIK3V63nHKnc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786143374; c=relaxed/simple;
	bh=KqeVNAeOYU6y4m1KTluK5kcP/EBETUP/b9tnPni4qZc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=J8LXRFMlflbJ/Omy3hFhP2EFGIA4ph4psNzcQ9reSoIwlQ2oqfAVQd2QHwkZGk9VUX1wTi4kObEacKBCBkkJwJIDLK64YLxOWt5iCmAzCKJLxGTl6CwjQOPNZKlQQZfMrnRDpPIvxLKFIuAjJHiGfOSSgptB08f30/KXj0Txibo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OzkQm4sI; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OzkQm4sI"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B80101F00A3A;
	Fri,  7 Aug 2026 22:56:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786143373;
	bh=k2h7TFpNtHGZoQbDMXlxnaziePvR8kZuJ/KZ00xUctY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=OzkQm4sIh98Wqq9Rgzi8nNRRs5cOR5UONHibRZ6i/HgWrIQkMs3L4ma4sRMTQsRkr
	 rYUC3o4jxH+IhxRUpzUXY42thV+sWlmDR95ynufsP+qFFiMVS/N2tRawqnt1eyIKiq
	 GPlLxNB+iVZHZygXL1bmxO+YJfPjbdsGidN8+TtsErKTB+wQ3ENy/niqQGt8oucBx4
	 dAy5uN8aJTjrvyyVuNxFg+OS4rMUMzJKbPKaDiWiTz9/HHZM8w8KAzeZ9LkUMHplnP
	 XEx7ZiRcNYKUkPBDiiPaXAPOFu226wm7iBdPcjMbdso4KnvRnMYJh9VKsMgJx3rESQ
	 IcZ7lULkttxZw==
Date: Fri, 7 Aug 2026 15:56:11 -0700
From: Josh Poimboeuf <jpoimboe@kernel.org>
To: Peter Zijlstra <peterz@infradead.org>
Cc: x86@kernel.org, linux-kernel@vger.kernel.org, 
	live-patching@vger.kernel.org, Joe Lawrence <joe.lawrence@redhat.com>, 
	Song Liu <song@kernel.org>, Catalin Marinas <catalin.marinas@arm.com>, 
	Will Deacon <will@kernel.org>, linux-arm-kernel@lists.infradead.org, 
	Mark Rutland <mark.rutland@arm.com>, Miroslav Benes <mbenes@suse.cz>, Petr Mladek <pmladek@suse.com>
Subject: Re: [PATCH v3 10/21] objtool: Ignore jumps to the end of the
 function for checksum runs
Message-ID: <rcfhf5sutcqvl4bwhn7neuwv7di7opbkwy754sfgtwmce7mpte@vbtw77bs3khg>
References: <cover.1778642120.git.jpoimboe@kernel.org>
 <b3b58101e15e1bb5266e57134f0b65f7d8efdd4b.1778642120.git.jpoimboe@kernel.org>
 <20260513073617.GH1889694@noisy.programming.kicks-ass.net>
Precedence: bulk
X-Mailing-List: live-patching@vger.kernel.org
List-Id: <live-patching.vger.kernel.org>
List-Subscribe: <mailto:live-patching+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:live-patching+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260513073617.GH1889694@noisy.programming.kicks-ass.net>

On Wed, May 13, 2026 at 09:36:17AM +0200, Peter Zijlstra wrote:
> On Tue, May 12, 2026 at 08:33:44PM -0700, Josh Poimboeuf wrote:
> > Sometimes Clang arm64 code jumps to the end of the function for UB.
> > No need to make that an error for checksum runs.
> 
> I'm not sure I understand the rationale. If the compiler trips UB, we
> want to be complaining about that no?
> 
> Same as when clang just stops code-gen, also something we commonly see
> when it hits UB.

Right, but I guess the question is, should we always warn about that, or
should we only warn about it when doing stack validation or ORC or some
other CFG-traversing thing?

The checksum thing is only used when manually enabled by klp-build
(never for normal kernel builds), so it would be a weird spot to report
the Clang "jumping to the end of the function" UB.

If we care about that for arm64 then the UB check probably belongs in a
new standalone objtool command that would get used during a regular
kernel build.

-- 
Josh

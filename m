Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B7ED2F8E8B;
	Mon, 17 Aug 2026 11:06:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786964764; cv=none; b=HWy4MiqOPeJ33ltqLhUrPAcoTOxsbpOvzbtVMOhMfzel1jY5HF3ClU/yDZlqgNr/ELJjQGJwAxxJQMmRDlKEGE64yGOjFPRz2kZQUEoiJZQI7OuHP5KalbL3+lhXP2HHoI4Ljab4iRd1anBMh7UaKhaPN3vqFJoAjNCS0vVb0JU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786964764; c=relaxed/simple;
	bh=9BitqWpRRd1sNk0Ud7Ndi5+ylUTvjHGVp909fSGuDv0=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=g0jlez2iQl0EjwWXY7JcUHYKbuDceSBS2k/l9tHqE185HkHMGfuCg+PlEmtPum8jXcka27qcTjqm5uZrE5CjGr8UXjksxQOsFZfh8JviQLflvd6JRIQJ5e6Gh6iF6SxS0s9/CBQl6DbkzX4mP2ELwIE9+WR7w7WZ+MlnPezP1s4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cl5Z5DGd; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cl5Z5DGd"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 485751F00A3A;
	Mon, 17 Aug 2026 11:06:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786964762;
	bh=5YDm2MEhblHeSTo+p97BhcoDmU/H9pfWhKKQjOGcjQA=;
	h=Date:From:To:Cc:In-Reply-To:References:Subject;
	b=cl5Z5DGdncoriLwQGDRfyRGh+OY85XF8Y5ecEk7j5EEbi050hkhy3jL2SMtyt9UEA
	 cAAKfZfHt3Ef1YSNNWd6J5u3ny39/fHxGVikcFTmMWbprU1v/mLxeneEyh/nUPHop5
	 We/5rqBSAcw1kUz/c0I+QXa0PdH8PeQkXkwfdzmv2u/Ii46xFNqztXyLfCb9IRTZ3l
	 Pr0aGNqW73BQu4IlcNlI2qeYNICz/xIioHj0kAoRhzKPZVSZoTwhJ035NXwFPvLurI
	 M9S+6CoWs7eKAaNA4vcN7HK7h4wMtm3Lmdc8erDhbF/5426vZxxIy9qMP3t/d/ZUi9
	 gJ+wRd+k8XAYw==
Received: from ams-compute-02.internal (ams-compute-02.internal [10.64.2.62])
	by mailfauth.ams.internal (Postfix) with ESMTP id EAE1D1980062;
	Mon, 17 Aug 2026 07:05:59 -0400 (EDT)
Received: from ams-imap-11 ([10.64.2.31])
  by ams-compute-02.internal (MEProxy); Mon, 17 Aug 2026 07:05:59 -0400
X-ME-Sender: <xms:FeuCalPl3nblAg5cLX2Sdy9YMy-qJ_OEri82lyj4BmpAN8qR-E_0QQ>
    <xme:FeuCaiwKAx3Nghd8c6xu9MMl23Zmx5VnpWk4vO16BRzxSqVRAP6g9cO6WvTnKen5b
    jWbJG5LclKcruDGJA26P6CxbiM5h77xc4HgvwbHQjl3W09NRPdamkX->
X-ME-Proxy-Cause: dmFkZTGQTHdWnJJCE22d/zqJDKF+JU5EHgBWnubh5cfMqZ6YpZC4QRyAcPIogwmsD7ZFvV
    rpjOfIO7lr1q9eqfc3+CiXePGWFmdsM14RQa6WX2LKGHS1r/tHa+O1ao3urpQREtRewSHc
    95m/2eg3vmA0WPhirsiFjG9t1Tj3PRGHDWnebRQFHUi5zIzq4Mfnkao6G6YiF3iP7bZRS8
    IHR8yLciD4LE4B6OfJXkjWTT/ZczxC8BLxtrr+PGPg4KmcNAxm19G5CJzDoapvlrSbEybn
    saX8AxbVSnMbpLAjW28JIQNo+itVuegoqNASFwyfn3u5IeUtYs4ZxaV15k5DHxvqzhiHew
    cz5fUSxiHAKmlFd/EfY3HXC3PkP0TpK1r5YG+JJqNkzVG0pVmRgz3y+F5Tp7sIVMjXLc0Y
    n27yPSeTCjuMXiCb/2OOAF49v8nDGcfXApjhVVEC/s/of89/B3uOyeRYcDPvbVaENbrk39
    fwxgd4y5lndWRdIQ0jgR5PkbVnS0rtUAYJ8qwrGdZNYqEMsACbIvPhbVtbbOIh1OCMxcM5
    OJmXnxyHbCdmfXCtNaBFWhVns2A2XYtv+o0ppWnUGTOol9ryIPzlk7cwHlxOanFvVlpI8/
    qbcEcUqtr5+QPmT1lTIFC8PDIBfpi59InZ0g0Ru+ckDtGOTgosh8s6avroNw
X-ME-Proxy: <xmx:F-uCamR3yQ3UVMcC3FBLKa86uKdnNdCGhaZugOJXDlCkift2hjSaqg>
    <xmx:F-uCalL5oXnNVuUoeykyhNvQgRpFUnAtMM2wTykZ3aR_5rar7o_pHQ>
    <xmx:F-uCasURjhNqoi7z8gj46235HXGKnvmh5rgqe7W8yRRxnyouJuXYKA>
    <xmx:F-uCahgNSWu-nM8MqIbUnmZmvTFeAo2bKqp9gpzLlVMrZ4c5UziwUQ>
    <xmx:F-uCagspqxAsWBDGMykXhxBbnCdtTVM5pchvScjv7hvAyLUvfcz6wkRv>
Feedback-ID: ice86485a:Fastmail
Received: by mailuser.ams.internal (Postfix, from userid 501)
	id 2C96CF80070; Mon, 17 Aug 2026 07:05:57 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: live-patching@vger.kernel.org
List-Id: <live-patching.vger.kernel.org>
List-Subscribe: <mailto:live-patching+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:live-patching+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Mon, 17 Aug 2026 14:05:36 +0300
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
Message-Id: <73bdec09-a2dd-4693-aa30-12fab36e7a18@app.fastmail.com>
In-Reply-To: 
 <a9662e64de17882d2ef2401bad0d8172ef48bc4b.1786768375.git.jpoimboe@kernel.org>
References: <cover.1786768375.git.jpoimboe@kernel.org>
 <a9662e64de17882d2ef2401bad0d8172ef48bc4b.1786768375.git.jpoimboe@kernel.org>
Subject: Re: [PATCH 03/12] arm64/bti: Fix BTI linker failures with long branches into
 .idmap.text
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

Hi Josh,

On Sat, 15 Aug 2026, at 07:45, Josh Poimboeuf wrote:
> On a kernel whose text exceeds the +/128MB direct branch range, the
> linker inserts veneers.  With BTI enabled, the veneers' indirect branch
> targets need a BTI landing pad, which not all functions have starting
> with Clang 21 (and for all versions of GCC).
>
> In such cases the linker can emit a second veneer close to the target
> which has the landing pad along with a direct branch to the target.  But
> a long branch to .idmap.text never gets one because it's missing the
> executable section flag.
>
> With the LLVM linker, it's a silent failure, presumably only discovered
> by a BTI exception at runtime.  With the GNU linker it's even worse, as
> it dereferences the missing stub/veneer group entry and seg faults (this
> was how I discovered it).
>
> Make sure the section is executable by adding the "x" flag to all the
> creators of the input section.
>
> Also manually add "bti c" to primary_entry() and enter_vhe(), otherwise
> the linker-generated veneer page pushes the .idmap.text past its
> asserted 4KB size:
>
>   ld.bfd: ID map text too big or misaligned
>
> Link: https://sourceware.org/bugzilla/show_bug.cgi?id=34525
> Signed-off-by: Josh Poimboeuf <jpoimboe@kernel.org>
> ---
>  arch/arm64/kernel/cpu-reset.S | 2 +-
>  arch/arm64/kernel/head.S      | 7 ++++---
>  arch/arm64/kernel/hyp-stub.S  | 1 +
>  arch/arm64/kernel/sleep.S     | 2 +-
>  arch/arm64/mm/proc.S          | 8 ++++----
>  5 files changed, 11 insertions(+), 9 deletions(-)
>
> diff --git a/arch/arm64/kernel/cpu-reset.S b/arch/arm64/kernel/cpu-reset.S
> index c87445dde6745..9943a7c70f6b0 100644
> --- a/arch/arm64/kernel/cpu-reset.S
> +++ b/arch/arm64/kernel/cpu-reset.S
> @@ -14,7 +14,7 @@
>  #include <asm/virt.h>
> 
>  .text
> -.pushsection    .idmap.text, "a"
> +.pushsection    .idmap.text, "ax"
> 

We've had issues in the past with this change.

The problem is that the ID map is restricted to a single page, and
[some versions of] the GNU linker concatenate generated veneers onto
whichever executable input section came last in the input, which was
this one at that point.

That resulted in the ID map start/end boundaries being placed further
apart than the linker asserts would tolerate, even though the generated
code in question would never be called via the 1:1 mapping.

Not sure whether that problem has simply disappeared by now, or older
versions of the linker may still trigger it. But it is something to be
aware of.

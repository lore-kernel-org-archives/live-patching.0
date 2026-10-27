Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793067748;
	b=mvYT8eFHcyye8z6mfEppoCAuiaNM6dWRAtqdBO/mznBxM5h6pL9d+NmMiAIpqXlAjvZP
	 kGiF5VYe7lLu3kcmMK8RVx0vA498u6HXFI7dQ73h0/W7wdOyWKDJ2ZjuOzBcFjQQf2DVQ
	 0RawdsDPz0tcPJSsFfkWbeUjI3azyw7s3HMxjwjhyUvC5IbnL5ZpFV8AR22E0bwaIHadu
	 lGc7knJABZfhtwGCQb9tB2iGyA2NoR/gkffPaun2sOGJyZeBQJYvUkYavph/DXj7IqHJX
	 KMOr+JLSbbtDDA6k7lCGbCMfT0guC47MqW9EKZatayBLkHst2a312n92xhOauvewNcQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793067748;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=54+eeI7JG7svROI7vWxsG3h9jsfit6e7W5UKf/RnHwg=;
	b=Aocgf82fAEyeJzC7e7p1Aj6fiYW4/sIiLKvzyskA2iplajJu5KZpnvRI67MZuugxdeu+
	 oXco7YyN1onPthG51S+0bHPMPDh1jBmwr9oHizTaeu9/KlLRcKRVSEoSQJP5JoWi+E4Fg
	 SvQNDT6aICGqvVrIwpgfAJ1GLD3mcnZDCvv9KHjaGZ4SMC0KGhvoY9/Y+CCywhCfqf+3n
	 3LM/1b4WF8Y1TUpM2g+9EpNM0tWZOs/CSV8nla/WrCJGg1pVGm8QUUkRSHkfVncDv1tfy
	 MPv2ysK6Y8/wxhJse6J6wMtVNHQ1qXabYKv9yptAKt8LhFGRqKGQkZ0vhAaGlONwGbw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Ya6rScKB;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1D62606A31B;
	Tue, 27 Oct 2026 02:22:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Ya6rScKB
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D844F1F01825;
	Tue, 27 Oct 2026 02:22:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793067747;
	bh=54+eeI7JG7svROI7vWxsG3h9jsfit6e7W5UKf/RnHwg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=Ya6rScKB18t0P84kk/AWpYtURSATktpjypcDTMw3OMX/VOOYuhGU5d7NDlQ+ZDPbk
	 9Uq9A1+tgFaPKg5vA9kqglsZ4aXLwbQQZu9M+vfXAmdw+M6JnZRUr3pwhsB11NDxwJ
	 IZ9KL/1uTAiKAT0px3nDmTm4ktBoFxwOpncRoyPcecGDDnns8ZYQfEMfoLvgQlPNzY
	 fMjtGqfeLUbAY8s5VX48BKFNRDDSTAeh5dWPUgy6IZnYYqCRIjjfxcQL9xsV6R43Op
	 aXQabpT8a/zB40Vcgot7BHHfv3CnEGWdOUX8LiifcGUDK0t9y18IRFN14P5DPlIhs9
	 lnGTzj1OyMdOA==
Date: Mon, 26 Oct 2026 19:22:25 -0700
From: Josh Poimboeuf <jpoimboe@kernel.org>
To: Song Liu <song@kernel.org>
Cc: live-patching@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	jikos@kernel.org, mbenes@suse.cz, pmladek@suse.com, joe.lawrence@redhat.com, 
	shuah@kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 02/11] klp-build: Add --patch-only option
Message-ID: <auAGCNUz9BChLpaX@jpoimboe>
References: <20261017002441.716615-1-song@kernel.org>
 <20261017002441.716615-3-song@kernel.org>
X-Mailing-List: live-patching@vger.kernel.org
List-Id: <live-patching.vger.kernel.org>
List-Post: <mailto:live-patching@vger.kernel.org>
List-Help: <mailto:live-patching+help@vger.kernel.org>
List-Subscribe: <mailto:live-patching+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:live-patching+unsubscribe@vger.kernel.org>
List-Owner: <mailto:live-patching+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20261017002441.716615-3-song@kernel.org>

On Fri, Oct 16, 2026 at 05:24:32PM -0700, Song Liu wrote:
> klp-build fixes the input patches before building the patched kernel:
> it combines them into a single patch against the original source and
> adds #line directives, so that unchanged functions further down a
> patched file keep their __LINE__ values.  This only happens after the
> original kernel has been built, so seeing the result, or testing this
> step, takes a full kernel build and --keep-tmp.

Not sure how this last sentence is relevant, either way klp-build will
run to completion (or failure)?

Also the above feels like a strawman, I think the real justification for
this is the selftests?

> +++ b/scripts/livepatch/klp-build
> @@ -19,7 +19,7 @@ set -o nounset
>  # This helps keep execution in pipes so pipefail+ERR trap can catch errors.
>  shopt -s lastpipe
>  
> -unset DEBUG_CLONE DIFF_CHECKSUM SKIP_CLEANUP VERBOSE XTRACE
> +unset DEBUG_CLONE DIFF_CHECKSUM PATCH_ONLY SKIP_CLEANUP VERBOSE XTRACE
>  
>  REPLACE=1
>  SHORT_CIRCUIT=0
> @@ -137,6 +137,7 @@ Options:
>  
>  Advanced Options:
>     -d, --debug			Show symbol/reloc cloning decisions
> +       --patch-only		Print the fixed patch(es) and exit without building

This is basically bolting a test hook onto klp-build.

What if we move the patch validating/fixing into a self-contained
klp-prepare-patch script?  There might be a small amount of duplication
for some of the patch handling but that would hopefully be minimal.

Then the selftests can run it directly and klp-build doesn't need the
new option and the PATCH_ONLY special casing.

-- 
Josh

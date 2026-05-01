Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 924C23290D8;
	Fri,  1 May 2026 18:47:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777661223; cv=none; b=dAUW4aPeyfGKWd5l5ZdTnYCPMXA76AfLxkZ1muRFTKv2GI1v52blHI6mn5ZyK67ge9XlDOaIZXo46DPa4zzq98Y2Eo6oZW3+P1M8JOAi7EsXDAb2JUrdE09N2XHyk7eHspcniwL2ctlgBgT6xu6cLofRicVMCGngiRApxGnYGLQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777661223; c=relaxed/simple;
	bh=6E8Tl687aEPwdZH9TB9kGJxMfQzZ5hy3fpenQQ4rNu0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mymJ9gWztvzohtcPUjIKDqd19H4iqpctkrEnYF9c25tnxdBlZIy9CDtxVwv+95xVDj1UR3fX//ebfpCeYIHYHwsLHk7rtlCCPchePTfVBHIlo0QFcVw/eUWTulzBPnPxyjw9tMIsre+5fqhoBhi6Jic2ttN2Kc23ibzJBM3s6Uk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MFzxwHzD; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MFzxwHzD"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 65B6CC2BCB4;
	Fri,  1 May 2026 18:47:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777661223;
	bh=6E8Tl687aEPwdZH9TB9kGJxMfQzZ5hy3fpenQQ4rNu0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=MFzxwHzDE9YoQWC1hkHgebu0YHmuHecHu3MnIqXATIHbNuudi/yFEBVcgU3om3iyg
	 hE6aWjlQev+5e8Gw8i1jVesk3iGuhEiEEOXRtgQYIn8S4Mxzl6UVZG+DL+HcotQPOD
	 IS7TJ0siQXtz6y18536jZNmfX4jGMkKJOi3OLCXh1Pa6bDm+dD9bGzImFkoqQBEgQz
	 tf04qQAjCHI8r51NTuUapPO6qSijKE6ltPKSY/bvjPiulmzhDfonmhj55N2wuq7K0K
	 j4ZgqkGdIb9zCBTw8+QKEp1YzHTC5khKUVH7dWFzX6AY6klr8Rb4K+cxfHcXdmubqz
	 no/55nWk5Xn7Q==
Date: Fri, 1 May 2026 11:47:00 -0700
From: Josh Poimboeuf <jpoimboe@kernel.org>
To: x86@kernel.org
Cc: linux-kernel@vger.kernel.org, live-patching@vger.kernel.org, 
	Peter Zijlstra <peterz@infradead.org>, Joe Lawrence <joe.lawrence@redhat.com>, 
	Song Liu <song@kernel.org>, Miroslav Benes <mbenes@suse.cz>, Petr Mladek <pmladek@suse.com>
Subject: Re: [PATCH v2 00/53] objtool/klp: Some klp-build fixes and
 improvements
Message-ID: <cq5uytz6edj75w53f2eubypvqm66hgh4eag7ec2vgqjefzzqts@lcnvt7fcrtmd>
References: <cover.1777575752.git.jpoimboe@kernel.org>
Precedence: bulk
X-Mailing-List: live-patching@vger.kernel.org
List-Id: <live-patching.vger.kernel.org>
List-Subscribe: <mailto:live-patching+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:live-patching+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.1777575752.git.jpoimboe@kernel.org>

On Thu, Apr 30, 2026 at 09:07:48PM -0700, Josh Poimboeuf wrote:
> Changes since v1 (https://lore.kernel.org/cover.1776916871.git.jpoimboe@kernel.org):
> 
> - Add comment for find_reloc_by_dest_range() first-match behavior
>   [Peter]
> - Simplify is_cold_func() [Peter]
> - Grow __cfi_ symbols [Peter]
> - Rename "Ignore __UNIQUE_ID_*() PCI stub functions" to more general
>   "Don't report uncorrelated functions as new" [Song]
> - Move rodata non-correlation into pointer-comparison fix [Miroslav]
> - Add comments for convert_reloc_sym() return values [Song]
> - Remove redundant SRC/OBJ variables [Song]
> - Use "if (mismatch) {} else" in for_each_sym_by_*() [Song]
> - Flatten nested if-else chain in short-circuit validation [Song]
> - Add comments with examples to symbol correlation algorithm [Song]
> - Move callback refactor to earlier in the patch set [Miroslav]
> - Fix reloc corruption in convert_reloc_sym_to_secsym() [Sashiko]
> - Include offset in object checksum hashing [Sashiko]
> - Fix klp-build checksum comparison output for added/removed
>   instructions [Sashiko]
> - Fix kCFI prefix finding/cloning
> - Add reloc symbol conversion simplification cleanup
> - Improve local label check for uncorrelated symbols
> - Drop "Make function prefix handling more generic" for now (refactored
>   version will come with arm64 patches)
> - Refactor inline alternative cloning into separate
>   clone_inline_alternatives()
> - Add Acked-by/Reviewed-by tags

I'm squashing a few Sashiko nits (see below) into their relevant
patches, along with a minor bisectability issue.

latest is at:

  git://git.kernel.org/pub/scm/linux/kernel/git/jpoimboe/linux.git klp-build-arm64

diff --git a/scripts/livepatch/klp-build b/scripts/livepatch/klp-build
index 31604d48ff49..10145b1dd089 100755
--- a/scripts/livepatch/klp-build
+++ b/scripts/livepatch/klp-build
@@ -275,7 +275,7 @@ validate_config() {
 		[[ "$CONFIG_AS_VERSION" -lt 200000 ]] &&	\
 		die "Clang assembler version < 20 not supported"
 
-	"$OBJTOOL" klp 2>&1 | command grep -q "not implemented" && \
+	[[ -x "$OBJTOOL" ]] && "$OBJTOOL" klp 2>&1 | command grep -q "not implemented" && \
 		die "objtool not built with KLP support; install xxhash-devel/libxxhash-dev (version >= 0.8) and recompile"
 
 	return 0
@@ -741,7 +741,7 @@ diff_objects() {
 
 		(
 			cd "$ORIG_CSUM_DIR"
-			[[ -v VERBOSE ]] && echo "${cmd[@]}"
+			[[ -v VERBOSE ]] && echo "cd $ORIG_CSUM_DIR && ${cmd[*]}"
 			"${cmd[@]}"							\
 				1> >(tee -a "$log")					\
 				2> >(tee -a "$log" | "${filter[@]}" >&2) ||		\
diff --git a/tools/objtool/check.c b/tools/objtool/check.c
index ca360239ea2b..2b03a2d6fc95 100644
--- a/tools/objtool/check.c
+++ b/tools/objtool/check.c
@@ -2494,7 +2494,7 @@ static int __annotate_late(struct objtool_file *file, int type, struct instructi
 			ERROR_INSN(insn, "dodgy NOCFI annotation");
 			return -1;
 		}
-		insn_sym(insn)->nocfi = 1;
+		sym->nocfi = 1;
 		break;
 
 	default:

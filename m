Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D255288AD;
	Mon, 14 Sep 2026 00:27:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789345621; cv=none; b=saE02bj9cq23snLQZDliOzm9Qvtw/s9ip8/a8d0QAa3L5Uvuc4/k1itW4pcyyfunAaccwO+rw1lccr+atZMPgezC7qztkeXhvw7oEaJC0h/q3CU6BbP3GsRKRt6cedtUjkK/wvMZVpBA1KfGxHQomMYUWm93O7rwc/UzKLOd1OU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789345621; c=relaxed/simple;
	bh=w+4uqDdlqZgm2Npn//V+rjm6SQTYUQYvyl7OIxV4huQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IYrExmKYM2TWXCje2INS3fpG6QfRbD542l1nmRc+g5gIpqppRBu9Eypfj25gDdsJENTcovtdvQ0iGjus3frdo1LjoM8rJPhTzJqpraVfI7eIZ9vqb95sGFWV6HSNfuqkj+g8mBLXO/agd/BLLmlikgnGBVZ2gYAdZ1IhVeSzG2M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=in/5aUBX; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="in/5aUBX"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 426B41F000FF;
	Mon, 14 Sep 2026 00:26:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789345620;
	bh=VN8GSkJYmsOcRWa81Sf3C5UMaoNecugnSWfYugCVR5g=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=in/5aUBXe3/B2t2U6w5ZwPWsDn3PEuIoeKA/nyk0rZRxOY/l+ypiXIvN3VpW6up7w
	 78WthnTCwHuS/Dk160ofZjoTXPcLXi76v4cY7VRABeuUN1ErQmGdkje9gziwJmynr2
	 4JYWgzbIeGUGDD3XBMWkzEpvm3sLlVPNUMV4f6NzhPeUC117rdDZ/PgRHRHdAo7A15
	 GzKuYYa56qoEnPFxEj+xphBfqkBsK8MDp+xSMyOYbsW85V2X7RfBzQ0Gmym3bITJji
	 VrwiarCiZ7ektPcVoY5RuHhp84/3a8hv75K+3JKKr0Ege7IWiylwoKvhnQuFve5Ue3
	 UN4+LI4KgbwZg==
Date: Sun, 13 Sep 2026 17:26:57 -0700
From: Josh Poimboeuf <jpoimboe@kernel.org>
To: Longjun Luo <luolongjuna@gmail.com>
Cc: peterz@infradead.org, song@kernel.org, jikos@kernel.org, 
	pmladek@suse.com, live-patching@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] objtool/klp: Fix missed changes to same-named symbol
 references
Message-ID: <aqc5Q4_9bHpAI4jh@jpoimboe>
References: <20260910085218.66565-1-luolongjuna@gmail.com>
Precedence: bulk
X-Mailing-List: live-patching@vger.kernel.org
List-Id: <live-patching.vger.kernel.org>
List-Subscribe: <mailto:live-patching+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:live-patching+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260910085218.66565-1-luolongjuna@gmail.com>

On Thu, Sep 10, 2026 at 04:52:18PM +0800, Longjun Luo wrote:
> Hashing symbol references by demangled_name alone can miss target
> changes while the instruction or data bytes and normalized relocation
> offsets remain unchanged. This occurs when:
> 
>   - A global function moves between files and calls a same-named static
>     function with a different implementation.
>   - A function's call target changes from a global function to a
>     same-named static function, without moving the caller.
>   - A data object, such as an ops structure, changes its function pointer
>     from a global function to a same-named static function.

These seem like unusual edge cases, is this problem theoretical or was
it a real-world bug?

> +/* Include FILE identity to distinguish same-named local targets. */
> +static inline void __checksum_update_symbol_identity(struct symbol *sym,
> +						     struct symbol *target)
> +{
> +	const char *file_name = target->file ? target->file->name : "";
> +
> +	__checksum_update(sym, file_name, strlen(file_name) + 1);
> +	__checksum_update(sym, target->demangled_name, strlen(target->demangled_name) + 1);
> +}

If the .patch upgrades a function from static to global then the
function no longer has a FILE associated with it.  Then with the above,
all callers to that function would be marked as changed.  And note that
LTO does a lot of that, so static-to-global and global-to-static changes
are common between orig and patched objects.

Note that function change detection isn't intended to be 100% perfect
for all edge cases.  The patch author needs to verify the changed
function list matches what they expect.

-- 
Josh

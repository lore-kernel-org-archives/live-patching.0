Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 776F83E4C7D;
	Fri, 26 Jun 2026 08:21:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782462087; cv=none; b=CrZB1H/dP7Do9zNWAeL55pnMYtBtuHH27WkO1nuncKdIktsKwQclhyftEIPNOep0OoPUttTntibLQBO+nZxbvSwW64CVF5TkrHqBkRa8PJtzenFE5OtOMuw7y9/noyULlJPwGN1Jed87kGseEk6fb7Vs2GQ2fvkvWG85oA/w3QE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782462087; c=relaxed/simple;
	bh=puOmygpcg/vCV8OR9zslKD7qIGXEOW9zhKfCu64CNRM=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=GOc3NlFx8ZkvNJYgP+LGUbjUUkkDqbpreR3q2Nxzd7+UmVxz73tVC9bN6y/ftZOhqwLPrwmgKNEANA8sqC6XN2UyqF7jGHKOUHGrpn+kH+ThBEbUTNhBUPRO2yPxeR/36hzuGc9NJPplGZAfKW5VSqiNpLmOS88M1jzw8rx++mE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=g1bqmy0K; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="g1bqmy0K"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5728E1F00A3E;
	Fri, 26 Jun 2026 08:21:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782462086;
	bh=zsScqxEdMhuN7RDDDXh0ed+YZPuMqpL3ArI4WO1ybVk=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=g1bqmy0Kp4g9VaQu2yr2zVYlOynszE/KmM+iSDj7cw4DeRLc4KFm1BsQgAROhaNI6
	 1yvnhJG2UuOI9kPmeK04S3ASG4+TheDpFXvEHORJR/QLZrCLgz7sxklwE9eb0KnOXi
	 aSKpnA7KG4QvZ0a638RFUEXrNszZG+KJAo+vN6fTzmKxTtrKWbpJU+BGzFzfm1jhcm
	 yo1A+sBu9dg1V0bomrp2Dwvti6FJW/YCk6S68SoQSO+mIIjXXKuvMJjB5mis2Y2RuK
	 3dbrOHshP7pPbr70ugmFP3C6DwmE9z0RboUWZQFtkaZk7UPGNLRK8rNGDjDytS/uIz
	 sMJSMjqZKWAgQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 93C0839389E8;
	Fri, 26 Jun 2026 08:21:14 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: live-patching@vger.kernel.org
List-Id: <live-patching.vger.kernel.org>
List-Subscribe: <mailto:live-patching+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:live-patching+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v3 1/8] scripts/sorttable: Handle RISC-V patchable ftrace
 entries
From: patchwork-bot+linux-riscv@kernel.org
Message-Id: 
 <178246207319.3816447.13538002278089334459.git-patchwork-notify@kernel.org>
Date: Fri, 26 Jun 2026 08:21:13 +0000
References: <20260609063002.3943001-1-wanghan@linux.alibaba.com>
In-Reply-To: <20260609063002.3943001-1-wanghan@linux.alibaba.com>
To: Wang Han <wanghan@linux.alibaba.com>
Cc: linux-riscv@lists.infradead.org, pjw@kernel.org, palmer@dabbelt.com,
 aou@eecs.berkeley.edu, rostedt@goodmis.org, alex@ghiti.fr,
 mhiramat@kernel.org, mark.rutland@arm.com, catalin.marinas@arm.com,
 cp0613@linux.alibaba.com, andybnac@gmail.com, bjorn@rivosinc.com,
 debug@rivosinc.com, puranjay@kernel.org, conor.dooley@microchip.com,
 jpoimboe@kernel.org, jikos@kernel.org, mbenes@suse.cz, pmladek@suse.com,
 joe.lawrence@redhat.com, shuah@kernel.org, peterz@infradead.org,
 mingo@redhat.com, acme@kernel.org, namhyung@kernel.org,
 oliver.yang@linux.alibaba.com, xueshuai@linux.alibaba.com,
 zhuo.song@linux.alibaba.com, jkchen@linux.alibaba.com,
 linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
 live-patching@vger.kernel.org, linux-kselftest@vger.kernel.org,
 linux-perf-users@vger.kernel.org

Hello:

This series was applied to riscv/linux.git (fixes)
by Paul Walmsley <pjw@kernel.org>:

On Tue,  9 Jun 2026 14:29:52 +0800 you wrote:
> RISC-V uses -fpatchable-function-entry=8,4 when the compressed ISA is
> enabled and -fpatchable-function-entry=4,2 otherwise. In both cases, the
> patchable NOP area starts 8 bytes before the function symbol address.
> The __mcount_loc entries therefore point at the patchable NOP area
> associated with a function, while nm reports the function symbol at the
> entry address used for the function range check.
> 
> [...]

Here is the summary with links:
  - [v3,1/8] scripts/sorttable: Handle RISC-V patchable ftrace entries
    https://git.kernel.org/riscv/c/57ad674d032b
  - [v3,2/8] riscv: stacktrace: Add frame record metadata
    (no matching commit)
  - [v3,3/8] riscv: stacktrace: disable KASAN and KCOV instrumentation for stacktrace.o
    (no matching commit)
  - [v3,4/8] riscv: ftrace: always preserve s0 in dynamic ftrace register frame
    (no matching commit)
  - [v3,5/8] riscv: stacktrace: introduce stack-bound tracking helpers
    (no matching commit)
  - [v3,6/8] riscv: stacktrace: switch to frame-pointer based unwinder
    (no matching commit)
  - [v3,7/8] riscv: Kconfig: enable HAVE_RELIABLE_STACKTRACE and HAVE_LIVEPATCH
    (no matching commit)
  - [v3,8/8] selftests/livepatch: Add RISC-V syscall wrapper prefix
    (no matching commit)

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCF0F256D;
	Tue, 19 May 2026 00:22:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779150168; cv=none; b=TCygj+rdmst90yTA24iicHAzcfzJ2poC2krIJ0oUX0tuUjYyAXtBkV7ieAxR9tDgsOhxYrGObB0VKS3F9NpW5Xv4f3x89IPChiGRsLHdyMV0zryC+3VjR0os/ZnzL1nJC7gLm2ZQkIGj7fH0i5PDR3LR+vPRI6P36ePETy4wYlQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779150168; c=relaxed/simple;
	bh=Anfm2V29kEqzlr/JH3ri8/rl14YQqHS868kBaMbZwoI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DwiQ5yVyRwX4k8mL5JeoPMBQYvCTcWwunxLzwi2H3DXRXLEqovDvsoVPckpgl1d9AlWbmQC04NROSTnVlI/Cc9dACjTqSfShQBT6Xby7XWZGVPIYH/IaTzvNJVLjY9OvNE2mqOjXZO1Q31NPKGxn9/gYOjPA1S2XLa0NRbesods=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KnFxmPTs; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KnFxmPTs"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 869E5C2BCB7;
	Tue, 19 May 2026 00:22:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1779150168;
	bh=Anfm2V29kEqzlr/JH3ri8/rl14YQqHS868kBaMbZwoI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=KnFxmPTsGPe/N/OFwLwrK5NtRjrGdsrXlvPYxSky3jwZWsKhViSDhEAeFQ3CPlwer
	 IILhttA5jEBe+Ksvh5kHXHYimu0vFkJf6Y9opsynBT4Lxq8q9qIo+091CdAgV2Cztl
	 31XtqLc45M1HS/DPOKyoA+VmhD++jRiJdx8mBFkfhySw5f/8XkpiOj64nVnpiYLpys
	 tZY2QJGeTaGlrD/59SYyogsA47zPVlPRCm20uDzvM8cQ1+sFogxO1N6OdGsN1BYidw
	 Fh8RkngIBJoOD96mrGI69NZYO2ilJY2w1rk9BJyCyirRTeKbLC/pi59w3VJBSc010B
	 glfq6PpW9cT+Q==
Date: Mon, 18 May 2026 20:22:46 -0400
From: Sasha Levin <sashal@kernel.org>
To: Song Liu <song@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
	linux-kselftest@vger.kernel.org, bpf@vger.kernel.org,
	live-patching@vger.kernel.org,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Jonathan Corbet <corbet@lwn.net>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Joshua Peisach <jpeisach@ubuntu.com>,
	Florian Weimer <fw@deneb.enyo.de>, Breno Leitao <leitao@debian.org>,
	Anthony Iliopoulos <ailiop@suse.com>,
	Michal Hocko <mhocko@suse.com>, Jiri Olsa <jolsa@kernel.org>
Subject: Re: [PATCH v3] killswitch: add per-function short-circuit mitigation
 primitive
Message-ID: <agutVsxfG2bg0lnz@laps>
References: <20260508195749.1885522-1-sashal@kernel.org>
 <20260517134858.146569-1-sashal@kernel.org>
 <CAPhsuW4x8shWon8Moi5VgCq2n4E2EzaaauZ2HHpy42Rp1Y-J-g@mail.gmail.com>
 <agsVDqdALBoHEHlv@laps>
 <CAPhsuW44UX663Au=WwHz8MVwnQgLkjxOqpJSCKxNiv3=RpZvqw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: live-patching@vger.kernel.org
List-Id: <live-patching.vger.kernel.org>
List-Subscribe: <mailto:live-patching+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:live-patching+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAPhsuW44UX663Au=WwHz8MVwnQgLkjxOqpJSCKxNiv3=RpZvqw@mail.gmail.com>

On Mon, May 18, 2026 at 04:59:08PM -0700, Song Liu wrote:
>On Mon, May 18, 2026 at 6:33 AM Sasha Levin <sashal@kernel.org> wrote:
>>
>> On Sun, May 17, 2026 at 11:37:36PM -0700, Song Liu wrote:
>> >On Sun, May 17, 2026 at 6:49 AM Sasha Levin <sashal@kernel.org> wrote:
>> >> * fail_function (CONFIG_FUNCTION_ERROR_INJECTION) is disabled in
>> >>   most production kernels. Even where enabled, it only works on
>> >>   functions pre-annotated with ALLOW_ERROR_INJECTION() in source -
>> >>   no help for a freshly-disclosed CVE. The debugfs UI is blocked by
>> >>   lockdown=integrity and the override is probabilistic.
>> >>
>> >> * BPF override (bpf_override_return) honors the same
>> >>   ALLOW_ERROR_INJECTION() whitelist, and BPF itself is off in many
>> >>   production kernels. Even where on, the operator interface is
>> >>   "load a verified BPF program," not a one-line write.
>> >
>> >If it is OK for killswitch to attach to any kernel functions, do we still
>> >need ALLOW_ERROR_INJECTION() for fail_function and BPF
>> >override? Shall we instead also allow fail_function and BPF override
>> >to attach to any kernel functions?
>>
>> I don't think so. ALLOW_ERROR_INJECTION is not a security mechanism, it's an
>> integrity/safety mechanism for both bpf and fault injection.
>>
>> It protects against a "developer or CI script doing legitimate fault injection
>> accidentally panics the box" scenario, not an "attacker gets in" one.
>
>There really isn't a clear boundary between "security mechanism" and
>"non-security mechanism". As we are making killswitch available
>everywhere under root, users will soon learn to use it to do fault injection,
>and potentially much more scary things. (Think about agents with sudo
>access).

Wouldn't the same argument apply to /dev/mem? If you enable that, and you give
whatever tool/agent/etc access to the interface, you're bound to have a really
bad time unless you know what you're doing?

root can already load a killswitch equivalent module, right? there's nothing
really new with killswitch.

-- 
Thanks,
Sasha

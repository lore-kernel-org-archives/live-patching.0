Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=216.40.44.12
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793296052;
	b=xq2zMGWUZJ2bMVQvoRtagywDHI8eiCsVetPCN3I++3r7vWXlixpGrj9P/UBbdIdvz66h
	 UAw+s9otpfBHFzangtPz6MpXeXkpacDzl5a6w+u9OK2ykLVAaLlpiP2K0thczuBEG76vH
	 5xJM0ohic2TBNKC64F7nArNPzqNViMIqSoqmx69f/NvzTcGpyvQBTxV/rITfXa/dUYK0J
	 X57ijwNf8OtQuaWbOWFmfS58iSxs4WzdgxR/ZQs6S/uBnkqcmcN94848SkbHUX5Vl/LHa
	 25YAmvQrb2lrCAKSSF/ugouU7uq2ZAtaFoYpIT/x9vJ09EEnWNLt39s8Xn+DJIcXKDw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793296052;
	h=DMARC-Filter:Received:Received:Date:From:To:Cc:Subject:Message-ID:
	 In-Reply-To:References:X-Mailer:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:X-Rspamd-Server:X-Rspamd-Queue-Id:
	 X-Stat-Signature:X-Spam-Status:X-Session-Marker:X-Session-ID:
	 DKIM-Signature:X-HE-Tag:X-HE-Meta;
	bh=TZqWEhV2y/lvzzClRPojBV8sMBYlwAYy6VL/gIbvyug=;
	b=2XfDa2UcW7tEUqDI6kZZPUEPuzmZipIE3fM9DRJTh4XGV3u698q/yOM/3Q/bbQeDaoNe
	 4fi3YGWF73+Vgo37G41mHdHHL0K+QvuISqisgn4dYLBZ6cDXPz+vRyUEK2tttIZOZCfrl
	 Vt+CUp8fGm/Z6hJF8nkowaaYQ/zTTeSDA4x1Em9jNSu0kzcKWM8YVBIut2UXhjU/gKHqN
	 SfFIh9c5L4JvyXGflpMCVkVHpBvhnykIpCeJNctec4qyp5NY6/9GrbaaHRxBFK+BqKd5S
	 alw2ijjEnsiorE8ZY8+2Urh8PMVl1CrDRLr+fG9MK4SEYihl2puKHEr9uk56F8ywcQg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=goodmis.org;
	spf=pass smtp.mailfrom=goodmis.org;
	dkim=pass header.d=goodmis.org header.i=@goodmis.org header.a=rsa-sha256 header.s=dkim1 header.b=k5xCO8Td;
	arc=none smtp.remote-ip=216.40.44.12
Received: from relay.hostedemail.com (smtprelay0012.hostedemail.com [216.40.44.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8239606A31A;
	Thu, 29 Oct 2026 17:47:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D8239606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goodmis.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=goodmis.org header.i=@goodmis.org header.a=rsa-sha256 header.s=dkim1 header.b=k5xCO8Td
Received: from omf18.hostedemail.com (lb01a-stub [10.200.18.249])
	by unirelay03.hostedemail.com (Postfix) with ESMTP id 2A5B6A050D;
	Thu, 29 Oct 2026 17:47:24 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: rostedt@goodmis.org) by omf18.hostedemail.com (Postfix) with ESMTPA id 43BA32E;
	Thu, 29 Oct 2026 17:47:22 +0000 (UTC)
Date: Thu, 29 Oct 2026 13:47:21 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: Song Liu <song@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
 live-patching@vger.kernel.org, mhiramat@kernel.org, mark.rutland@arm.com,
 kernel-team@meta.com
Subject: Re: [PATCH v2 07/16] tracepoint: Mark __do_trace_##name() notrace
Message-ID: <20261029134721.66bb584c@gandalf.local.home>
In-Reply-To: <CAPhsuW54Tco1Y_khWHeomq_ZTxvDoHFuX77w9cqojuXCrhGKWg@mail.gmail.com>
References: <20261023011049.1164625-1-song@kernel.org>
	<20261023011049.1164625-8-song@kernel.org>
	<20261023093256.20d3e300@gandalf.local.home>
	<CAPhsuW78w86tV3gwRWQMOdWUK7Rcc8dSsp==XypKdB5BMP6QiQ@mail.gmail.com>
	<20261028210844.105c431f@fedora>
	<CAPhsuW54Tco1Y_khWHeomq_ZTxvDoHFuX77w9cqojuXCrhGKWg@mail.gmail.com>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
X-Mailing-List: live-patching@vger.kernel.org
List-Id: <live-patching.vger.kernel.org>
List-Post: <mailto:live-patching@vger.kernel.org>
List-Help: <mailto:live-patching+help@vger.kernel.org>
List-Subscribe: <mailto:live-patching+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:live-patching+unsubscribe@vger.kernel.org>
List-Owner: <mailto:live-patching+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Server: rspamout02
X-Rspamd-Queue-Id: 43BA32E
X-Stat-Signature: drxb1cnkyexensd37b1u4a49sqbji47x
X-Session-Marker: 726F737465647440676F6F646D69732E6F7267
X-Session-ID: U2FsdGVkX18NORkA5fioUOLAX9SsNx3u5SPSwUmH0e4=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=goodmis.org; h=date:from:to:cc:subject:message-id:in-reply-to:references:mime-version:content-type:content-transfer-encoding; s=dkim1; bh=TZqWEhV2y/lvzzClRPojBV8sMBYlwAYy6VL/gIbvyug=; b=k5xCO8Td4pNr8GUnAHOmFxw0PniFVCmAijvq9Om+QIDCXCVj0CYvY/niKkFnfk1fp4JpMVTdosKVvT8dEixw4jB8uGqVUTf1zFfEOIN6AqTXrVWIeE91l1KdDTYXoD0m2NvIUBnsa6po2ACt8oNRSPwZrEGEhiFqV4cooGU61xs=
X-HE-Tag: 1793296042-951613
X-HE-Meta: U2FsdGVkX19+m4toOwYeAxCMuZBtYopgyOAuy4o4bNKDshcgXGTmCaxB1LDLJxS8Zt5fArQywqkEr8MkMmbK5O0qBaUyM2LLjNXz3Sl3oc7ufqgnCfC5mE6kWZhWVvYgT5Ah0kkfSpzeXKa6p6O82Dd/JqYGevW1nZFqaOD1gkLeS9bB5QOKNvy+OpL8gywg5ZT3k3Q9wcZyjRO7CnG0vhilN1rr1oZOuv8wtkrHj6ZENDGeyxJ7LpRPj4A0eket044bZKb6nJ2n1VuscCoAopEOH6gT+DrtiBJZp6PkgdFZP4B6dtrJWZ0sadxr390jr+Bg7bPLXeGqmlp5h9hqeZxcsEL+ZjjxM/Ei3K7h+syNcWUjLvo3cqouTUpW+7+nI28kNWtOMFMB+4CURMXUEg==

On Thu, 29 Oct 2026 10:40:57 -0700
Song Liu <song@kernel.org> wrote:

> Hi Steven,
>=20
> On Wed, Oct 28, 2026 at 6:08=E2=80=AFPM Steven Rostedt <rostedt@goodmis.o=
rg> wrote:
> >
> > On Wed, 28 Oct 2026 15:20:37 -0700
> > Song Liu <song@kernel.org> wrote:
> > =20
> > > Do you plan to apply this set to the trace tree (after the merge wind=
ow,
> > > I guess)? If not, how should we proceed? =20
> >
> > I can take it if we get all the necessary acks, or it can go through
> > the BPF tree. Either way is fine with me. =20
>=20
> > If you prefer me to take it (as I do have a lot of ftrace specific
> > tests), I'll do it. But I'd like acks from maintainers of all the code
> > this touches. =20
>=20
> I think this should go through the ftrace tree. It has very little to do =
with
> BPF. We discovered the need for this change when building live patches.
>=20
> Regarding ACKs, it is a bit tricky. For the code we touched in this set,
> there is actually no behavior change at all. OTOH, the real change
> happens to "inline"s that we didn't touch in this set. If such a function
> was left out-of-line by the compiler, it was not traceable before, but is
> traceable after this set. How should we approach this? Maybe we can
> just ask ACKs from the maintainers of all the code touched here.
>

OK, I'll just add it to Linux next around -rc2 then.

-- Steve

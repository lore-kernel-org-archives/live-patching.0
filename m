Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=216.40.44.13
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792762382;
	b=ZMU53ueqtk5KrC//IdBYZNlDax3oEPNT88FakbpSM8qAG7b502sH9BJ5rFB4F5DXzZSj
	 2vJzXFNQLrcLHMqoncPPD7a4fwhahlPnrSHijo1SPB4QtFmZYoyKPpzawzgug3wkKTupi
	 AqYtqWsofrNILs2i/G2koi6w697zbmvVO79JGf+q0MuWyqQ85hcStoqzQQa8tpL2vRbti
	 IHSL29s+iPjGOUXa8dG3DA6zHrXRt/QwnWv0yKwx1pCRTGlBzzvZhjawSketFvnWBdiFr
	 JbZirzPT9Lc3WwJis7z4M781vVV63dQZmQGfgLnD31uWmADpvMZ/dFJIE+dl93uFNUQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792762382;
	h=DMARC-Filter:Received:Received:Date:From:To:Cc:Subject:Message-ID:
	 In-Reply-To:References:X-Mailer:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:X-Rspamd-Server:X-Rspamd-Queue-Id:
	 X-Stat-Signature:X-Spam-Status:X-Session-Marker:X-Session-ID:
	 DKIM-Signature:X-HE-Tag:X-HE-Meta;
	bh=F7rw6auYLS4SpzkC8GTK58UcBgrUdlTlzRhuSFwxD5E=;
	b=SHwGHOn3xi5TgamWEpX0fJ7h+5VFYBl5SBeaW8Tsz2g42eTpp+RYz9uC6lK0Vfq8q0Ks
	 3XYetIQoKIu8E9eNya+riuspsiii8Sa+qJGrYX0mfXx5SWZpDFEWrbzoDI2e4QJl65bgw
	 7pWcz7Z1E2YtTCuoEj7ZbE0BtbJjBoNUdcxahvC0bKH2oSM57uIIOJhr4GZ9qbhsCUlBT
	 bO2F3ak1RrBmSs+VQkcyOM6P+fODWSSMux2rccTFJYBg/lPTn7aH+lI3kPepYrMSswDKG
	 JwynT1HRk9sxF6RhSOOmH+USpk7mpPMkrOQzfBMocqiIAFLKgEczLkgofn/vMa9OeZg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=goodmis.org;
	spf=pass smtp.mailfrom=goodmis.org;
	dkim=pass header.d=goodmis.org header.i=@goodmis.org header.a=rsa-sha256 header.s=dkim1 header.b=ijSOhbuj;
	arc=none smtp.remote-ip=216.40.44.13
Received: from relay.hostedemail.com (smtprelay0013.hostedemail.com [216.40.44.13])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2BA98606A31A;
	Fri, 23 Oct 2026 13:33:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 2BA98606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goodmis.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=goodmis.org header.i=@goodmis.org header.a=rsa-sha256 header.s=dkim1 header.b=ijSOhbuj
Received: from omf08.hostedemail.com (lb01a-stub [10.200.18.249])
	by unirelay05.hostedemail.com (Postfix) with ESMTP id 802EA40436;
	Fri, 23 Oct 2026 13:32:59 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: rostedt@goodmis.org) by omf08.hostedemail.com (Postfix) with ESMTPA id 8398920026;
	Fri, 23 Oct 2026 13:32:57 +0000 (UTC)
Date: Fri, 23 Oct 2026 09:32:56 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: Song Liu <song@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
 live-patching@vger.kernel.org, mhiramat@kernel.org, mark.rutland@arm.com,
 kernel-team@meta.com
Subject: Re: [PATCH v2 07/16] tracepoint: Mark __do_trace_##name() notrace
Message-ID: <20261023093256.20d3e300@gandalf.local.home>
In-Reply-To: <20261023011049.1164625-8-song@kernel.org>
References: <20261023011049.1164625-1-song@kernel.org>
	<20261023011049.1164625-8-song@kernel.org>
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
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Rspamd-Server: rspamout05
X-Rspamd-Queue-Id: 8398920026
X-Stat-Signature: 6szgc8uh8aeiqjjrgh53jhzmc1gri8ck
X-Session-Marker: 726F737465647440676F6F646D69732E6F7267
X-Session-ID: U2FsdGVkX18OvsBEw8Ud3/F0oR+Lw3bl/oeU0l1coOI=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=goodmis.org; h=date:from:to:cc:subject:message-id:in-reply-to:references:mime-version:content-type:content-transfer-encoding; s=dkim1; bh=F7rw6auYLS4SpzkC8GTK58UcBgrUdlTlzRhuSFwxD5E=; b=ijSOhbujBpUtnsIyR6odXt3xJ6ub0pytk/99TIjBC3kwfwTjOa4y1xnIvvdQg+FBRn49jbr2qz3X2DPSMFXbXiOrGiye5oX9Tq+M92dXXN8O7AykrIOwR5oiz11HBGg4AM5eOmcsISBMGWVRN5/7aXigxsJlrxGtuuno77jDiZ4=
X-HE-Tag: 1792762377-490633
X-HE-Meta: U2FsdGVkX1+GjCa/E6Mfohw/oJUJCTOkLZYaAJCnA3P3dpwM3XMlWnpJiGJZqHmrRESGCtKKUb6KObm5h173rzsCOHfrsAHLjShEkWLyOEH7BqVXPSkwtnxO1Ehi7eTLsyHaOQpk3zrlTPHQ4myejRtIKDbuBudDUVKZQFIDInag01MK16MjrsnfHFkNVSPOKcUQWwZpqXtlJOT0npM1WM9TH672TUMHL5Msujgr4fTGAEghDZeT+2M+1FwGUvQC7qi24tAL4sfagMRg1SXC7rnG/YmoG++LcZpRILfcrhCeOVITGr20EE2INoB+sg+ZrZulx7zNVZ+/ZHPBgXU/IdxmJBJhXQqPL3TUdLvzIG97ShEuDuEnyKOchrBEaKhROBDg/00NaZcU4sg3hJgTcg==

On Thu, 22 Oct 2026 18:10:40 -0700
Song Liu <song@kernel.org> wrote:

> __do_trace_##name() takes the tracepoint SRCU read lock and calls the
> probes. It is called from trace_##name(), trace_call__##name(), and the
> notrace rust_do_trace_##name(). It is a plain inline function, so if
> the compiler emits it out of line, that copy is untraced only because
> inline implies notrace.
> 
> Mark it notrace explicitly. No functional change.
> 
> Assisted-by: Claude:claude-opus-5
> Signed-off-by: Song Liu <song@kernel.org>

Acked-by: Steven Rostedt <rostedt@goodmis.org>

-- Steve

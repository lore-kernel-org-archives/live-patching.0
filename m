Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=216.40.44.11
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793236130;
	b=ErUCNwJi6Wxh76wiJ8IqW0Z774WEAAeJRHAfOTlDp972PRVOrixIN7zsbLqZUZiOiQ2F
	 FvbwRcqFDVxKlihIWdLqpbksoIbFfWmSm1IhXJHvmlDh5ssn6DlS+fqECvIsM+FMKnAih
	 r6GXIHZs/JO5t5GkgQcBPbCHZuwnWYZ+uHcCkhQUtMWIzkVyL9YPX+j2lHURapBm/CUcy
	 ZIbq+8CSsCgh8fC/14sMaL383WnBxyRn6obvqQzVgXWSck/GQrt0UulOnOuQI6BmsaYIa
	 FoyR8aQxrWWkiTYed+DZem/JRuzq9b7iYrgT6TomWlLT6Oy1MIqM8C+gY4Ybk2gxH1g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793236130;
	h=DMARC-Filter:Received:Received:Date:From:To:Cc:Subject:Message-ID:
	 In-Reply-To:References:X-Mailer:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:X-Stat-Signature:X-Rspamd-Server:
	 X-Rspamd-Queue-Id:X-Spam-Status:X-Session-Marker:X-Session-ID:
	 DKIM-Signature:X-HE-Tag:X-HE-Meta;
	bh=5dUAdbD583w0cxZdPyqG0/8OuDFEv0NHP0fbuKgWWMk=;
	b=OB2FUYfVFtPBSg1s2n2OzeEg8h9UzXAIG1llafS/jAetRSiSjEfCZwVdtIqc62nlqSGy
	 dtTakHIpIqUAuYtsrJj19NH9mybyympRrQ6fbjJG2ywnFJbZtu9kKb1FPC9LCb/yCC1CG
	 f6XtCwjLA11U/geyFmNVlKjdw4p1YnOBFriTxeam4LK4Z0PQtIaxlZHv/hVNRrqF//6Kd
	 AJ+ZJ9GPDMrrMnv+xzLNPywCu+EMfio2ehNFS43H/e7dkFeTd5Z3o+spdj96A79qBRRFg
	 gVozADpHlI7lcsXvtm3SSL/7Eny9Y6prrTQO4XxQ3kMptolw69IqDMLEkO4OplkJPkw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=goodmis.org;
	spf=pass smtp.mailfrom=goodmis.org;
	dkim=pass header.d=goodmis.org header.i=@goodmis.org header.a=rsa-sha256 header.s=dkim1 header.b=m4tvVkIj;
	arc=none smtp.remote-ip=216.40.44.11
Received: from relay.hostedemail.com (smtprelay0011.hostedemail.com [216.40.44.11])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B68A1606A31C;
	Thu, 29 Oct 2026 01:08:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B68A1606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goodmis.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=goodmis.org header.i=@goodmis.org header.a=rsa-sha256 header.s=dkim1 header.b=m4tvVkIj
Received: from omf02.hostedemail.com (lb01a-stub [10.200.18.249])
	by unirelay02.hostedemail.com (Postfix) with ESMTP id 0979D1201F7;
	Thu, 29 Oct 2026 01:08:47 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: rostedt@goodmis.org) by omf02.hostedemail.com (Postfix) with ESMTPA id 24E4480011;
	Thu, 29 Oct 2026 01:08:46 +0000 (UTC)
Date: Wed, 28 Oct 2026 21:08:44 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: Song Liu <song@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
 live-patching@vger.kernel.org, mhiramat@kernel.org, mark.rutland@arm.com,
 kernel-team@meta.com
Subject: Re: [PATCH v2 07/16] tracepoint: Mark __do_trace_##name() notrace
Message-ID: <20261028210844.105c431f@fedora>
In-Reply-To: <CAPhsuW78w86tV3gwRWQMOdWUK7Rcc8dSsp==XypKdB5BMP6QiQ@mail.gmail.com>
References: <20261023011049.1164625-1-song@kernel.org>
	<20261023011049.1164625-8-song@kernel.org>
	<20261023093256.20d3e300@gandalf.local.home>
	<CAPhsuW78w86tV3gwRWQMOdWUK7Rcc8dSsp==XypKdB5BMP6QiQ@mail.gmail.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-redhat-linux-gnu)
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
X-Stat-Signature: fbiqak3gh69qxotq9ppcdtg358g34ibz
X-Rspamd-Server: rspamout01
X-Rspamd-Queue-Id: 24E4480011
X-Session-Marker: 726F737465647440676F6F646D69732E6F7267
X-Session-ID: U2FsdGVkX19OfcNoiNsy0Lzx1Co9eO1IsS1FQ0e7MsU=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=goodmis.org; h=date:from:to:cc:subject:message-id:in-reply-to:references:mime-version:content-type:content-transfer-encoding; s=dkim1; bh=5dUAdbD583w0cxZdPyqG0/8OuDFEv0NHP0fbuKgWWMk=; b=m4tvVkIj2mL1WETv8pacDGjDciq2kEHF3zKuMhpY1mR4RIIIftdq62ztpRYI1IJb9pdg4pQ3E+mwO5mbvbSes+7204gEG0nyjP5Xf79defNIMm69p76YoMnXb0b8+nmCvVHaGuFdNVgYXzLNVbR3pr86mGtGw+8pDFZEOBPygEc=
X-HE-Tag: 1793236126-653337
X-HE-Meta: U2FsdGVkX18rdRVD82s61VMXfWJQHgQORymeZdncNXfzImetPHMJjA4YvMPEO2bdg/ywUw+8Kz7xewfI4Zya+iRC1gT/OeRsac6UOyrPIEctFg38NUdSauMmDK3xjTEruTn74FU+IBhetF9jJerKox5lF10/akqpVk37r15c9j1qZfM6HiMqcQCviC7qOQTAytpEi0zwpiyNjjD/zzPI7UukGeZjJ5Xqt+LIezuPfPh7+r9+NRng0TizMWbJ7ZLQEYpuoShhVbj9Sl1sfIVa0fSrWL2CpdM/0sqhda1GxVS5o4WLmDFB9v5CJ6WpiIyTqs2/5ipqval5IVhh6p0cOfQztPSrEhdA

On Wed, 28 Oct 2026 15:20:37 -0700
Song Liu <song@kernel.org> wrote:

> Do you plan to apply this set to the trace tree (after the merge window,
> I guess)? If not, how should we proceed?

I can take it if we get all the necessary acks, or it can go through
the BPF tree. Either way is fine with me.

If you prefer me to take it (as I do have a lot of ftrace specific
tests), I'll do it. But I'd like acks from maintainers of all the code
this touches.

-- Steve

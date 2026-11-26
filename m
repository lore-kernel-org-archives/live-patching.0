Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.128.181
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795662785;
	b=fh2GGmxBb8Klovi/ETTRxYEwYP3goNvfDiy8G7RfJpT5uW9AnqTqnJe8u6RpULRpOuN1
	 utczb+jC0iKI7c3jxvIZiasolqzaXlF086RltN36eDxI4DnsPEIdgSQVRADRBvExMk39n
	 oyd5DAkqUamTdpbx5Pm2V/RtYbwQn+yKYfj6NBISu9/g5w3zGypggwkEXHc2AnDhjAKmY
	 JXPFOgHAgTjWKHFm2/Ghll+fNRwBi0PmI8XFVokje/SBtpL1OoVndYJsuTs5DvyWUEz3H
	 +hMMaKOubqRcRYmgQI4svZ3wV/jkrDFgf5h43GMZDV+HYwB/tb+MXfh1JyvZpcBoDeA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795662785;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=0u2teU5+DNhXHRl/MB1LD7h44EF6lJ6g1dkNyrP5OEA=;
	b=oF3MnjMDMvJMm3rnIfnywlFxUk/HI2bR5IFZe5mVtDlHu2gNpBcZp8Ynvgeu+Xg2CZMt
	 BtvC64p3p06WDDS+qa7LAj4LIW5e4/kIQilpChFUx2Sek4H5CmjtyrRlKTYoKQWATxkd8
	 KRMQ1MfVOzwTKkbO8nyzQBSdpc80Hymnz/focl1hZnid53e+jYPmsU83GaLEOly5vLdSZ
	 bkN+v9ls4A539Evi2GTV+DiNAwCFVbp73QMHiJdJs5dmulbKTrmhx/voPtifA204TgpLH
	 uRvCNHrbIovx5fZFjylbRhYb/IIKEC4K5kyDk/Ty9cML5ELsjO85sUMrQXrAtAqjQBA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=UisuFHf+;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.128.181
Received: from mail-yw1-f181.google.com (mail-yw1-f181.google.com [209.85.128.181])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3247606A31E
	for <live-patching@vger.kernel.org>; Thu, 26 Nov 2026 03:13:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C3247606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=UisuFHf+
Received: by mail-yw1-f181.google.com with SMTP id 00721157ae682-8b4fb5d96b3so101387767b3.1
        for <live-patching@vger.kernel.org>; Wed, 25 Nov 2026 19:13:04 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1795662784; cv=none;
        d=google.com; s=arc-20260327;
        b=B4G1zDdvuMopRyDlilS/Obp4g6YCp6D/87NLItUNlL1RQ61eSqi7TKcAmCNV1WeRMQ
         EJuvSSCzCwjHY/Pn99qnatigSF2lnDyGipSN2S9tQ2DjFDXpxsLU3PuY08jX4t0uqNKN
         S7ptYVzK1bFey+O/1bZPTdKtFiEs3n+lWSZ254BGVKYsf84uyncKJOYLfSxvsK0uEBha
         j2YPaZ8l9x2aDD/rYD5Ws+j5IaqR+kYwZnCJDbqhKumL7pz66LMCn8H5INFvsYJL90h7
         S3gL+3O7zOwgGcusPLp4f/szxvd9pJrCh7L25jnSbRwdhwndJtklraQYyVqdHMPl6eDb
         G06Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=0u2teU5+DNhXHRl/MB1LD7h44EF6lJ6g1dkNyrP5OEA=;
        fh=uIrY2IjZ6RBstDtZ04Qk4PXOZ1I/sNJ2TIAIZ0X8/mw=;
        b=FTrabnMzFYotiUqEQVNTJUYMt1kIIk9S2ANe5Q1sGKnBMu0oqpAaLl+NElegT+SEtH
         Nj1oB2qo6vtmSH+jrCYjy0T42yjM2aXoLKy421h5alo3sOoP/mxmUm7dWUm4MMEkFGXn
         +udgHl0BFTS29LTS85WoFPTKKtp83Xeo4d7UoXSatk2jxJjD/Vnm8LPTxUXpEJDz5KEL
         xkcI1zM70et5jhBlWURJyGFD55W2bWDFPEcCm7hgBabxK1Xp+XfGv326qbuXs8QZxvPi
         B3WwtIOe78BPNlVzr1FHJYox6qcgn2sQ3h7uWcnBWdC6nByrkRPqK81ZaVBiU/9dMTP9
         greg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795662784; x=1796267584; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=0u2teU5+DNhXHRl/MB1LD7h44EF6lJ6g1dkNyrP5OEA=;
        b=UisuFHf+11MsiQEkohokz+1jDpyAqyX++7iLpg29wa6o3zjneM/lyPoL7/X1iNCEvO
         kZScrauJ/qMJ8kMTxa9PFoPJ1TS8z1vpnkJ2zARofylySHngdnuX3MXKPt14xwi57xsW
         lKGFJhN5zuUVkvmiYHg9G2xqhUaazUBCFZvZ/o2kXcCF4v6M55t0XkuGjKZ7viu7LHFr
         JGllJTyjOmxI9DqOjEdaNNZGAZn5Y+OruXKEea+t4GQMCNUMA1wO+NifHnnJxe+LhmGk
         GUwD6owy1Fy+/g9Giv6BbOgVUoDMYWVEhSGcOxlAq/FBCzAaK1Hs97skGyOP0qFngu51
         GsWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795662784; x=1796267584;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=0u2teU5+DNhXHRl/MB1LD7h44EF6lJ6g1dkNyrP5OEA=;
        b=koXvOxZRHpRRip5i19poOEPWN0rdwOr1sFaUscNLCoTt6Diy9Tco1LugalWpUf/Rw6
         xjBeekUq3WJjGH9iHA3ccgG7Qc77YhUwNjElZt9lGqUiJqA+5gej83RtKm2vji1RMSJZ
         z8HDuSzq2edcsIa2esYfN9kMQUe0jZmno3/3dGuMTHRVR/z9FNoL6avw7EWPa9MDhcXg
         M3P7LLLVsw1/cWKY1j3LFD6Ie5Cds5FjR3Jp/tBwW5F4SdOVMT+NNxA2F74lMVgXx266
         6nGPzgsetA9D03vueCHUK/p7kq0ZuAttkFzEknUkATZbbzrqV06yYW7qoa0lnMZIEyrm
         XRRA==
X-Forwarded-Encrypted: i=1; AL+hErGA7ywECd3Cwv+Z5gq0CNCZ4EndTQgUVcZRLrQOh/jKYz6xc7KuBaoHeURCqrhnDyElcEN1954yOJrvElB9@vger.kernel.org
X-Gm-Message-State: APuU4Z8I9Sb0SmpPSJKP2zr9UlxcOKcDF0IpZqupe5k+sXOGG2uEIj+M
	nYsC7RHgVvETDyLtQumEAEQ7Nua2aLmQF3u/Um60JGgv2F/0cAlgPC/hvw3RdMrS7wl4/bIWCsr
	SWqijCv7WVTNQpF5haWq623KOU8gQhPQ=
X-Gm-Gg: AZFdTZfVUFWA9agayhgJImD8f+vTBjAgzXiSUel8IlJUnKvTzJrBQ8C2GTB1VPFZpbP
	O8SQJioCRqjaj4auaF56ivLGF8VRh/5KBVD9wFnC4KMijEAP+DU97Gwf9f647E5qU5ZY+djCz3B
	Z+DK5+m3Frb93bwg3fVQpj3+EZuSJBGeWz19+tpVXO9axxiwzwkTmv5mpRhk2X/Mw1lz+mWwzN/
	5yzTwJCv7pszPp3z96nUTOyfyL4yKJb4pIT88uviNcwD4HJye0gHFVsJ5RvwFDzexFaYD0IpMK6
	2vKifJbE6Bcf8oajINfoqPv1V3R0bXbBcmVE2WUEwJ2AUsvmxFMQ7pSK+gEW6aUjOlraw1xGnCd
	bYJGd4STHd5nwn+7eoAoFGGbNfpA/j+vq2v7OQ+A3xzUQkcnr43rniPc8P6QoDSKzbOA=
X-Received: by 2002:a05:690c:6d83:b0:8b1:6c4d:6b83 with SMTP id
 00721157ae682-8b518f1cf54mr82200347b3.24.1795662783714; Wed, 25 Nov 2026
 19:13:03 -0800 (PST)
X-Mailing-List: live-patching@vger.kernel.org
List-Id: <live-patching.vger.kernel.org>
List-Post: <mailto:live-patching@vger.kernel.org>
List-Help: <mailto:live-patching+help@vger.kernel.org>
List-Subscribe: <mailto:live-patching+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:live-patching+unsubscribe@vger.kernel.org>
List-Owner: <mailto:live-patching+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261125-klp-series-v3-v3-0-b1e0f79af331@vt.edu>
 <20261125-klp-series-v3-v3-2-b1e0f79af331@vt.edu> <sashiko-outbox-234405@kernel.org>
 <DM6PR05MB4137C0B5BB4D88A9D5847EBAD1432@DM6PR05MB4137.namprd05.prod.outlook.com>
In-Reply-To: <DM6PR05MB4137C0B5BB4D88A9D5847EBAD1432@DM6PR05MB4137.namprd05.prod.outlook.com>
From: Yafang Shao <laoar.shao@gmail.com>
Date: Thu, 26 Nov 2026 11:12:27 +0800
X-Gm-Features: Aa3M54r9bQyCNEtl8vDg0fA8BgkRlMLeLZFLbV6lOjC0bsXV0kG9vz91uifhxJo
Message-ID: <CALOAHbAQuYG__4b054bRobVRyT+v143wBcVAN26T_PtiO-oqmA@mail.gmail.com>
Subject: Re: [PATCH v3 2/3] livepatch: Include exiting tasks in the transition
To: "Ravindran, Binoy" <binoy@vt.edu>, "Paul E. McKenney" <paulmck@kernel.org>
Cc: Frederic Weisbecker <frederic@kernel.org>, Neeraj Upadhyay <neeraj.upadhyay@kernel.org>, 
	Joel Fernandes <joelagnelf@nvidia.com>, Josh Triplett <josh@joshtriplett.org>, 
	Boqun Feng <boqun@kernel.org>, Uladzislau Rezki <urezki@gmail.com>, 
	Steven Rostedt <rostedt@goodmis.org>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, 
	Lai Jiangshan <jiangshanlai@gmail.com>, Zqiang <qiang.zhang@linux.dev>, 
	Josh Poimboeuf <jpoimboe@kernel.org>, Miroslav Benes <mbenes@suse.cz>, Petr Mladek <pmladek@suse.com>, 
	Joe Lawrence <joe.lawrence@redhat.com>, Song Liu <song@kernel.org>, 
	Ingo Molnar <mingo@kernel.org>, Jiri Kosina <jikos@kernel.org>, 
	"sashiko-reviews@lists.linux.dev" <sashiko-reviews@lists.linux.dev>, 
	"live-patching@vger.kernel.org" <live-patching@vger.kernel.org>, "Shastri, Jaidev" <jaidevshastri@vt.edu>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "rcu@vger.kernel.org" <rcu@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Nov 26, 2026 at 8:58=E2=80=AFAM Ravindran, Binoy <binoy@vt.edu> wro=
te:
>
>
> Thanks, this is right. A dying task reports its quiescent state in
> rcu_note_context_switch(), early in __schedule(), and then still runs
> traceable code, such as update_rq_clock() and pick_next_task(), until
> switch_to(). RCU does not promise to wait for code after that point, and
> with expedited grace periods the quiescent state is reported right
> there, so synchronize_rcu() can return too early.
> klp_synchronize_transition(), which v2 used, does not have this
> problem: schedule_on_each_cpu() completes only after the work item has
> run on every CPU, which on the dying task's CPU happens only after
> switch_to().
>
> v4 goes back to klp_synchronize_transition() for both waits and keeps
> klp_try_switch_exiting_tasks() from v3. I will send it after rerunning
> the tests.
>
> Yafang, this reverses your second suggestion; I hope the reason above
> makes sense. It also brings back the v2 transition times.

Agreed. I missed the point that the quiescent state is reported early
in __schedule(), and that the code from there until switch_to() is not
covered by synchronize_rcu(). Thanks for pointing that out.

--=20
Regards
Yafang

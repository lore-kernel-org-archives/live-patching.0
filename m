Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.128.175
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795502861;
	b=du/TBDQo1TFFsG4A/jjxFVUnWbIJdjn1iHv0fHWrJijymanbhs0UxY12liaQrY8bPERm
	 uUu3hB5emNU6aGDlZ/98rO0tHtKO1R682abtwVsR+DCGIuY6KNWA+3k4vOClkWJEPqsQx
	 X8slqkWXWDxHnPZ+JUrxsL7LpbAsPUNiYamwwZveKyr+Eau5/456e3LzhfEL4Dhq/+jaE
	 84HwHmsqYksCW/R9/GOcd+jwf0+Rma92tsJDZo0EZC3CTaNSj86DedG89kmlB593wIkM4
	 SRhBLR2C54dKVyucv9BkA/beU6mkbeRuACiubCsCkrXg4sDz+ez0ct6Y+rx6Wl1emwQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795502861;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=VnrZOZlg3BlUOIyh9s4cDgTJrHx2oMwWRpzxMW8e3a0=;
	b=5VpLqtnHuPgNMHfyjeRvo1N2MImdSkHx9Lj/kK3dmk/gs1giMDpbYLIcOMsmNGATSXKG
	 bJA+nsuNwk+LVFsx+IBKMQv0nKUK5P6UETz8oLBsTaKLJtufvXcnyAwGfO1EiLBqSa6Cg
	 algFy/PaguayuFQ80xfs/19ERWkYQ+F0nZ3khAUPYwchy1XJ6PBznpzIiq8SLrdjJS9hf
	 IZmWSL3ebCsQzUZo6sX0eLw0aINHsYTqRF5bslDrXN3U3llqOAGOvPX3adZh8qaDwD+6m
	 VorAQe4yXHMF1XQyfG+RnlCjBWSdJNf1XzEpTqGYfWagskNq6uZ2N42bHgJbmlaTABA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=l6KiE0vX;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.128.175
Received: from mail-yw1-f175.google.com (mail-yw1-f175.google.com [209.85.128.175])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2EE5B606A321
	for <live-patching@vger.kernel.org>; Tue, 24 Nov 2026 06:47:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 2EE5B606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=l6KiE0vX
Received: by mail-yw1-f175.google.com with SMTP id 00721157ae682-8b30cbfa628so29885177b3.0
        for <live-patching@vger.kernel.org>; Mon, 23 Nov 2026 22:47:40 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1795502860; cv=none;
        d=google.com; s=arc-20260327;
        b=PfrqplIjq+/RpC5ldpKzIaFCCYJM6mxqtRfRhkRDRcYZsteVv0shl3qhy1IbOJVsLP
         lemlhtDA0PYM5p2VIOqu1KUzc69R2/iChZ4M6JlA7DhL8jysd/dYCZyb4mCZNSSe4R5h
         oopj5hBGLPxGekhn0wLnQQcezebYEGr8o7qX8QBMTk+4hKOKNW8zd7KaHrPmH7f64Am3
         EsO34vwj48A4sPBt8uyZNvF9SBhmoN9AEuXNzCA5B8tmrXZaPnuVXMX6L8BaKtFt6neb
         haQ8UBY2Lln1sykzDYkiu/iA+qegKGI90sPuozmPgoYMVBIjT6+eWBQPKJReLlA3EFW/
         Prmg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=VnrZOZlg3BlUOIyh9s4cDgTJrHx2oMwWRpzxMW8e3a0=;
        fh=Qr+6iZEyN/SxLY5G/sxMO88fFQbJu483/4v8/DIwCNw=;
        b=eV+8xPtAoFL9yZMOJWo8nhi0cQKnsXQLLRzy+0PGtA3s8Pg2/InCjQu/Zrg0uIU/Ie
         IS6f++FjnY1A6wmQDqHshjH83jLEuLqCg8CliM7JoYtr04SqjDSNkA5K5PfXIcC+1jqY
         a5VXTBRfcogZ4VRJScxECHiGFGCWE8U+Ua1wJu2NPgsPG/K8P9cEVjFP3eQmWqa504NA
         SfgldcGRbzYtesbnsy04y8/hlWj2TcMUd1RovYuwrCnocp4+2Cx2YBEjar7z6KVFKegV
         xcOoDWtJBlWMLWy6gVf3i86sXNsQAmwpLjYjX0v2FmAJlnM/VoArcbwgKvucvHoObpJY
         Kbpw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795502860; x=1796107660; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=VnrZOZlg3BlUOIyh9s4cDgTJrHx2oMwWRpzxMW8e3a0=;
        b=l6KiE0vX1DJWMgWjM8XEA6zfQmx+6toUGoWw49iNLZ2omHgB1EGKia+KQ9rLVa4EGn
         ICr+sMiZRF53bVRYYmsKeQGoVSR/QUMZ7Z78d3e2Fv464j90HRMgNMOSyWqOC9E7T03Z
         LJR7+upDUr92NJCWACupI+hSqkFt9bicdtGtHWTxpu4YwAoLqO0HlfdzPrCx6gFHWHLu
         xaiTtAkAoAvSuo2mfhCJTa1xc4Cov+uZI/fi6h7jfhpXNIVgyr08nlxdiiX/RA/K6Lnv
         H4OauwOSlcelISEbafEo5XADmEcNT9yKBAS5uQj4Sg7mjzgObOLPWacsXxHWD+hKX9fq
         zF6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795502860; x=1796107660;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=VnrZOZlg3BlUOIyh9s4cDgTJrHx2oMwWRpzxMW8e3a0=;
        b=ynvsXQMmvKd8zGgoqNN6v9ds1CyOTD/8p/Trk314c1VS9Cl/HF2XpCf3zzYXA90Tun
         5d7oal4irclrPXIoijuXu2gFII87S2GYPbZuYzFVgt9hpAFlcoe02BS8JaJi7ZNc+BJN
         aTbl3vwQpovmYzSt2+09gH8cozpeAHiA8vJ/hFmk+NGGnf8nXK7qNH+nU+WDIK+RpScG
         8WgaV0cjiMc1kmCjwYgat6LeuGoBvPWODiIgQhEEhUYGD0Zwc3vt/gl/WJV5IgV1dbp5
         GD2RQV9GANgme03u1kAA6a0yBYeshRQgKvig9tFRLDGjWY5ziaObw53LZ65NjsHQyk6h
         lqQQ==
X-Forwarded-Encrypted: i=1; AL+hErEnmbGYDE/8jhO4ZgWAv52S05F4zw/d4GQIkbzW2UJ99IOr9fjfM+VMoxsXTkXk90gAZQDVa5DEZctW5UkE@vger.kernel.org
X-Gm-Message-State: APuU4Z8Ht+GR1rjymdqOc0cAXCd1CYxrHuxV+CGaTZwo8uuwJvaqZ77I
	Gk1HTteUOkK2bWdLFB81fJRhNnd6zF/kLFjAzduCb8ZSg+Zlo7qoJL0sqwXbNnRmVYVeCVwxlr1
	FGjzrVikmeMXifCJTDAtaa590EjbVeLY=
X-Gm-Gg: AZFdTZfr/PQ8P7HOZ2pZd+VGXWx6tBkX+Nip232DodeBzlkgUk1EA8vw5tUMt4+MMeV
	6Zan82TucIoqSSZiUJI7xXFwRIlEI2oCyUBjMfAT5hcJ5AfgFWe+e7Fc5JKBsS5Ey9jKVdiOH30
	u8gdgG9w6eJ2HWzxv4A+snC5cu0J0ouncIXrN28eq7i67EaRRmB+XEuWpNxfkg5Vj2+MWhDJJS0
	9jeRp1g+DsVWTjhd/UTMK4m2y1V8Nsq9glRnrUMSf/d3iGbkdZkE0Qy8GtNzv8tRRT00nzgWPSO
	J4BcCAF8IXPqdyRq+2tuzQdWPJ/9Ieh+RBXegm058AUVykajODpO7UR+OUvrj+kihnHZj7IfL47
	D68gNefiWo90B5aXZ1dXO3isAHHG6uhNHkBOlLhwSkAEeBZoB0lsXz1iwfguKcsAlB9fziMYmDg
	9PQDzqMuv44dM9
X-Received: by 2002:a05:690c:f0a:b0:8b0:a8c1:b203 with SMTP id
 00721157ae682-8b5204a4d62mr49738217b3.29.1795502860010; Mon, 23 Nov 2026
 22:47:40 -0800 (PST)
X-Mailing-List: live-patching@vger.kernel.org
List-Id: <live-patching.vger.kernel.org>
List-Post: <mailto:live-patching@vger.kernel.org>
List-Help: <mailto:live-patching+help@vger.kernel.org>
List-Subscribe: <mailto:live-patching+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:live-patching+unsubscribe@vger.kernel.org>
List-Owner: <mailto:live-patching+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261123-klp-series-v3-v1-0-427c95811d9b@vt.edu>
 <DM6PR05MB41373C039888AD13938D3838D1452@DM6PR05MB4137.namprd05.prod.outlook.com>
 <CALOAHbDu5NmVowk4SHzeUDxASaxKkbL_w1dModFWzdi8yK9tBw@mail.gmail.com> <DM6PR05MB41377901DA5182DDFAD6E3D4D1442@DM6PR05MB4137.namprd05.prod.outlook.com>
In-Reply-To: <DM6PR05MB41377901DA5182DDFAD6E3D4D1442@DM6PR05MB4137.namprd05.prod.outlook.com>
From: Yafang Shao <laoar.shao@gmail.com>
Date: Tue, 24 Nov 2026 14:47:04 +0800
X-Gm-Features: Aa3M54o2kD5CAgD6Kh7BeaSGBGBREFHEzSySI0CnyEHkEYGRzmsY1gHwE2Ygmgc
Message-ID: <CALOAHbCDSAuvxHt2jd-f5rvTrxeZ4KZkKUfqxrE09PXk+Te36Q@mail.gmail.com>
Subject: Re: [PATCH 0/2] livepatch: Do not lose exiting tasks during a transition
To: "Ravindran, Binoy" <binoy@vt.edu>
Cc: "Paul E. McKenney" <paulmck@kernel.org>, Frederic Weisbecker <frederic@kernel.org>, 
	Neeraj Upadhyay <neeraj.upadhyay@kernel.org>, Joel Fernandes <joelagnelf@nvidia.com>, 
	Josh Triplett <josh@joshtriplett.org>, Boqun Feng <boqun@kernel.org>, 
	Uladzislau Rezki <urezki@gmail.com>, Steven Rostedt <rostedt@goodmis.org>, 
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, Lai Jiangshan <jiangshanlai@gmail.com>, 
	Zqiang <qiang.zhang@linux.dev>, Josh Poimboeuf <jpoimboe@kernel.org>, 
	Miroslav Benes <mbenes@suse.cz>, 
	"live-patching@vger.kernel.org" <live-patching@vger.kernel.org>, Petr Mladek <pmladek@suse.com>, 
	Joe Lawrence <joe.lawrence@redhat.com>, Song Liu <song@kernel.org>, 
	Ingo Molnar <mingo@kernel.org>, Jiri Kosina <jikos@kernel.org>, 
	"rcu@vger.kernel.org" <rcu@vger.kernel.org>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "Shastri, Jaidev" <jaidevshastri@vt.edu>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 24, 2026 at 12:57=E2=80=AFPM Ravindran, Binoy <binoy@vt.edu> wr=
ote:
>
>
> Hi Yafang,
>
> Thanks for the pointers to the earlier thread and to Josh's
> suggestion.
>
> > I did not take it for the same reason Sashiko raised in issue 2: the
> > RCU exit list narrows the race window but does not close it.
> > I could not see how klp_synchronize_transition(), as you describe
> > below, completely resolves it. Could you please explain that in
> > detail?
>
> The exit list alone does not close it, and v2 does not rely on it
> alone. The exit list covers the part of the exit path that can sleep.
> The part it misses cannot sleep or be preempted, and
> klp_synchronize_transition() waits it out. In detail:
>
> 1. Where the gap is. An exiting task is on an exit list from
>    exit_tasks_rcu_start() to exit_tasks_rcu_finish(). exit_notify()
>    runs inside that range, and the task is unhashed no earlier than
>    exit_notify(). So until exit_tasks_rcu_finish() the task is on the
>    task list, an exit list, or both. After exit_tasks_rcu_finish() it
>    may be on neither, if it has already been unhashed. That is the
>    gap in issue 2.
>
> 2. What the task can do in the gap. do_exit() calls preempt_disable()
>    before exit_rcu() and exit_tasks_rcu_finish(). After that the task
>    runs only lockdep_free_task() and do_task_dead(), whose __schedule()
>    is its last. From preempt_disable() on, the task stays on its CPU:
>    it cannot sleep, be preempted, or migrate. So once a task is in the
>    gap, the next context switch on its CPU is the task's final one.
>
> 3. What klp_synchronize_transition() guarantees. It calls
>    schedule_on_each_cpu() and returns only after a work item has run
>    on every online CPU, so every CPU has switched context since the
>    call began. Any task that was in the gap when the call began has
>    reached its final __schedule() and will never run again.
>
> 4. Where v2 calls it.
>
>    a. In klp_init_transition(), after patch_state has been set on
>       every task (the task list and the exit lists, walked under
>       tasklist_lock) and before func->transition is set. A task that
>       the walk did not visit had left the exit lists before or during
>       the walk, so it was in the gap when the sync began, and it is
>       dead before any function enters the transition. So when
>       func->transition is set, every task that can still run has a
>       valid patch_state.
>
>    b. In klp_try_complete_transition(), before it calls
>       klp_complete_transition(). A task in the gap can still be
>       running code reached through the old function, and the switch
>       check cannot see it. The sync makes it dead before
>       func->transition is cleared and before the old patch can be
>       freed. A task that leaves the exit lists after this sync was
>       already counted as switched, so it runs the new code.
>
> So there is no point at which a task that can still run patched code
> is invisible to the transition: before exit_tasks_rcu_finish() it is
> on a list the transition walks, and after it, the sync waits for it to
> die.

Thanks for the detailed explanation.
It makes sense to me.

>
> One limit: the exit lists exist only with CONFIG_TASKS_RCU. Without
> it, the helpers are empty and only the final non-preemptible stretch
> is covered.

Is it worth adding yet another separate list for the klp transition?
If not, I think we should at least make the CONFIG_TASKS_RCU dependency
explicit:

--- a/kernel/livepatch/Kconfig
+++ b/kernel/livepatch/Kconfig
@@ -12,6 +12,7 @@ config LIVEPATCH
        depends on KALLSYMS_ALL
        depends on HAVE_LIVEPATCH
        depends on !TRIM_UNUSED_KSYMS
+       select TASKS_RCU
        help
          Say Y here if you want to support kernel live patching.
          This option has no runtime impact until a kernel "patch"

--=20
Regards
Yafang

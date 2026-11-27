Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.43
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795792217;
	b=iGy6tdY0AWku8DIZq2pa3yGqTJ5I9qhRXtJ3fM/fMov4FXSnEzgsk7vpI5RBamgXiqCs
	 IYdYC/b+DsBXxUbPrwwDJ+F0C3Khax0gBgFvHAHQSb9arg+BySJltHApOqkDx1/x266M9
	 gEKHTDLVWhL7VwiKF5jS8k5IxbS6wBeBDsoBpVvLJK61RGjktP/gwe4SWnlutvlAGpO4L
	 uZaIDeQR2D7fdrFZPPFlvyKBCyBWIWBK1l5gvLxBcov2EW9yn1rTOh9NWDs6IM8NL3XtL
	 TVR7fdpqUNHrvpXvA6xcbEaI9rUtK8/FQjXAa1+3DFXCPKPi1MGKdJyczlP0qd74q6Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795792217;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:Content-Transfer-Encoding:
	 In-Reply-To;
	bh=dB3Mu1p4rL6bAO330MA2e6OIkjqTQSd8YGpfYYCrr/0=;
	b=0aPdPjsRxS/sZ7it9XGGhqOxVcydLr13xdnH63dKsszP317EKuOKCwAuE/s7FjT/jULl
	 /CjfKgUEmHfcn0o0yBIht4iUniC7pveIEjXstc0C4S98zjRsawpS0V9SGzCDyazpL21Dx
	 JGqvKbtkL3OOEI7/2DXoc2T33jk4Y19v89rFbMIfJpReixhyt3NkSADZr/s4WHaD0YQkE
	 ReETEZJy8gCH2R+vK7+U7GUvoI4pw5TM6EeBvgPJx61V09I2Ded4RN+exwI49aeflbxQt
	 bp7kDCOA0cJ7cyluL7teY5y2Ewpw2QLiDuaq/dQiZTwIWio4ptEkonKdfYiRB2sKZpg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=suse.com;
	spf=pass smtp.mailfrom=suse.com;
	dkim=pass header.d=suse.com header.i=@suse.com header.a=rsa-sha256 header.s=google header.b=BNBBToX9;
	arc=none smtp.remote-ip=209.85.128.43
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 778EF606A31F
	for <live-patching@vger.kernel.org>; Fri, 27 Nov 2026 15:10:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 778EF606A31F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.a=rsa-sha256 header.s=google header.b=BNBBToX9
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-4b467581b98so79228255e9.0
        for <live-patching@vger.kernel.org>; Fri, 27 Nov 2026 07:10:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1795792216; x=1796397016; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:from
         :date:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=dB3Mu1p4rL6bAO330MA2e6OIkjqTQSd8YGpfYYCrr/0=;
        b=BNBBToX9KBOtwdKh9WaJ9mUZLDZorMOpz24pc+Ie7Va4OwK4iffPBdEtrf+IAhTs/r
         RMHWVFmj7aQYIJ4PL4JujOOWTdVODgr3hmIix7XIX8JeVbRP8EyrmzdxI9ihdcxVxRmX
         YJfXkCyYI+9ioSrCpKMUdEmGe1cNXx7B/3yf8+hpb9hH+B2tDqqO1HOuN4Nq3MjPgofw
         kCk7u/CuHzkgPPsl9yq4Q3NK8qwZvU9/2bc8ysn81X3mCDGpLJEkF8Knzevfj+fJrv2B
         CE/0YYW8j4fdZcHmkpjewsVgd59W92doOnUF0T1AhDGFc7qqPcYEPy/B/pdc3vGo7DYi
         1ooA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795792216; x=1796397016;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:from
         :date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=dB3Mu1p4rL6bAO330MA2e6OIkjqTQSd8YGpfYYCrr/0=;
        b=qwCKqk5T+eCswVBPIopi9gSOist0KsUetM95/9Z82ZeRIp2MM/U+NyNmcFnssgfgrD
         ClUmaEYKUDlXpJZMKP1CXzo50fSTmPdTlnlTTpV/ByclkZ/Bu3BOyGU5GTp0LSpR48Tn
         JIHLiWCzpWgx3uGTlzlnm7LoTxgX46ArthYtAltBKWY88x1vpwChsdUq+feTbeh7p5bl
         uK4luiUgg2dGUBBC4aVLVVsy+8tcZNn2uR8ocK7qUF3IH/dG7mbl3RrL4R+cgfpsDIxl
         z+gFmkGKoHIZ2vPagRJMvn3vEptdxlWfwwgNaqjQzu6Y6otOB668Y6wXD9LBt4ZTCVjo
         H05A==
X-Forwarded-Encrypted: i=1; AL+hErHMaZgU235sORt2f6RDWjL0r4U5IbMl6cfmObhk9PhyUSC9qeAhrStIe22LXl9xBYysECer2v6nvqb9i7Sh@vger.kernel.org
X-Gm-Message-State: APuU4Z8V7hqm1/11N0nL4i+ztW6Vrp2WpbxARP8dIdyVWg8Y/Mz2kJ4f
	CObhQSRVrFfi2sNMk29sog6yIhJPSturu/4cWECgPdt4LcVCSNPlDX5dZ/JW+OFCiGk=
X-Gm-Gg: AZFdTZcVvwNJfiR9ZE3nwouRDHkvwtNFXEp/y2gaNwFqza45p5a7gAM6CL3uBFvzpGB
	FYDdQdRSmqH+TXOZkJYD9z7c0DuQw30oU2cu6E6GFrWXxiLe2UYYLGcduVplYNGVQCVvq3eqsKF
	xHYhtfSlWLHCR/WB+ut1i+rJ+jh7rwSiuEWULMUYmBJxEcuRjHSXc/+CoMrHXdan4OTamegRNZ1
	BVuUeU9bEtgIzNcdjYyyQQP4tDFEM1J8dr7GzrX7P8eBdxeKlHmzSl76l9CvW5fOnV90L4i62yi
	eLWDKNQZUk0IrQy+2CXwxrZsmljSubek3LyHgB+qtq+b3wsZD2iqgn1LpgOPIrX20TW1nk+klGv
	Az8v5mlxax77evcWztpQ4CtMcV7bWP7nSKKEVBduZKqTAIY+bMetnDL4UGf0QGw37gRnNdJVIfU
	h97ATSbgB6dbJHbi/LLjG7RCda5m3y6Hihn5SrETYb5ACLUC27+ks+DlnBT9Si7Pn8MQXgC0Esk
	g11b6joDSDXHqy63zEfX8OHyx+tSYteZYFSa/C9+TWWeLAFb4ItjXDLPq3gV6Vk8Sg95EwL7+vk
	lQ1zo1PZWWIfiLzXU4RJNu6p7X5AOXiO0sAKvxFv8+N5H54zi+uw
X-Received: by 2002:a05:600c:468c:b0:4bb:6d61:af7c with SMTP id 5b1f17b1804b1-4bb88944bf5mr493578005e9.35.1795792215604;
        Fri, 27 Nov 2026 07:10:15 -0800 (PST)
Received: from pathway.suse.cz ([176.114.240.130])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4bb853a12acsm729529545e9.8.2026.11.27.07.10.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Nov 2026 07:10:15 -0800 (PST)
Date: Fri, 27 Nov 2026 16:10:12 +0100
From: Petr Mladek <pmladek@suse.com>
To: Yafang Shao <laoar.shao@gmail.com>
Cc: "Ravindran, Binoy" <binoy@vt.edu>,
	"Paul E. McKenney" <paulmck@kernel.org>,
	Frederic Weisbecker <frederic@kernel.org>,
	Neeraj Upadhyay <neeraj.upadhyay@kernel.org>,
	Joel Fernandes <joelagnelf@nvidia.com>,
	Josh Triplett <josh@joshtriplett.org>,
	Boqun Feng <boqun@kernel.org>, Uladzislau Rezki <urezki@gmail.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Lai Jiangshan <jiangshanlai@gmail.com>,
	Zqiang <qiang.zhang@linux.dev>,
	Josh Poimboeuf <jpoimboe@kernel.org>,
	Miroslav Benes <mbenes@suse.cz>,
	Joe Lawrence <joe.lawrence@redhat.com>, Song Liu <song@kernel.org>,
	Ingo Molnar <mingo@kernel.org>, Jiri Kosina <jikos@kernel.org>,
	"sashiko-reviews@lists.linux.dev" <sashiko-reviews@lists.linux.dev>,
	"live-patching@vger.kernel.org" <live-patching@vger.kernel.org>,
	"Shastri, Jaidev" <jaidevshastri@vt.edu>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"rcu@vger.kernel.org" <rcu@vger.kernel.org>
Subject: Re: [PATCH v3 2/3] livepatch: Include exiting tasks in the transition
Message-ID: <awmdVLfnwgrS9VfS@pathway.suse.cz>
References: <20261125-klp-series-v3-v3-0-b1e0f79af331@vt.edu>
 <20261125-klp-series-v3-v3-2-b1e0f79af331@vt.edu>
 <sashiko-outbox-234405@kernel.org>
 <DM6PR05MB4137C0B5BB4D88A9D5847EBAD1432@DM6PR05MB4137.namprd05.prod.outlook.com>
 <CALOAHbAQuYG__4b054bRobVRyT+v143wBcVAN26T_PtiO-oqmA@mail.gmail.com>
 <awmWExtIJGM805__@pathway.suse.cz>
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
Content-Transfer-Encoding: 8bit
In-Reply-To: <awmWExtIJGM805__@pathway.suse.cz>

On Fri 2026-11-27 15:39:15, Petr Mladek wrote:
> On Thu 2026-11-26 11:12:27, Yafang Shao wrote:
> > On Thu, Nov 26, 2026 at 8:58 AM Ravindran, Binoy <binoy@vt.edu> wrote:
> > >
> > >
> > > Thanks, this is right. A dying task reports its quiescent state in
> > > rcu_note_context_switch(), early in __schedule(), and then still runs
> > > traceable code, such as update_rq_clock() and pick_next_task(), until
> > > switch_to(). RCU does not promise to wait for code after that point, and
> > > with expedited grace periods the quiescent state is reported right
> > > there, so synchronize_rcu() can return too early.
> > > klp_synchronize_transition(), which v2 used, does not have this
> > > problem: schedule_on_each_cpu() completes only after the work item has
> > > run on every CPU, which on the dying task's CPU happens only after
> > > switch_to().
> > >
> > > v4 goes back to klp_synchronize_transition() for both waits and keeps
> > > klp_try_switch_exiting_tasks() from v3. I will send it after rerunning
> > > the tests.
> > >
> > > Yafang, this reverses your second suggestion; I hope the reason above
> > > makes sense. It also brings back the v2 transition times.
> > 
> > Agreed. I missed the point that the quiescent state is reported early
> > in __schedule(), and that the code from there until switch_to() is not
> > covered by synchronize_rcu(). Thanks for pointing that out.
> 
> Honestly, I think that synchronize_srcu() should work. Otherwise,
> the comment in rcu_tasks_postgp() would be wrong.
> 
> IMHO, the trick is that there are two interlacing rcu_read() periods
> in do_exit() and synchronize_rcu(), see the comment in
> rcu_tasks_postscan() and the commit e4e1e8089c5fd9 ("rcu-tasks:
> Improve comments explaining tasks_rcu_exit_srcu purpose").

Wait! I might be wrong. I think that it does not work because
the 1st rcu_read section ends in exit_rcu() which is called
before exit_tasks_rcu_finish() where the task is removed
from rcu_tasks_exit_list.

By other words, the task is removed from the rcu_tasks_exit_list
in the later 2nd RCU period. So, if synchronize_rcu() is going
to wait for this 2nd period then it might end prematurely because
the quiescent state is reported by rcu_note_context_switch()
early in __schedule().

But I might miss something. I am not sure which period
synchronize_rcu() is waiting for.

Best Regards,
Petr

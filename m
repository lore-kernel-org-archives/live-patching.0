Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.49
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795790360;
	b=Iw84fCMIcmNc4vyQM3nNMjryAr38lMBCj+k2y1lz4sOC1xG3dryinZsGUKVG4NJLkFos
	 fPqTszRM2Xve6uQ8VodrpHN1BwI0KGutYS4LWwk63JxRBWBpF93RTBWyinyjKg7HYD7AV
	 X+4HcZHsgn/NxQJEMwdN4JMAXkl91Ox6Uq++k5f2x7VPpESsLHl7z2pVv8XsZq9l7jdpM
	 ms+SkKC/VoZoucsARdXN0oqlJrk9NIagPIE86G0MkhRM4LERi7LLkAFhxIHyZ0S1bNPHd
	 nNmuDmVgfV4GqGZ5XojEL296DMCyFyJBGSNHcAjCnr4zqbir2oShN8w4uoaH1ccNnNw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795790360;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:Content-Transfer-Encoding:
	 In-Reply-To;
	bh=6/DHKlXFhMo0Z9b6H9IFVOO6KYXjJkCSJrFRpsaTfpo=;
	b=t3QHpCrWRqLlZRLuvb5Xm8ecP37AQ5Npg4JWct7olIM1uqyoLyH+35rHvJ7kLvNVg11R
	 RdDjx4QcqwdiKFa3MiPMZvbMFbRSYlA4Y7n7zpP71sD25ZcmJqS/TYPgtZl1SYLsOAvSh
	 CKRULHnIa7KiJQW6YjKxjLtjT4R5m8qdiV+06G9i1C2b1UKU5tSlii+ciXBQTkF20hsTd
	 q9occb/Gq8So7JhJsA22ue8jViFQXowslSSgHkhyEDbShly3ZB6itFJTAbFQvxE87hiR1
	 uSKNWY6ljIrb184jOu8h7ibmYBc/CcBawqTTfoXZ25jR4oSOHxZ0JmzOHnXfscrbCtw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=suse.com;
	spf=pass smtp.mailfrom=suse.com;
	dkim=pass header.d=suse.com header.i=@suse.com header.a=rsa-sha256 header.s=google header.b=C+KiDKIk;
	arc=none smtp.remote-ip=209.85.128.49
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1935F606A333
	for <live-patching@vger.kernel.org>; Fri, 27 Nov 2026 14:39:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 1935F606A333
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.a=rsa-sha256 header.s=google header.b=C+KiDKIk
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-4bb70074ab2so86971375e9.0
        for <live-patching@vger.kernel.org>; Fri, 27 Nov 2026 06:39:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1795790358; x=1796395158; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:from
         :date:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=6/DHKlXFhMo0Z9b6H9IFVOO6KYXjJkCSJrFRpsaTfpo=;
        b=C+KiDKIkOntzP/sj1I7O2rUUqPpSVBmmAI1n+KYTyNAMZnmgZI7IZz/spt69kO2BMw
         nnjaP+QY1JPZ5eqIDfjDJ+xhZeVi4akvv2sIGRuYQrGpfYoanZdAS5yl5qqJ/eM3GVES
         J259yff9j5IlS6SQlyHR8MEK4XgM0kHpbalWjnDitGNKNMy824nIqaLrnyxvj2LmXElB
         x4I5L9MJ+idJxN7xh5VSGAm3GS1+H19nXW6U6ugzvIzARwAV+lps2pkXV5IO3P/kUHC2
         4YTW86EXnFL+16/sbnmd07XgBCAhq43/th91ZhVVWe0/vhW4MSEdku4a+v5Jtp1x0piu
         5gCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795790358; x=1796395158;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:from
         :date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=6/DHKlXFhMo0Z9b6H9IFVOO6KYXjJkCSJrFRpsaTfpo=;
        b=m1QhIRfUwAxX1DP9ekNyAp792MyF/sKHlo7ZuJEVz9mXoz6bp5ihOWACIR8i3Y32UU
         Vt6CO1nQ2lGP+U3tVADg7C+Bt4DzLo7tXFQ7jjYjy9iUvxp9HoUNJpbV47Z9yjH4vUDP
         dcstdFU4lFFDCZAxu/bY8+RtUVisajLjk2rjPOj1cgXm/xQyrREmeAoVPgUNaiZtjjYR
         PKaiF/vrGA6uzCpcilP9F1V0/4S9otH6NzKxS+gstIxpQrkWxoyTQdOYCRn0xYDurWiZ
         t/NSEpDAV1HgPKjXumc+5k/+FPkXrIohrRS3UJf2ROYlOMxRnFsXPwuK9KQyZRstGJw/
         gnig==
X-Forwarded-Encrypted: i=1; AL+hErGCFZKzI3EfP1KPk7gP/o/9GH7js22iTbbu2Y8lK85msClCLkgEMC06ulXj3O5NR2RsOOglWODblKFV4T5W@vger.kernel.org
X-Gm-Message-State: APuU4Z8zdBTKCaRpxqPsW5G7e6naMMhn+8iDQFSCcn3MlU225XxRGiNS
	FIoHne5AgcbUEaAcOk+wBGYRfsZugFTXIvQa0Y0MCdqqefhjlrYcxuCT72TToLxr5Do=
X-Gm-Gg: AZFdTZeWV5z+o5p30lkTEDCoFaWhyZO5qIwb8KdHPvwYYsHGvUeF9n3Qd8kBDJNMYy5
	Iq0uyGfcUe8pdGbhERcDaWnpOmfbtrkngBwKsJJIB0D5CEUk0rwjBXDd1dUw3l3a25UnX9Wve3K
	OZXe5cehJPROFp92oCPMkOvQghZm4L4tk2tWZwdAThzQtrSD5M21Tv8nKf1KIxXYUSg5bGyhoZs
	QLDzKmowU5Owc4OcRADvNOmS5m0Q2W8Zk0cEfNSCiyrOhEmxIXxQOXd18wUCMOqW7pxrsp5AJT1
	G8Gfvc0LWXiLWNGQdIuvlYYyV6ax4wsbxPknhPqLaEq4Hu9ZP0dcNOwR45U6t4aCTGFi3AzFtGv
	yzV8I0zD03ZdLohSO0wb6dD/uWRzYrcYN1kQY8LnFN/giExoEGlCt+q1Gxx1gnfsOX7NwQbRhQ5
	WsBqbKBNd1SJRjmuycXSIdzfBaZQjr2JTF+B7hLv3qksMO/1DGmtolIJE73KJiwRXii3vW1i/xH
	oFJvUQNiso/RagDZkLEZyMohLDeKd3ma2sKmOc17UuhW4T6XAa2wit4LwK+tYeIfvzcr+0TiXe9
	kw+CNDNROlRzka1RPSwx3W70BhFwpkI=
X-Received: by 2002:a05:600c:4584:b0:4a7:c366:d791 with SMTP id 5b1f17b1804b1-4bb887e266amr484172275e9.1.1795790358486;
        Fri, 27 Nov 2026 06:39:18 -0800 (PST)
Received: from pathway.suse.cz ([176.114.240.130])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4bbb97e5356sm7164615e9.4.2026.11.27.06.39.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Nov 2026 06:39:18 -0800 (PST)
Date: Fri, 27 Nov 2026 15:39:15 +0100
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
Message-ID: <awmWExtIJGM805__@pathway.suse.cz>
References: <20261125-klp-series-v3-v3-0-b1e0f79af331@vt.edu>
 <20261125-klp-series-v3-v3-2-b1e0f79af331@vt.edu>
 <sashiko-outbox-234405@kernel.org>
 <DM6PR05MB4137C0B5BB4D88A9D5847EBAD1432@DM6PR05MB4137.namprd05.prod.outlook.com>
 <CALOAHbAQuYG__4b054bRobVRyT+v143wBcVAN26T_PtiO-oqmA@mail.gmail.com>
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
In-Reply-To: <CALOAHbAQuYG__4b054bRobVRyT+v143wBcVAN26T_PtiO-oqmA@mail.gmail.com>

On Thu 2026-11-26 11:12:27, Yafang Shao wrote:
> On Thu, Nov 26, 2026 at 8:58 AM Ravindran, Binoy <binoy@vt.edu> wrote:
> >
> >
> > Thanks, this is right. A dying task reports its quiescent state in
> > rcu_note_context_switch(), early in __schedule(), and then still runs
> > traceable code, such as update_rq_clock() and pick_next_task(), until
> > switch_to(). RCU does not promise to wait for code after that point, and
> > with expedited grace periods the quiescent state is reported right
> > there, so synchronize_rcu() can return too early.
> > klp_synchronize_transition(), which v2 used, does not have this
> > problem: schedule_on_each_cpu() completes only after the work item has
> > run on every CPU, which on the dying task's CPU happens only after
> > switch_to().
> >
> > v4 goes back to klp_synchronize_transition() for both waits and keeps
> > klp_try_switch_exiting_tasks() from v3. I will send it after rerunning
> > the tests.
> >
> > Yafang, this reverses your second suggestion; I hope the reason above
> > makes sense. It also brings back the v2 transition times.
> 
> Agreed. I missed the point that the quiescent state is reported early
> in __schedule(), and that the code from there until switch_to() is not
> covered by synchronize_rcu(). Thanks for pointing that out.

Honestly, I think that synchronize_srcu() should work. Otherwise,
the comment in rcu_tasks_postgp() would be wrong.

IMHO, the trick is that there are two interlacing rcu_read() periods
in do_exit() and synchronize_rcu(), see the comment in
rcu_tasks_postscan() and the commit e4e1e8089c5fd9 ("rcu-tasks:
Improve comments explaining tasks_rcu_exit_srcu purpose").

Best Regards,
Petr

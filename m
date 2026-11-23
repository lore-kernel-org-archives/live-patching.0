Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795467812;
	b=yEuAFB1RYAC9Gc9X97h4fhtItwHAoQ77qmZEFSl24ucBCrMxgT01TBV9Vhxuyb0hsWHK
	 eKAKscDAqLyhWwYzGUt0brv6T7kt5rU2n5mc97/A6YErljsifUKHN5gTBqykaiRPecHGb
	 RAj7O1H3Kc7wdl8cZ302GqA0mruZxdC8t49B/EL4fLvjY9u1DyzTmzrDfoEEeG8+yULkS
	 nP7bq4OB+Up77drJ/69/7gEwWKi3zbg3j2qnOLseXA0II7GlwSmhQerYLIaXK62qf40DA
	 2xsAyJL12v6InDX9DRDIL0buATq1Dw5LggeOdBEDI5m9bFA2vREsTGbob6if2ahVgKw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795467812;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=KqEsFoKK+fEpIGg96aBIByWBHL6vb6HjfFxgzbXHm8g=;
	b=VQBmWVVS93+FHnacWC6k8FLu4MDBuDorYnb3IptCbpSExZWaNNYC3vMmKoTpI/0yrjWj
	 g7f0EOiyzXlVKpaKl7/Xiw9HtjV3rWyrlWmrzS8IVYYPMMEaDbAkw744d2jFp19oe1SWt
	 tHZTqvJM0DBclQWQoHqZpOeuJa+qzDNJ1wBRykRN6zMzNG9Q7LFNG5HjuaLAOpyNIzp3R
	 qbtRP8yx/fEeLRevHpbbMhX2aLykElSXPEp3WZT2KhwLOH7/266sLrYdzycImBiAwVZQR
	 0WxJzGHu6K+ZsibR1H8oLZk2XNuCS4Gs1Rk9Ob7CliHjVmhdL8DbRoaGPW5uuW31n2Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=DuwOl8Iy;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E887606A31E
	for <live-patching@vger.kernel.org>; Mon, 23 Nov 2026 21:03:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=DuwOl8Iy
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 831B71F000C4;
	Mon, 23 Nov 2026 21:03:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795467811;
	bh=KqEsFoKK+fEpIGg96aBIByWBHL6vb6HjfFxgzbXHm8g=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=DuwOl8IyECkffp7/43ZIUWx19Oz+A17y51ZLZ0XhhywlJcGQrUpMkZki4e8aCcJ2L
	 q6teP0IYmDlcVVbNkeS3BpHAdWpIY5cMkyhrAVz6GYGkKzscwK3IhSA/vMja722xeQ
	 LFb3SM0EYFwhwk3lTLzSTShTAUmHzoPEaFLG315V6CfjRBTlr4dtSfG5NGvHBakZEt
	 OB0NyQuhMCW4vb8FOmm3IYz6i/y/Htx52lkmeCFB478wws+PvKug2LM/qIqL7Pj7zO
	 BEDcuEOEcOh6bnGd+yGApUQeLjdPzCLEhVE4nnejUoCK8scePJZzhuUcY2u6MkX24l
	 CtbUddpwwR7hw==
Message-ID: <sashiko-outbox-230055@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 1/2] rcu-tasks: Add helpers to visit tasks on the exit
 lists
Reply-To: sashiko-reviews@lists.linux.dev
To: "Binoy Ravindran" <binoy@vt.edu>, "Paul E. McKenney" <paulmck@kernel.org>, "Frederic
 Weisbecker" <frederic@kernel.org>, "Neeraj Upadhyay" <neeraj.upadhyay@kernel.org>, "Joel
 Fernandes" <joelagnelf@nvidia.com>, "Josh Triplett" <josh@joshtriplett.org>, "Boqun
 Feng" <boqun@kernel.org>, "Uladzislau Rezki" <urezki@gmail.com>, "Steven
 Rostedt" <rostedt@goodmis.org>, "Mathieu Desnoyers" <mathieu.desnoyers@efficios.com>, "Lai
 Jiangshan" <jiangshanlai@gmail.com>, Zqiang <qiang.zhang@linux.dev>, "Josh
 Poimboeuf" <jpoimboe@kernel.org>, "Miroslav Benes" <mbenes@suse.cz>, "Petr
 Mladek" <pmladek@suse.com>, "Joe Lawrence" <joe.lawrence@redhat.com>, "Song
 Liu" <song@kernel.org>, "Ingo Molnar" <mingo@kernel.org>, "Jiri Kosina" <jikos@kernel.org>
Cc: live-patching@vger.kernel.org, "Yafang Shao" <laoar.shao@gmail.com>, "Jaidev
 Shastri" <jaidevshastri@vt.edu>
In-Reply-To: <20261123-klp-series-v3-v1-1-427c95811d9b@vt.edu>
References: <20261123-klp-series-v3-v1-0-427c95811d9b@vt.edu>
 <20261123-klp-series-v3-v1-1-427c95811d9b@vt.edu>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 23 Nov 2026 21:03:29 +0000
X-Mailing-List: live-patching@vger.kernel.org
List-Id: <live-patching.vger.kernel.org>
List-Post: <mailto:live-patching@vger.kernel.org>
List-Help: <mailto:live-patching+help@vger.kernel.org>
List-Subscribe: <mailto:live-patching+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:live-patching+unsubscribe@vger.kernel.org>
List-Owner: <mailto:live-patching+owner@vger.kernel.org>
Precedence: list

Thank you for your contribution! Sashiko AI review found 1 potential
issue to consider:
- [Low] rcu-tasks: missing kernel-doc for rtp_exit_cursor in
  rcu_tasks_percpu
--

commit 9e81067d979ad449972a5a1385a8dde8a63b037b
Author: Binoy Ravindran <binoy@vt.edu>

rcu-tasks: Add helpers to visit tasks on the exit lists

This commit adds rcu_tasks_visit_exiting() and
rcu_tasks_snapshot_exiting() to iterate over tasks on the per-CPU
RCU-tasks exit lists, and moves the rcu_tasks_postscan() list cursor into
struct rcu_tasks_percpu so the new helpers can skip it.

> diff --git a/kernel/rcu/tasks.h b/kernel/rcu/tasks.h
> index fcac7361ec51e..a231d30ebf811 100644
> --- a/kernel/rcu/tasks.h
> +++ b/kernel/rcu/tasks.h
> @@ -49,6 +49,7 @@ struct rcu_tasks_percpu {
>  	struct rcu_head barrier_q_head;
>  	struct list_head rtp_blkd_tasks;
>  	struct list_head rtp_exit_list;
> +	struct list_head rtp_exit_cursor;
>  	int cpu;
>  	int index;
>  	struct rcu_tasks *rtpp;

[Severity: Low]
Should @rtp_exit_cursor also be documented in the kernel-doc comment above
struct rcu_tasks_percpu?  kernel/rcu/tasks.h is included by
Documentation/core-api/kernel-api.rst, so omitting it triggers a
scripts/kernel-doc warning during W=3D1 and htmldocs builds.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261123-klp-series=
-v3-v1-0-427c95811d9b@vt.edu?part=3D1

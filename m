Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795648337;
	b=4glsV77KPeSm5X6U6HFDAcpJZR560kO3qyDlAAz3rAXfcwTdOUVFrpaFYyhLiaIV4oZk
	 LbcAdeUWbjyq2k6y9Vw8wSPMHPDfRcLNW99Oyxrrfl4/VIHel0GG9ZQ8+BVefrw2eSZWK
	 UZxuiKx4sb044Ai2UEaJXjc2J+5JWFX7+cS5UGmsB/XKMaWTBJlDvUpXb9HOjthucTZTi
	 00XOBhzLOLWUL9fPXUJMxhbnMOMi+pLo5KHflmtzZ27mnpVeqKTGHOMKHBWJ8FsUQvhnp
	 Z9jS6TQbN5aQ5h6oHoxzUy69UqahI1VE2yNY/qqL6RXV5IwnTsJdK6DQeOi7vDYkxAQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795648337;
	h=Received:DKIM-Signature:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=JxOz4tZV1m2Hck3wrwJdkTZz6iX3ghPkIF8+sOMG0gc=;
	b=0pL+EVyxKOxX5ja9bov/NvX4nCw4BHmd3W3eFpbF3RR6fAIXTozxnXmgCGHuO5HB+6Ca
	 CufX+mb6q2Zh898zG6peH8uncSxdkw2QfTEDvizM3CZW8XDhkScnuVCu4j3185OggkjTn
	 bLYPUA0qmTz4dscXQ3k/H8a/obmH39K+HdZeiuEJtWkkSjdZUSKZDhsEJ9IeJ5zVTgRtE
	 8WJ/gYbkJbStrmY4hw6NOKhkgE1PXsxlneH9RQZfwNwdbv+kHyyXiw3jkog/VuAbu2wDt
	 tFZUCeWaFWaHV3ZZ8ecBCSTujCQIocSZAP58jGsm8mQlsDRF2TlYdJC2JpVF3cSVMdw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ZZhyiGzR;
	arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35350606A31E;
	Wed, 25 Nov 2026 23:12:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ZZhyiGzR
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
	t=1795648336;
	b=GP6zOz5Qx+DAVMDC284Bmw2I/GsFfv6mUDKkMFFoxQGy3dh+wN5SH03tHn3rJSLaSixA
	 /86ic/a/e+Bebo4a0tIV2KHyvE03ZhwOdDJdr+IihBUbs63XPeOnwzk6yWbcFoqGVegFa
	 lHr0ajUeWvvk3taEP/juHYb5GyuJJ5Iw8pHqHGDIUTqvrnexQj2URzeb2KIzw0s/mSSyU
	 hfKrkAqLjVT+b/1/h8bRVXQL+gE9GUU43ZeV/VdZ1Rrx9nvjFUXkvXgVK7FgaSQwpCYk4
	 hD0M+bcsNRATxQxL4CIvc1gPWgRmA2Jc8/qCDNsKTR6Kc2wKdk6JDs7q3nK9ehz+/QQ==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
	c=relaxed/relaxed; t=1795648336;
	h=DKIM-Signature:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=JxOz4tZV1m2Hck3wrwJdkTZz6iX3ghPkIF8+sOMG0gc=;
	b=jIW8msYsSiBwszGKEixLDOUNm8K7e9IL7+1nXZK78hg/Ca3yjPLYc6zV1PmN05NjPveu
	 5eNY1H0VyU4D3jbeyTj0ysDh9yrbDyixRr8SAVOUD4ZGnSxww+9GXgSiCy70eQz8Ay7Tl
	 PNrEqsNkkc1+JMckQ5QzsUaVL9o3blV0bnrUVWXA96KIVZ+fOmB6qcx+AnaPu2RsrqTjB
	 oCX/KIm0ovY3RaOpphdVo70koYlpXGNq7YCM3AOCQ4T8bEorh1q2SFAZVaosh0zBfOQpU
	 lJbgVES5lEqoYiuHcUu8W6WMgWTXgut1Euh0Z/QxWu1C67pfYEbdFcS/BeqXX7hSw0Q==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
	arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.kernel.org (Postfix) with ESMTPS id 24B161F00A19;
	Wed, 25 Nov 2026 23:12:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795648336;
	bh=JxOz4tZV1m2Hck3wrwJdkTZz6iX3ghPkIF8+sOMG0gc=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To;
	b=ZZhyiGzRLjM/j8ARBZj7O6WAbmAWy7l78dhYVqqyPpC2MH5Z6G0KfRXJoGpKGs0Za
	 rhwgQKT/QnuR0M2bMaGeKZF0Fn5l90FH593tLOyOwqQVJ6X1QyNgZ6T/UkohF7+IB4
	 fUCwgbn29RWDHPUDyEMQwfdZ2mY7fofFDKWy9a3Z7y553Yo5XgKmoIfc43BbS+5FYR
	 0y1UvjMrb6pYaBLxYOn5L6B7DN52m0n1ZvhUmkAQwY9/B5T9hXfWI+sdVWpdYS7RoZ
	 ZOOTu/e3FfJwGUGtVWfjvp0XjtnQDT9Y3kSFa8kHPOcqgZgBR+UeL46t+ryCbE/3Xi
	 IDNUb7oHoOGeQ==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
	by lkml.kernel.org (Postfix) with ESMTP id A17CF4D0AE;
	Wed, 25 Nov 2026 23:12:07 +0000 (UTC)
From: Binoy Ravindran via B4 Relay <devnull+binoy.vt.edu@kernel.org>
Date: Wed, 25 Nov 2026 18:11:48 -0500
Subject: [PATCH v3 3/3] livepatch: Select TASKS_RCU
X-Mailing-List: live-patching@vger.kernel.org
List-Id: <live-patching.vger.kernel.org>
List-Post: <mailto:live-patching@vger.kernel.org>
List-Help: <mailto:live-patching+help@vger.kernel.org>
List-Subscribe: <mailto:live-patching+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:live-patching+unsubscribe@vger.kernel.org>
List-Owner: <mailto:live-patching+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Message-Id: <20261125-klp-series-v3-v3-3-b1e0f79af331@vt.edu>
References: <20261125-klp-series-v3-v3-0-b1e0f79af331@vt.edu>
In-Reply-To: <20261125-klp-series-v3-v3-0-b1e0f79af331@vt.edu>
To: "Paul E. McKenney" <paulmck@kernel.org>, 
 Frederic Weisbecker <frederic@kernel.org>, 
 Neeraj Upadhyay <neeraj.upadhyay@kernel.org>, 
 Joel Fernandes <joelagnelf@nvidia.com>, 
 Josh Triplett <josh@joshtriplett.org>, Boqun Feng <boqun@kernel.org>, 
 Uladzislau Rezki <urezki@gmail.com>, Steven Rostedt <rostedt@goodmis.org>, 
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, 
 Lai Jiangshan <jiangshanlai@gmail.com>, Zqiang <qiang.zhang@linux.dev>, 
 Josh Poimboeuf <jpoimboe@kernel.org>, Miroslav Benes <mbenes@suse.cz>, 
 Petr Mladek <pmladek@suse.com>, Joe Lawrence <joe.lawrence@redhat.com>, 
 Song Liu <song@kernel.org>, Ingo Molnar <mingo@kernel.org>, 
 Jiri Kosina <jikos@kernel.org>
Cc: rcu@vger.kernel.org, linux-kernel@vger.kernel.org, 
 live-patching@vger.kernel.org, Yafang Shao <laoar.shao@gmail.com>, 
 Jaidev Shastri <jaidevshastri@vt.edu>, Binoy Ravindran <binoy@vt.edu>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1795648326; l=1360;
 i=binoy@vt.edu; s=20261123; h=from:subject:message-id;
 bh=O07DZ6njJy/t9NEqF60nH7AFPGu6AH+JcyxcLxcqN68=;
 b=hTqH85UxJt6RZeHENYlKuc6P1efIPyhLZTzhr/RuQOIg6OPmzKe4cJLTnKZlEyPzRynceEwmf
 nLqpiCHuojsAaU3UyTxyzK1++faIIHDRgLCEwQw9C7sRkfVp34koRAN
X-Developer-Key: i=binoy@vt.edu; a=ed25519;
 pk=4cNdKPHP0InmhK/9bb7Tm2ZMUXUvLGfw1pmVt5b98fA=
X-Endpoint-Received: by B4 Relay for binoy@vt.edu/20261123 with
 auth_id=1622
X-Original-From: Binoy Ravindran <binoy@vt.edu>
Reply-To: binoy@vt.edu
Content-Transfer-Encoding: 7bit

From: Binoy Ravindran <binoy@vt.edu>

The transition finds exiting tasks through the RCU-tasks exit lists,
which exist only with CONFIG_TASKS_RCU. Every kernel that can enable
LIVEPATCH already builds TASKS_RCU. TASKS_RCU defaults to
NEED_TASKS_RCU && PREEMPTION. LIVEPATCH depends on dynamic ftrace, so
FUNCTION_TRACER is set, and it selects NEED_TASKS_RCU. Every
architecture that selects HAVE_LIVEPATCH also selects
ARCH_HAS_PREEMPT_LAZY, which rules out PREEMPT_VOLUNTARY, and none
selects ARCH_NO_PREEMPT, which PREEMPT_NONE requires, so PREEMPTION is
always set.

Select TASKS_RCU explicitly, so that the dependency is documented and
holds even if those defaults change. This changes no configuration
today.

Suggested-by: Yafang Shao <laoar.shao@gmail.com>
Assisted-by: Claude:claude-opus-5-5
Signed-off-by: Binoy Ravindran <binoy@vt.edu>
---
 kernel/livepatch/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/kernel/livepatch/Kconfig b/kernel/livepatch/Kconfig
index 4c0a9c18d0b2..683d6993e207 100644
--- a/kernel/livepatch/Kconfig
+++ b/kernel/livepatch/Kconfig
@@ -12,6 +12,7 @@ config LIVEPATCH
 	depends on KALLSYMS_ALL
 	depends on HAVE_LIVEPATCH
 	depends on !TRIM_UNUSED_KSYMS
+	select TASKS_RCU
 	help
 	  Say Y here if you want to support kernel live patching.
 	  This option has no runtime impact until a kernel "patch"

-- 
2.39.5



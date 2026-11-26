Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795711319;
	b=Oe0eU7btmYNTEXCTKoO3ykCZb2P+U8iD18bqQUz7fmx8mgc7cV5Q8NAQnLDctyBreS/O
	 BIzT4q5uKrTbeFalFjEDmg9XXdeKwsp30CWN5dzhdigy4Z0QzHd+mltNdsB25Lif2YtVS
	 F0KwWGO/h3zS0WLRXdCPmeTU8la+A+ulz3skoqI2HioV2EUfR4eLH/ZhH8O+2viMgdd3p
	 cPCFHrvIQb3jvZjmrV9OuA5XMIYy1evB0U1jgFy4gg4/CY20NIz10kSp41V/3RFUKm2li
	 Ivx9/EoP7wkOxV7Xh29Wy4RkaH6D5pzn+Q68sBqXLIrVRzraZH+MUHaMNKIGEUkuMmw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795711319;
	h=Received:DKIM-Signature:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=JxOz4tZV1m2Hck3wrwJdkTZz6iX3ghPkIF8+sOMG0gc=;
	b=ihx94o+JgX6ro9m/5zPBsT4krnDqPdsUiaICt6KpW3ko/Aod5wKcCquGPks56gpq1Bc/
	 Vy/sNSzaP0y/mgDBd2nN0it/eZSVGXkYT3juY/OpP6Cqu6/zXzhP2ULm9gfo8AbJhu5St
	 hoK4shGtq6kRSx75XCndr0cESFRhFNmzaaLkSe59iyodNwHYjNeS/bhLEPsrEOSVn7bKr
	 v7nHgTPtDCfw+sGbDmZuE/LUB4Wxs4muEbzDhrRDpZiuZs7bytgJjYwydD8xBc0Ec1eQY
	 K4f6OHN1qtelbVAa8VXyl16LRT/W2+LMbcF/maSphcS9EPdKaoBdi/iDaNRGN3/ChiQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Vwzo8pf1;
	arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E97C4606A680;
	Thu, 26 Nov 2026 16:41:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Vwzo8pf1
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
	t=1795711318;
	b=G4OZcnxDvAO9uC8fp5eHjxX5lcPOjQmVCJjnn8IOkn+ttftSF+D+VrgA2HwbjMH0n4KY
	 C2M1HXhVu/A1lD3g3PhrK51UTH+010ZgrEA7e1K7C5a7P7vNnSKU1YsZ2fGIIGKoZc8VI
	 cn0ZaPt9LQQC+UVk15H3ugwVe6/2fH/fzB8GyngcnbZLQ2IAPWGh8GaCQmfhL8/xxIWNR
	 /kN/Xhj+OX80jLEItZqZiRZjNxWOfKBTUliLCJMyty0WxpEXOGusKDo0CAA5LL+4h0cIi
	 TGr8WlVrT4YCx5tLDeDDwATLsoZx7XGsk7Wd7NhXkRdRqtICjhFp9DouEC8HUCTVRsw==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
	c=relaxed/relaxed; t=1795711318;
	h=DKIM-Signature:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=JxOz4tZV1m2Hck3wrwJdkTZz6iX3ghPkIF8+sOMG0gc=;
	b=WiTW+Momjq1yN7rX4QMq9YYrj4+E/6qXKPZ2wDGSaS8DCMzIzl96rlBvDamw/xkdxvLz
	 cpQA8MfW4kJ8xKJOLcRKo1sEpttFO33SYHE5CaFmWb/IZOmGQGRL7j4hrZbyEDhZxs2cO
	 wLpkzplLVJzWK1xXsnX6Fi3qsWZ/wUs5izJpZUtlYbfdY8bJ0GO+a46SvZtHYpirlGA1y
	 dVF4tQI1rV++7GjIeXWEKwTENWvhMleJ6VlSyz9oH2kcP6UzAzh5eX/a3qt21/dOlowLz
	 PM4nBPLJBSDuYOpAZEEKBoHT80YeB3tSN9ViB/Ky4tg/goadq+RzMzWV45T0qoXOlPQ==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
	arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.kernel.org (Postfix) with ESMTPS id 6115F1F000D1;
	Thu, 26 Nov 2026 16:41:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795711318;
	bh=JxOz4tZV1m2Hck3wrwJdkTZz6iX3ghPkIF8+sOMG0gc=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To;
	b=Vwzo8pf1sgo12FtU+9EpNVBjCvbkgVtD5yXgSyIsA2Wl1rYJ6b1RWJ4H1zSgAN7wx
	 /7EOUF9JbLTqaeBwyP41rhKAB2yI+ms3wkO3SoXfiMDR4Eb6mJNErkHHsJKkpYnEN/
	 lNqM4YutR+OWePRPhY2/NUq2KNm2+enkPq1bV/FIU2oZyt+HEYGw6KPhRVOkCPAkVe
	 pcGdJA6NsSNcsMhQ3SVaaDlu1S5sNei6iMRgzKalZEtqowpyhMPsLUPKLmZ6zIaDxg
	 hao2/aq4+LfS9BvTad8Je5Q8G4wZxgH9T3gcTQjUnpRBP+4NpqUa+eSd+Pohky8z2O
	 GnGuR/Q2LR8dQ==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
	by lkml.kernel.org (Postfix) with ESMTP id E095B4D729;
	Thu, 26 Nov 2026 16:41:46 +0000 (UTC)
From: Binoy Ravindran via B4 Relay <devnull+binoy.vt.edu@kernel.org>
Date: Thu, 26 Nov 2026 11:41:34 -0500
Subject: [PATCH v4 3/3] livepatch: Select TASKS_RCU
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
Message-Id: <20261126-klp-series-v3-v4-3-2ad73e9c9254@vt.edu>
References: <20261126-klp-series-v3-v4-0-2ad73e9c9254@vt.edu>
In-Reply-To: <20261126-klp-series-v3-v4-0-2ad73e9c9254@vt.edu>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1795711306; l=1360;
 i=binoy@vt.edu; s=20261123; h=from:subject:message-id;
 bh=O07DZ6njJy/t9NEqF60nH7AFPGu6AH+JcyxcLxcqN68=;
 b=sD4/zqAPn0OCOpBQ3T0LU+zE9LoijzOUBJqdTMu7nqy1sNm3NvlbKRMDU2z+mPwwxKlWZfiaX
 k5oyKCf9tE5CoglJBn2Nb0Tp5xwHZx7qG4I8vew31GLJlHVEROc0pdT
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



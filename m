Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795534516;
	b=GUT2VA2+5oowAxJEh3NAMohe6HrA1a7qoTPYn2zTLwW8ekuVgYxKMKIur4PGgdtDDcVK
	 99smJOiKBaP5D0fWhl2otJ4NwFxvq9mC2MJl0cmopXAPyqGyVt44PweAIeIVLblX/w4St
	 +SDrAD2oPlXjza1bY6/ZK+iqOGh6Hb8h5BwtZ49KLg7E/wnEh9aKQ/Pbz247ig+Ap7Eiw
	 +1YQqRRwkS0/lEBsMFA+L2G4LTK7zrwJN920BsnGtczrmbQTnIjqo3HbhThrSRUIzzbq7
	 hcHApnoU3kIg/s8cC9fPdsfGw7Zpkxb/05XrG5tzGwnmrDr7jsHssfAy7yq/9/z9z+Q==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795534516;
	h=Received:DKIM-Signature:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=JxOz4tZV1m2Hck3wrwJdkTZz6iX3ghPkIF8+sOMG0gc=;
	b=HZHLTAgp8y19suCgc2XkeCSRALQ+D03Z5O2fiDexhOJw2YCmRQm92cRFbTlW19TF2AEu
	 JT0rzDjc0ofNR2RLsn4JYMe0kVxqJQZiO3l+hdLcp6cjgYZDcx/EEkvg11AnHXyfFs70o
	 v1Xly/n5sYEIh1sGPE+LFKZTRKahpqDRhzs2BkDwlFUYf4jcjwcpZyZSDwQE/4cUu4FsV
	 atNfvuSxxubyLcj16SNfAAInuA1qn0Aq4XIwxplplf5x2baaZysZT5+hc+0B9v00alYVD
	 3KHiCT0+gHNtOnYvm+SBuTHL0tZpKtVtTYFUNlPd+7lEzWSt+S3zbxtfiM6y8rAYhqQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=WheOMYdV;
	arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66AAF606A6B2;
	Tue, 24 Nov 2026 15:35:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=WheOMYdV
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
	t=1795534516;
	b=bIKRsD3C98jsUX2LUI54lB1IGj45DAEXDYNDdfcgMy/U2ddFqPayGLmf1DZAxv1ac5X+
	 qJ+R5dYzX38iLqLbv5HjtDNXDcPgEDlADGhln3oX17kzmguB4UHbewbh01vcTL6nX6s8c
	 MXudhuI30AxzCl3z7qjQYOza1/tzvj6ahKhdep7LO6WuIHyXByOb49+50aKpsYxt87cL+
	 yb/E5R/3BZmVxyTC8+dY+icYlyn5pYVO+DyAcYJqjXeB6qldZ6fYXOZ+pE3EAIvbBB6uH
	 LOxtY1mH8I5MnyovrYA2Mf9Hn6KrgAjU+NFYcadwR4G4lbolKuR6vjVdcPszF3+M7KQ==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
	c=relaxed/relaxed; t=1795534516;
	h=DKIM-Signature:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=JxOz4tZV1m2Hck3wrwJdkTZz6iX3ghPkIF8+sOMG0gc=;
	b=M7ui18Ekk4HZxO4A67wNfAElSxP+XSkjAqhMCIouEf7lhKj6fz2GLgc7dMnsZKm+kcAA
	 GDvgFFZuyluDOMW2JUK1fVW8d3RLZDYDDLemzrFDy82nATUYOYZrJHKTew7hbGG4W7W//
	 WtEFaR4jvHG1Y60JKXnR5cspFlLTK/G3d8uDkd6Z3oZGMS9yFHd4f5oq58uKB3dy5Vk+J
	 LWLcDh7Nm/vvB1DKZuETBVVWWv8dappbd2LMMR8J+a29BaxtbRo5zYN8A9UMfdF1LJOqq
	 23FJlmeBUANNGf4pmkrj+kCqFZ/cZWoAsYYrC7HsYSpGGixvquD93sEX9v8gAoBzazg==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
	arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.kernel.org (Postfix) with ESMTPS id 6F6071F000CF;
	Tue, 24 Nov 2026 15:35:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795534516;
	bh=JxOz4tZV1m2Hck3wrwJdkTZz6iX3ghPkIF8+sOMG0gc=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To;
	b=WheOMYdVhwiH7RMcMx4Y2wa3RjlduEBUoiomph3Gjh0rHED8knnVIpMmNJTHngPMn
	 QrJYZtX6OGz0mcZRVVFWk29LHz8/HGGy64D0oKKRXs6d3fHbq18hK8KqzTs3kxUqm6
	 hHpjfD6Fcux2h5gmVk3WByok8ynHQcVFjPniQWWrDQPRBMMYiEUE8UO6PONTMnE+ee
	 GQUWpuS9i+SWrJ65hxgP0KXGCHyuECsa+xLzjAAjPPehdorXkcEQlS7ORA4kkEyuAO
	 vRtSF7b5VQVWtsLYrq1j+YEUb0/4htbKplfbtcWvV6Nch9wv14Hp9k2H6CWFoxaNsP
	 I3jQbQPdfBW4Q==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
	by lkml.kernel.org (Postfix) with ESMTP id F10514CAA0;
	Tue, 24 Nov 2026 15:35:04 +0000 (UTC)
From: Binoy Ravindran via B4 Relay <devnull+binoy.vt.edu@kernel.org>
Date: Tue, 24 Nov 2026 10:34:29 -0500
Subject: [PATCH v2 3/3] livepatch: Select TASKS_RCU
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
Message-Id: <20261124-klp-series-v3-v2-3-50d20829a337@vt.edu>
References: <20261124-klp-series-v3-v2-0-50d20829a337@vt.edu>
In-Reply-To: <20261124-klp-series-v3-v2-0-50d20829a337@vt.edu>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1795534504; l=1360;
 i=binoy@vt.edu; s=20261123; h=from:subject:message-id;
 bh=O07DZ6njJy/t9NEqF60nH7AFPGu6AH+JcyxcLxcqN68=;
 b=h5AxmIhSZ2ihSKCOhyw8ZKfE0osyf1IyI5LH0warbJcV4BvaZphK+A8E8Xa7fLf26ebMA8k5n
 /J/sNgc0OpoBgiYIEf8WfhfFtlB6o/+Sh3L6oxMgGT6f+ysM45yitZm
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



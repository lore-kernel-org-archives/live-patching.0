Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F041F3E51FA
	for <live-patching@vger.kernel.org>; Thu, 28 May 2026 11:43:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779968611; cv=none; b=GHYGHWgxTg9TFppv8id2jtFh2cl4Pk4N5fZ8pV1zEzLU2sIK9mv8LsAjA1x39wQ7afb826H98pHBsF5vwddrdnBc49Nr09ozCpKk66jVXjK3mfvHf1+TzVdq29sVkVI9wHZbiLrFJ57HRhn0McpGsyujiLFqgsVCBiAcDMWL/y8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779968611; c=relaxed/simple;
	bh=a0041oiCdnkxEXuYs9lJxxPL52p9JZxnl67NSshM3Tg=;
	h=MIME-Version:Content-Type:Subject:From:To:Cc:In-Reply-To:
	 References:Date:Message-Id; b=aV6vGsWUHSdGsvOStJUl/nnSvQuidcbBVfDkNkDNnlWvdOg5rFXQNL3+spvHrpfH7nCu34U6x7qVDNvG0rwpwqchKVFNmyv2BRziPkgDxSQu377640H1wUPmtPKXGJxBr5QnnwZClY3y8oqDi4mhuHOd+k+/nl0awKTkZ7QT8bA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=B5z+GJeo; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=4W9ORqVk; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=HH5/dHPT; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=3s5rldQx; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="B5z+GJeo";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="4W9ORqVk";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="HH5/dHPT";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="3s5rldQx"
Received: from localhost.localdomain (unknown [IPv6:2a07:de40:b2bf:1b::12ef])
	by smtp-out2.suse.de (Postfix) with ESMTP id 24DBE66DBF;
	Thu, 28 May 2026 11:43:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1779968608; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=eObPcYN0CyeQlsOiHZ34vA9Ekxa4xYjlXwd530ow3AA=;
	b=B5z+GJeoMC9VtgSnN7qQKqPi0Ittn1niuVcGnfpoS6rPiZb8KFKNXt0oEjKSlcvgYXhAbM
	yXQuK/mY3Er34k3xNAXknJhnsX641PRNbKrTUDoucjduKqfg5n7RyUcAPf+7g5WxMVkXVB
	0b+2Ku3maXrj8bjGmA7fHB156QdMeek=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1779968608;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=eObPcYN0CyeQlsOiHZ34vA9Ekxa4xYjlXwd530ow3AA=;
	b=4W9ORqVkfj3QbPRXRekT+CTbh3hNPQ28cLP1lIdEn73fdDRXZUmcV5bLVMIjMunSZLURg8
	2Ve7gjWntXPKL0AQ==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b="HH5/dHPT";
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=3s5rldQx
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1779968607; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=eObPcYN0CyeQlsOiHZ34vA9Ekxa4xYjlXwd530ow3AA=;
	b=HH5/dHPTu56GV/B2/TXXvHsbAi1lR+m182wnDznmE3K71+x1FpoNATJW5S7FqR8+KdDTA6
	DK6HJMwPGb4YTOTpq8hYqFgfcCseePTaBNm8HRask3toGSqko+ZcbPaLIMtoFvwJEZv+KN
	s1TsHfY+7vmQ2E9d4ZCscIqw+VHlkLs=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1779968607;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=eObPcYN0CyeQlsOiHZ34vA9Ekxa4xYjlXwd530ow3AA=;
	b=3s5rldQxKZgOeHsrIaIO5Szs+4Zi8kF445D/8w6dNx2avlP5tRoOtWwdYAHnZJ9ZeHFerc
	gTvtCLUNvQHrNxCg==
Precedence: bulk
X-Mailing-List: live-patching@vger.kernel.org
List-Id: <live-patching.vger.kernel.org>
List-Subscribe: <mailto:live-patching+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:live-patching+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH] selftests: livepatch: set LC_ALL=C to fix
 locale-dependent test failure
From: Miroslav Benes <mbenes@suse.cz>
To: Qiang Ma <maqianga@uniontech.com>
Cc: jpoimboe@kernel.org, jikos@kernel.org, mbenes@suse.cz, pmladek@suse.com, 
 joe.lawrence@redhat.com, shuah@kernel.org, live-patching@vger.kernel.org, 
 linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20260527095929.1504032-1-maqianga@uniontech.com>
References: <20260527095929.1504032-1-maqianga@uniontech.com>
Date: Thu, 28 May 2026 13:43:15 +0200
Message-Id: <177996859570.11509.15949973088707134296.b4-review@b4>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=215; i=mbenes@suse.cz;
 h=from:subject:message-id; bh=a0041oiCdnkxEXuYs9lJxxPL52p9JZxnl67NSshM3Tg=;
 b=owGbwMvMwMHYWJt9x2W1tA7jabUkhiwJrejWZ72HtA89ZJZ6X2AXGLDDcS7jzZD6/S1ntRJd5
 cpZOHI7Gf1ZGBg5GCzFFFle73WWM5ySa6BZ/e4uzCBWJpAp0iINDEDAwsCXm5hXaqRjpGeqbahn
 CGToGDFwcQrAVNtsY/9f0jUh+lPBVNMZFhYOD61v/9Z5NHWLygnZ5WVhHLHLUpYYqEXr2gstSfN
 YbH575QNd5y3+OiyfLzYnGDmf5jgeGWhgvEy3/r3P/OdV3jEbY125m+8bPjks+aI5VfWQg0KF6d
 elZ39fX7ZL4KSOU9Sp+9MV5/KEtr99+GNKg+Mlj3lncmTtWi+bmk6YWhQ7/frRrz7zHh5cWNd1m
 d/9Whv3/WjOd0ulgv52HHm4fKblRr3IfI3cxc7VS5ylVbe8DbdU967+fcOef7bLyw21Je7L1/+a
 scgn/HCDspTPlnamJ7y39a2bN/2/s/HKqrf3I+INnBNrNnRfYP7901FqSeu99tO6c0Q/WZ7+/nd
 qVetrAA==
X-Developer-Key: i=mbenes@suse.cz; a=openpgp;
 fpr=91BB0699882EF39D46654BB3FF98A38DA80834DA
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spamd-Result: default: False [17.52 / 50.00];
	SPAM_FLAG(5.00)[];
	NEURAL_SPAM_LONG(3.50)[1.000];
	HFILTER_HELO_5(3.00)[localhost.localdomain];
	NEURAL_SPAM_SHORT(3.00)[1.000];
	BAYES_HAM(-2.87)[99.43%];
	HFILTER_HOSTNAME_UNKNOWN(2.50)[];
	RDNS_NONE(2.00)[];
	ONCE_RECEIVED(1.20)[];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	TO_DN_SOME(0.00)[];
	ARC_NA(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DIRECT_TO_MX(0.00)[b4 0.15.2];
	RCVD_COUNT_ZERO(0.00)[0];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	DBL_BLOCKED_OPENRESOLVER(0.00)[uniontech.com:email,suse.cz:email,suse.cz:dkim];
	FROM_EQ_ENVFROM(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[10];
	DKIM_TRACE(0.00)[suse.cz:+]
X-Spamd-Bar: +++++++++++++++++
X-Rspamd-Queue-Id: 24DBE66DBF
X-Spam-Flag: YES
X-Spam-Score: 17.52
X-Spam-Level: *****************
X-Rspamd-Action: add header
X-Spam: Yes

On Wed, 27 May 2026 17:59:29 +0800, Qiang Ma <maqianga@uniontech.com> wrote:
> selftests: livepatch: set LC_ALL=C to fix locale-dependent test failure

Acked-by: Miroslav Benes <mbenes@suse.cz>

-- 
Miroslav


Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3EC33BADB1
	for <live-patching@vger.kernel.org>; Fri, 17 Apr 2026 18:15:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776449760; cv=none; b=VK0kmvbfQs4bcAlxqJJbC+pymZXJhXCg/wAowu6pe0rPHPukinTf7YF0l/AU8ZH2E/AYM3r8VBSWvL+AXeaiCiizZiP80ilgJeQ6gjT96M/RhlB43ICK4byjnOlkXoSNguD2MZYrbaeCyLbBNZ1YKBwDQFG3LuCxtYWaVngCa/M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776449760; c=relaxed/simple;
	bh=3P/Defy6oWxQk8qVnesL1oNujyRxbEaWXuQLcpIcZ6Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hP41/OtYxSXvHL3kTAoZsUyAwkka/9I/QccBtSlEtsX4SXREPMN7sh7jfTUtc39ReXV7AVs7Rj5Gy3HgaMTwQjvoLBcNT1VXk7BewZSVUuSSIsKXBN1v4pxjwEnnifITIi+KWoFpgVjHC65DPek4i1W+icjo+nUya80F7dzzoCA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=iaDqQ8RV; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="iaDqQ8RV"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1776449754;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=2Iy6IAQnRJdVhZcV27rIu4fDbcobG2wk2pALP4+Es5E=;
	b=iaDqQ8RV30jk6eaeQMhOrCFWA3CgG3osiDWx+3934GnqbstPp1nwNeXiSvc14Qd6ppzSzV
	Gnc7mcs1gj0rk242lcgjWsA03x3HbvoxGGieP8itaQapWZGWfyPLByHP+ORRJqR0MBWgrk
	+DwfO7pGPdiErPdKk4nkU4LLoqw3Fwg=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-28-a6tZnBCtPYi4uDaESzUNfA-1; Fri,
 17 Apr 2026 14:15:48 -0400
X-MC-Unique: a6tZnBCtPYi4uDaESzUNfA-1
X-Mimecast-MFC-AGG-ID: a6tZnBCtPYi4uDaESzUNfA_1776449747
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id DC42D19560B2;
	Fri, 17 Apr 2026 18:15:46 +0000 (UTC)
Received: from redhat.com (unknown [10.22.88.10])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 2F3D71800351;
	Fri, 17 Apr 2026 18:15:45 +0000 (UTC)
Date: Fri, 17 Apr 2026 14:15:42 -0400
From: Joe Lawrence <joe.lawrence@redhat.com>
To: Marcos Paulo de Souza <mpdesouza@suse.com>
Cc: Josh Poimboeuf <jpoimboe@kernel.org>, Jiri Kosina <jikos@kernel.org>,
	Miroslav Benes <mbenes@suse.cz>, Petr Mladek <pmladek@suse.com>,
	Shuah Khan <shuah@kernel.org>, live-patching@vger.kernel.org,
	linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 3/6] selftests: livepatch: Introduce does_sysfs_exists
 function
Message-ID: <aeJ4zmJgDE0Ff9OY@redhat.com>
References: <20260413-lp-tests-old-fixes-v2-0-367c7cb5006f@suse.com>
 <20260413-lp-tests-old-fixes-v2-3-367c7cb5006f@suse.com>
Precedence: bulk
X-Mailing-List: live-patching@vger.kernel.org
List-Id: <live-patching.vger.kernel.org>
List-Subscribe: <mailto:live-patching+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:live-patching+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260413-lp-tests-old-fixes-v2-3-367c7cb5006f@suse.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111

On Mon, Apr 13, 2026 at 02:26:14PM -0300, Marcos Paulo de Souza wrote:
> Return 1 if the livepatch sysfs attribute exists, and 0 otherwise. This
> new function will be used in the next patches.
> 

Not true in v2 since the return code is now `[[ -f
"$SYSFS_KLP_DIR/$mod/$attr" ]]`

--
Joe


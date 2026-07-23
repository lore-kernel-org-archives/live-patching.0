Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE7DC470448
	for <live-patching@vger.kernel.org>; Thu, 23 Jul 2026 13:05:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784811938; cv=none; b=rzLyqf6Yj++7fFI8s6XFLiqQ3kTNY/QxjrMjxgeWZm//30z4V+yaIlRpEq6Z31TNWkbQ8bGw9WEZYpJAR0R8eZ4CD8Y1XG3oqFWNLQX9ocvlIwUIOn+Tb/11tsFJ7eyGHHqntsGXbmP2ck9mmCOK3nnDGmkS+dQKvLI+DqRhHSM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784811938; c=relaxed/simple;
	bh=wlLlhopn67APG0By90Qh0IruNYxL7z010P1dh8lbR3w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PySKg+ZWgVJITDB390rzGZVKX36gPJ0KFufnOoYUsA+Mep4G9HBoVeXUtrWQCzgKvQMMwVzrI8Pm0I7vUNv85RKrNJryfovoMH7SL+bmOiQiBRXOVdPo5KfrhI8Crt8Yla1MbuvUzrDsOADsJkqDguFiMcvdV3KVk9fLlTRKkwY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=IkPNlzkT; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="IkPNlzkT"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1784811928;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=1RIRHk/5eupvdzhLb3ghBJUhwiY8L0yKBenw7BiB0cc=;
	b=IkPNlzkTcLlSyhifl+1kHG+JCroV4PVwTpUx3f5xDA9xxe70oOxHNfxJK8gxpL63ZCGmLM
	YDU/SFGZO4j5r8qNMqvrElj+IfP7t8MlO8J/pYxpGvOWsWGBWTJ6n/RF3tYb68OEgcPDJV
	o2O5KphO1SHROwzwl6R4D7q/bJcSmmA=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-73-4_dSjE1UMKmaRvsflCxsWg-1; Thu,
 23 Jul 2026 09:05:22 -0400
X-MC-Unique: 4_dSjE1UMKmaRvsflCxsWg-1
X-Mimecast-MFC-AGG-ID: 4_dSjE1UMKmaRvsflCxsWg_1784811920
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 620441945CAA;
	Thu, 23 Jul 2026 13:05:20 +0000 (UTC)
Received: from redhat.com (unknown [10.22.80.207])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id B48CC180029A;
	Thu, 23 Jul 2026 13:05:19 +0000 (UTC)
Date: Thu, 23 Jul 2026 09:05:17 -0400
From: Joe Lawrence <joe.lawrence@redhat.com>
To: ahamed <ahamedr0809@gmail.com>
Cc: jpoimboe@kernel.org, live-patching@vger.kernel.org
Subject: Re: Query Regarding Backporting klp-build from Linux 6.19 to 6.12.x
Message-ID: <amIRjXKfDPTGD_0Y@redhat.com>
References: <CAL0stzsJ_hJidg0hyJbaSWKHU=qqhh1G5BhKnJRsWS66PJh3oA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: live-patching@vger.kernel.org
List-Id: <live-patching.vger.kernel.org>
List-Subscribe: <mailto:live-patching+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:live-patching+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAL0stzsJ_hJidg0hyJbaSWKHU=qqhh1G5BhKnJRsWS66PJh3oA@mail.gmail.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93

On Thu, Jul 23, 2026 at 05:58:58PM +0530, ahamed wrote:
> Hi Josh,
>
> I hope you're doing well.
>
> We're currently using Linux kernel versions 6.12.74 and 6.12.90 in our
> environment. We have been using kpatch-build for livepatch generation,
> but it doesn't work on these kernels because CONFIG_X86_KERNEL_IBT is
> enabled.
>
> Since IBT is an important security feature, disabling
> CONFIG_X86_KERNEL_IBT is not an option for us.
>
> While looking for alternatives, I came across the new klp-build
> infrastructure that was introduced upstream in Linux 6.19. I also
> found your patch series:
>
> https://lists.openwall.net/linux-kernel/2025/06/26/1920
>
> From what I understand, this series introduces the new klp-build
> workflow along with the required objtool and livepatch infrastructure.
>
> I wanted to ask whether it would be feasible to backport this entire
> patch series to Linux 6.12.74/6.12.90.
>
> Specifically:
>
> Would backporting the complete klp-build patch series be sufficient to
> make klp-build functional on a 6.12 kernel?
> Are there any additional dependencies or upstream changes outside this
> patch series that would also need to be backported?
> Have you or anyone else attempted such a backport, or would you expect
> significant compatibility issues with the 6.12 stable kernel?
> In your opinion, is backporting klp-build to 6.12 a practical
> approach, or would you recommend another solution?
>
> Any guidance or recommendations would be greatly appreciated.
>
> Thank you for your time and for all the work you've done on the new
> livepatch infrastructure.
>

Hello Ahamed,

I'm replying to your mail here since this one is on the list and the
info might be helpful to fellow travelers.

The klp-build tool and support infra should be backport-able to a 6.12
downstream kernel if you are diligent in tracking all the dependencies.
I don't think there was a definitive commit list, but you could get a
massive headstart by looking at the CentOS-Stream-10 kernel [1], which
is also based on 6.12.

If my gitlab search foo is correct, these would be the MRs in
chronological order for cs-10 objtool:

  objtool: selected fixes for rhel-10.1
  https://gitlab.com/redhat/centos-stream/src/kernel/centos-stream-10/-/merge_requests/580

  objtool: rebase to 6.15 with supporting commits
  https://gitlab.com/redhat/centos-stream/src/kernel/centos-stream-10/-/merge_requests/995

  objtool: backport v6.17 updates to rhel-10.2
  https://gitlab.com/redhat/centos-stream/src/kernel/centos-stream-10/-/merge_requests/1737

  objtool: backport klp-build and late fixes
  https://gitlab.com/redhat/centos-stream/src/kernel/centos-stream-10/-/merge_requests/1964

  module.lds: force 0 sh_addr for .text, .data, .bss, and .rodata sections
  https://gitlab.com/redhat/centos-stream/src/kernel/centos-stream-10/-/merge_requests/2213

  objtool: backport v7.0 updates to rhel-10.3
  https://gitlab.com/redhat/centos-stream/src/kernel/centos-stream-10/-/merge_requests/2589

  objtool: backport v7.1 updates to rhel-10.3
  https://gitlab.com/redhat/centos-stream/src/kernel/centos-stream-10/-/merge_requests/2793

Keep in mind those ~200 backports are for the entire objtool and
supporting patchsets, with some skipped along the way.  And to a
downstream moving CentOS-Stream franken-kernel.  Stable 6.12.74 and
6.12.90 may be more or less work, I don't know.

Good luck!

[1] https://gitlab.com/redhat/centos-stream/src/kernel/centos-stream-10

--
Joe


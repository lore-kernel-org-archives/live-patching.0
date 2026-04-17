Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E2FE3ACA42
	for <live-patching@vger.kernel.org>; Fri, 17 Apr 2026 18:18:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776449909; cv=none; b=FYNZr/7ft+Am4mhL8P+8/ApGKKohHdgRVq4CnZ9qIABFH6830JEDwctT5ONr8mLCbEAJ8HuaGFbAhDZyitiew83zDSqbKVQUkstdz1gOSKzZLwSR3dlP9QAOHOv8X4PCg+xkyIVDH9hzQBQtzlk38gP8byyMlIlxkhtF4Dat7TE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776449909; c=relaxed/simple;
	bh=XpyEjG6CV7qsJexFw+igvLlsYr2Ygk7ymss8zHYrNkY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UPy6t/+vy8TXtn8vCNqofTn6LQYy0NVI9BoEGTP9u7ONWLqIIrKtOQdvaodYAZrgb/NUsmrQZ9DzWiARbD8aMuY3hQMgSKtucZgfituz9vA8F3xDxlqQGy5du7Nf8L+sgjv0j//0FqAd0LfgGibOBcgcSPffxqFKye8jxS6Q8pc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=XLxLMiIe; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="XLxLMiIe"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1776449901;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Xnn1Q1mpxJ9MCl0OBKY4gQzrZVclCQm8nybLj8B1p5Q=;
	b=XLxLMiIev0XRXsau1NX1ICEvgmsm7BiU7xpN8lO8ZrElrloBRdus1mON5wIJu09J/fOKoW
	jIF2vi58BTveX1MPuQZwDAZtEel6MVoPt59CkQPf/VBIGyTW6r+Sr6cYc+4h/BcCz7E9z1
	+Kg3L9zwRSDPvaltZ6brRmRmkIpXwa0=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-407-zZA1zPJ-OpOz_DCxbgggQw-1; Fri,
 17 Apr 2026 14:18:18 -0400
X-MC-Unique: zZA1zPJ-OpOz_DCxbgggQw-1
X-Mimecast-MFC-AGG-ID: zZA1zPJ-OpOz_DCxbgggQw_1776449897
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 1258B19560B3;
	Fri, 17 Apr 2026 18:18:17 +0000 (UTC)
Received: from redhat.com (unknown [10.22.88.10])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 7FF44195608E;
	Fri, 17 Apr 2026 18:18:15 +0000 (UTC)
Date: Fri, 17 Apr 2026 14:18:13 -0400
From: Joe Lawrence <joe.lawrence@redhat.com>
To: Marcos Paulo de Souza <mpdesouza@suse.com>
Cc: Josh Poimboeuf <jpoimboe@kernel.org>, Jiri Kosina <jikos@kernel.org>,
	Miroslav Benes <mbenes@suse.cz>, Petr Mladek <pmladek@suse.com>,
	Shuah Khan <shuah@kernel.org>, live-patching@vger.kernel.org,
	linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 3/6] selftests: livepatch: Introduce does_sysfs_exists
 function
Message-ID: <aeJ5ZQ0y9WPePjou@redhat.com>
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
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17

On Mon, Apr 13, 2026 at 02:26:14PM -0300, Marcos Paulo de Souza wrote:
> Return 1 if the livepatch sysfs attribute exists, and 0 otherwise. This
> new function will be used in the next patches.
> 
> Signed-off-by: Marcos Paulo de Souza <mpdesouza@suse.com>
> ---
>  tools/testing/selftests/livepatch/functions.sh | 10 ++++++++++
>  1 file changed, 10 insertions(+)
> 
> diff --git a/tools/testing/selftests/livepatch/functions.sh b/tools/testing/selftests/livepatch/functions.sh
> index 8ec0cb64ad94..382596eaaf01 100644
> --- a/tools/testing/selftests/livepatch/functions.sh
> +++ b/tools/testing/selftests/livepatch/functions.sh
> @@ -339,6 +339,16 @@ function check_result {
>  	fi
>  }
>  
> +# does_sysfs_exists(modname, attr) - check sysfs attribute existence
> +#	modname - livepatch module creating the sysfs interface
> +#	attr - attribute name to be checked
> +function does_sysfs_exists() {

Super small nit, but s/does_sysfs_exists/does_sysfs_exist ?

--
Joe


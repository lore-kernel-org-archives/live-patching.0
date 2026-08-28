Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D580399D0C;
	Fri, 28 Aug 2026 17:41:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787938875; cv=none; b=jVfE+rhfU6VWkMKus5LdY+EJv14c5lU/XUpT1M7Bte4iCArlxZ30866n1g9tMnZdol8Xjcm9U/rADHGCM5HnXvSYQ4Jc1Mjy8PxHbUjccCC8mj9nNis+9R7jEvrbkh6kp/IVh+qKK5f9Yp4ecLLUxFh3qisgepTb8KSTjt7nOKA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787938875; c=relaxed/simple;
	bh=O5zZkS1VVCsdDaIxNH2qSIHqrmJeQGT/sguxQMHJ60k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=D8wrmkaMcFzv+qliCmzy0c/RIRIc25MoCIy2e17Bd6QVXRYBvjFzdF55+AiQaDYkYPL8A9oWyQ7J4G0CvvJ2OtwVlq2bALZwJESccR0M4mvXi8xsa3y06d0x0g5K0Huns5zW4t7qAfp0Kkfpmnj0Dqe+vvHt3TsA8smfx+vPjEA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Gy0XeFTS; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Gy0XeFTS"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 652A31F000E9;
	Fri, 28 Aug 2026 17:41:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787938872;
	bh=i5V79ymDVn7AY3DtL3FFFbO8tJHtbjZSg9ZOEV0s0S4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=Gy0XeFTSQDstRsmby8uk/qZem+sWUlpkc0udHzBBcTRlFpa7kTziS3IFDzcI2wQ6y
	 MU3aX1dbCuAG0W7R07TGEos/K0TTbuzeWRz6dhWJYv0WXfDitbU6UQA/TA59AohcVU
	 dDFxUQ8ILHqv4fHS12ny6VgXEK6e8Sxx0oniTN5WhDWtsZkTJpJK3sZMG6DMt6WbnS
	 NLShdArZpCkTjakuIa8LSbbkVzIqDaHQdhuGFECZmHHkOrQaT4LSvEpqezyMumdUBA
	 fK49XhNUyimSPs/HvBNFpHjyJ4MkcoT9nVNaMkAKPGZzbQ+MorMBjPooDalLYo5KG1
	 iN8lKBG7wQtOg==
Date: Fri, 28 Aug 2026 10:41:09 -0700
From: Josh Poimboeuf <jpoimboe@kernel.org>
To: Song Liu <song@kernel.org>
Cc: Petr Mladek <pmladek@suse.com>, Harry Hsu <x90613@gmail.com>, 
	mbenes@suse.cz, joe.lawrence@redhat.com, jikos@kernel.org, 
	live-patching@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] livepatch: Move code for updating livepatch object
 relocations
Message-ID: <apHH5-VsffdBQtuX@jpoimboe>
References: <apBbjoEHJ98DWN_W@pathway.suse.cz>
 <20260828125244.509977-1-pmladek@suse.com>
 <20260828125244.509977-2-pmladek@suse.com>
 <CAPhsuW72hqxThCfDWY=gXffwcGvGL62pwhwMgE-39AGEv7DvCw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: live-patching@vger.kernel.org
List-Id: <live-patching.vger.kernel.org>
List-Subscribe: <mailto:live-patching+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:live-patching+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAPhsuW72hqxThCfDWY=gXffwcGvGL62pwhwMgE-39AGEv7DvCw@mail.gmail.com>

On Fri, Aug 28, 2026 at 10:02:09AM -0700, Song Liu wrote:
> On Fri, Aug 28, 2026 at 5:53 AM Petr Mladek <pmladek@suse.com> wrote:
> >
> > klp_free_object_loaded() is supposed to clear changes made by
> > klp_init_object_loaded(). It should call klp_clear_object_relocs()
> > which is currently defined later.
> >
> > Move the code for updating object relocations up.
> >
> > This is just a preparation step. No functional changes.
> >
> > Signed-off-by: Petr Mladek <pmladek@suse.com>
> 
> Do we really need to move them? I think adding a function
> declaration is cleaner for git log/blame, etc.

Personally I prefer a cleaner end result (put the function where it more
naturally belongs), though I wouldn't object to combining them into a
single patch.

-- 
Josh

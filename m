Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA5AB357D1D;
	Fri,  3 Jul 2026 20:40:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783111202; cv=none; b=jDYAFvoi4KjCu4NbdiQ1W+ezkvlb67VEu/R6S1qtsav8ZysxJYj6cgjOG/GaUBLf+guMTn0OicqkHXVfubWfcjlOfyC8FJI+NF6LSHSBRrKaRzyVG8NVWmGelGa4UzGpTPTWqU05goGyTKDm39gyXYxlEct8Jd/3fDbLWL15yeY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783111202; c=relaxed/simple;
	bh=XeeWYd67+Nf7TrAtqFVEUlB0cZm2g08N8NRLs/kxHzw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Y2ED1bGWotoN7W5jPlcSe9bYHTfrQ2xrRMB7axoqxYarKh/sg9QmdnvZN+TyEkX5LLRPIEAgKDio8LhotZulVJP3tYgDpqE2rVPMacTWbD8OqqOrX6soe7X8oSyMVqDRtyAhFULpwEvfnHE4F03YYZHIbktyeJx4GpbVKdX4SmU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hUxXciSs; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hUxXciSs"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DE34B1F000E9;
	Fri,  3 Jul 2026 20:39:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783111200;
	bh=izwtVf2TMVCopitSxzWEc6ullJIsgVxzL4etLyLuq/I=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=hUxXciSsnq+sikwdkGXzPLd+zhiioysXw9FaS4vyfRG0KcDnY/03uGPvUBGcWJPiw
	 71jXf7FJZK15VkES4zzcB9CD9RULP6jBsC4eQqaB+gjtzEbALSG+mCQVr4qVM+4Flt
	 duz+QKSnAz/ppCsMG6EVL4esq3BDfye2z65Tc1xM8pXENPia1jc6qimwHyDllCcKJF
	 3voXyzyyWXcvmzCDCD6urwHd6KKaF6gLmFecAxGHHgVsK2H2Ronzk/9YsIwH+QtFsM
	 eKEpLL7MoVIz8ND6Xmv57bgUqLj12KVhQMP9PObkyhBPLs2yuf2yvQqiKuSNPhced2
	 EQY5DiHodzWUg==
Date: Fri, 3 Jul 2026 13:39:58 -0700
From: Namhyung Kim <namhyung@kernel.org>
To: Petr Mladek <pmladek@suse.com>
Cc: linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
	live-patching@vger.kernel.org,
	Joe Lawrence <joe.lawrence@redhat.com>
Subject: Re: [PATCH v2 0/2] perf symbols: skip livepatch symbols
Message-ID: <akgeHmvrezhiSK26@google.com>
References: <20260626212140.1380094-1-joe.lawrence@redhat.com>
 <akWomlgaxlvkBwkX@google.com>
 <akYaZf228lnNLQbp@pathway.suse.cz>
Precedence: bulk
X-Mailing-List: live-patching@vger.kernel.org
List-Id: <live-patching.vger.kernel.org>
List-Subscribe: <mailto:live-patching+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:live-patching+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <akYaZf228lnNLQbp@pathway.suse.cz>

On Thu, Jul 02, 2026 at 09:59:33AM +0200, Petr Mladek wrote:
> On Wed 2026-07-01 16:54:02, Namhyung Kim wrote:
> > Hello,
> > 
> > On Fri, Jun 26, 2026 at 05:21:38PM -0400, Joe Lawrence wrote:
> > 
> > Petr, are you ok with this change?
> 
> Yup, both changes look good to me. Feel free to use:
> 
> Acked-by: Petr Mladek <pmladek@suse.com>

Thanks for the review!
Namhyung

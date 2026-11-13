Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.52
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794561592;
	b=bkocp8BwuKC769YhzjBDiTMecKBRuJXm87aAFUw5qLvUHC/SuAQIWbPs2xTmgujgyYLI
	 PHAFGKlnGZF0og6RXuglEZnAGUuXn4VjDTBac6bKjtycA4MRDsoypEMFW8e4fnhqwnG9H
	 SfJ9Lm3DEdHy1y576rBmviFcmXb/h07WhCMZP/C2fcPlTDVXY+vhhoOHUeRcNUjm+yn9p
	 42VatVv7UnKlbNvhoqW8YZm3gYBPZpzV8Bfe4BO9+awAMaSElCc0rm1A5v/SDWh9zQ8n7
	 8KTeZSVtnUpVTElynM5QPpLGDTVgNhPgYUEKfHhDlLKLu1q1zx1w3enr3Z/WfAt8RTQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794561592;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:Content-Transfer-Encoding:
	 In-Reply-To;
	bh=K2w3c32f4q6pe2d6yUOTDv3y5JLyWy2gymTmBW7sA8Q=;
	b=lakWSc6wt+na52FNbs0mH/pH4sD5aYZ+WFv7e5VE+kyTQC1zSDZMPRGToT9d6otyKtQh
	 xOz/thL1JoJXkGp5gQ78cPVHeuJDY7ICshmuBIRIFvI2HUqtqwO+HKBqcHaZ5ArskH1Hp
	 koEqZUSFrXDMro/eals9lGTBGSmFVqBpsDh/r0XV4ifMIDJkVgTVerJp/srXs2cmNWoYI
	 LkaMjzQUwNfMU1DNdGSCDoSR6qAy7JkYWjEgRpwAm6DHWKPCX4LegwKDvDxrACtJ2PfKQ
	 d2Qm2/phkvr4+DJXzGaJKmM6nl8aPaUb3zVE4naWEbejYnwXfHPUPkR5MbK36JOyPaA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=suse.com;
	spf=pass smtp.mailfrom=suse.com;
	dkim=pass header.d=suse.com header.i=@suse.com header.a=rsa-sha256 header.s=google header.b=AQL8dOGy;
	arc=none smtp.remote-ip=209.85.221.52
Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF782606A32D
	for <live-patching@vger.kernel.org>; Fri, 13 Nov 2026 09:19:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org EF782606A32D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.a=rsa-sha256 header.s=google header.b=AQL8dOGy
Received: by mail-wr1-f52.google.com with SMTP id ffacd0b85a97d-490585eddfcso676461f8f.0
        for <live-patching@vger.kernel.org>; Fri, 13 Nov 2026 01:19:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1794561589; x=1795166389; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:from
         :date:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=K2w3c32f4q6pe2d6yUOTDv3y5JLyWy2gymTmBW7sA8Q=;
        b=AQL8dOGyJtW9llbmxXGfnemLzJOn6ySyGs2CTf776mUwsjh/Lky4CxBPuBsPMHVnZV
         Mp/HvslB7b05KMwWYuUWLd2BUWktMm73lbN2nfa//39zVR22v35Ku0n7fn4LkiKh87DB
         JBnsy6ayERgnuJzGaP0lKZRkE3zpw4PTa4PPQH/7FPFUaO1eoonWPNsi81sZYHhalM6N
         kLedLvARxZekaD0I6IZogcldlPTtrjSbmWNWcDLpBWu8/AjgGSp0G4oOYqH+yCBWFqI6
         6JQeVXnPklY8icUvrEwVYCdjNyDrZ5590ml6hVSPLrxt2YxTmDCWNyO+51ODtYBtM+TA
         GBGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794561589; x=1795166389;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:from
         :date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=K2w3c32f4q6pe2d6yUOTDv3y5JLyWy2gymTmBW7sA8Q=;
        b=0UUX6DrkyxrJ7O9X228pEtBeekV6MutKELQpiCpqFPVCbXtWPZw0mtRuCJ5StNEngM
         7P+aCkeJkhfy/HExuPMAlutV+zSQW/Wo8mujI9uggoG6qmy8TgTh9ocFUwmO4OtMARO5
         RWZPqmMS6pB5ZRw57p9RMNh/rUpCmQMMmB0fe54mHqTjdI7kdfE5Eiz6eAC7R+bGtpZl
         4hCy3SDCD7hIOMxlNby+L9r6RijtnOveocc3avF5OYXHCj/fFGXjpiIyaU1k2UVlqq4M
         7stNMIexqFpCJHZDHjmUpJ/FXX9Jvb0ZcowIwM66NlwUL+xzKcD4+EezDnGDu2pxD6Qq
         V8lA==
X-Forwarded-Encrypted: i=1; AL+hErG4/qbqvUC6yGwvxiJVWSEhLDXoege/xj1luV0S5yAmYynlbysobSa/MNOBA1wacUBI3MUEghHhzD8IJ3dF@vger.kernel.org
X-Gm-Message-State: APuU4Z9BCw+V+7I0S5FIc2PYCEyTYBkPNhMo2ioNyMneXfsUrgs1VAAu
	K3z9rvzoUKugFbbOY0fQw5xdI/rt7s2Hdc8lElEwVNeAbPIaNpOCPEZOUgjggJzwvyk=
X-Gm-Gg: AYBFou3826RtV56+Qh+X5D0+6zxDFAiPAPS+eVX8x46kLAHms8RVWl+1uOhAXQy7qoW
	RYWQkGDqpXawGh7Sh7BFSfYepJGmr5Z4w+5rZZmp8qCblFWnGNrd8lj9mCsHcErT2VwVRmffJZa
	cUmpYVe2wibublq/HbUT30vS+n28DSKqT/CEwq1y/9h9fScJ1Ks0WNVYBDq9pU+FILz16pNyv/2
	PaOiuBlxMH2RMAxUYm6QHixosUJC4YWE7GYzeqpS5s7iBP9nHkoL3mNELDeMuTiVTVcpSVmfb98
	84v+gA8RMNGvg3aRLCjKwBUH+B9r617SKGw3Y/QXX2zexUt9FUs9DRmxzwCaF7uPWLFDjpP0sip
	B1wRdCiseoQwlIMPtNrNDhHl3uV3rzZsKFmshBS9ljF/z3g0sBiOPRrW3eyYnlnh1xLbh0A1X/M
	oi15DdyFyDRehr2kQTc4FIkfXigafyBerDfsZbBplm4tebWPtsPvUF3sQf2QpBtW+QpVZy6i6vC
	TCfSthxv3CfB/N+pYwW/rT2yM7fZcVmETcos4qMfYEPjNpTiFr8R9TALUzet1QxiuxHxTMm+JV9
	O49kpKUNIDcF2AhY
X-Received: by 2002:a05:6000:4284:b0:492:820d:5e6 with SMTP id ffacd0b85a97d-49c72ba6660mr4954981f8f.49.1794561589263;
        Fri, 13 Nov 2026 01:19:49 -0800 (PST)
Received: from pathway.suse.cz ([176.114.240.130])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-49c604ee47dsm3776134f8f.38.2026.11.13.01.19.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Nov 2026 01:19:48 -0800 (PST)
Date: Fri, 13 Nov 2026 10:19:46 +0100
From: Petr Mladek <pmladek@suse.com>
To: Yafang Shao <laoar.shao@gmail.com>
Cc: Josh Poimboeuf <jpoimboe@kernel.org>, mbenes@suse.cz,
	joe.lawrence@redhat.com, song@kernel.org,
	live-patching@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v13 0/9] livepatch: Add support for scoped atomic replace
Message-ID: <avbWMv1DJBoSzRKN@pathway.suse.cz>
References: <20261026133651.40061-1-laoar.shao@gmail.com>
 <avYNu60V0spG_xIf@jpoimboe>
 <CALOAHbCGy+tDn6b7rt11H99odZzRG6V67c17ToeHb_0SqVdxWA@mail.gmail.com>
X-Mailing-List: live-patching@vger.kernel.org
List-Id: <live-patching.vger.kernel.org>
List-Post: <mailto:live-patching@vger.kernel.org>
List-Help: <mailto:live-patching+help@vger.kernel.org>
List-Subscribe: <mailto:live-patching+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:live-patching+unsubscribe@vger.kernel.org>
List-Owner: <mailto:live-patching+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CALOAHbCGy+tDn6b7rt11H99odZzRG6V67c17ToeHb_0SqVdxWA@mail.gmail.com>

On Fri 2026-11-13 10:17:20, Yafang Shao wrote:
> On Fri, Nov 13, 2026 at 3:05 AM Josh Poimboeuf <jpoimboe@kernel.org> wrote:
> >
> > On Mon, Oct 26, 2026 at 09:36:42PM +0800, Yafang Shao wrote:
> > >   selftests/livepatch: Clarify test module file names
> > >   selftests/livepatch: Adapt atomic replace tests to provides/obsoletes
> > >   livepatch: Make klp_find_func() non static
> > >   livepatch: Call klp_init_patch_early() earlier
> > >   livepatch: Implement provides and obsoletes for scoped atomic replace
> > >   livepatch: Deprecate stack_order
> >
> > s/Deprecate/Remove/
> >
> > >   selftests/livepatch: Add provides/obsoletes test scenarios
> > >   selftests/livepatch: Add state test for provides/obsoletes
> > >   selftests/livepatch: Add function test for provides/obsoletes
> > >
> >
> > With the subject fixed on the above patch:
> >
> > Acked-by: Josh Poimboeuf <jpoimboe@kernel.org>
> 
> Thanks for your review.
> 
> Hello Petr,
> 
> Would you like me to send a new version with the change above, or will
> you make the change on your end?

I'll do the change when committing.

Best Regards,
Petr

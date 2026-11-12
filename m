Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.43
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794490297;
	b=J0o+P/rbyxpq3btXMVELWV1TWvfSZEJ1rvbPsehDvBW1ANsNnRa3m7MeXqdzqPsELqpo
	 vsU/DoznuHdnlhKqD7wQWwuuWyT/KG9rItwDNdzx5+B4jrA0HSLCsvjWRqWevF/9zEBer
	 paFA1LGc8U9N3BLvz7Qra10fp3+9GprQuNfjqu45MTfUTZYyxewXwbTE0cwFrfXv484Tj
	 m+yQCGo+yrMUhSVR4I99sY0T+EaD+FpU0HxQJuD2eYhyahqjOc6L5JVlTSn2JBuRt0Hcr
	 qOigvl4+4zWiu+J12ZPSl664G/kFB72zCx7i1dOWYlg3/SUnPrai1vlV+6AYDaCUYdA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794490297;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Date:From:To:Cc:
	 Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:Content-Transfer-Encoding:In-Reply-To;
	bh=FkczQkrlsHUpyp5C71Vb5YxWTFStgOTkUESg1X8sWls=;
	b=OdDX8Gx1hfTETScr/L5GMgzi0bKuumpTcM0CyUY20ct8YvjtVDtsz3YW8hjrorIgyA35
	 AOQOHrCqffj9pRLAawSuQ0fDNdFQDB8VxPezmULHK+cOjNVgp0GBJdWueF7jARTvtgWR3
	 7cT0dRWWwQ9swCddX42s6FhDhIf7o8jCXCOKAxa6ddj6KPdgBZjcPmP7n5NJjC54uB6pt
	 UsPMUoZogrsW+d2ahCI29O0rKRskozvYCFaE7QgqjRDubJ0kMFCMGcDQyDtXwJXNH/UIZ
	 8Z58JwqTQ7x3gCWu/C83/YifWFeArMhcvDKtBh9kOKttFubZu5srJrwjdAST+zPCPbg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=suse.com;
	spf=pass smtp.mailfrom=suse.com;
	dkim=pass header.d=suse.com header.i=@suse.com header.a=rsa-sha256 header.s=google header.b=cbVu4UnL;
	arc=none smtp.remote-ip=209.85.221.43
Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6AE83606A33A
	for <live-patching@vger.kernel.org>; Thu, 12 Nov 2026 13:31:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 6AE83606A33A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.a=rsa-sha256 header.s=google header.b=cbVu4UnL
Received: by mail-wr1-f43.google.com with SMTP id ffacd0b85a97d-492fcbfaa88so2878180f8f.3
        for <live-patching@vger.kernel.org>; Thu, 12 Nov 2026 05:31:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1794490296; x=1795095096; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:from
         :date:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=FkczQkrlsHUpyp5C71Vb5YxWTFStgOTkUESg1X8sWls=;
        b=cbVu4UnL/2wLjP5O/IAZJhNryAwEIeRelW1gkVPXauVZ7kpQs5nvxLtuoZz2LbLAk9
         ho7jhQ+ikfjAIPJ9OyiYUkwWKY8aNTnL5jStJpdABOvIJiNWWTNroUAb4sLLfEpEFia0
         2oNcoQkuTTVNlM+i52s9KcLsLSTGRrM9x9ETUsBCg3Kb1BAzQ9WHMuaT9qzJ/n97K4tI
         NOmoYevxjiBEbMjpnxLL1FrnPrBcOIVZ6sA7LyYuPDQt6dkI16vjVHLn+Y/H0VVQf5S2
         QJIeyVrJWuxFzUbimDWnBj6UItlZm9PWovFEeOfUrcg2ORYUozNBcxorhgiDQ/EwijkD
         iE/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794490296; x=1795095096;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:from
         :date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=FkczQkrlsHUpyp5C71Vb5YxWTFStgOTkUESg1X8sWls=;
        b=oASvIX/ozhVzmDE+NvSbEVV04/hgkqPNXDFni7feXTDyBMU/ulHKX93oBHOY3mug2F
         Pn9tZw04o1OiFC1nct5AiCgCd4hdl5qs8ecCy8xRtH062f+HFQ/HhuyRjoNvxM/9Wg+g
         v0T58jxm+oabCb385WJRkax9iqt5UNhrPD8DdC1zq/Z9hn2Jkyv2sYEKl0ODnuN2OeOH
         tqOviRF8UVDZbezrbPC3zra+l4a4DwEyNoiphS8cK9+SlmpsuiJMC8DezU+wCIN/qKnT
         bOlS4QddMlUhThU3b9+D1P5hW+8SFHAVSt8T2FansJNNd1cI/8OjtFsQOUlyNJTpKb07
         RLcg==
X-Gm-Message-State: APuU4Z8DGEvuI1BLm7RqEK7/NEK1R0N+awbpbZtDLIs7rv0sIGFD/ua7
	rzd/cY1znciPSc7FevbgQbJfr2ADI/rchE8LAOPHqe16a1qBTCgQP+krOQhfpBaAFgw=
X-Gm-Gg: AYBFou0WvHJ9NXCnlzY3OC17NDvPclcWacnJ3eV0EwZEHril5+xKXWH4OfFL4KvZy2k
	tAObZb2JOqhdIUIkFDhMh9gl+kF3TFeVolO7oeAGV+6XaTs/JPo3jHEZSl1N/bvN7P3itLXkECj
	2Lh+rdLnAvZRUFDYEbRzn8ol8jYmACz0f2PHRysFnZS9a2UIwMd9STzO20w0ZvMc98KfC3NGDtP
	Xlc6TN1A53hGZ86JoKiuMrgRFlSRFIzojxSvYhcLhNXx6iFloInj61fTsrCd8dD1378xKNsBaXu
	DZERHK5LUcYYZxq7KLd6jtYFul1I153dw96FXQEDECKFmaZeqS2zSg0miG6mv0r/UqT+fQBt/nh
	YkcxqmfpzMW8J8AOiG3Fk3yFx39nPHJy+mBk/vFv2J68HmGuJqvZMO8OEHLzPQcU730pZ+bUgaf
	lFgXbTgt7YJeC7DlRLkWQAYIQsCJVJAqYDekAQX8OsSaO1CX27ZC4NbgHi6Oy/oloxBxxuH4coX
	uH+uhOtOtqSFiJdpyfY3QvKSk43bhG2CEot8Ke3NyTVaTwp9cizDpnBKm9Zvf03t8zrm9Q7kkdY
	sYI8oadFGDRgnei7BlxFlCk6s9bOW08=
X-Received: by 2002:a05:6000:2611:b0:490:d197:bde8 with SMTP id ffacd0b85a97d-499c150ed5bmr9292233f8f.0.1794490295828;
        Thu, 12 Nov 2026 05:31:35 -0800 (PST)
Received: from pathway.suse.cz ([176.114.240.130])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4988bdef64dsm15259248f8f.20.2026.11.12.05.31.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Nov 2026 05:31:35 -0800 (PST)
Date: Thu, 12 Nov 2026 14:31:33 +0100
From: Petr Mladek <pmladek@suse.com>
To: Song Liu <song@kernel.org>
Cc: live-patching@vger.kernel.org, linux-kselftest@vger.kernel.org,
	jpoimboe@kernel.org, jikos@kernel.org, mbenes@suse.cz,
	joe.lawrence@redhat.com, shuah@kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 00/12] klp-build: Fix dependent patches, add selftests
Message-ID: <avW_ta_T6CBdn4Rq@pathway.suse.cz>
References: <20261028214534.1919398-1-song@kernel.org>
 <avMR6tKwddVBrkpk@pathway.suse.cz>
 <CAPhsuW4Dh=QRgChcfbrTZtxCko90+o5cgzFpytBEQcHh9xd61A@mail.gmail.com>
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
In-Reply-To: <CAPhsuW4Dh=QRgChcfbrTZtxCko90+o5cgzFpytBEQcHh9xd61A@mail.gmail.com>

On Tue 2026-11-10 19:58:50, Song Liu wrote:
> On Tue, Nov 10, 2026 at 4:45 AM Petr Mladek <pmladek@suse.com> wrote:
> >
> [...]
> > >  create mode 100755 scripts/livepatch/klp-prepare-patch
> > >  create mode 100644 tools/testing/selftests/livepatch/test_klp_build/Makefile
> > >  create mode 100644 tools/testing/selftests/livepatch/test_klp_build/functions.sh
> > >  create mode 100755 tools/testing/selftests/livepatch/test_klp_build/run-tests.sh
> > >  create mode 100755 tools/testing/selftests/livepatch/test_klp_build/test-basic.sh
> > >  create mode 100755 tools/testing/selftests/livepatch/test_klp_build/test-cancelling-patches.sh
> > >  create mode 100755 tools/testing/selftests/livepatch/test_klp_build/test-independent-patches.sh
> > >  create mode 100755 tools/testing/selftests/livepatch/test_klp_build/test-line-directives.sh
> > >  create mode 100755 tools/testing/selftests/livepatch/test_klp_build/test-new-and-deleted-files.sh
> > >  create mode 100755 tools/testing/selftests/livepatch/test_klp_build/test-offset-and-fuzz.sh
> > >  create mode 100755 tools/testing/selftests/livepatch/test_klp_build/test-patch-not-applying.sh
> > >  create mode 100755 tools/testing/selftests/livepatch/test_klp_build/test-unsupported-files.sh
> >
> > I am sorry, I am overloaded and do not have time for a proper review.
> 
> No worries.
> 
> > I just see that it adds a lot of new files. And I wonder how much it
> > shares with the livepatch selftests. Would it make sense to put
> > it into a separate directory, e.g. tools/testing/selftests/klp-build ?
> 
> This set of tests is mostly independent to current livepatch selftests.
> But in the longer term, as we add more end to end tests with klp-build,
> there will be more overlap between klp-build tests, and livepatch tests.

OK, fair enough. It was just an idea based on the git log stats
of this patchset.

Best Regards,
Petr

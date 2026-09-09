Received: from mail-yw1-f176.google.com (mail-yw1-f176.google.com [209.85.128.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E68F3B4E9B
	for <live-patching@vger.kernel.org>; Wed,  9 Sep 2026 06:59:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.176
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788937194; cv=pass; b=j2kgqiJ4o9KmUA5kc5tQdnKigIc29Qg3TT3QROF4el4uKaX+j9/rDZMz9rmwJ0cN6YDvPGLWoRr/gqz0zXqCGBak3/g3ImDnLuCDbOZEQz9bYbq+Pgg1t+Rnctmz4T1Q2K3fZNosr65WKxajbDLWBsNn/pivlAXtjEo1Ft5OLMs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788937194; c=relaxed/simple;
	bh=Oc9WFsPSUGc1zv3+n30cvXqdc4oUwLf1ybDOL44QFvc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=OpxU7pfQquU5237BoPMU5bM6BYN2WgcvVPImAuPp47zg/WmcbgN7ad1HsAsGxHQCqKp3D1ccbKse8ZJg2F1l1H+pARR9H+1rJcmXtWf8Z+vFE9cNfyMYMz03vbkpzFlzUPNm9Fj5Qp/di8UxQ4ZZaZs6G8ADzpy4PPRWD40/Udc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=plU0QlyK; arc=pass smtp.client-ip=209.85.128.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="plU0QlyK"
Received: by mail-yw1-f176.google.com with SMTP id 00721157ae682-86d43cdee51so68566797b3.2
        for <live-patching@vger.kernel.org>; Tue, 08 Sep 2026 23:59:52 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1788937191; cv=none;
        d=google.com; s=arc-20260327;
        b=av9YB1ByEuEDszHIRjrm6FPuRB2ee2iRmS93tMca20wMzeVqR0pCIHQZGos/6AW7UZ
         24v2h/IgXM46RM1W1yj2s57sd6wrpzJsS4tJ5LU6b2wQAR+4ui5ptITEJfsDv6BzAuen
         1KaetixFqOPP4PfVava2uGuBw/twt0DK2V+pq3rc3uc2s9Fje/HFewTVUDTSp1WkpKsW
         pZrfCmVKiRywIoc+u7UZgeMaqtTxOAn2IU5t2cEA0dlEA2ltNdlA8kwt8nnF9YLjj4L8
         EUqVvXE14nkn6vtSn2WKyQOIJ5WUECVCJ9ni56GCO549qQyt6fT5OekeaDXxqBFsW2S0
         P4Mg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=CDdn0MPfpfnKpCCiCY1yHBVe9ymTCedi3+08W6KqZf4=;
        fh=u6ZMUOr8aaAxgQKZQ916R5D5+U6XRUq1UR5lQaAy58c=;
        b=CNa/2rT+ICMOX8htC/uYbzt3taVLzpt8EdhvEHXpZ//t0+y+ICEDumK67v8W/poZuv
         jhco2QJgYgyx17hoZjChY6vDCaWxLoj1WFiCxYxHq1VePMn8dB91c4TqZY7wIPWuWXWY
         wHR6ggnxAaBLhhWv6J9+hAGWz9PHzLZRB6ySOgnYzJTXOqae1mHGpOzrTqrToxsEWDlq
         oM4nRmrfvfjblSF4l2/yzdSDIxKmJt6nBWmoze1KrcFRXT5Zpxo5vi+2s+0yq9bW5gLJ
         sUViO13gyaRFkQUYDKG/SvozgGP39SKmdaefGvoy0w074NqZLS2epEDEODJL4copYH6n
         6jTQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788937191; x=1789541991; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=CDdn0MPfpfnKpCCiCY1yHBVe9ymTCedi3+08W6KqZf4=;
        b=plU0QlyKYIBWGaCR8vHT/7uVmhrBzmORBNj3PzJvG9kSeq2yqBeABA0yFGxMj2ryDt
         T45BfTSVZUixruf16etWaLpxq/SNTL+LxzE9ZzrZhK6Lkqkfo2TlSoxEnC6OFeS8Tipo
         1TCwI0exuTaXAu9uqYFiGnaSDQRhA96fxtZEtABrOMNwdOWATKIpaFolElvDWM4wpxAK
         XyX9DkSqvG1fv8uHZcVD5YBlLYoS33X36GAigHn+0++mzOj/0B9B5APASlw3/668Drg8
         l+kbivu8pt0caGRowIg0rkukhVduT5W9xiVVhDFEmIDoXb3g3W9d8cnRmJ1wpOqB8SgM
         wEXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788937191; x=1789541991;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=CDdn0MPfpfnKpCCiCY1yHBVe9ymTCedi3+08W6KqZf4=;
        b=pH4yd6HCX6DDUFL3Xh8w9EnlHS1G8FbpxCtc+U9Tfkt20VFzHTT1qdUGX1o4rbjasH
         idGHFzjhny76t8LQuUtGrsSWbR8ocbVxbuSWW+7tQDDvWepcAh+D2EAl3ygw2H3E6Dc7
         dtC0hSnFDntAOVn6jbeJ96dzbCk16NKl7B/NwlZHv1vCBpWazHOGm+mEOS3hCMRo6+YY
         Q3VfhJtYrHiSZo5KR1s8i8y/S+JLsiIdX81NVIxCpaABkmElY8enElW+8tyaKPq67T84
         tnIKheruzVKye9Gm7SEW4LcYt25F5+sOw1KONJLaAb9skFGFIGPC2eOsXYqH9U28Gy4o
         Nikw==
X-Forwarded-Encrypted: i=1; AKwUvBxOjlMIvnTkqcSIdJggkBvDMLdYo7ZpUv3fyCkTV4fdkWro45jnkJ+vHJSyf4cG1xXkLczPdo2URm1nuCMe@vger.kernel.org
X-Gm-Message-State: AFuF++ku0KOE3aqvVo04KXMw86SQiFci9kqfyk4klRi0oO6A3bBBEuXf
	ykarxZzT+qt2YEnAPEVUWRH/CZo17XOHCieYgqn2nIhSAMkuVEWGDZ6XloInshJieXZ3gqnQXwL
	3sFPRLaxu5I6y3+e0wM5Y+N3xcUbW8RI=
X-Gm-Gg: AYBFou1F+VPoVnTemje8ZfKfV8euzIUlgDpgzhI/SM93ZuYMjFlxjmnXRx4WEJZchs0
	51y0K6gzfpiGH4ZqibkOBdrQ3SfdY0GtX+gOG+gjlwKer8J+4WcoLRYVwLNCfJr+2wzrRBSbpLD
	VeUKPTD8/NLFMnXG1FsEyLmsFez9TeRz43pGsbhzYlij8H2lND4MChZoBd2V3gA9Vf1qFV0GBkU
	TP+MLljGVtcNoHa71kTbIvJYlvqD6cKqhsykfBFHYkIPChRUJlU10tkOymgCGZqMHyVgDrHNWoC
	hzjNRTYZfG71pRhHTjxclw9vWcN9ZmnIB7f5EBRGdrTDU36erbNoNJX1mXcEsvDtT2LHVr3k7Qa
	I5oe1MPuWDSwn
X-Received: by 2002:a05:690c:9a8e:b0:81d:c233:aea0 with SMTP id
 00721157ae682-8712a415be9mr129403717b3.18.1788937191399; Tue, 08 Sep 2026
 23:59:51 -0700 (PDT)
Precedence: bulk
X-Mailing-List: live-patching@vger.kernel.org
List-Id: <live-patching.vger.kernel.org>
List-Subscribe: <mailto:live-patching+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:live-patching+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260909024324.16002-1-laoar.shao@gmail.com> <20260909024324.16002-3-laoar.shao@gmail.com>
 <CAPhsuW7iK5QeOGdbNr=0ygch=ySNbUuVPdvy2BWFieFAb14u4Q@mail.gmail.com>
In-Reply-To: <CAPhsuW7iK5QeOGdbNr=0ygch=ySNbUuVPdvy2BWFieFAb14u4Q@mail.gmail.com>
From: Yafang Shao <laoar.shao@gmail.com>
Date: Wed, 9 Sep 2026 14:59:13 +0800
X-Gm-Features: AcwNN1WDD35CjhL0ylhm-HomRwfmFluqu4tzQjxt1RFL8b29gouM2h1PpNna_eE
Message-ID: <CALOAHbBjbGu3E8Tfu6z2CZqcaJUSYYrPB3LsT54V1DpTDok75w@mail.gmail.com>
Subject: Re: [PATCH v8 2/9] selftests/livepatch: Adapt atomic replace tests to provides/obsoletes
To: Song Liu <song@kernel.org>
Cc: jpoimboe@kernel.org, jikos@kernel.org, mbenes@suse.cz, pmladek@suse.com, 
	joe.lawrence@redhat.com, live-patching@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 9, 2026 at 1:28=E2=80=AFPM Song Liu <song@kernel.org> wrote:
>
> On Tue, Sep 8, 2026 at 7:43=E2=80=AFPM Yafang Shao <laoar.shao@gmail.com>=
 wrote:
> >
> > The legacy "replace" field in struct klp_patch will be replaced by the
> > provides/obsoletes mechanism. As a result, the atomic replace
> > selftests fail to build against kernels that only support
> > provides/obsoletes.
> >
> > Adapt the selftests so that they build and run on both old and new
> > kernels.  On kernels without the legacy "replace" support, the
> > replace-related test cases are skipped with a SKIP message instead
> > of being run.
> >
> > The provides/obsoletes based selftests will be added later after the
> > provides/obsoletes are substituted.
> >
> > Suggested-by: Petr Mladek <pmladek@suse.com>
> > Signed-off-by: Yafang Shao <laoar.shao@gmail.com>
>
> Shall we add functions for code blocks inside
>
>    if [[ "$HAS_PROVIDES_ATTR" !=3D "1" ]]; then
>
> etc.?

Makes sense. It will be clearer.
I will rework it in the next version.

>
> Other than this.
>
> Acked-by: Song Liu <song@kernel.org>



--=20
Regards
Yafang

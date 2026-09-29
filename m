Received: from mail-yx2-f39.google.com (mail-yx2-f39.google.com [74.125.224.167])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76F4D3AF66D
	for <live-patching@vger.kernel.org>; Tue, 29 Sep 2026 09:26:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.224.167
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790673969; cv=pass; b=t/5C9+0HnkJ8JOr2WEgH73IeJ0jVeG8vhIc3kUnqU5KC70bx7Zzzke0AopNzUBgx0hCtWBmOc2lEIvk5pj0Yu28AZuxpekbW1LZKvuDsK4vHwazyr5QiAInfTdNZ0AQbRpmUFAiwdX5902AxMjO+OHOWrfQLSDs/vCNjohrRe3s=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790673969; c=relaxed/simple;
	bh=hhfR1MyODAyUV5Awjq/lZCqePiX0iSLORwDn20vFErQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Yf7dxubo5tlfp+/MJlEaRgHtkf5H1Z2vOub4Jh1lbPfe3nrbXK7VrzFrRye7iqsirYg4QnJImZ2v8mzsUehuJXMyYrQWq1zXDNWXZaqt7A02uiGuKDl4X/0dxGtQw2Cf7vqg5Vn+1jC/KkeNtsqAT/ce/8UadLUJ9C6cZBYt3ds=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HvBWd+5d; arc=pass smtp.client-ip=74.125.224.167
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HvBWd+5d"
Received: by mail-yx2-f39.google.com with SMTP id 956f58d0204a3-6755aad8a98so904159d50.1
        for <live-patching@vger.kernel.org>; Tue, 29 Sep 2026 02:26:05 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790673963; cv=none;
        d=google.com; s=arc-20260327;
        b=Gwmyp4hckRx3nRMtBd/TaC+FZVN7o6+7NWdxBmG+cur1hLG6rOM9lorRG5sAJzwqtB
         W1nQr+dbXIa9uVlKJNhT/ZRCyp7oPWop5cMK0HUiXnnndjk2K7cY0wx/5WRW1gu0BvLw
         Ch1IibmXrQJsZIR2YsSJQbC8pWJZTApqC3zVUv6svQhyJ9EtWCI9ZoozFbMNZgm9n0KB
         ccJxaoNQicL6nhwvUopye4MdYvgD/Fo3w3NA0SpSaKhNoHyvdmVoaY/cdPViptnaNfAV
         ztD7lh6mWrHU3JCL3kU4DNv5uF/94hlXrAlv3BI14msb8CzoNT31SLWLTBYONm9JgJ69
         f8Mg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=XPVNkmQlazxoieuu/szGHezCZqG+i5ehvurv5jY/qZA=;
        fh=PR2NFP90qmUpmIzJUfOx5xCQRwirAPRMMClV8ojU3js=;
        b=iGEr94zDJsgDUo4sEQjatjwZGiWHNiLmNQz86S3p47nPjbdUKuPX0gh/GvT/QEf+9C
         kQyP5l6vjuDwjy5lwgt+uptmekpMMX6LpzADzSBQX4hhhEAyBaOaWRsexxhTDnYGyiJD
         aOF9/BFV4QipJUUWp706D67tN8vM/31dKyD75qB9Te9ISZjNvyCk/e0XffdV2YKlXR4Y
         3+7R2pSo7p8MAd715XLZeN+N9f3b9dFs9yoIebyNkdMHOday66mXrR130q5DsDYp5zIX
         NRViNsnMwYJr8irtGw1WKPbQAAIJaft4fz7ev7yO6vEgZdCYVjNPgoJiHf9lNF/E0Q41
         +4KA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790673963; x=1791278763; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=XPVNkmQlazxoieuu/szGHezCZqG+i5ehvurv5jY/qZA=;
        b=HvBWd+5dkhl5f1sEkb1XANrl00LkXDp4il1eJ0H0NwYF/ZlsUvU+7iETkSK1KoDh1E
         lQUeoaqKPktHG6gqnqcA4iyJbwVmBY8vPF3Tw8AzgMpn/5p3AEDzC+Y6TuUPYS6kPAWz
         XvGK2YSz3K+iBne4xHA3ugC65A8xHvAgaSx369QdogmVOvE14lF1fwvL42ceBlgtlDyF
         ONEqKn1lV4Uvtb7DMMo0bMxcWT+dDXhNfpVqhW1FOnSUn9ye0fmqkweymrBdLNbPALlf
         UjXYlX+TVKHGqqMi2FfrFpyLkZhKuE79Hx+HUUWjfDn9ERMusXFlm9iFCTwOZ4AhQ6W1
         y+tg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790673963; x=1791278763;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=XPVNkmQlazxoieuu/szGHezCZqG+i5ehvurv5jY/qZA=;
        b=MrGRtCG8YVhZpBiwT4N0Wi0Ee3DIkvyAmv8qZgO07m7jiz5m9MZL9Q1hTeYCg9BBEY
         aSQmTGRyUqVSE4PggqKdYo+8SAPCp0pQzGdDGXCZ2vYPnaZJdhBJgmPfmKya6uKMy6yi
         eghgmbnclpS6UVHutGjXfsjJetkCtAaEEYkI+YQk0glJeuQGUw/2zEMnY9a3CrGd4ouG
         8im2kwDRhMvTnurnUmt+P8pI+9xhE+KsWS/Y1tu4ZhjjRuTlbd1GIw4Bo/XbVBmFd4vF
         7MhCc2i+vowIEdQYUpxe+ZmGt0hrRGez8gSv3qXIZKz1o8FHxP467xZVmSuQ/cRzGPCx
         Bs/g==
X-Forwarded-Encrypted: i=1; AKwUvBzZn/1rdG3mlzY4W4nPd7v8JGIJI7LIobNtOGyolXGK5ToY+owBr3/rC3WcfJu2mGNwRJ2DNzgzPiO67N1F@vger.kernel.org
X-Gm-Message-State: AFq9FYKemi7HeIYZzsFHQvYgYU6YhijsFQleWTsUhdR6jHBmoLVhzZAV
	O/cu/vrocIcyCxP2TJ+pTaiCQRNNiR/SnzPng6n5nAhdg/bhAzcQNsObZZ0qJa9c9nGpuRtJVWz
	cqLnpV7/4VOOp+WFpkEZTZtnWrCCvSkk=
X-Gm-Gg: AYBFou0roNOvF4Bqm92DoK76axJAf+jPbUO6k2H51NOQcrT1E1YGUB3wKZG7uXLFJ/v
	u0qg+Ev6Z6xbOg0nRIF1dQrgneoBid1BaEERvawmoWpLaFDhEcJIfpLH2j/dZWoJOA3LKOEaUT+
	W76pcs0c5aI6AdGzqivAgw1oA+CIsMKt8EPlM8OVXpJZjMrMK0tEDtWK27173Bh9XdDjxudYRIg
	LYTgctN7hK9imOYg+c3okk6+mrGhGtDvCthKrWmes4obzEqctmtUG9N9Jrq97GupgfuhqPIlH0w
	tjrR/b4v6A8tmlL7PnwGtOI7dXoGncwFcmXjpPeTb6s+CHx0soZGvxm/IPtd0b/Y2HKwHIMQKFS
	9arvCDTT6jBaqBJYm0SOO
X-Received: by 2002:a05:690e:1488:b0:671:c5e:6d5 with SMTP id
 956f58d0204a3-675402599d3mr3526028d50.4.1790673962997; Tue, 29 Sep 2026
 02:26:02 -0700 (PDT)
Precedence: bulk
X-Mailing-List: live-patching@vger.kernel.org
List-Id: <live-patching.vger.kernel.org>
List-Subscribe: <mailto:live-patching+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:live-patching+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260913024228.72317-1-laoar.shao@gmail.com> <20260913024228.72317-3-laoar.shao@gmail.com>
 <179032647206.68715.855492643431181079.b4-review@b4> <CALOAHbBQyCNyvWtv3r+7mgScGuiZunfDq-+CJgKYGVyZDxcB3g@mail.gmail.com>
 <alpine.LSU.2.21.2609291040330.18161@pobox.suse.cz>
In-Reply-To: <alpine.LSU.2.21.2609291040330.18161@pobox.suse.cz>
From: Yafang Shao <laoar.shao@gmail.com>
Date: Tue, 29 Sep 2026 17:25:25 +0800
X-Gm-Features: AclHuK-Mh2jxZDIOZqG4QPgIwcJb_xHY-dnEFWzFuPyzDZ4dY-7Dr0emHkarQkY
Message-ID: <CALOAHbCJ56wfkZaTzYg1VgtkHyN9v02XAMX10-rJVtw8XKrVtQ@mail.gmail.com>
Subject: Re: [PATCH v9 2/9] selftests/livepatch: Adapt atomic replace tests to provides/obsoletes
To: Miroslav Benes <mbenes@suse.cz>
Cc: Song Liu <song@kernel.org>, jpoimboe@kernel.org, jikos@kernel.org, 
	pmladek@suse.com, joe.lawrence@redhat.com, live-patching@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 29, 2026 at 4:43=E2=80=AFPM Miroslav Benes <mbenes@suse.cz> wro=
te:
>
> > > >  # check_result() - verify dmesg output
> > > >  #    TODO - better filter, out of order msgs, etc?
> > > >  function check_result {
> > > > @@ -365,6 +374,27 @@ function does_sysfs_exist() {
> > > >       [[ -f "$SYSFS_KLP_DIR/$mod/$attr" ]]
> > > >  }
> > > >
> > > > +# detect_provides_attr() - detect whether the running kernel suppo=
rts the
> > > > +# livepatch "provides" attribute and set HAS_PROVIDES_ATTR accordi=
ngly.
> > > > +# The provides/obsoletes based tests are only run when HAS_PROVIDE=
S_ATTR
> > > > +# is set.
> > > > +function detect_provides_attr() {
> > > > +     HAS_PROVIDES_ATTR=3D0
> > > > +
> > > > +     if [[ -r /proc/config.gz ]] &&
> > > > +        zgrep -q "CONFIG_KLP_HAS_PROVIDES=3Dy" /proc/config.gz 2>/=
dev/null; then
> > > > +             HAS_PROVIDES_ATTR=3D1
> > > > +             return 0
> > > > +     fi
> > > > +
> > > > +     load_lp test_klp_cmdline_lp
> > > > +     if does_sysfs_exist test_klp_cmdline_lp "provides"; then
> > > > +             HAS_PROVIDES_ATTR=3D1
> > > > +     fi
> > > > +     disable_lp test_klp_cmdline_lp
> > > > +     unload_lp test_klp_cmdline_lp
> > > > +}
> > >
> > > Why is there does_sysfs_exist() fallback? I mean, we use that current=
ly
> > > for exactly this purpose. My understanding is that
> > > CONFIG_KLP_HAS_PROVIDES is also used elsewhere in the code so using i=
t
> > > here makes some sense, but do we need both?
> >
> > CONFIG_IKCONFIG_PROC may not be enabled, so if /proc/config.gz doesn't
> > exist, we must fall back to an alternative one.
>
> Ok. Let's keep it like that because it is definitely cheaper than loading
> and unloading a module. Could you add a comment just before
> does_sysfs_exist() fallback about CONFIG_IKCONFIG_PROC, please?

I will update it.

--=20
Regards
Yafang

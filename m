Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CAF5D38C42D
	for <live-patching@vger.kernel.org>; Tue, 26 May 2026 18:28:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779820090; cv=none; b=Y4+epVE5n88AdEsYMEvEHBZeDrNVwXysy2LZasaB3A7oATBQthUWHOgYK1xa6ooAUzXGnP2mx86p/SQcGLn8NE4aGZxfI4iRXCD3h3XLC8zCeh83B+qZyo9ZFQniujA38nd1i7SjAPCy1uRH71Ipqg8iJCUsMi997DDWH9eoHhE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779820090; c=relaxed/simple;
	bh=92RLB+LsBmj6/cQJEKssexPiW/LGz7Rb2s+WDolZcJc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ACaXK9Fu4vUr56pYMA92EaED8gTsHEpd+uXDTVBNjcUS5KW4maJhfo+WWw9LXDQMchzqI88dBU+TfA1tZxEoEOHfIn6rkEF+SV9Zg6o9O+JfG4wCAvUa1yDrNWyidmcio6bDFRS2vfezGCp2f796JwaTZww2IpACKl+Rwtp7cSE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ajffb/tP; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ajffb/tP"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 633E31F000E9
	for <live-patching@vger.kernel.org>; Tue, 26 May 2026 18:28:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779820089;
	bh=HI2uoA0n1M13V/as5BANxWG0gD/IOAfpKGAm07iqeMw=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=ajffb/tPoKoVz6F1bulr5ZGrO4oCvagr7BOLhk6Grk/85d3m3XVEpzmDwiGNyW9f5
	 abag3IKcNppafmRM0GtE8qcU6/5bg2HodDPqKrEmVNwgu3rvBMq3cpDT+d4M+FG2Mz
	 expI6JFZiRpPh3h44WJ9Rm0oEQmOBDtm4EFK+VppMYbnYPQ7NVtsa0EJFKfHWUonVs
	 0ni4btwoCczUw3bBKj3VVr2RmjaLjkhFb3aZmsu+PeF4TTR6SJ2DYzcMQkDDGwwHky
	 KCS2TKqjbzl0E8iDJQ82VeRt8lh4pSt2niw9yb5Q8UZICYUdJGmKk2i68RFcx4tT5d
	 QO+xPVLMLkO+Q==
Received: by mail-qk1-f181.google.com with SMTP id af79cd13be357-91066394ef8so839399585a.1
        for <live-patching@vger.kernel.org>; Tue, 26 May 2026 11:28:09 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AFNElJ9cGxUcxovYtlrUQ3OI287VxOKDCp2Lja69vGtIJEonl4V0UVKGGHVG++F2En2EMVk3iLoaJMvZ159h83ky@vger.kernel.org
X-Gm-Message-State: AOJu0Ywnn2ZSMZrYE5OIinQZKoEy9qpM0cEb8Y9Sfz5lJepo2bffW9VE
	ErW0G6kvBie3/YasC7QwyQmiJPJf0mQRUNVuTGlsvov/fPCnEXfP48Qn07caheQlSZOeYCZ9uuA
	4HlNuZeckpP4ovMcF40Hr2hhaiJu74/I=
X-Received: by 2002:a05:620a:468a:b0:914:aa94:8e9 with SMTP id
 af79cd13be357-914b4915983mr3024257085a.17.1779820088722; Tue, 26 May 2026
 11:28:08 -0700 (PDT)
Precedence: bulk
X-Mailing-List: live-patching@vger.kernel.org
List-Id: <live-patching.vger.kernel.org>
List-Subscribe: <mailto:live-patching+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:live-patching+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260513143321.26185-1-laoar.shao@gmail.com> <20260513143321.26185-2-laoar.shao@gmail.com>
 <CAPhsuW6Aa8Tu5aWGVYzRVVNEnJiHrNzsa4aKXoOEa_gwhp3XfQ@mail.gmail.com> <ahV3dBovdQZoF__j@pathway.suse.cz>
In-Reply-To: <ahV3dBovdQZoF__j@pathway.suse.cz>
From: Song Liu <song@kernel.org>
Date: Tue, 26 May 2026 11:27:56 -0700
X-Gmail-Original-Message-ID: <CAPhsuW4OsPexwZE9EeffuDwndV_Oj-fcR5T-ZFFsBOuY1EkKnw@mail.gmail.com>
X-Gm-Features: AVHnY4LgnIdR7FBDhKYiefSL6cYaiPAKWIxmnFMRWEw2peeQr1mD8A_NBERYNrE
Message-ID: <CAPhsuW4OsPexwZE9EeffuDwndV_Oj-fcR5T-ZFFsBOuY1EkKnw@mail.gmail.com>
Subject: Re: [RFC PATCH 1/6] livepatch: Support scoped atomic replace using
 replace set
To: Petr Mladek <pmladek@suse.com>
Cc: Yafang Shao <laoar.shao@gmail.com>, jpoimboe@kernel.org, jikos@kernel.org, 
	mbenes@suse.cz, joe.lawrence@redhat.com, live-patching@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, May 26, 2026 at 3:35=E2=80=AFAM Petr Mladek <pmladek@suse.com> wrot=
e:
[...]
> > I wonder whether we should have "replace_set =3D 0" means no replace.
> > This will simplify the transition for users of the existing replace=3Df=
alse
> > option. I would like to hear other folks' thoughts on this.
>
> I would find this confusing. Also it would complicate the code.

Agreed with your assessment of the scenario.

> I always considered the "replace" and "no replace" mode as two
> separate worlds:
>
>     + people using many "no replace" livepatches

My only concern is that we are adding more burden to these users.
Before replace_set, they just use 0 for all the live patches. With
replace_set, they will have to use some mechanism to assign a
unique replace_set for each livepatch.

I don't know how many users are in this world. If there aren't many
users, we can ignore this case.

>     + people always using atomic replace

OTOH, these users don't need much change. They will just use
replace_set =3D 1 for all live patches.

Note that, I am not proposing to have replace_set =3D 1 to replace
all live patches. It only needs to replace other live patches with
replace_set =3D 1. The only change I am proposing (debating) here
is to have replace_set =3D 0 as "no replace". However, if this still
feels too confusing, or there are NOT many users in the "no
replace" world, we can safely ignore this.

Thanks,
Song

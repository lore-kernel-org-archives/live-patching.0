Received: from mail-yx1-f52.google.com (mail-yx1-f52.google.com [74.125.224.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29D6C3E1688
	for <live-patching@vger.kernel.org>; Fri,  9 Oct 2026 08:33:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.224.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791534821; cv=pass; b=YYFljS9FasfrsB3yXLIOtXGvQdv6xL++XnIRqBH2Mq7hcS1huYSxkddsN3QkQvq/+uN1TKBs8nxG7Ep8NJFfFyYKeoLAJ7QQjOtCvyyBljtK9Jrw6tVUsKlcvW1GwjxSQ0J4TkltGzX4S/OKH8+9+lL8dBnOYIgOttY0A5nU/vc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791534821; c=relaxed/simple;
	bh=ddeJ1Zt4cF3j4uvmIU3owGW1qWyWoX0MOr2QpO/cFA8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=QU9l+YcQNICjPmPRnLVeYpRXGCkMCcnVAWrTLLyGY1sejbNc8Qr0FXFUKZpDfSBtftgze/1S4nsy9qEHSMrTjDo1sJEmjq2qE6fs29x0lmXOcPZLWd5Ci0Nhgkn+TGoVV6CzBwEmQBBOCMhsDANHErN31P5nd/2Wws7PI9DlpPc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dfK13TPZ; arc=pass smtp.client-ip=74.125.224.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dfK13TPZ"
Received: by mail-yx1-f52.google.com with SMTP id 956f58d0204a3-677c1fc082bso5345116d50.3
        for <live-patching@vger.kernel.org>; Fri, 09 Oct 2026 01:33:39 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1791534819; cv=none;
        d=google.com; s=arc-20260327;
        b=X+qEghlLP6smm+QTgvHKkrTHV9Uw6CvRj4OsWeAfkRqmH4C5s4EYmdf6cHAC5ouldS
         ZCVlFmYbGrD2EwixXChkv+cg3NgMDubn9m0wIMLevOo5YGPUKaelEYITiXQvq0fELQAJ
         Cyg84NgV+ALraJFtPmDTuSOvc/IydZqF232LUfGW5thnjxXjj4MJIiwV0D3zfr1WgQr+
         qE2Gd8PbWw1bk/57mea7UCBvaZQ7zFBLaJCfWuT/+LWpDTSqTcbTUPw14bggc9yVuZt5
         MWcBLce9HXjbPqt8UPNhY7z46ck5maky6DqIBUrov3Ar2ucWZyCEeD3XawT+oy7K3tMR
         o4Kg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=tp8jzmJ+j9j47iv0QhHar3/TDlI8KsvEQBACpC9vK3k=;
        fh=wlYSlSxm43AI3JoblHS2DW5orxFr/hfH31rHAFBc3RI=;
        b=rigWYkYsyLVx+FQxx0ILNURftWMvPCFqEPCfZetZ2sEwR7YERIGPGN4Pz+UNasSAD8
         OrU52Po9+Lt+sB46WICg5VSEwm32dHGfBEsCumxY8NxFQlRg/3t4Cqh3YNog3Bg01nMZ
         QngOqH9Rp4Zj6RMYcKrmjN4WoOeVJsu/5yGWzdQ+nAzwbwu5V6xAvW0W63Ftov3WQEam
         k4RLAe2S5antmyLzgLwNu/POExkT9ASOatKZlkVHosq4uBR9EAnP0ZoN+JtCTM33QwR0
         JyneY9rtP/U3bVMuxYwEqJG2hQESmxYbhxwQ2ovfHZY+LEvIfbztBIlCQCv8P/QPUWIJ
         XErQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791534819; x=1792139619; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=tp8jzmJ+j9j47iv0QhHar3/TDlI8KsvEQBACpC9vK3k=;
        b=dfK13TPZ2HR9G3xoEef0ffguFhz9wsNBAPBJ9ZFRS7zVZickwx+eC/DkAB4Yr3+7pp
         xdYm0dKqH0blsk4r5OhX9O+9M/+JRYPsCWy7ZDYXblC+Hsm4GQbPfZ6LIQTVUbs2UgYr
         wCX4jlCQL9Xhgzw2SIL1ItXZm4bhBsLtxFMAaJO+oXJnm1dZGJ7tmiMTiKmjXQCuvJD+
         8QTeyGRyUKVZjHmQi1uNYFQ8xn1T35mN18kkDuNVzCAXJuVfUZBFSibXkANkbCl26bO2
         +EWJWvB85/v06b0I3gEJnTLrqFnNpi7oFIQZghhNI5rNgBNzfSFNIolF5W+h9g/eNyY4
         xCow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791534819; x=1792139619;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=tp8jzmJ+j9j47iv0QhHar3/TDlI8KsvEQBACpC9vK3k=;
        b=q4nUyjTPcgaLlkdqjJCZO9gR5DS3SdwWVTeEoqedNcIvtRq+ehVV8wtH44Sqn8mNmd
         +39e0zowk7cOe99z0uDl4TuI4iKMozfxOa6rqgmCNFaXkBKMHiM5AzZW4aZ4gMnq8pan
         f4cUAHXOi77rLEE7Q1gbWzfOBlDZOFtMv87a1651j5E6BLJYF8cTu+jTh7CnwTVJZmSm
         +6HSauMiC9xeutqHIHhMCCYgtInWMs5N+4eoD7pDaJEVHv1wZsy/z3VpORhrWbsnk87w
         33HDzjJhMKOq3p685Xn7iY2W0Z4wELdGrgYgNzdGAEgw+IE5Pca7IE2LYD11D5H613S3
         iM9g==
X-Forwarded-Encrypted: i=1; AKwUvByZXUf6raQ6xrwzFzh7TFGU3Rn/OmVzt+4z950WV+DHfKWjty4cK5G46a0BZOnEdo0SXM4gaajwikrICSqk@vger.kernel.org
X-Gm-Message-State: AFq9FYJoevOrI43W8e6xXHN8z/mDYOPwmNUYy0E9/Tx/4NfGWiiXBoTK
	0noEhbx/6PV5VpLzZxof/6I7o9CPtnEKpjLqHXPjujO5GmYbRX2HpzBLvhI0QI0bAHknEzTlrr5
	87LWp8WCCgH/AzmdvXoy5QeSnWpJWxE4=
X-Gm-Gg: AYBFou1tHi4ZhfAkEky31PWKkNKSm7wOSypF4Yq25cJsJLHlSq3cyj5DePS69wWu/eH
	EI541+GHbIqtXbrwOU/gpxobaSQ/snuYwGdAUbenWvyr5W0by/H1qLPP+7Z3pczuyGft6OMeGrR
	A3rL3JwBLuYzBGG13vK6FJVwPUW61s+PMkdm6T/ehWE3zbMWe0oOXp/H0qFcltbFBmb0QbiaFK6
	fIgTKyBb9bQPViiUfNoYXAiiPgRyi5nfN3PEt/wqiS5rbBXACnHbPoCk6SV2aDJEPjTvCnWgLYr
	zU2e2rdiGjkcDEZOQtBOeAp3qw4gx4gdlFkQXjX2Uw1ZIQkC0MNfGOUSBh2O6zvIvXvpYD86rAa
	Q3P89zAlNYw==
X-Received: by 2002:a05:690e:43d0:b0:677:db69:cbd4 with SMTP id
 956f58d0204a3-67936013292mr205531d50.34.1791534818887; Fri, 09 Oct 2026
 01:33:38 -0700 (PDT)
Precedence: bulk
X-Mailing-List: live-patching@vger.kernel.org
List-Id: <live-patching.vger.kernel.org>
List-Subscribe: <mailto:live-patching+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:live-patching+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260930030323.14396-1-laoar.shao@gmail.com> <20260930030323.14396-6-laoar.shao@gmail.com>
 <ar_kouwlAGcnnUYQ@pathway.suse.cz> <CALOAHbCHwJ2htPOoako_EqNg-bQF=4NLNqVGAnzsAi2uitMdeQ@mail.gmail.com>
 <asdwx-BENZy6dajG@pathway.suse.cz> <CALOAHbC3p30s8sQwd5OO6DLqQ+5qvpFyyRWb2p05mmMabO7E6g@mail.gmail.com>
In-Reply-To: <CALOAHbC3p30s8sQwd5OO6DLqQ+5qvpFyyRWb2p05mmMabO7E6g@mail.gmail.com>
From: Yafang Shao <laoar.shao@gmail.com>
Date: Fri, 9 Oct 2026 16:33:00 +0800
X-Gm-Features: AclHuK-Og6XWwv-rK0S3uVozAtIPaer3AUdEkRM2-IuDS5HVu4GUbSZAOowTcKQ
Message-ID: <CALOAHbCDrFjNEQPqEOpLH5K7rKjVvYz3nDWce9hZpWfjY-AMEQ@mail.gmail.com>
Subject: Re: [PATCH v10 5/9] livepatch: Implement provides and obsoletes for
 scoped atomic replace
To: Petr Mladek <pmladek@suse.com>
Cc: jpoimboe@kernel.org, jikos@kernel.org, mbenes@suse.cz, 
	joe.lawrence@redhat.com, song@kernel.org, live-patching@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 8, 2026 at 7:04=E2=80=AFPM Yafang Shao <laoar.shao@gmail.com> w=
rote:
>
> On Thu, Oct 8, 2026 at 6:30=E2=80=AFPM Petr Mladek <pmladek@suse.com> wro=
te:
> >
> > On Sun 2026-10-04 23:46:29, Yafang Shao wrote:
> > > On Sat, Oct 3, 2026 at 1:06=E2=80=AFAM Petr Mladek <pmladek@suse.com>=
 wrote:
> > > >
> > > > On Wed 2026-09-30 11:03:19, Yafang Shao wrote:
> > > > > The current bool replace flag is too coarse: it is either all or
> > > > > nothing. A livepatch with .replace=3Dtrue replaces ALL existing
> > > > > livepatches, which is safe but inflexible. There is no way to hav=
e
> > > > > multiple independent livepatch sets coexist on the same system.
> > > > >
> > > > > Replace it with a more flexible model using two new fields in
> > > > > struct klp_patch:
> > > > >
> > > > > - provides: an unsigned int id identifying the changes made by
> > > > >   the related livepatch. Where the changes are a set
> > > > >   of modified objects, functions, and used callbacks,
> > > > >   shadow variable ids, and state ids.
> > > > >
> > > > > - obsoletes: an optional array of unsigned int ids specifying
> > > > >   additional provides ids to be replaced. This allows a new patch
> > > > >   to explicitly obsolete patches from different scopes.
> > > > >
> > > > > A new livepatch atomically replaces any existing livepatch that
> > > > > meets any of the following conditions:
> > > > > 1. It has the same provides id as the new patch,
> > > > > 2. Its provides id is listed in the new patch's obsoletes list, o=
r
> > > > > 3. The new patch's provides id is listed in its obsoletes list
> > > > >    (the obsoletes relationship is symmetric).
> > > > >
> > > > > The obsoletes relationship is symmetric: two livepatches that
> > > > > obsolete each other are mutually exclusive. Loading either one
> > > > > atomically removes the other, so they can never be enabled at the
> > > > > same time. This allows swapping between two independently prepare=
d
> > > > > livepatches that cover the same scope, in either direction.
> > > >
> > > > Honestly, I am confused by the 3rd rule and by the last paragraph.
> > > > It is not compatible with my understanding of the provides/obsolete=
s
> > > > semantic.
> > >
> > > Correct. In package management semantics, Obsoletes is not a symmetri=
c
> > > relationship.
> > >
> > > >
> > > > In my mental model, the provides and obsoletes define which
> > > > way is supported. Let me show an example, let's have:
> > > >
> > > >  Livepatch A:
> > > >    + provides: 1
> > > >    + obsoletes:
> > > >
> > > >  Livepatch B:
> > > >    + provides: 2
> > > >    + obsoletes: 1
> > > >
> > > >  Livepatch C:
> > > >    + provides: 3
> > > >    + obsoletes: 1,2
> > > >
> > > >  Livepatch D:
> > > >    + provides: 2
> > > >    + obsoletes: 1,3
> > > >
> > > > How is this supposed to work, please?
> > > >
> > > > In my mental model:
> > > >
> > > >   Livepatch A:
> > > >      + can be replaced by B, C, or D because they all obsolete 1
> > > >      + can _not_ replace B, C, D because A does not obsolete 2 and/=
or 3.
> > > >
> > > >   Livepatch B:
> > > >     + can be replaced by C because C obsoletes both 1 and 2
> > > >     + can be replaced by D beause D provides 2 and obsoletes 1
> > > >     + can't replace C or D because B neither provides not obsoletes=
 3.
> > > >
> > > >   Livepatch C:
> > > >     + can be replaced by D because D provides and obsoletes
> > > >        all ids which are proviced and obsoleted by D
> > > >
> > > >     + can replace D from the same reasons.
> > > >
> > > >
> > > > OK, I understand that it might be practical to allow replacing
> > > > the patches just because they are "conflicting". As a kind
> > > > of revert/downgrade.
> > >
> > > Right. This will let us easily roll back the buggy livepatch and
> > > reinstall the old one as part of the rollout.
> > >
> > > >
> > > > It might help to rename "obsoletes" to "conflicts". And just
> > > > say that the livepatch replaces livepatch with the same id
> > > > in provides and also all conflicting patches.
> > > >
> > > > But then I see another problem. We have three types of conflicts:
> > > >
> > > >   1. same id in provides/obsoletes/conflicts
> > > >   2. same livepatches function
> > > >   3. same livepatch state id
> > > >
> > > > It is weird that we would silently replace livepatches with 1st
> > > > type conflict. But we would refuse to load the livepatch with
> > > > the 2nd and/or 3rd type conflict.
> > > >
> > > > Note that the inconsistent handling of conflicts exists in
> > > > this patch even when the array is called "obsoletes". My proposal
> > > > to rename it to "conflicts" just helped me to see this
> > > > inconsistence.
> > > >
> > > > Any option/idea? Yet another naming?
> > >
> > > Perhaps it could use a better name, but I'm not good at naming things=
 ;)
> > >
> > > >
> > > > One more thing, the commit message does not describe that
> > > > the livepatches might conflict when livepatching the same
> > > > function or using the same state id. It is important part
> > > > of the semantic and must be documented.
> > >
> > > Sure. I will update it.
> > >
> > > >
> > > > Best Regards,
> > > > Petr
> > > >
> > > > PS: I am sorry but I won't be able to finish the review before
> > > >     the Plumbers conference. But I am happy that I have found
> > > >     the above problem. We could discuss it at the conference
> > > >     and come up with some sane naming and semantic.
> > >
> > > I can't be there in person, but I believe we'll come up with a
> > > sensible name or semantic. I'll hold off until we reach a final
> > > conclusion.
> >
> > I am not sure if you saw the video from the the conference.
>
> Song has shared the results with me offline. Thank you all so much!
>
> > It looked like we were going to nack this feature because
> > installing more livepatches on the system was considered
> > too dangerous.
> >
> > In particular, it allows using livepatches provided by different
> > teams/vendors. It is almost impossible to prevent incompatible
> > changes and breaking the system. The check preventing livepatching
> > the same function or using the same state IDs is just the best
> > effort but it still allows many hidden incompatibilities.
> >
> > We should rather discourage people installing more livepatches
> > in parallel.
> >
> > Anyway, we had a follow-up discussion and agreed to accept this
> > feature in the end. We already allow to install more livepatches
> > in parallel. So this patchset is not adding any new danger.
> > Instead, it reduces the danger a bit without complicating the
> > code too much.
> >
> > Also we understand that there might be some use cases for this
> > feature. And it might be safe when used carefully.
> >
> >
> > We also discussed the semantic of the obsolete field and we
> > would like to it simple. The livepatch with a provides ID should
> > replace a livepatch with another provides ID _only_ when the other
> > ID is mentioned in obsoletes.
> >
> > By other words, please remove the symmetry and "support" for
> > a rollback. The symmetry causes some confusion as explained
> > before. I would summarize it by two reasons:
> >
> >    + In the packaging world, the "obsoletes" behavior is not
> >      symmetric.
> >
> >    + The symmetric behavior adds a "conflict" semantic. But
> >      this particular conflict is handled another way than
> >      the other conflicts (livepatches functions, state IDs).
> >      I mean replacing an already enabled livepatch vs.
> >      rejecting the new one.
> >
> > In addition, we do not support the rollback in all situations,
> > for example, let's have:
> >
> > Livepatch A:
> >   + provides: 1
> >   + obsoletes:
> >
> > Livepatch B:
> >   + provides: 2
> >   + obsoletes:
> >
> > Livepatch C:
> >   + provides: 3
> >   + obsoletes: 1,2
> >
> > The meaning is:
> >
> >   + A and B are independent livepatches.
> >   + C adds some dependency and has to replace both A and B.
> >
> > Here a proper rollback from C to A+B would require loading both
> > A and B livepatches synchronously. It would require adding
> > special support into the module loader and the livepatch core code.
> > We do not want to add this complexity. Especially, because
> > the parallel installation of livepatches is considered a bad
> > practice.
> >
> > A partial workaround might be to allow changing "obsoletes" via
> > a livepatch module parameter. It would allow to do the
> > rollback in 2 steps:
> >
> >    modprobe obsoletes=3D3 livepatch_A
> >    modprobe livepatch_B
> >
> > It is still not an atomic rollback. But it is better than
> > without the parameter which would require 3 steps:
> >
> >    echo 0 > /sys/kernel/livepatch/livepatch_C/enabled
> >    modprobe livepatch_A
> >    modprobe livepatch_B
> >
> >
>
> Thank you for the review! I had actually sent v11 before your email
> arrived =E2=80=94 you can find it here:
>
> https://lore.kernel.org/live-patching/20261008095830.26308-1-laoar.shao@g=
mail.com/
>
> Regarding your summary:
>
> >
> > Summary:
> >
> > We are open to accept this feature but please:
> >
> >     + Remove the symmetric handling of obsolete flag.
>
> Done in v11.
>
> >
> >     + Properly document, in both the commit message and
> >       documentation, when the livepatches will be replaced
> >       and when they will conflict.
>
> Done in v11.
>
> >
> >     + Document the pitfalls with the rollback.
>
> Not yet addressed =E2=80=94 I'll cover this in the next revision.
>
> >
> >     + Add a warning that installing more livepatches in parallel
> >       is dangerous, especially when they are provided by different
> >       teams or vendors. The built-in checks of possible conflicts
> >       do not prevent potential incompatibilities and breakages.
>
> Not yet addressed =E2=80=94 planned for the next revision as well.
>
> >
> >
> > Heh, I hope that I got it right.
>
> If you have a chance, could you take a look at v11 and let me know if
> there's anything else I should address?
> Thanks again for your time and guidance!

Hi Petr,

Regarding the last two comments, I've drafted the following additional
changes on top of v11. Does the wording look good to you?
If yes, I'll fold them into the series and send v12.

diff --git a/Documentation/livepatch/cumulative-patches.rst
b/Documentation/livepatch/cumulative-patches.rst
index f456b727318b..5ce04424e09d 100644
--- a/Documentation/livepatch/cumulative-patches.rst
+++ b/Documentation/livepatch/cumulative-patches.rst
@@ -25,6 +25,13 @@ the default ``provides =3D 0``. As long as all
livepatches use the same default
 id, any livepatch replaces any other livepatch, preventing any unexpected
 interactions between incompatible livepatches.

+Installing more livepatches in parallel is dangerous, especially
+when they are provided by different teams or vendors. The built-in
+checks for possible conflicts do not prevent potential
+incompatibilities and breakages. For example, two livepatches might
+modify different functions but still affect each other via shared
+data structures or global variables.
+
 Provides and Obsoletes
 -----------------------

@@ -109,6 +116,35 @@ Limitations:
     only when the transition was not forced.


+  - The rollback is even more complicated when the new livepatch
+    obsoleted more livepatches. For example, livepatch A (provides 1)
+    and livepatch B (provides 2) are independent. Livepatch C
+    (provides 3, obsoletes 1 and 2) replaces both A and B. A proper
+    rollback from C would require loading A and B synchronously.
+    It would need special support in the module loader and
+    the livepatch core code. This is not supported.
+
+    Instead, the rollback has to be done in more steps, for example::
+
+      echo 0 > /sys/kernel/livepatch/livepatch_C/enabled
+      modprobe livepatch_A
+      modprobe livepatch_B
+
+    Note that the replaced livepatches stay loaded but disabled.
+    They have to be removed before they can be loaded again.
+    The example above assumes that they were removed in
+    the meantime.
+
+    Also, the older livepatches can be loaded only when they do
+    not conflict with the still enabled ones, see the conflict
+    rules above. The newer livepatch is expected to include the
+    fixes from the obsoleted livepatches. As a result, the
+    rollback usually has to start by disabling the newer
+    livepatch. The rollback is not atomic. The affected
+    functions run the original code until all the older
+    livepatches get loaded again.
+
+
   - Only the (un)patching callbacks from the _new_ cumulative livepatch ar=
e
     executed. Any callbacks from the replaced patches are ignored.

diff --git a/Documentation/livepatch/livepatch.rst
b/Documentation/livepatch/livepatch.rst
index 56c4022654d7..2567e09c74fd 100644
--- a/Documentation/livepatch/livepatch.rst
+++ b/Documentation/livepatch/livepatch.rst
@@ -357,6 +357,11 @@ In this case, the two livepatches must not modify
the same function, or use
 the state with the same id. Any attempt to load an incompatible livepatch
 will be rejected by the kernel.

+Installing more livepatches in parallel is dangerous, especially
+when they are provided by different teams or vendors. The built-in
+checks for possible conflicts do not prevent potential
+incompatibilities and breakages.
+
 Once the transition is complete, all functions (``struct klp_func``)
 associated with the matching replaced patches are removed from the
 corresponding ``struct klp_ops``. If a function is no longer modified by

--=20
Regards
Yafang

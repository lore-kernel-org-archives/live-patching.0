Return-Path: <live-patching-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3B6E1C433EF
	for <live-patching@archiver.kernel.org>; Mon,  9 May 2022 19:10:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240449AbiEITOW (ORCPT
        <rfc822;live-patching@archiver.kernel.org>);
        Mon, 9 May 2022 15:14:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49866 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240446AbiEITOV (ORCPT
        <rfc822;live-patching@vger.kernel.org>);
        Mon, 9 May 2022 15:14:21 -0400
Received: from shelob.surriel.com (shelob.surriel.com [96.67.55.147])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AB64C293B79;
        Mon,  9 May 2022 12:10:26 -0700 (PDT)
Received: from imladris.surriel.com ([96.67.55.152])
        by shelob.surriel.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_ECDSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <riel@shelob.surriel.com>)
        id 1no8lt-0002U9-KO; Mon, 09 May 2022 15:10:17 -0400
Message-ID: <68f91fb233d5bf82e29cc5c6960a62863b297db3.camel@surriel.com>
Subject: Re: [RFC] sched,livepatch: call stop_one_cpu in
 klp_check_and_switch_task
From:   Rik van Riel <riel@surriel.com>
To:     Josh Poimboeuf <jpoimboe@kernel.org>
Cc:     Song Liu <song@kernel.org>, linux-kernel@vger.kernel.org,
        live-patching@vger.kernel.org, mingo@redhat.com,
        peterz@infradead.org, vincent.guittot@linaro.org,
        jpoimboe@redhat.com, joe.lawrence@redhat.com, kernel-team@fb.com
Date:   Mon, 09 May 2022 15:10:16 -0400
In-Reply-To: <20220509180004.zmvhz65xlncwqrrc@treble>
References: <20220507174628.2086373-1-song@kernel.org>
         <20220509115227.6075105e@imladris.surriel.com>
         <20220509180004.zmvhz65xlncwqrrc@treble>
Content-Type: multipart/signed; micalg="pgp-sha256";
        protocol="application/pgp-signature"; boundary="=-8fjrMtbSQtuvFTIamLXF"
User-Agent: Evolution 3.42.4 (3.42.4-1.fc35) 
MIME-Version: 1.0
Sender: riel@shelob.surriel.com
Precedence: bulk
List-ID: <live-patching.vger.kernel.org>
X-Mailing-List: live-patching@vger.kernel.org


--=-8fjrMtbSQtuvFTIamLXF
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, 2022-05-09 at 11:00 -0700, Josh Poimboeuf wrote:
> On Mon, May 09, 2022 at 11:52:27AM -0400, Rik van Riel wrote:
> > Does this look like an approach that could work?
> >=20
> > @@ -315,6 +321,9 @@ static bool klp_try_switch_task(struct
> > task_struct *task)
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0case -EBUSY:=C2=A0=C2=
=A0=C2=A0=C2=A0/* klp_check_and_switch_task() */
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0pr_debug("%s: %s:%d is running\n",
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
 __func__, task->comm, task->pid);
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0/* Preempt the task from the second KLP switch
> > attempt. */
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0if (klp_signals_cnt)
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0stop_o=
ne_cpu(task_cpu(task),
> > kpatch_dummy_fn, NULL);
>=20
> I must be missing something, how is briefly preempting a kthread
> supposed to actually transition it?=C2=A0 Won't it likely go back to
> running
> on the CPU before the next periodic klp_transition_work_fn() check?
>=20
That's the kind of feedback I was hoping for ;)

I looked around the code a little bit, and it seems
that only the idle tasks can transition to another KLP
while they are running?

That makes me wonder how the kworker thread that runs
the klp switching code transitions itself...

Should kernel threads that can use a lot of CPU have
something in their outer loop to transition KLPs,
just like the idle task does?

--=20
All Rights Reversed.

--=-8fjrMtbSQtuvFTIamLXF
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----

iQEzBAABCAAdFiEEKR73pCCtJ5Xj3yADznnekoTE3oMFAmJ5ZxgACgkQznnekoTE
3oMAbQf/atY56IVjx2ggJ6AXEZS/hq956KtUV6M0CHWL4+JGly/8Y+CFt/FDHy6U
00r89Uty7vv6OxL++mjjfOGg7o9FGDogg1dIqRaQwX++uXk493ixmvlQE77g6WtJ
lfk+pOtJyDwUaEiJkwHjv7MCbQBYBiwwZB4eZH/mlMwo1xNt8ten1YOOGojRmDfv
hwxvs25AHNIDv3PUIK5YuyBR7n6/bkUgh3Wuw1zj8kQ05LgcM4obHLvjDvFcBLRW
TbmyFC8ODY1Vq3gcWieLAlmPG9vkgzI/ESE8OYIg90xGfChbwUE8hQPrqZO5z3Y4
/n2eqP2EBSmCD7g0cz25Ite2R82cgQ==
=+Vcf
-----END PGP SIGNATURE-----

--=-8fjrMtbSQtuvFTIamLXF--

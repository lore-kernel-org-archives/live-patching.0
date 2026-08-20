Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A53693C9EF4
	for <live-patching@vger.kernel.org>; Thu, 20 Aug 2026 07:42:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787211776; cv=none; b=MnQs1qhh35w7gySo9XVXJoauYxD7kfP5Q2bf8A/zIYgzqdHx1iVBBdsscpHol4VzyYY1n9CDYGt4/s/zAxzKH2Kk/INLKD3JEOA47uy55OUQFUY0LiBA0p7vhKI4LcPkj2mWAgGER/BGetAGx+KX8U2HouGPDBr7scVgCo8xbTo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787211776; c=relaxed/simple;
	bh=AqUhh2XJ70EsIUOmKutmWRilc0z5hldt4fAvzaocFto=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MY/0CGMwB6GugOcGLCGhR88WRIcByutx5+XbMemhNNgPAt8uEHN5sBcn+2t3eKGLLLOOT+8cP8XUqY9XEKdLXEJpxLyeAA4BurKmNKpa0fhjcj7d2y4FW0laC9i5y5t7IuBDc1MJTx/9Ne4SrKt7vC/aMF3J+zDM+5EHJAN2s78=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=JxTtYsBm; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="JxTtYsBm"
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-4957eefd361so15344195e9.1
        for <live-patching@vger.kernel.org>; Thu, 20 Aug 2026 00:42:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1787211770; x=1787816570; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:from
         :date:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=OcWUGBQ/SlfiBiATG+T2azUFgMkNcDxsPsVw+8kJMzg=;
        b=JxTtYsBm+1a4rQAP9FCWbukzGcS3vozKPAmNiNk+O6j6L8SG6b3UxxUhdly9mlnx1a
         no9QAGt2Z2MLaWejDm+vVkE726U7HAHuu2S/mqSBmf22RQswyeUnK97Uuo1oi8vb5MyL
         HFLVXPhJAV2IA7cLX07CjHq2IUUxnp4RN9zf2xDbx6xLvWbxmkIebyJn651eKPpERkCA
         dh5qpTIObnGYguDWiaAf6mWibDlJ59gdZMdCPrxv98zGh5hebPeebGkQFfis+St0atdH
         o4zjhKUvnkBvFaBxpIEH+nIcTY7aevWTTFCXpOqOBrUqkPL9xMvTgt0lQQWoxaps2Oiy
         ckHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787211770; x=1787816570;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:from
         :date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=OcWUGBQ/SlfiBiATG+T2azUFgMkNcDxsPsVw+8kJMzg=;
        b=T/Hfv88tffPtw5Y7Wp0PLx8O2o/0iwNcGAUAUVVOymP4ru/Uk5O1YjsJPUHUbyKm2N
         x0Y7AUn71bfgvVUj/VcrShKsZReY2Or4jW7YNMht/+6gKUBjEELauKks71B6gIJsaNph
         8/Lk/AihVo0JfJAJLL+JYanqjL/HeBk6iIGfuCMg3qna3rcQz09K2zjd1yJPYQMIJqNg
         U7gJkWmE4hcA8YzZYUp1CfIGo9QxklQLHj5r/Axhv7p+xUjABssTSjYnNiRJ5oxvVLAh
         hYAZO4iatxCW0aRRgOQ+G2agZIbmwWGQ+YxQQiGg5rY9Vvk4WPK6rxjfixHNgJI85nhM
         h/WA==
X-Forwarded-Encrypted: i=1; AHgh+RpNRZ8OzB7T3Pg/v6YiL5eQvPvmH1s6Vcq9J2EXh768+r16DWjqCj4wcSU04NiPDoWOqw5Ck3YHmbG3vp78@vger.kernel.org
X-Gm-Message-State: AOJu0YyKTKN6WO8ufD+0E7WogeC7+wpm05NHhYR4X6Jl/CkOG5xBoDZZ
	9Pz4qJAEjVBZ8Em+bZ+bTMl3r6semy7MniaR5JnS1afJVlU3/rB9CMHyrozWssLTB9c=
X-Gm-Gg: AR+sD10fpXFF34CSNXl6uoYrX+Qwqr+nNMJ4SlrTOFROY5pDnWECcku3eciIJ/ENDk1
	OGSr7dDDis8oWsH+ASMHsJKt8j+VMaXmacKb9Hjy55RWADpzwlmTJcs/aw5mTbIfOb6UokphKWl
	3avaPwtn3uWFnSwTLfUMiq9YmtZtP49N5gRCA7v7pTywQqZpnDbm18espvRYqKrXM5ykuAhOVvJ
	m7ewKQG3hMwFXgwrT6ioXReQpB398YwTaD7Px3I4Nnmk5sFmuNRCgM0FFoZ6Ea2dXnbkJ/ha5pL
	cradTg7deLIa12d4YrN9ciMJ7MUpohS8klMrG1/b5N7Ni3bZlaZCG0aRw53M+8wtAl04ovODByP
	uvUIDNXumMQYvil3j1e5mDfDznq8CwEI6NUoLs90KiNQjfv5WiHIGc1fytYgbpVnA2WrGJhZA9u
	L57DoUmia1aWst1OqW0JgL1fGQd8me2lAdDlMFDfKPJIxfe38NC5acqeBlw7ppng==
X-Received: by 2002:a05:600c:3f12:b0:496:c93d:e2f with SMTP id 5b1f17b1804b1-499aa1e3ea4mr192867415e9.15.1787211770569;
        Thu, 20 Aug 2026 00:42:50 -0700 (PDT)
Received: from pathway.suse.cz ([176.114.240.130])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-499b20a14c6sm31648905e9.0.2026.08.20.00.42.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Aug 2026 00:42:50 -0700 (PDT)
Date: Thu, 20 Aug 2026 09:42:48 +0200
From: Petr Mladek <pmladek@suse.com>
To: Yafang Shao <laoar.shao@gmail.com>
Cc: jpoimboe@kernel.org, jikos@kernel.org, mbenes@suse.cz,
	joe.lawrence@redhat.com, song@kernel.org,
	live-patching@vger.kernel.org
Subject: Re: [PATCH] selftests: livepatch: filter kobject debug messages in
 check_result()
Message-ID: <aoav-Pol5nrEquMB@pathway.suse.cz>
References: <20260818054629.69246-1-laoar.shao@gmail.com>
 <aoWvidB12l4oPIdK@pathway.suse.cz>
 <CALOAHbCFt2H6CZ0Y0FJJ9+yHFDNkrKKHk5Y_c6JnArXQhaEj1A@mail.gmail.com>
Precedence: bulk
X-Mailing-List: live-patching@vger.kernel.org
List-Id: <live-patching.vger.kernel.org>
List-Subscribe: <mailto:live-patching+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:live-patching+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CALOAHbCFt2H6CZ0Y0FJJ9+yHFDNkrKKHk5Y_c6JnArXQhaEj1A@mail.gmail.com>

On Thu 2026-08-20 11:34:22, Yafang Shao wrote:
> On Wed, Aug 19, 2026 at 9:28 PM Petr Mladek <pmladek@suse.com> wrote:
> >
> > On Tue 2026-08-18 13:46:29, Yafang Shao wrote:
> > > CONFIG_DEBUG_KOBJECT makes kobject_add_internal(), kobject_uevent_env(),
> > > fill_kobj_path() and friends emit pr_debug() messages, and
> > > CONFIG_DEBUG_KOBJECT_RELEASE makes kobject_release() emit a pr_info()
> > > for every delayed kobject free.  All of these carry the "kobject:"
> > > prefix via pr_fmt(), e.g.:
> > >
> > >   kobject: 'test_klp_livepatch' (ffff...): kobject_release, parent ... (delayed N)
> >
> > Yeah, this is pr_info() printed only when CONFIG_DEBUG_KOBJECT_RELEASE enabled.
> >
> > >   kobject: 'test_klp_livepatch' (ffff...): kobject_add_internal: parent: 'module', set: 'module'
> >
> > This one seems to be printed by pr_debug(). It is printed
> > with CONFIG_DEBUG_KOBJECT but only when CONFIG_DYNAMIC_DEBUG
> > is not enabled.
> >
> > > The livepatch test modules' kobjects are named "test_klp_*", so these
> > > lines match the check_result() grep for "test_klp" and leak into the
> > > result.  The extra lines no longer match the expected output, so the
> > > selftests fail when either debug config is enabled.
> > >
> > > Filter out the "kobject:" lines from the result and note in the README
> > > that both configs are safe to keep enabled.
> >
> > Honestly, I do not feel comfortable with this ignore-all-kobject-messages
> > approach. We might miss real problems reported by the kobject API.
> >
> > It seems acceptable to ignore the quite specific "kobject: .*parent.*
> > (delayed" pattern.
> 
> These messages are printed using pr_info:
> 
>   pr_info("'%s' (%p): %s, parent %p (delayed %ld)\n",
>       kobject_name(kobj), kobj, __func__, kobj->parent, delay);
> 
> In addition to the specific "kobject: .*parent.*(delayed" pattern,
> several other pr_debug messages are also produced.
> For example:
> 
> # --- expected
> # +++ result
> # @@ -1,7 +1,13 @@
> #  % insmod test_modules/test_klp_livepatch.ko
> # +kobject: 'test_klp_livepatch' (000000009dbf565e):
> kobject_add_internal: parent: 'module', set: 'module'
> # +kobject: 'holders' (00000000d9fe84ca): kobject_add_internal:
> parent: 'test_klp_livepatch', set: '<NULL>'
> # +kobject: 'test_klp_livepatch' (00000000dcae1113):
> kobject_add_internal: parent: 'livepatch', set: '<NULL>'
> # +kobject: 'vmlinux' (000000007b8837e6): kobject_add_internal:
> parent: 'test_klp_livepatch', set: '<NULL>'
> #  livepatch: enabling patch 'test_klp_livepatch'
> #  livepatch: 'test_klp_livepatch': initializing patching transition
> #  livepatch: 'test_klp_livepatch': starting patching transition
> # +kobject: 'test_klp_livepatch' (000000009dbf565e): kobject_uevent_env
> # +kobject: 'test_klp_livepatch' (000000009dbf565e): fill_kobj_path:
> path = '/module/test_klp_livepatch'
> #  livepatch: 'test_klp_livepatch': completing patching transition
> #  livepatch: 'test_klp_livepatch': patching complete
> #  % echo 0 > /sys/kernel/livepatch/test_klp_livepatch/enabled
> # @@ -9,4 +15,15 @@ livepatch: 'test_klp_livepatch': initial
> #  livepatch: 'test_klp_livepatch': starting unpatching transition
> #  livepatch: 'test_klp_livepatch': completing unpatching transition
> #  livepatch: 'test_klp_livepatch': unpatching complete
> # +kobject: 'test_klp_livepatch' (00000000dcae1113): kobject_cleanup,
> parent 00000000f8785d63
> # +kobject: 'test_klp_livepatch' (00000000dcae1113): auto cleanup kobject_del
> # +kobject: 'test_klp_livepatch' (00000000dcae1113): calling ktype release
> # +kobject: 'test_klp_livepatch': free name
> #  % rmmod test_klp_livepatch
> # +kobject: 'test_klp_livepatch' (000000009dbf565e): kobject_cleanup,
> parent 0000000052e5c022
> # +kobject: 'test_klp_livepatch' (000000009dbf565e): auto cleanup kobject_del
> # +kobject: 'test_klp_livepatch' (000000009dbf565e): auto cleanup 'remove' event
> # +kobject: 'test_klp_livepatch' (000000009dbf565e): kobject_uevent_env
> # +kobject: 'test_klp_livepatch' (000000009dbf565e): fill_kobj_path:
> path = '/module/test_klp_livepatch'
> # +kobject: 'test_klp_livepatch' (000000009dbf565e): calling ktype release
> # +kobject: 'test_klp_livepatch': free name
> 
> >
> > But I would prefer to ignore the other debug messages by detecting
> > the KERN_DEBUG loglevel. It seems that dmesg even allows to filter
> > the output on its own. It is a bit ugly because we want all
> > other loglevels but:
> >
> >    dmesg --level=info,notice,warn,err,crit,alert,emerg
> >
> > might do the job.
> 
> The following issues will occur:
> 
> # --- expected
> # +++ result
> # @@ -1,12 +1,8 @@
> #  % insmod test_modules/test_klp_livepatch.ko
> #  livepatch: enabling patch 'test_klp_livepatch'
> # -livepatch: 'test_klp_livepatch': initializing patching transition
> #  livepatch: 'test_klp_livepatch': starting patching transition
> # -livepatch: 'test_klp_livepatch': completing patching transition
> #  livepatch: 'test_klp_livepatch': patching complete
> #  % echo 0 > /sys/kernel/livepatch/test_klp_livepatch/enabled
> # -livepatch: 'test_klp_livepatch': initializing unpatching transition
> #  livepatch: 'test_klp_livepatch': starting unpatching transition
> # -livepatch: 'test_klp_livepatch': completing unpatching transition
> #  livepatch: 'test_klp_livepatch': unpatching complete
> #  % rmmod test_klp_livepatch
> 
> This is because these messages are emitted using pr_debug:
> 
>   pr_debug("'%s': initializing %s transition\n", patch->mod->name,
>       klp_target_state == KLP_TRANSITION_PATCHED ? "patching" : "unpatching");
> 
>    pr_debug("'%s': completing %s transition\n",
>        klp_transition_patch->mod->name,
>        klp_target_state == KLP_TRANSITION_PATCHED ? "patching" : "unpatching");

I see.

> In summary, we need to filter out the pr_info messages from kobject
> while retaining the pr_debug messages from livepatch.
> Therefore, the following change should address this:
> 
> diff --git a/tools/testing/selftests/livepatch/functions.sh
> b/tools/testing/selftests/livepatch/functions.sh
> index 46991a029f7c..54789fae8055 100644
> --- a/tools/testing/selftests/livepatch/functions.sh
> +++ b/tools/testing/selftests/livepatch/functions.sh
> @@ -300,9 +300,9 @@ function start_test {
>         # find new kernel messages since the test started.
>         local last_dmesg_msg="livepatch kselftest timestamp: $(date
> --rfc-3339=ns)"
>         log "$last_dmesg_msg"
> -       loop_until 'dmesg | grep -q "$last_dmesg_msg"' ||
> +       loop_until 'dmesg --raw | grep -q "$last_dmesg_msg"' ||
>                 die "buffer busy? can't find canary dmesg message:
> $last_dmesg_msg"
> -       LAST_DMESG=$(dmesg | grep "$last_dmesg_msg")
> +       LAST_DMESG=$(dmesg --raw | grep "$last_dmesg_msg")
> 
>         echo -n "TEST: $test ... "
>         log "===== TEST: $test ====="
> @@ -318,9 +318,12 @@ function check_result {

Also we should update the comment, something like:

+	# - exclude debug messages except with "livepatch:" prefix

>         # - include lines matching keywords
>         # - exclude lines matching keywords
>         # - filter out dmesg timestamp prefixes
> -       result=$(dmesg | awk -v last_dmesg="$LAST_DMESG" 'p; $0 ==
> last_dmesg { p=1 }' | \
> +       result=$(dmesg --raw | \
> +                awk -v last_dmesg="$LAST_DMESG" 'p { if ($0 !~ /^<7>/
> || $0 ~ /livepatch:/) print; next } $0 == last_dmesg { p = 1 }' | \
>                  grep -e 'livepatch:' -e 'test_klp' | \
>                  grep -v '\(tainting\|taints\) kernel' | \
> +                grep -v 'kobject: .*parent.*(delayed' | \
> +                sed 's/^<[0-9]*>//' | \
>                  sed 's/^\[[ 0-9.]*\] //' | \
>                  sed 's/^\[[ ]*[CT][0-9]*\] //')

It is more tricky that I have expected. But I think that
it is worth it because it covers many other debug messages.

Best Regards,
Petr

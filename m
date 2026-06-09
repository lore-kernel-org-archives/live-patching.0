Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F0C6328B56
	for <live-patching@vger.kernel.org>; Tue,  9 Jun 2026 16:00:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781020858; cv=none; b=YNFDXE+agmWIxovU952wggJed1fookibZNZT/jz692gm7uAs+HAuCsIbt0DXXnGc/d+4GS5U1tHHBGAONw6tzKyMV85v1E+wDPR8ydazWuIhGFmpe7KB3llqy4J9Ph3Y3UQTAPJqvOucHkOQnmDpGsRqI/yDJnJRsOgK9Zq9UM4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781020858; c=relaxed/simple;
	bh=nIy+moPtS3yHqnns0ThTgPfMmpWwA/29rFCHohDBOwo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=r5EF3oKqrHXX3PCArycVgWr66sAExlx0digDU2WNvpmnaNJYQe0TWG2ehREP8t1SmzVugsryRivEQ1CcqBVCAnEIfhl4y4hka3qIGUs86Mk0BkEmX+70+v8MNQTrdY9s0fWOUNUhve59bzR+dd7lkBhpuWSri9fZpGAjxzG8Omc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=f/WFRKdv; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="f/WFRKdv"
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-490b3e03939so47900655e9.1
        for <live-patching@vger.kernel.org>; Tue, 09 Jun 2026 09:00:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1781020855; x=1781625655; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=HICuz8kufXe3VeUyiNeFO8G+orYjGx6W8FZ4/ddOFVQ=;
        b=f/WFRKdvzbdp4QEFFzqaXF4ER48CbfIS2pW+HR7PwWBA1AA9jjI5xjgrmbLOBpKAuQ
         SUEWHGtJ8XIxMmqkdK/tnrerakP6I1q0fn1U/wlJ4K/uwKOIpkcDYtuA7YOb/Oy3jHr9
         JIzIbLDGBmMO92tFBn2tQoPTEWvR+7uU3uknwajHGySW/FblbGIiGIzWrvugGaWdZaos
         F1jtEK6j+mcerQGtapCDtyzPC3hqz4fJWbqczbd64If6iDVjciPOOnUwZqlTwpC2YjDq
         04hR1zkaMUEF69yVrhS51J/p1DZkIqWzxMQh7lvOhFkKYF/1KLZiB02Zv9jVl9aMRmwJ
         8DYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781020855; x=1781625655;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HICuz8kufXe3VeUyiNeFO8G+orYjGx6W8FZ4/ddOFVQ=;
        b=pFbzC6ii0I85+BYivrnG+gxeHjcNyH2uSZQLE5/2pXwraJGgGulj091mBKbKVGsdDI
         +zWGcGO0CrQXiCv/BddiIfkg2SqA8tEVqHpwiiNg9tTvpFfX38ShpmZUtZn2zBl4JIL2
         66sG+rkuRFNEnFCDDLCXpp5V/VW+XmrunCTC8+mJOX5jQr0bjSrmeOaJ/lUUOjgwizzZ
         EJ2AAtEk3hqESv4Qboxdi09t2qoAeEpsIwJ6zUJVpZlcoO5PMMZ0moEBDKlWJE3mTMVA
         gCunN0eaBZ537raqchyvUYK77HKqUJvSrZpagz/8jXKl0sFful7TTY+dCT3Jzu0K753Z
         yfyg==
X-Forwarded-Encrypted: i=1; AFNElJ9tQOO3MnG369Y1NdBfwcSI64LwomcoI10Q5ziGvG3WlUQQ6eOvzCux/D025MRIHF51iPtKep+UN26wyz9N@vger.kernel.org
X-Gm-Message-State: AOJu0YyuWv/v/7vm68QPvT3t88BxtsFWlRTggV7X1HsRFtbCXXyO8nhB
	hsHrBzxwzNb7RKj/I8cMIwvnH7ji9+2UG9glMG/kn8UwVC69WWTaJYUj0dfHQYHt9HE=
X-Gm-Gg: Acq92OEjJ+meA/LCM1nO/H5J4OkppM3kA49EOHLrBQRGd1uu+Kj3q3rYp+IyPsRVyV9
	Ht9N52f0yMRtyBkNSkCpUej1yW/uYIfuI3hPSAzleIk9tEAtldgdOUY2lOsgJpVj0YnSPE5kPW8
	xvjf0ptsyYRRg2/Yzk8Lk+JzV8IK5X18gGI1jelPpqpDlMJhPIVzD7ku8fxlYPm1xsCaJ9ONBue
	cQtVHJQVpp5DEDTUpyGGpSRP64tZaMObcNDJ2u/YHmswT5CYC8Yzaj/Jj7DYaacb2pAQIu236o3
	/EdJXfOgqtW1EDQGglT+otGwabjZgZeHi3UnLMIXXrJYAwylQMIIl6ljU2eDJ7GLeYMV++nBOVt
	tDdlEJsrlveQ8BNubqOWmRxnuhwcPapGqTa7miQKjQyYH7bZRqZNYQW4oJBxNfh074GdPrbZShF
	TXs0wGn64LffNutjh4B+x1kPGZ2vKgeO9W45qUSBi699ohC1M=
X-Received: by 2002:a05:600c:4689:b0:490:bbc1:c9be with SMTP id 5b1f17b1804b1-490c2c63f53mr257964045e9.0.1781020855277;
        Tue, 09 Jun 2026 09:00:55 -0700 (PDT)
Received: from pathway.suse.cz ([176.114.240.130])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-490bda4fd52sm479974755e9.0.2026.06.09.09.00.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Jun 2026 09:00:52 -0700 (PDT)
Date: Tue, 9 Jun 2026 18:00:50 +0200
From: Petr Mladek <pmladek@suse.com>
To: Yafang Shao <laoar.shao@gmail.com>
Cc: jpoimboe@kernel.org, jikos@kernel.org, mbenes@suse.cz,
	joe.lawrence@redhat.com, song@kernel.org,
	live-patching@vger.kernel.org
Subject: Re: [PATCH v3 3/7] livepatch: Support scoped atomic replace using
 replace_set
Message-ID: <aig4smgme6DR8pfs@pathway.suse.cz>
References: <20260607131659.29281-1-laoar.shao@gmail.com>
 <20260607131659.29281-4-laoar.shao@gmail.com>
Precedence: bulk
X-Mailing-List: live-patching@vger.kernel.org
List-Id: <live-patching.vger.kernel.org>
List-Subscribe: <mailto:live-patching+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:live-patching+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260607131659.29281-4-laoar.shao@gmail.com>

On Sun 2026-06-07 21:16:55, Yafang Shao wrote:
> Convert the replace attribute from a boolean to a u32 to function as a
> "replace set." A newly loaded livepatch will now atomically replace any
> existing patch belonging to the same set. There can only ever be one active
> livepatch for a given replace_set number.
> 
> This change currently supports function replacement only. Livepatches that
> belong to different replace sets cannot modify the same function. If a new
> livepatch attempts to modify a function already modified by an older
> livepatch from a different replace_set, the loading of the new livepatch
> will be refused.
> 
> Similarly, for the KLP state, livepatches belonging to different replace
> sets cannot use the same state ID. The system will refuse to load a new
> livepatch if it uses a state ID already in use by an older livepatch from
> a different replace_set.
> 
> For the KLP shadow variable mechanism, developers must assign unique shadow
> IDs to livepatches that belong to different replace sets.
> 
> Support for replace_set compatibility with KLP state and shadow variables
> will be implemented after Petr's KLP state transfer work is completed [0].
> 
> Other user-visible changes include:
> - The non-replace model is now deprecated
> - /sys/kernel/livepatch/livepatch_XXX/replace attribute is replaced by
>   /sys/kernel/livepatch/livepatch_XXX/replace_set

The commit message is not bad. But the patch is breaking the backward
compatibility. We should explain the motivation first.

I would write something like:

<proposal>
The practice shows that the current semantic of the patch.replace flag is
not ideal.

The atomic replace is disabled by default. And the no-replace mode allows
wild installation of many livepatches in parallel. The author and
administrator are fully responsible for preventing problems caused
by producing and installing incompatible livepatches.

The most safe atomic replace mode must be explicitly enabled by
setting "patch.replace = true". It is all or nothing. The livepatch
with enabled .replace will always replace all already installed
livepatches. It makes it very safe but it might be too harsh.

Improve the situation by switching "bool .replace" flag to
"u32 .replace_set" and and updating its semantic.

Any .replace_set value might be associated with a set of livepatched
symbols, callbacks, shadow variable and state IDs.

A livepatch with a particular .replace_set number will atomically
rreplace any already installed livepatch with the same .replace_set
number. By definition, there can only ever be one active livepatch
for a given replace_set number.

On the contrary, livepatches with a different .replace_set number
must not modify the same function, or use the state with the same
ID [*]. Any attempt to load an incompatible livepatch will be
rejected.

Summary:

The most safe mode when any livepatch replaces any other livepatch
will be the default. Note that all livepatches must keep
.replace_set = 0.

It will be possible to install more livepatches in parallel by
using different .replace_set numbers. The livepatches might be
updated independently using the atomic replace feature as long
as the new version does not break compatibility. The kernel will
reject a livepatch from a different replace set when it would
want to modify the same function or livepatch state from
another replace set.

[*] The compatibility check of callbacks and shadow variables will
    be improved later by reworking their semantic. There is a work
    in progress, see [0]
</proposal>

> Link: https://github.com/pmladek/linux/tree/klp-state-transfer-v1-iter12 [0]

I have realized that I actually sent "v1-iter12" to the public
mailing list as the official v1. So we could use:

Link: https://lore.kernel.org/all/20250115082431.5550-1-pmladek@suse.com/ [0]


New idea:

I have briefly discussed the new semantic with Miroslav when I met
him in person. And he was a bit concerned. We as an OS distributor
might want to be sure that our livepatches can be installed the most
safe way. So, we still might want to preserve the "replace all"
semantic to make sure that our livepatches will not break anything.

I though about 4 approaches approaches:

1. Make .replace_set=0 special so that it will always replace
   everything. Similar to the current .replace=true mode.

   Customers will still be able to install custom livepatches
   later with .replace_set != 0. But the "0" livepatch will
   always wipe them out.


2. Use two flags in the livepatch, for example

     a. Rename .replace to .replace_all. The livepatch with this
	flag set will always wipe all other livepatches.

     b. Add .replace_set which will allow to install more livepatches
	in parallel, replace the livepatches with the same .replace_set
	atomically, and check the compatibility. As described above.

    It is a bit more complicated. But it is more compatible with
    the current state. And it removes the special meaning of
    .replace_set == 0.


3. Introduce a system wide flag, sysctl livepatch_replace_all
   which would allow to enable/disable the replace_all feature
   of either .replace_set == 0 or per-patch.replace_all flag.

   It would allow the customer to preserve their custom livepatches
   when they know what they do. For example, when they use the livepatch
   to modify a 3rd party module or tune some functionality.


4. Just taint the kernel when a livepatch with .replace_set != 0
   is installed. Then the OS provider could say that a tainted kernel
   is not longer officially supported.


I personally prefer the 4th solution because it is simple.


Best Regards,
Petr

PS: I still have to review the actual code changes. I'll do
    it in a separate mail, ...

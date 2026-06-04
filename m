Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 529F03ECBC8;
	Thu,  4 Jun 2026 08:42:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780562542; cv=none; b=k4jRPheNcECejH7uxJbbgYUCw1udlHywsHS5ObhEfNaJgFcEtz5ru6f2X4mb+DvSPuGPWPr1UdoMl0IeaoUB1ShAcEpHJYcRG6oslLWoifXhY9RQC9T+PIL1lFi27m8UFRf/Pw98dGZWeAGd5zprptlhy4Ee43O0C3sPpwq5ZAo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780562542; c=relaxed/simple;
	bh=TDfdIIJHsMr7WCdTJlYNljEXymUMertVtTw7im8L5gU=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=IPUnkzeTUZSTw6S6FZ11MWhTIFtwF2DdithhwTWzUEqQHRYN9xX/gkClQC6QPO2HJ3+lIVf+3/ld6bfmT3prpCFPpFlP+mH4V1XZhHVlkSqaMN36JsysAUCJenUk3rXKR9uFM/JHWoFNYWUl2/Qig6EEMbDVUGxY6Jl5g7bTXOI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jIcN/8O1; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jIcN/8O1"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4F9751F00893;
	Thu,  4 Jun 2026 08:42:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780562534;
	bh=XOeitkG4Fmb4bMUy6RsRwiH+yGw27mwe06zS+tYVVHs=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=jIcN/8O1zuzjgS4cTFj+hJXMveCz9I/chhdCrwBtXps1f0xnZT0Q0KX9WKyjplBTm
	 flFB3DuBVSoXI8BoDAIKk38e7K3Nr75Zpc90WJMtfVCrY4wlj7U0MBuKBXNMzp5HAd
	 C3Kd/XDP9itLLPK5M8pDD4vBCRJhCuCrnyf+mkEG4TpA61YJ21ooQG/8h2aMHOg/zg
	 GLG1Dos6iUCPpSM9ol/JGyH+CH4Zg/P9O+gLjttlaxmAkhtH+Parjzq8oeHxkranGA
	 vRf8tkmgS9rhloC3ZDgr5u+ssJkyPCeazQyeGVaZ6YvaGH8Yvto3oLG16QWM8jzaO1
	 ENbPA/pDlaeRw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2] selftests/livepatch: fix resource leak in
 test_klp_syscall init error path
Reply-To: sashiko-reviews@lists.linux.dev
To: mbenes@suse.cz
Cc: live-patching@vger.kernel.org, jpoimboe@kernel.org, "Rui Qi" <qirui.001@bytedance.com>, joe.lawrence@redhat.com, pmladek@suse.com, linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org, jikos@kernel.org, shuah@kernel.org
In-Reply-To: <20260604083208.1071428-1-qirui.001@bytedance.com>
References: <20260604083208.1071428-1-qirui.001@bytedance.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 04 Jun 2026 08:42:13 +0000
Message-Id: <20260604084214.4F9751F00893@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: live-patching@vger.kernel.org
List-Id: <live-patching.vger.kernel.org>
List-Subscribe: <mailto:live-patching+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:live-patching+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [High] Relying exclusively on kobject_put() to clean up sysfs attributes =
backed by module memory introduces a use-after-free window during module un=
load if CONFIG_DEBUG_KOBJECT_RELEASE is enabled.
--

commit 89541aa9ecd8e356eaf4884fa2b111bc605a7933
Author: Rui Qi <qirui.001@bytedance.com>

selftests/livepatch: fix resource leak in test_klp_syscall init error path

This commit attempts to fix a resource leak in livepatch_init() by calling
kobject_put() on the error path if klp_enable_patch() fails.

> --- a/tools/testing/selftests/livepatch/test_modules/test_klp_syscall.c
> +++ b/tools/testing/selftests/livepatch/test_modules/test_klp_syscall.c
[ ... ]
> @@ -98,7 +98,11 @@ static int livepatch_init(void)
>  	 */
>  	npids =3D npids_pending;
> =20
> -	return klp_enable_patch(&patch);
> +	ret =3D klp_enable_patch(&patch);
> +	if (ret)
> +		kobject_put(klp_kobj);

[Severity: High]
This isn't a bug introduced by this patch, but it replicates a pre-existing
issue into the error path.

Does relying exclusively on kobject_put() here create a use-after-free wind=
ow
during module unload?

If CONFIG_DEBUG_KOBJECT_RELEASE is enabled, kobject_put() drops the refcount
but schedules kobject_cleanup() (and thus sysfs_remove_dir()) to run
asynchronously via a workqueue after a 1 to 4 second delay. Because klp_attr
and its show callback are allocated in the module's memory, returning an er=
ror
here causes the module loader to free that memory immediately.

During this delay, the sysfs file remains fully accessible. If a user reads
this file, would sysfs_kf_seq_show() dereference the attribute and callback
that now point to unmapped module memory?

Should kobject_del(klp_kobj) be called prior to kobject_put() to
synchronously remove the sysfs entries?

> +
> +	return ret;
>  }
> =20
>  static void livepatch_exit(void)
>  {
>  	kobject_put(klp_kobj);
>  }

[Severity: High]
This is a pre-existing issue, but the exact same vulnerability exists here =
in
the unmodified module exit path where kobject_put() is the only cleanup
mechanism before the module unloads.

Could we also add kobject_del(klp_kobj) before kobject_put() in
livepatch_exit() to ensure sysfs entries are synchronously removed before
module memory is freed?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260604083208.1071=
428-1-qirui.001@bytedance.com?part=3D1

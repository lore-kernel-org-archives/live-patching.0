Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C70B33DB330
	for <live-patching@vger.kernel.org>; Fri, 10 Jul 2026 09:15:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.214.177
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783674924; cv=pass; b=M4KL4iKgp5w0otNiDsoRKWxEt723PX7Npch+s6TY1T3yqNXUCbt6dQKnwseDEeGQ4oLo9Wd6JMFgQK6rhHlebcNos1Nm1VFaJvfrKvCC0IhQ1IETU+YrOLoLiE16KaYqV7KGFJssuZX+qxI6CUX79xgh38x/cKyxAx82JCYSIII=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783674924; c=relaxed/simple;
	bh=gq/ooXmbd8HCdxlajWK5VhmqWN2MEouHdYYsgyLcgio=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Content-Type; b=rmIxOSLPV4koDz02IgjWCzs9TBFzxouQ5qrtPmzCkJlVxJBkSBwEhoRWUAZweQtb2nKOeKf56j4JMGGGf96evSTXlrpOXRbo9zok1ij0G5bI2A8wKqdu0fMEUtkJdI+2jrLVa21ibqVFvJ8UIHakeP/oCqLLtDoB52MwOV3/jB8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=k4hQtQ7Z; arc=pass smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="k4hQtQ7Z"
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-2ca64c3ce5fso9299625ad.3
        for <live-patching@vger.kernel.org>; Fri, 10 Jul 2026 02:15:22 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1783674922; cv=none;
        d=google.com; s=arc-20260327;
        b=H5yW50f7R3Cb6YnUtM3p9gtA73XMSOcxQa6BJnTh6Q1xR8X4EwJQvaEvcrCcP8q9Lq
         jMUgm5Hpi0J6GZhwh26EDNkkjCMbmV5IM5LB89UdWEyXSjAza73WzW26vn3MNmJOc1wr
         OMouFbvdRVLEmZsNt0Kw3V7aV/N1ega3eLlM7wHOHr9hidTItl8MxmYkL0YRGMgtJyLz
         yj9wbECtlB7hM/K/kGeUO+IR8JBneMtCNH6r2j1/TgMXa1+SXGJTalNW/KUnLYmwmHag
         Yh7XgjHyE0tbgXQApNj7zWl0zaS7hpbwjeiNXD8RosInEQJb9MWF1A5yjBBiNASnB90Q
         0P8A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :mime-version:dkim-signature;
        bh=gq/ooXmbd8HCdxlajWK5VhmqWN2MEouHdYYsgyLcgio=;
        fh=b4YycFt6QiWyngZ0TJFv0P0JLO8UQADPI5p2oAFvNYc=;
        b=NjhIo66XUf6Y8O0WxPuNZJsg1UtdbBKFZiokZQ/pmSRgv4oIL1uxr0rinTel2O5GJJ
         dnC9qF/IomyZUt6ZXCQOZytRZQo0/THekMbicLk+c2br50VUR7ca2S6lfMDWbdqoOqtU
         vdyI9RplZaKr+8JHvSoFIqxUpCSlA4X6nPb3A1Q9BNGN7I9ayD80GEz0YeOpkPs+xevX
         7N53s3pt4NhhMPOOzea1z58WdJqJgs2VMUaOfOc7H2Dik3teUB75pJRxPgBLT8TIxTG3
         xaZIp8ZYRs8t8lAt7TY06QgAVIOpTpqU3DUNTnadqzEeuJIwCZ14bAvRfpVyasDq2KaX
         Ckew==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783674922; x=1784279722; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:to:subject:message-id:date
         :from:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=gq/ooXmbd8HCdxlajWK5VhmqWN2MEouHdYYsgyLcgio=;
        b=k4hQtQ7Zq3i3MoWrOP1VlhT+iRkIracqp53R9LrTaFB9UP9GUZZJ2sQvCTkEP6pxo/
         iP01/4TlpIo1BsN2AgxhmI5yKnCSqkOwl/fvzCKG+WYsZU9G7uiuCMvVL4AqL9qNW5Sr
         IcyTVLB+aBFImwOWbIM+j1L6IPrT3jC6Ou4dI1Oc+w2HHlSomaY+4Nx2mlwH6p5c7X5k
         SXFC9XsiAnR/ic6jw0bhbSchj9zxd5zKTTCAZmHeVW+EoNuC8/C4aa8e3G9djQFn4zID
         433Ofv6eK5JCYbZbx4h2t4PlkGycNPM3zzs/RSGKsZNL+34Js5YapZDfcR+W/hgEDvu5
         3bdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783674922; x=1784279722;
        h=content-transfer-encoding:content-type:to:subject:message-id:date
         :from:mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=gq/ooXmbd8HCdxlajWK5VhmqWN2MEouHdYYsgyLcgio=;
        b=H2jkHQQbp97GMWgJRxsgYQPxJ0EYRlI2qDKHfpsN1XEFYtiKVvIApObw6axaRjz5Mj
         8Q6UqypQfIoYCx6py4KE79FP8qFXZHdemqYLXWtEQaJACUIp/5KC3IhVYzSQ+F94PA09
         vb2DZ4r8IQ62IrIrvxaaIRksybpKgehN9sGl2QeGarm+GgjJJ1f04idSv0b3SPlSQ797
         mqPfSDPz0OijI+tAHuopExUsHQ8Aq3odId9IS+jpfv4pPqqZi2oLr/xjoG2IkxMs4fLP
         VoZ02pbJ8RRrRLoyl3Azh9IvD1dpUZ+buJF8Ss5IGB7B2fybvZX1nzRG9cwI+h5Sklfa
         SPZw==
X-Gm-Message-State: AOJu0YwtWDNxpP/7nf6rMv8ESWHdUd5HupA+tENtOZ3VNseRaxEe/jEB
	gS7NxSQijaV5t43LobRk/DlM/4vQyFouCr9a2viS1tUFIKWgPk10i8vcj0OJQdCszp/ZkzqVHX2
	F5ZrOmpwcjvDuIHz+d2k4guNwDwDI65Po7lXc9Pc=
X-Gm-Gg: AfdE7ck/F7xvBJvv8fy/dzXi56IxvxjqKJD7aVeEi/glQz8AGLnKIgINssaqLohguCW
	OWJzAwU6sDNuLZaYLQmpSMeQ1vbR1mKX1FoZiaZHr1D8Idt6VTN1gpJ7mVqQu/rpTdJG1IePIQU
	akC2SX6xI9tcSQJDVY1UrBCy7B2eGN+5x6rN36CEI10l5fseREb/cHwhbmGK+W1Hrgc3Aser6yU
	DzX0u73AIhWCEjeyqJThsFBcGOIQjTYsXmpmHwuD4SH+0ZIVua+DO5LIGm6S1XfLFd9NpuY6SkO
	dPZFqk+GOSl8y7yIIyrhxxIYdi+3
X-Received: by 2002:a17:903:234d:b0:2cb:3f5b:6663 with SMTP id
 d9443c01a7336-2ccea395618mr107853835ad.11.1783674921964; Fri, 10 Jul 2026
 02:15:21 -0700 (PDT)
Precedence: bulk
X-Mailing-List: live-patching@vger.kernel.org
List-Id: <live-patching.vger.kernel.org>
List-Subscribe: <mailto:live-patching+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:live-patching+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Seke Kazuru <kazuruuni@gmail.com>
Date: Fri, 10 Jul 2026 11:14:43 +0200
X-Gm-Features: AVVi8CdfYtqClMBYJ0TuUCLuuEf3QsNjJ7DOCw6Q6r1wuTD4nss2kMRDdev5pik
Message-ID: <CAJATrkxfnrAs8UDHiu+Fn5x7fXqTL_J1S=+pnVTyVUxN3rTZxQ@mail.gmail.com>
Subject: [RFC] sanity check on hand-built klp_patch for version_proc_show
 (measurement harness ground truth)
To: live-patching@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi livepatch maintainers,

I am building a differential-testing harness for livepatch build
pipelines (kpatch-build vs upstream klp-build, etc.) and need a
hand-built klp_patch module as behavioral ground truth per pinned
kernel commit.

Before I lean on this in a paper, I would appreciate an informal "does
this look sane?" pass on the LP-PILOT-02 module below. This is not a
merge candidate, but just a minimal multi-relocation replacement of
`version_proc_show` on Linux v6.6.47 (`4c1a2d4cd9a5`).

Target: `version_proc_show` in `fs/proc/version.c`
API: standard `klp_func` / `klp_object` / `klp_patch` (same shape as
`samples/livepatch/livepatch-sample.c`)
Relocations in the built .ko: `R_X86_64_PLT32` to `seq_printf`,
`seq_putc`; two `R_X86_64_32S` addends into `.rodata` (marker + suffix
strings)
Validation: `insmod` succeeds; `/proc/version` shows marker
`LP-PILOT-02 patched-by-harness`; revert via sysfs `enabled=3D0`
restores banner; controlled rodata-addend swap leaves module loadable
but breaks the marker predicate (behavioral detection, not load-time
rejection)

Questions I would value eyes on:
1. Is the `klp_patch` structure correct for v6.6.x (object/func
sentinels, `MODULE_INFO(livepatch, "Y")`)?
2. Any obvious foot-guns replacing a seq_file handler that only uses
`seq_printf`/`seq_putc`?
3. Anything you'd consider invalid ground truth for equivalence
testing even if it loads?

Source (LP-PILOT-02 hand-build):

--- livepatch-version.c ---
// LP-PILOT-02 hand-built klp_patch =E2=80=94 version_proc_show
// Multi-external-reloc replacement (strlen + seq_printf + seq_putc;
dual rodata addends).
#define pr_fmt(fmt) "lp-pilot-version: " fmt

#include <linux/init.h>
#include <linux/kernel.h>
#include <linux/livepatch.h>
#include <linux/module.h>
#include <linux/seq_file.h>
#include <linux/string.h>

static int hb_version_proc_show(struct seq_file *m, void *v)
{
static const char marker[] =3D "LP-PILOT-02";
static const char suffix[] =3D " patched-by-harness";
size_t n;

n =3D strlen(marker);
if (n =3D=3D 0)
return 0;
n +=3D strlen(suffix);
seq_printf(m, "%s%s\n", marker, suffix);
if (n > 0)
seq_putc(m, '!');
return 0;
}

static struct klp_func hb_funcs[] =3D {
{
.old_name =3D "version_proc_show",
.new_func =3D hb_version_proc_show,
},
{ }
};

static struct klp_object hb_objs[] =3D {
{
.funcs =3D hb_funcs,
},
{ }
};

static struct klp_patch hb_patch =3D {
.mod =3D THIS_MODULE,
.objs =3D hb_objs,
};

static int __init hb_version_init(void)
{
return klp_enable_patch(&hb_patch);
}

static void __exit hb_version_exit(void)
{
}

module_init(hb_version_init);
module_exit(hb_version_exit);
MODULE_LICENSE("GPL");
MODULE_INFO(livepatch, "Y");
--- end ---

Context: https://github.com/kazuru-chidumbwe/livepatch-differential-harness
(public release pending)

Thank you for any quick reactions, even "looks fine" or "fix X" is
helpful, or a correction if I am wandering the wrong direction.

Regards,

Seke

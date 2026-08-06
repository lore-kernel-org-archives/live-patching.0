Received: from mx0a-00206402.pphosted.com (mx0a-00206402.pphosted.com [148.163.148.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CCBC3F99F5
	for <live-patching@vger.kernel.org>; Thu,  6 Aug 2026 21:52:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=148.163.148.77
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786053151; cv=pass; b=av46FkL2YVCJEo5eGFtOW6IvlQTWi23b8EofTHTfuQX7dOmZKkhdmkElsjVpcrqKrqOxo5xLwP17CRUX4c/a5DgOpWOl9N+mVtjQpY7ZJ88rn8fKHZPNOg8kNi5c5GHqItshkOc7onLvT4dJcG4VjYXz80VMS/nQY5qStzhDxPs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786053151; c=relaxed/simple;
	bh=4j27c3ITXpBErSHQ7ijBlE2exB417P5mbmq8l9SQNdQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Q/vZDm3ouOOdNnwNfE0izj66YnF07o6w9EJIU5AJ1p4wjviQkYWBKP1heWACtex9tnKI3plEhg7C4hx7lgNINLh3EbuUtSpjw3Et54+RURPAjYpDNlOwHFG/YXMqrRPNVUNNBhgh0JKataKYRsu13NBrOse6WyPNui6K2CEJojM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=crowdstrike.com; spf=pass smtp.mailfrom=crowdstrike.com; dkim=pass (2048-bit key) header.d=crowdstrike.com header.i=@crowdstrike.com header.b=EpeLMTVH; dkim=pass (2048-bit key) header.d=crowdstrike.com header.i=@crowdstrike.com header.b=IG55PzML; arc=pass smtp.client-ip=148.163.148.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=crowdstrike.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=crowdstrike.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=crowdstrike.com header.i=@crowdstrike.com header.b="EpeLMTVH";
	dkim=pass (2048-bit key) header.d=crowdstrike.com header.i=@crowdstrike.com header.b="IG55PzML"
Received: from pps.filterd (m0354651.ppops.net [127.0.0.1])
	by mx0a-00206402.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 676KwCLM4162572
	for <live-patching@vger.kernel.org>; Thu, 6 Aug 2026 21:52:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=crowdstrike.com;
	 h=cc:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	default; bh=DfxBWQSPaUr2vqUZLxxkFzY58elRjodnE5b1RCZlWXk=; b=EpeL
	MTVHcxv76x1tW4kL6f0PWpDMX88pkGsCejHUiuCnq8z0xx8/3XgnQAU3IJt1F+8M
	dlF9iyMhSAqOLCD20RtoY2tYQaO0B/nGwS/ij6wLJ/JG0q4kd0JvPqCa+g5o3fN1
	PgtR8LsQ1hOLOsCNu6+TIqPh6YE+jQkRX9Ss3t1m1gVsWbIxXiIIgUdUAuf9lp47
	EWeUwFGewzkFtjI7p2IW1wTefeFIK4SJ5HDdA7/Jbo0oyC4YAJ/x1Lvr//tE3I47
	UiqVQlqgiUwwNQa0GEAvER8A4Shw7DvDm1pOnSZVOkAfRsb3DVYgHcmvS92dPX8/
	++RT6gGHJs2reTHbzA==
Received: from mail-yw1-f199.google.com (mail-yw1-f199.google.com [209.85.128.199])
	by mx0a-00206402.pphosted.com (PPS) with ESMTPS id 4fvq5kbu6c-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <live-patching@vger.kernel.org>; Thu, 06 Aug 2026 21:52:29 +0000 (GMT)
Received: by mail-yw1-f199.google.com with SMTP id 00721157ae682-7f5b54da461so41289347b3.3
        for <live-patching@vger.kernel.org>; Thu, 06 Aug 2026 14:52:29 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1786053148; cv=none;
        d=google.com; s=arc-20260327;
        b=DH7LCGgzRN+Y0nnqWd3Ko1tgOXz8S87yeA8BT9CmyTdqwTEQXmCSVVrS//9ishBKMi
         QhDHUw9eBZ6d6oI6ArdTbRP/XDwDr7S86j1L0TuGG3R2oEeCmanb9Mdrekl8f0CTmOC5
         re1bUCDx9V01pKDfTAdQW3QcU7xMFD/BWf13+PX5kaOnureqrJH18obmbbGbmLDt8UHK
         f382oA2wYCv+trQ5d4vUDaG8iJnn1ql7gRQDTDHasEVjXsceuXdVBtCvn3ZidB7YgRbK
         5hP7n4X+0WzVcKhuhihmvE/s9vwpnyyylUN0pkKexhgdAY0MZ1UWgwqfx26csI7Jjwfa
         mC1A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=DfxBWQSPaUr2vqUZLxxkFzY58elRjodnE5b1RCZlWXk=;
        fh=8uOLIUltGhL1t3eCrTGcG3pbmANkFSz47PI3paHwvXk=;
        b=nuiuuT6rv39b/MBziZA2nm5tQo9b0T8NreJs5Y3oiYJbmhJVy+zRs4qhaRr4PH5NO7
         T/vLx0ZJuEdfScOsp2RGH0SkPxOo71RZM+18L0ZcCgSYSl7P/2x88vwSci++Q/j1CgxR
         poYiasceRlfoTXFxmYwStP9GnSmW+W1oFaVbNCnnQik5CrKDkWV5K35Bqp7lV3HfSs84
         r2uusXetz25wjZ69m27a7YGPr24TQoH1QoiqdjjHzaWBaJncIvii3sjCABQ/7AzljVNP
         Ra5JAiajzg8SqOJ6HDjOfmaeEbhVjWs07B6QfyAx9Vq6ytpjx820ldTDN6SPkm3jh5Hp
         P5Sw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=crowdstrike.com; s=google; t=1786053148; x=1786657948; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=DfxBWQSPaUr2vqUZLxxkFzY58elRjodnE5b1RCZlWXk=;
        b=IG55PzMLLNCYWzhBq+cwUO8E5Of/wmqPJPmzTS/rAITe0mS1DjeD0Kbq0pUL86flIL
         mM25R62hSyAn/KkErAQTQ4RBXpFKtQmPlMDK7tv+tNksUA95j0a1M2x3NMXFulv0Dab3
         Dq3hIyDdxswH3aa2vR9XXgzXs3MEpYgtuVq38MKvsOGmZLMiltu8h3Goz5WbIm/9yQ8T
         Vz0AxXRbUpRUqTxvF1c7hnZitkUbt9TA37aIIgMkwbvUjHLy+lOecqNo95cmS7opkDuh
         pf4TfGlwHpDWNoc22BJC+HOX2dz6V03YoinhUMq/aEmUkmdm80HcaW3nmreO9cXUWTBV
         ESiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786053148; x=1786657948;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=DfxBWQSPaUr2vqUZLxxkFzY58elRjodnE5b1RCZlWXk=;
        b=nsh6zGFORX4+hbbx01G4BiYg4aOAcMKyqu3qSq4dNsc4EtZfi6DDBbRcm4hqseP/jA
         a2Uzy1YNey3YfK0gJZJZ7C1yLs1Gn2nJDqExTA3vUeQJpqlBbT5ncercGTRBDKeUlJgF
         Z7xuZVI5m35U1kkFt3/1VRnKRNc87DEkTDnbTNHCLNTxhCF12vb6/CCHGjPDijmVxvye
         SSkAuS2E0mV6lQtB6XsVNttkK+3QWlYiqpuOQ28XyibGbt30DdMKyRZ/laJtzvqLbApv
         WHT2VetLLtxkmbm2wW6lTvnfHvDXPWG+tRMHu3N60FBqKidVMys0+cnL3RWomYW1afor
         AKQg==
X-Forwarded-Encrypted: i=1; AHgh+RpFT2bag8PCpQOFJJhrnAQB0EgKfKKdoUS/GJMcaX1ZS1eqeXNhGj8dr5aKgKk5liR768T86XOUYtA+kFk9@vger.kernel.org
X-Gm-Message-State: AOJu0Yxs30eqC6+Hg4mKZEMmCNZxs5oWNQAF4YPaTeqk4M15PurBb6Xp
	6fB7rVHxSD7YqCahqzJSTl1qXkyDhNGCG3T0xMKNryP1jg1Wk5ayQsP2TApXPdGZSWweJnZ/gfK
	i6sJaPGSQM0BvCFVB7RRy4nZGrM47SFNvl+OrVFhL3F9aVK6K1ViLRCnI3gFsm/R8ToGiDV1ImL
	xuT4jx7934d9tEhnZ9S+u002V12s79cvyPhwts5u7Ztw==
X-Gm-Gg: AR+sD13EPo7jxgGcp8vStCWV6gZ8pBs6XhGn6oIYRT8y2i27N+l/meOmlAc7OGY3/jM
	fjywr+mIOOC3BXGtFvcKRVrL0h5VvMntVXuhbAeR+J0cziDyFS5gOd9x3Hn2OhMppPdZDv0wC9C
	JrAlL0Al03hP93MIOauJZVZWZ5gB/tDVHRfTjaY0zm1i5aJlly+0ui/ErQRw==
X-Received: by 2002:a05:690e:d83:b0:667:ca27:479e with SMTP id 956f58d0204a3-66ac2e29103mr3422580d50.8.1786053148466;
        Thu, 06 Aug 2026 14:52:28 -0700 (PDT)
X-Received: by 2002:a05:690e:d83:b0:667:ca27:479e with SMTP id
 956f58d0204a3-66ac2e29103mr3422536d50.8.1786053147864; Thu, 06 Aug 2026
 14:52:27 -0700 (PDT)
Precedence: bulk
X-Mailing-List: live-patching@vger.kernel.org
List-Id: <live-patching.vger.kernel.org>
List-Subscribe: <mailto:live-patching+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:live-patching+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260806153000.4184871-1-andrey.grodzovsky@crowdstrike.com>
 <20260806153000.4184871-2-andrey.grodzovsky@crowdstrike.com> <CAPhsuW53yRgFMkNuAPCrCm9fhNNb4EpN7vbcSEGkNCZXHjk7AA@mail.gmail.com>
In-Reply-To: <CAPhsuW53yRgFMkNuAPCrCm9fhNNb4EpN7vbcSEGkNCZXHjk7AA@mail.gmail.com>
From: Andrey Grodzovsky <andrey.grodzovsky@crowdstrike.com>
Date: Thu, 6 Aug 2026 17:52:16 -0400
X-Gm-Features: AUfX_mxi9cOXXsF6mNBrlNENbUcZVrExzFYiYnyltoL6hOluHOkwQ37RLslPbyA
Message-ID: <CAOu3gNhjDNFgzg0nf458FdMMMPx4WJi=n01musucvk=hbY0HMg@mail.gmail.com>
Subject: Re: [RFC PATCH bpf-next v3 1/2] ftrace: deprecate disabling via
 ftrace_enabled sysctl
To: Song Liu <song@kernel.org>, Steven Rostedt <rostedt@goodmis.org>
Cc: bpf@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
        live-patching@vger.kernel.org, mbenes@suse.cz, jolsa@kernel.org,
        mhiramat@kernel.org, jpoimboe@kernel.org, joe.lawrence@redhat.com,
        mark.rutland@arm.com, corbet@lwn.net, stable@vger.kernel.org,
        linux-open-source@crowdstrike.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-Spam-Info: AW1haW4tMjYwODA2MDE3MSBTYWx0ZWRfX3p2+pxYcGaie
 HUVZsngvkuG2PIsBBmn2IUCZCk5sO3Ct9nSNbcq6s2l8UG17Q5AElAyimEbDe5ItO8UT795PQKq
 JYPYvUoob7aglf/+d658XFPwDevBubH6WJ+US6VdzuaKWYi/DCqy
X-Proofpoint-ORIG-GUID: nKhp6TXb4k4tIKQ4qGRjFtwUqxs5D0Pp
X-Authority-Analysis: v=2.4 cv=QfJWeMbv c=1 sm=1 tr=0 ts=6a75021d cx=c_pps
 a=72HoHk1woDtn7btP4rdmlg==:117 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10
 a=KZhmPCYDdY0A:10 a=VkNPw1HP01LnGYTKEx00:22 a=T2KQ53IYiC3MXPrxx8bB:22
 a=b3B37AjAgz0HnGB3MuNd:22 a=VwQbUJbxAAAA:8 a=pl6vuDidAAAA:8 a=meVymXHHAAAA:8
 a=VIIMA12v6iqWkxtvh5QA:9 a=QEXdDO2ut3YA:10 a=kA6IBgd4cpdPkAWqgNAz:22
 a=2JgSa4NbpEOStq-L5dxp:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODA2MDE3MSBTYWx0ZWRfX+BcMYqcUz96r
 zHZhe/XLzyMwmU0s7G+By1YIrPdwtCOSuCQKip+mML1KFvFuaCvBV94w57moxo7Sxyv+Efd85of
 uu5NiB0/gDzH3hzPPR71FbbpSTzGSLE9Fqkpu9VEawLBpLQnzf+NjP+Z1cgwqKXfDzBKRCtvcLX
 WRA1YRe5/ZepkIchsGpigeyS5lrnzHVH/FAAvWxPro2qRkxpJ4fQkmSlAXOQYTJAw06YiK+X4zF
 p1GyNa6G+G72ITuvG4LGM8VCvBM59frdCayOJDST9GD23LoM2TT9qHNzBEFERMbLjJQVMiY+kIz
 s69RmGGnY8n2JOXnTcfLF61kvIxlrR7wRdORwReh1weLrCxr7KlcydYHPtDfLpnXYcHcp/NaMYs
 UoR9ZXu9KWIHOXvHhSN2biSzuF0+ceTTOe0Uu37sltpRgQQ0kXbieIKNNBMfWLh2vI8JhJw+bIv
 3JcydHN5MxK2Rz/XR7w==
X-Proofpoint-GUID: nKhp6TXb4k4tIKQ4qGRjFtwUqxs5D0Pp
X-Proofpoint-Virus-Version: vendor=nai engine=6900 definitions=11867
 signatures=596817
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 adultscore=0 lowpriorityscore=0 spamscore=0 clxscore=1015
 impostorscore=0 suspectscore=0 bulkscore=0 priorityscore=1501 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608060171

On Thu, Aug 6, 2026 at 5:22=E2=80=AFPM Song Liu <song@kernel.org> wrote:
>
> On Thu, Aug 6, 2026 at 8:30=E2=80=AFAM Andrey Grodzovsky
> <andrey.grodzovsky@crowdstrike.com> wrote:
> >
> > Writing 0 to kernel.ftrace_enabled has not reliably disabled ftrace
> > for years (FTRACE_OPS_FL_PERMANENT users already block it, and more
> > callers rely on ftrace always being on). Refuse the write instead of
> > leaving it in an inconsistent "disables some, not all" state: return
> > -EOPNOTSUPP and log a message. Reads and enabling (writing 1) are
> > unaffected.
> >
> > Update the docs to note the deprecation up front.
> >
> > Suggested-by: Steven Rostedt <rostedt@goodmis.org>
> > Signed-off-by: Andrey Grodzovsky <andrey.grodzovsky@crowdstrike.com>
>
> Sashiko's comments make sense. Other than those:
>

The bot has 2 comments.

In my opinion, the test-breaking comment is wrong as he looked
strictly at this patch w/o reviewing the follow-up live patch testing
changes which update the tests to avoid breaks.

The cleanup comment is valid but since we aren't sure if we'll need to
revert this change later if it breaks userspace in some unseen way, I
wonder how extensive the cleanup should be? Steven, can you advise
please ?

Andrey

> Acked-by: Song Liu <song@kernel.org>
>
> > ---
> >  Documentation/trace/ftrace.rst |  5 ++++
> >  kernel/trace/ftrace.c          | 43 +++++-----------------------------
> >  2 files changed, 11 insertions(+), 37 deletions(-)
> >

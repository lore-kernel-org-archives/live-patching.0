Received: from mx0a-00206402.pphosted.com (mx0a-00206402.pphosted.com [148.163.148.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E77144C50D
	for <live-patching@vger.kernel.org>; Thu,  6 Aug 2026 15:32:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=148.163.148.77
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786030324; cv=pass; b=CEm7p6Oa+m7glGoJL+Eq8N/0Q8YQ8HXZIsTcik7H3yhEuTLp88SMqX1JMwkZFtkDF8PFW1mFgWd8a/Gf040d/FJw1zkufEOQz3sipjVpSEC+EE25cvL1aJYkIHrpgY057REUs6UqMsNmNsWzc2uZbbuzSZaeIuIx7uek1HTBhzw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786030324; c=relaxed/simple;
	bh=q1yKAchAKLYq079ovpGA477d3rJNusw7Xe8p+FR68lg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=nALN0/IDocXjL0YIdWY0KAx64Fgdb1ex6XE2D/Bc69iDsM158BnkQCTScw9cx5jJBWYvq3SgMLTqBQPtEfjn5mzxZ37gzjmwqQrGHBn33cZcxhSZNMw+5FJlzKxc4JfT/2cew1Seh4ZaHnYyZ3Nb2FuhZSLlT54iVAmRwqpgt8o=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=crowdstrike.com; spf=pass smtp.mailfrom=crowdstrike.com; dkim=pass (2048-bit key) header.d=crowdstrike.com header.i=@crowdstrike.com header.b=cD4zTm5M; dkim=pass (2048-bit key) header.d=crowdstrike.com header.i=@crowdstrike.com header.b=jUwr7YyE; arc=pass smtp.client-ip=148.163.148.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=crowdstrike.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=crowdstrike.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=crowdstrike.com header.i=@crowdstrike.com header.b="cD4zTm5M";
	dkim=pass (2048-bit key) header.d=crowdstrike.com header.i=@crowdstrike.com header.b="jUwr7YyE"
Received: from pps.filterd (m0354650.ppops.net [127.0.0.1])
	by mx0a-00206402.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 676F5Gvv778089
	for <live-patching@vger.kernel.org>; Thu, 6 Aug 2026 15:32:01 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=crowdstrike.com;
	 h=cc:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	default; bh=c2fkWs3IPyqlvD9JKIug3ApdmdvPne7OgC9UgDf+NxM=; b=cD4z
	Tm5M17fPCDrNyQnDpnqttK1cC6kuMPVg4/jD/NafaBCKl0S12uY23MLt8b4AzTR1
	tNtAlGU6iP65NOCAbZGM/AFS1P8A8jFJtgC+Gka/cS6al6ZUwTehMeQPyb49rJQ/
	ju69mZ7d/ia/w2ssTJghneL2trmQpwiu1JI2o4ewFKbpqsE6YwXRn0dDomX5s3g/
	TzyMqV1CTrn8xM9VTU4dBjoou0s9LDokE/Lr5b8h6sM33N7AXcM7VGNgAH/pGgMd
	cZseJx5SSRaCvi1pYSw14VZx4tyjkzymIS24edQKmC4N7Wsh7W7pzQS0ATIUeCok
	yJesokBCRMEHIY5+8g==
Received: from mail-yx1-f70.google.com (mail-yx1-f70.google.com [74.125.224.70])
	by mx0a-00206402.pphosted.com (PPS) with ESMTPS id 4fvktmjekh-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <live-patching@vger.kernel.org>; Thu, 06 Aug 2026 15:32:01 +0000 (GMT)
Received: by mail-yx1-f70.google.com with SMTP id 956f58d0204a3-664e15b53d3so5822027d50.3
        for <live-patching@vger.kernel.org>; Thu, 06 Aug 2026 08:32:01 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1786030320; cv=none;
        d=google.com; s=arc-20260327;
        b=QLZ9WoUnuyaaCvl8QufPCjJUeBJL7NUfxVBu/up55Rmahp9tNiE3RbCRSKYcJOfOch
         VjA4k9nr3d/cq2rPK6RnO9BlFcPhE+08Mr26ctdrYek/etS367u/D5/wrYT/2KfT1aB3
         Hl6a60RSSuDT1KmEuQQbDVnQ9OTJTneKjYiTsH1u38eGPqcGL67TWMAm6kDgFMA4In49
         PZn92AcWhlr+VQdbj9flSMhrzAer6f8RymKZd0NEl1o+l2F67ItBrYfqOt3SQZ12+ph6
         EaQPAt2s1nWe5JSz1A8wV9vvVjS0nBeq8ctNHTQwkNGfrivYwNgLsyiQs21MZu2hsR2q
         iJKw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=c2fkWs3IPyqlvD9JKIug3ApdmdvPne7OgC9UgDf+NxM=;
        fh=cwAK0W04yIQ8S8/HgvjmAipqa+yFzLg6kRIpT5QoxYs=;
        b=kHmQ2TnPwu7nc8E5A5Q/OnRy7RKHdzO3fdzn79Qagm7GdmqdvGQ47WKJZe2PaC9in9
         Y1Q1TD1xdF5VBXDS3LNjrRIDKDqmDlIg1QFe3r1Tw8NF85yzZjD5mw3ieBs2E5jTGA8w
         6ugFL9f9zL5uPudNqShtmad6QBIJZSuULNg0RMIhUsVKNcVWuV1jbKXeYehACPDI+o8M
         chKJotsbjnkBKJxwQm9skdDh4TXBUt9HX2D0JhIr8gtK2ahuFtD1Sku1x6nSf1th1FWr
         OElNBLZjySpZCfWCgsBIkfrh2hEdnWJX5emCAQLCwo9hTz6pMt9qqOzc26exwlry079Y
         89vg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=crowdstrike.com; s=google; t=1786030320; x=1786635120; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=c2fkWs3IPyqlvD9JKIug3ApdmdvPne7OgC9UgDf+NxM=;
        b=jUwr7YyEutR2ntg8mjiTkWr8G03wYaEMxMSDpwpeIO060yep4vdjVdLNRvdpnYyHTh
         Q2ja/+7W1N89qUtLLHRF2mQFXrKXQw1q7TKbCzzFGzCy8phwlVgFemybh4MsP+CUcdjM
         lH3nwDnpqcmGChjsCbjpWZo8NYW4J3mXH8mmmFURQgcdbKZ6uwkM5LI8SnhJQM7acml/
         nJF1EDne5owqizd5ct1e56AakdqqUXBYpxOm46SB/gVYfEap/FbxbnM7SCuYg+6J+inK
         m/vmdXVQn4/+CKbdIOqRKB//rjFCjK81hRMhXyWjyAMGfCvtjZljQDehl4TxvX+xCLXI
         vkGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786030320; x=1786635120;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=c2fkWs3IPyqlvD9JKIug3ApdmdvPne7OgC9UgDf+NxM=;
        b=CRpIWzpRIOTa00NpHTNY5RSDOEpsaZqIYFU/56d1lbWXWMf4UEkkzwl65g/qE4ENae
         +7OVGrPP3ftqoZaZf3Gsf+P/BDAIV6C1X+tJtSyfd5scQ3/fbGZGRsFUhbzaobySHGJt
         yDzRt/zJUxndfOjGh3GEg1I9+tAyrVwza8gHlSKFzB9CimRSjNxkUdLlbBssATKk4ctu
         rObxCRgGUSGVr+mMNyDqwrW08RP54LAn7kuGAtx58vl23O9So3VOoiEaQT0u/8zEHpbd
         y0Ym4yHG4IlfSH2ciXcwtxZfeHcw4VR4w+AqJrOO/Xoj3qvPTczyD2aO/g2kmKJytylk
         drjQ==
X-Forwarded-Encrypted: i=1; AHgh+RqwQUCApYk6MNX+dmJd8unEt3uI8oqlVHDFqbzHCJy0Nmn0JVZqy9EztfxqZh1YAWXVoMKoWdIvZ48+sBJ1@vger.kernel.org
X-Gm-Message-State: AOJu0Yy+dOEvi7SL0nGCcbmk+oSI+pnNQXowDg8KPNpRYPcCoPmfbygb
	uuBSSRA/d9Xzto6tkJ15B3LIGLAmkBmSR1TmJpqbfTfoRL/NsoRXij+pk9cJ6VkcxE7ngcGG6Ad
	1SaEg+acRRwWYP3ZrpdjZgeuAuYZ3Sq+IJuOzHAqvVX3Pr/6pl0+id1ckn9LMpD8luJOlhWt1nf
	npvys9BBMCYJjh4FTg4UM05kJ2yJ6W8TaW+evrt/kypw==
X-Gm-Gg: AR+sD11zgXCzXyl1jhfo5nYZLDWEiMl+Hw/LODoaq87v0a2lGmmBmIHyIKpHmK+LPrp
	OI1Opm9ig7h8Afgc386V78s05/gATUYY6BxqhB1z3wOL9J2ADUIb86d2ho4IDU4wreqX32Vewfq
	cuORhpsW6NBhmnsM+7lKkqbi31jHFuU4ufybmqvw0TZUhkdjXirCQGulFOwQ==
X-Received: by 2002:a05:690e:488a:b0:664:bd5c:6e72 with SMTP id 956f58d0204a3-6699aa7511dmr7229020d50.34.1786030320299;
        Thu, 06 Aug 2026 08:32:00 -0700 (PDT)
X-Received: by 2002:a05:690e:488a:b0:664:bd5c:6e72 with SMTP id
 956f58d0204a3-6699aa7511dmr7228964d50.34.1786030319671; Thu, 06 Aug 2026
 08:31:59 -0700 (PDT)
Precedence: bulk
X-Mailing-List: live-patching@vger.kernel.org
List-Id: <live-patching.vger.kernel.org>
List-Subscribe: <mailto:live-patching+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:live-patching+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260731175358.3542156-1-andrey.grodzovsky@crowdstrike.com>
 <20260731175358.3542156-3-andrey.grodzovsky@crowdstrike.com> <am0-QoUNQo4p2sBg@redhat.com>
In-Reply-To: <am0-QoUNQo4p2sBg@redhat.com>
From: Andrey Grodzovsky <andrey.grodzovsky@crowdstrike.com>
Date: Thu, 6 Aug 2026 11:31:47 -0400
X-Gm-Features: AUfX_mw1nwxsETix0HLa6WjJrBSSAU1_0A9CQBJUP5Fq4BDIA8mjk_ZZNVuhTmY
Message-ID: <CAOu3gNhFL+1JmWRVwJVq4xUn-8mENkNwYexCwpFZ8FaZY82SRw@mail.gmail.com>
Subject: Re: [RFC PATCH bpf-next v2 2/2] selftests/livepatch: update
 test-ftrace.sh for deprecated ftrace_enabled
To: Joe Lawrence <joe.lawrence@redhat.com>
Cc: bpf@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
        live-patching@vger.kernel.org, linux-kselftest@vger.kernel.org,
        linux-doc@vger.kernel.org, rostedt@goodmis.org, mbenes@suse.cz,
        corbet@lwn.net, jpoimboe@kernel.org, shuah@kernel.org,
        jolsa@kernel.org, mhiramat@kernel.org, stable@vger.kernel.org,
        linux-open-source@crowdstrike.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-ORIG-GUID: ea9L5PZL4gDmoW2KpRbh0XcLIKMTRUsk
X-Proofpoint-Spam-Info: AW1haW4tMjYwODA2MDEyMCBTYWx0ZWRfX3oGaY1PsCBzV
 n316WDZSFXyGXTDcniJtxAXdplVbx+jqxd3xK90DoCDWEnOa3EQkrMHjm2XdlPPxe6jRuWlhzdM
 TW6JZxFKB+Umf/X0qy3v55JZp9mSrVSVgtNJV23oST4LbB0o4sem
X-Proofpoint-GUID: ea9L5PZL4gDmoW2KpRbh0XcLIKMTRUsk
X-Authority-Analysis: v=2.4 cv=B7iJFutM c=1 sm=1 tr=0 ts=6a74a8f1 cx=c_pps
 a=S/uc88zpIJVNbziUnJ6G4Q==:117 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10
 a=KZhmPCYDdY0A:10 a=VkNPw1HP01LnGYTKEx00:22 a=T2KQ53IYiC3MXPrxx8bB:22
 a=t04HzT_fAfAF5W-3wVZy:22 a=ngmC-yC5AAAA:8 a=e25ExAebAAAA:8 a=20KFwNOVAAAA:8
 a=meVymXHHAAAA:8 a=pl6vuDidAAAA:8 a=dDW-ktzWsA5qhXuJ1JwA:9 a=QEXdDO2ut3YA:10
 a=nd2WpGr1bMy9NW-iytEl:22 a=P5XVh-r7Nk77isVNjX_M:22 a=Fx-rEtueDibNKiZPBj-h:22
 a=2JgSa4NbpEOStq-L5dxp:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODA2MDEyMCBTYWx0ZWRfX0JdK558y/s1K
 kEsvYNhWywlNfpwgACWswItayU3WOWnLhvgx2VzXVhEW07kMrs9lLwoUw2v8U/2vKBn4YlYo8nb
 tGKXBvxVEZVGGzO8ZvId1TN9yR4wZNHjO+V61XPBqUm85ngLVdSR5Qw2HpWVPo0c6P/pm6jrbVH
 BRTySBUziJ7K5QXdnz5X1oiFdCsmYs9L25aXFRebLS/uDtewBTRg6Cdk2IxVMJXKfUG7YunLL5g
 uzOJ2Q+7QgnjA44j3f41Q53klTaPXGqplniMh4YlRedP4zHLGr0nBmNgELuqPE6kEb181/XbW3D
 7/ZlMOPFlDMaeXsknpHVaBxZMpcuFQ9ZoS5XhjBVvuvZ3LrczJlCRA+lReK2wsPRZEnZZoNDf0z
 eeIq1ofTzWCvUao/FArUm1ZNiLE3SSD6xBYnkdJVW1fkGdadeglo4ZOBRmCLzNqKxIJrtk2bRq4
 rpnZDGbIta5qea2ZzjA==
X-Proofpoint-Virus-Version: vendor=nai engine=6900 definitions=11867
 signatures=596817
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 phishscore=0 clxscore=1015 impostorscore=0 suspectscore=0
 spamscore=0 malwarescore=0 adultscore=0 priorityscore=1501 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608060120

Thank you Joe and Steven for your comments; I sent V3.

Andrey

On Fri, Jul 31, 2026 at 8:31=E2=80=AFPM Joe Lawrence <joe.lawrence@redhat.c=
om> wrote:
>
> On Fri, Jul 31, 2026 at 01:53:58PM -0400, Andrey Grodzovsky wrote:
> > kernel.ftrace_enabled=3D0 is now refused on kernels that deprecate the
> > knob, so the old disable/reload flow no longer applies there. Probe
> > for this with ftrace_disable_supported() and keep the full original
> > scenario (disable, fail to load a livepatch, re-enable, load, confirm
> > disable is refused while loaded) on kernels where it still works;
> > otherwise just confirm the write is refused.
> >
> > Suggested-by: Steven Rostedt <rostedt@goodmis.org>
> > Suggested-by: Miroslav Benes <mbenes@suse.cz>
> > Assisted-by: Claude:claude-sonnet-5
> > Signed-off-by: Andrey Grodzovsky <andrey.grodzovsky@crowdstrike.com>
> > ---
> >  .../testing/selftests/livepatch/https://urldefense.com/v3/__http://fun=
ctions.sh__;!!BmdzS3_lV9HdKG8!zXXcFqHACaJ7PyoFMFh-_8DFTwWSotPltPcR5ezYC87Va=
VkoNZcqFkVTtLbYUQp4DKEh9Z-0WLN8c5sMeyug2BCCuslAibAtHJo$   | 13 ++++++
> >  .../selftests/livepatch/https://urldefense.com/v3/__http://test-ftrace=
.sh__;!!BmdzS3_lV9HdKG8!zXXcFqHACaJ7PyoFMFh-_8DFTwWSotPltPcR5ezYC87VaVkoNZc=
qFkVTtLbYUQp4DKEh9Z-0WLN8c5sMeyug2BCCuslAJf9tNxM$         | 45 ++++++++++++=
-------
> >  2 files changed, 41 insertions(+), 17 deletions(-)
> >
> > diff --git a/tools/testing/selftests/livepatch/https://urldefense.com/v=
3/__http://functions.sh__;!!BmdzS3_lV9HdKG8!zXXcFqHACaJ7PyoFMFh-_8DFTwWSotP=
ltPcR5ezYC87VaVkoNZcqFkVTtLbYUQp4DKEh9Z-0WLN8c5sMeyug2BCCuslAibAtHJo$  b/to=
ols/testing/selftests/livepatch/https://urldefense.com/v3/__http://function=
s.sh__;!!BmdzS3_lV9HdKG8!zXXcFqHACaJ7PyoFMFh-_8DFTwWSotPltPcR5ezYC87VaVkoNZ=
cqFkVTtLbYUQp4DKEh9Z-0WLN8c5sMeyug2BCCuslAibAtHJo$
> > index 30dc677b2f45..7fa4bda70221 100644
> > --- a/tools/testing/selftests/livepatch/https://urldefense.com/v3/__htt=
p://functions.sh__;!!BmdzS3_lV9HdKG8!zXXcFqHACaJ7PyoFMFh-_8DFTwWSotPltPcR5e=
zYC87VaVkoNZcqFkVTtLbYUQp4DKEh9Z-0WLN8c5sMeyug2BCCuslAibAtHJo$
> > +++ b/tools/testing/selftests/livepatch/https://urldefense.com/v3/__htt=
p://functions.sh__;!!BmdzS3_lV9HdKG8!zXXcFqHACaJ7PyoFMFh-_8DFTwWSotPltPcR5e=
zYC87VaVkoNZcqFkVTtLbYUQp4DKEh9Z-0WLN8c5sMeyug2BCCuslAibAtHJo$
> > @@ -126,6 +126,19 @@ function set_ftrace_enabled() {
> >       echo "livepatch: kernel.ftrace_enabled =3D $result" > /dev/kmsg
> >  }
> >
> > +# ftrace_disable_supported() - probe whether kernel.ftrace_enabled=3D0
> > +#    can still disable ftrace on this kernel. Newer kernels deprecate
> > +#    the knob and always refuse the write with -EOPNOTSUPP.
> > +function ftrace_disable_supported() {
> > +     local result
> > +
> > +     sysctl -q kernel.ftrace_enabled=3D0 &> /dev/null
> > +     result=3D$(sysctl --values kernel.ftrace_enabled)
> > +     sysctl -q kernel.ftrace_enabled=3D1 &> /dev/null
> > +
> > +     [[ "$result" =3D=3D "0" ]]
> > +}
>
> Small nit: AFAICT, it doesn't really affect the test pattern, but it
> would be a bit cleaner if this function restored the original value
> instead of always turning it on, like (untested):
>
>         orig=3D$(sysctl --values kernel.ftrace_enabled)
>         sysctl -q kernel.ftrace_enabled=3D0 &> /dev/null
>         result=3D$(sysctl --values kernel.ftrace_enabled)
>         sysctl -q "kernel.ftrace_enabled=3D$orig" &> /dev/null
>
>         [[ "$result" =3D=3D "0" ]]
>
> --
> Joe
>

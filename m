Return-Path: <live-patching-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B16C1EE49A0
	for <live-patching@archiver.kernel.org>; Wed, 23 Aug 2023 03:42:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232332AbjHWDms (ORCPT
        <rfc822;live-patching@archiver.kernel.org>);
        Tue, 22 Aug 2023 23:42:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44030 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232469AbjHWDm3 (ORCPT
        <rfc822;live-patching@vger.kernel.org>);
        Tue, 22 Aug 2023 23:42:29 -0400
Received: from symantec4.comsats.net.pk (symantec4.comsats.net.pk [203.124.41.30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B1E3BE4D
        for <live-patching@vger.kernel.org>; Tue, 22 Aug 2023 20:42:21 -0700 (PDT)
X-AuditID: cb7c291e-06dff70000002aeb-92-64e56b34f719
Received: from iesco.comsatshosting.com (iesco.comsatshosting.com [210.56.28.11])
        (using TLS with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        by symantec4.comsats.net.pk (Symantec Messaging Gateway) with SMTP id CB.B1.10987.53B65E46; Wed, 23 Aug 2023 07:13:09 +0500 (PKT)
DomainKey-Signature: a=rsa-sha1; c=nofws; q=dns;
        d=iesco.com.pk; s=default;
        h=received:content-type:mime-version:content-transfer-encoding
          :content-description:subject:to:from:date:reply-to;
        b=OakzZDGO7y860k5lsi5BDIiEFsVQBzwH2YVhoXwt10JX725nBbCh9t7tOopd3CRB3
          9TzaGgVXsBVFJtm1GyTUJuXL+F9cnB9x2kUULHr46YPOyV1RgQZ3NbTPDkxC/JgP5
          4PJrOY5kMhofWYoRmvj43NwxLirNDb4imbLGx9d7w=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=iesco.com.pk; s=default;
        h=reply-to:date:from:to:subject:content-description
          :content-transfer-encoding:mime-version:content-type;
        bh=GMzYzcyTxDsE6wX/XHG6MHqAdAiHrhqbmmLQ/TZ1QnQ=;
        b=ETCitrAqeuKUEHfCVzZHRCVTPpU8C0qStOLwhdZwWkvnjPOasogB6h38IFj8UK4nb
          c+COIfKC/ZUToGjRrPTI/ss8nN6V6+Vb8y0KqDDF7lZpYhy284T+vN/VJBMX104Eg
          yKwGnhZuzyEmK04psvk7CuyuNvEHrOoh+vrKvwGlg=
Received: from [94.156.6.90] (UnknownHost [94.156.6.90]) by iesco.comsatshosting.com with SMTP;
   Wed, 23 Aug 2023 04:32:37 +0500
Message-ID: <CB.B1.10987.53B65E46@symantec4.comsats.net.pk>
Content-Type: text/plain; charset="iso-8859-1"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Description: Mail message body
Subject: Re; Interest,
To:     live-patching@vger.kernel.org
From:   "Chen Yun" <pso.chairmanbod@iesco.com.pk>
Date:   Tue, 22 Aug 2023 16:32:51 -0700
Reply-To: chnyne@gmail.com
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrDLMWRmVeSWpSXmKPExsVyyUKGW9c0+2mKwYZtIhZnDt5jc2D0+LxJ
        LoAxissmJTUnsyy1SN8ugStjyboLLAW7mSva+hexNDA+Zupi5OSQEDCR+Lh0F3MXIxeHkMAe
        Jom7xz4xgjgsAquZJdYevQblPGSW6F71D6qsmVHiyZE/jCD9vALWEheuHmIGsZkF9CRuTJ3C
        BhEXlDg58wkLRFxbYtnC10A1HEC2msTXrhKQsLCAmMSnacvYQWwRAUWJ5fcvsoLYbAL6Eiu+
        NjOClLMIqEpsuW8AEhYSkJLYeGU92wRG/llIls1CsmwWkmWzEJYtYGRZxShRXJmbCAy1ZBO9
        5Pzc4sSSYr281BK9guxNjMAwPF2jKbeDcemlxEOMAhyMSjy8P9c9SRFiTSwD6jrEKMHBrCTC
        K/39YYoQb0piZVVqUX58UWlOavEhRmkOFiVxXluhZ8lCAumJJanZqakFqUUwWSYOTqkGxtll
        KsknjggLvlu/nX/da++fq3cHX99uJb3/wWYWF3fVW0/ktSd+fneiaLXmQ5UJiv+yPotKFRmf
        036fyzJ3R++iAo7Lt/sZBFe7pDTsPPn369YXs2fUHJBYH8Oj/iCQWU563eOZmS4XD9z//mje
        W2m5VQfvq957PV/sTHysUsTdmh0z/z4PW6qhxFKckWioxVxUnAgAFLZWxz8CAAA=
Precedence: bulk
List-ID: <live-patching.vger.kernel.org>
X-Mailing-List: live-patching@vger.kernel.org

Re; Interest,

I am interested in discussing the Investment proposal as I explained
in my previous mail. May you let me know your interest and the
possibility of a cooperation aimed for mutual interest.

Looking forward to your mail for further discussion.

Regards

------
Chen Yun - Chairman of CREC
China Railway Engineering Corporation - CRECG
China Railway Plaza, No.69 Fuxing Road, Haidian District, Beijing, P.R.
China


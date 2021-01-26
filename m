Return-Path: <live-patching-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D5C4AC433DB
	for <live-patching@archiver.kernel.org>; Tue, 26 Jan 2021 10:52:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8E40E23103
	for <live-patching@archiver.kernel.org>; Tue, 26 Jan 2021 10:52:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732112AbhAZKvw (ORCPT
        <rfc822;live-patching@archiver.kernel.org>);
        Tue, 26 Jan 2021 05:51:52 -0500
Received: from mail.kernel.org ([198.145.29.99]:56976 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2404253AbhAZKvj (ORCPT <rfc822;live-patching@vger.kernel.org>);
        Tue, 26 Jan 2021 05:51:39 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 871A4230FD;
        Tue, 26 Jan 2021 10:50:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1611658258;
        bh=Xfyl0VQcIuqe4e956VVFqDmX5OfaPoi+OGgwbqduj08=;
        h=Date:From:To:cc:Subject:In-Reply-To:References:From;
        b=m+ho0nCSB6XlRcFx0GW9VXbH0Hp/2ViCkA9BlS5LqN5OFmhEWi9cZU5htWmGu3SMS
         /814gETtB06b8EhpNGKSdhxcwPe+eoFsaJuQcEdsiszgAq0asP0MYcACJciDP3wwME
         UAYfosjlI/IvL3s0tpWaGDR7feEUvxsfKbGMsZSDh60PV/D7eojPY5DLefLm06u6Lb
         YzM1hfswqdgKQBfCsQimXV+NECOW7Fz5r8OjuBDQqCcmf+2WcNghrjhiejrSwVpWHv
         GoS/lX5BowAfGixianMRKGyFl2NhOV1tpjOM9WMjXxWnTdvLmbvtux4OiAxsMvwL7q
         cNOvTmDq/5zgg==
Date:   Tue, 26 Jan 2021 11:50:54 +0100 (CET)
From:   Jiri Kosina <jikos@kernel.org>
To:     Jonathan Corbet <corbet@lwn.net>
cc:     Mark Brown <broonie@kernel.org>, linux-kernel@vger.kernel.org,
        Mark Rutland <mark.rutland@arm.com>,
        Joe Lawrence <joe.lawrence@redhat.com>,
        Miroslav Benes <mbenes@suse.cz>,
        Petr Mladek <pmladek@suse.com>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        linux-doc@vger.kernel.org, live-patching@vger.kernel.org
Subject: Re: [PATCH v6 0/2] Documentation: livepatch: Document reliable
 stacktrace and minor cleanup
In-Reply-To: <nycvar.YFH.7.76.2101221158450.5622@cbobk.fhfr.pm>
Message-ID: <nycvar.YFH.7.76.2101261150400.5622@cbobk.fhfr.pm>
References: <20210120164714.16581-1-broonie@kernel.org> <20210121115226.565790ef@lwn.net> <nycvar.YFH.7.76.2101221158450.5622@cbobk.fhfr.pm>
User-Agent: Alpine 2.21 (LSU 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Precedence: bulk
List-ID: <live-patching.vger.kernel.org>
X-Mailing-List: live-patching@vger.kernel.org

On Fri, 22 Jan 2021, Jiri Kosina wrote:

> > > This series adds a document, mainly written by Mark Rutland, which 
> > > makes explicit the requirements for implementing reliable stacktrace 
> > > in order to aid architectures adding this feature.  It also updates 
> > > the other livepatching documents to use automatically generated tables 
> > > of contents following review comments on Mark's document.
> > 
> > So...is this deemed ready and, if so, do you want it to go through the
> > docs tree or via some other path?
> 
> I am planning to take it through livepatching tree unless there are any 
> additional last-minutes comments.

Now applied to for-5.12/doc branch. Thanks,

-- 
Jiri Kosina
SUSE Labs


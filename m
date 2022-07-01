Return-Path: <live-patching-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 13A12C433EF
	for <live-patching@archiver.kernel.org>; Fri,  1 Jul 2022 21:49:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231564AbiGAVtC (ORCPT
        <rfc822;live-patching@archiver.kernel.org>);
        Fri, 1 Jul 2022 17:49:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36464 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230352AbiGAVtB (ORCPT
        <rfc822;live-patching@vger.kernel.org>);
        Fri, 1 Jul 2022 17:49:01 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 97E755925B;
        Fri,  1 Jul 2022 14:49:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=L+XWyIOtHCryPT3MflUZHHSsExUiw0c1jQ2qAUSUbtg=; b=zB2HlgA9edyrQXm9q0cd8MWgUx
        8/4cGrpHEyoWWsSn+TLG3M7VP+3DWox6u+vbS47k6vwP+g3NZ7bNcIHVoq8DeVYooeuTOSi6znNOT
        thrDWtUYWCUhkVTwblYG7Yjuiccup6qaKzhAwHNf08FDJAZXnRJQ7hus9qLo9tDSMUfA40AQpn4nQ
        ACttzBI94pYSmpcCUR6QU9AT5Drc3b38/O0TQv9XxcDPPkXRslEHy6WsCDJxiRcchClfDyW36R02D
        SJiIbxJwxy/ZWXOJB5x6eYdBV64e7KPDH238El2ipoGoc0oPlaEJmcsF7X3atudF5VmAOZMLtU7vV
        f83ZiSkA==;
Received: from mcgrof by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1o7OVW-0075qO-Tk; Fri, 01 Jul 2022 21:48:58 +0000
Date:   Fri, 1 Jul 2022 14:48:58 -0700
From:   Luis Chamberlain <mcgrof@kernel.org>
To:     Masahiro Yamada <masahiroy@kernel.org>
Cc:     linux-modules@vger.kernel.org,
        Josh Poimboeuf <jpoimboe@kernel.org>,
        Jiri Kosina <jikos@kernel.org>,
        Miroslav Benes <mbenes@suse.cz>,
        Petr Mladek <pmladek@suse.com>,
        Joe Lawrence <joe.lawrence@redhat.com>,
        live-patching@vger.kernel.org, Alex Shi <alexs@kernel.org>,
        Federico Vaga <federico.vaga@vaga.pv.it>,
        Jonathan Corbet <corbet@lwn.net>,
        Matthias Maennich <maennich@google.com>,
        Yanteng Si <siyanteng@loongson.cn>, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] doc: module: update file references
Message-ID: <Yr9ryl7SiiAlMQ0f@bombadil.infradead.org>
References: <20220613081741.1699713-1-masahiroy@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220613081741.1699713-1-masahiroy@kernel.org>
Sender: Luis Chamberlain <mcgrof@infradead.org>
Precedence: bulk
List-ID: <live-patching.vger.kernel.org>
X-Mailing-List: live-patching@vger.kernel.org

On Mon, Jun 13, 2022 at 05:17:40PM +0900, Masahiro Yamada wrote:
> Adjust documents to the file moves made by commit cfc1d277891e ("module:
> Move all into module/").
> 
> Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>

Queued up, thanks!

  Luis

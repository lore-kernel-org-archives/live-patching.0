Return-Path: <SRS0=8L+z=3C=vger.kernel.org=live-patching-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 28D3EC33CAF
	for <live-patching@archiver.kernel.org>; Mon, 13 Jan 2020 12:49:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 08AF82081E
	for <live-patching@archiver.kernel.org>; Mon, 13 Jan 2020 12:49:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728656AbgAMMtK (ORCPT
        <rfc822;live-patching@archiver.kernel.org>);
        Mon, 13 Jan 2020 07:49:10 -0500
Received: from mx2.suse.de ([195.135.220.15]:44068 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726946AbgAMMtK (ORCPT <rfc822;live-patching@vger.kernel.org>);
        Mon, 13 Jan 2020 07:49:10 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id F1164ACC9;
        Mon, 13 Jan 2020 12:49:08 +0000 (UTC)
From:   Miroslav Benes <mbenes@suse.cz>
To:     jpoimboe@redhat.com, jikos@kernel.org, pmladek@suse.com,
        joe.lawrence@redhat.com, shuah@kernel.org
Cc:     live-patching@vger.kernel.org, linux-kselftest@vger.kernel.org,
        linux-kernel@vger.kernel.org, Miroslav Benes <mbenes@suse.cz>
Subject: [PATCH 0/2] selftests/livepatch: Trivial cleanups
Date:   Mon, 13 Jan 2020 13:49:05 +0100
Message-Id: <20200113124907.11086-1-mbenes@suse.cz>
X-Mailer: git-send-email 2.24.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: live-patching-owner@vger.kernel.org
Precedence: bulk
List-ID: <live-patching.vger.kernel.org>
X-Mailing-List: live-patching@vger.kernel.org

Two trivial cleanups after recent changes in selftests/livepatch. Based
on "next" branch of Shuah's kselftest tree.

Miroslav Benes (2):
  selftests/livepatch: Replace set_dynamic_debug() with setup_config()
    in README
  selftests/livepatch: Remove unused local variable in
    set_ftrace_enabled()

 tools/testing/selftests/livepatch/README       | 2 +-
 tools/testing/selftests/livepatch/functions.sh | 1 -
 2 files changed, 1 insertion(+), 2 deletions(-)

-- 
2.24.1


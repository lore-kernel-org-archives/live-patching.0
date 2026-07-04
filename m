Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C77432B9B5;
	Sat,  4 Jul 2026 16:11:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783181463; cv=none; b=dRS0KhxAbHJ2hKfEbpCD1ZfTlp0VX0JebUNrrfQTizcwmRLq0qiYcsair+D7Ij/CrSZk7HFoGubgjXXaVdZl0giLF3//XAqH6T9thpiYJ7sPPcLA1sYBw2im0yTrmKNXBvYelkEw9N63XfGfKbVDaLgS1Uvyy70ilM5bE9iBKnU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783181463; c=relaxed/simple;
	bh=GIxnK5KNTpY08mnVXaUXeQr5XDCAdwvPwqH0Fl0SHXo=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=AvufprvQwbxiJyxdf1MPT8yTOxa2kYzXf5hhoX1ypsr1ryX8rpZY1+I9x4yehbloV6deSJ2dPUkZX5VRMQcNvmCILUxycYIL6+YJc/gz0WmSaUp/WVac6iQ3aXOh623oKD7ACMlt2yHFhTBwp68LJ0N38jMo+HG8n1Cap++QRH4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SagrakNp; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SagrakNp"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DC6E61F000E9;
	Sat,  4 Jul 2026 16:11:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783181462;
	bh=9BCBxOMJjJb5UbDil90ZttRFVlP90VAZpDtTqO/OiGI=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date;
	b=SagrakNpBM+ToOv8CO5kbgKMFlzOqrrwmw8uy0JXIx0j5Kq4CzqFbDPR0VkkP9sSv
	 GONCjs4fFNEVwdcGPs0ah6lMzDC7b22/QHJCqxa2ntZusY8HbxMheOU50cj2QJPiwN
	 v5gip6rEmpLwqwOdw5Eiei+/pjfLPzuRzWccuJy4CJHxcZ8O9ErgavWwJ+sSuga9Yt
	 IknHZJ5uRJqvXp1oayxoTJtremztRHymcx9Rxe/nYZRe424fwlOsNOY5Rn51dfHBN3
	 1UQQaozKIcuSRPI6VFIKz7P4lhClGp2lumukSwdEhf1JSHRBpyNivGcqWoInJMIsDI
	 d+jYhoqF8HWgw==
From: Namhyung Kim <namhyung@kernel.org>
To: linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org, 
 live-patching@vger.kernel.org, Joe Lawrence <joe.lawrence@redhat.com>
Cc: Petr Mladek <pmladek@suse.com>
In-Reply-To: <20260626212140.1380094-1-joe.lawrence@redhat.com>
References: <20260626212140.1380094-1-joe.lawrence@redhat.com>
Subject: Re: [PATCH v2 0/2] perf symbols: skip livepatch symbols
Message-Id: <178318146185.1194818.28831173448483232.b4-ty@kernel.org>
Date: Sat, 04 Jul 2026 09:11:01 -0700
Precedence: bulk
X-Mailing-List: live-patching@vger.kernel.org
List-Id: <live-patching.vger.kernel.org>
List-Subscribe: <mailto:live-patching+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:live-patching+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15-dev-c04d2

On Fri, 26 Jun 2026 17:21:38 -0400, Joe Lawrence wrote:
> This patchset fixes two minor perf bugs when livepatches containing
> special so-called livepatch symbols are loaded.  In both cases, perf
> should ignore these symbols as they resolve as relocations to kernel
> addresses and not module space.
> 
> - Patch 1 fixes `perf test 1`
> - Patch 2 fixes `perf record --kcore` bloat
> 
> [...]
Applied to perf-tools-next, thanks!

Best regards,
Namhyung



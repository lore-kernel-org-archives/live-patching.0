Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60BDA2ED843;
	Sat, 15 Aug 2026 04:45:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786769150; cv=none; b=o4Da2JPRrZGApUnv7UkwzuZLeQVczXjQqOOKYF6cdkThE/VYlP5C/CWhZh57CgfCYRulwE+Bl9oluw9mMSGpUoUyw0vFsA617ucXEpRldZjZIkJTDUEdOnQZY7eTRE8LwmGPSr/eQ1PAwdUVnHZR1XtvgyWeNT1tbedVW708zhQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786769150; c=relaxed/simple;
	bh=LjDQ70UaEYhvY8UBrUQAircCS/5wtHBctyqoau8f6b4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mjrFOhymIoo/dbhfDmUQ2HwKgikgd2Ja4KVaTNwv6jIcqnKcP+dHKOeJmh/lqs7RuZIrEVGPHnKBabX6pRY17sX3hpBEVELRmYCyZKBRYInT5zO0CWT21wjLF+61EEeepAEIlA4PDkJmqqHjxsLn4k2DXvKdR67x3q7iE8EuZ6U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Hj47LVxo; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Hj47LVxo"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B7BBF1F000E9;
	Sat, 15 Aug 2026 04:45:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786769149;
	bh=fT44iHwShZYqHlrkVVc92252zfcCjw/uJmqte3KuCwo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Hj47LVxoYM8DunlTEHRgvNdzoKlQ7WASQfHhhJxWXwHqpoDHdGy8+S3dlLQrhl38/
	 0o4HXCx9MeNuPPOObGDj4hFfRORTpVhf8bLYkjiTwoKbSJSuhCL3/2jkR8GhuqQID5
	 VX/xhmWTvAlNwYUtWswI/ij5FKVKt7ADbeD9nFzZupC5RNROOcOGlqgwqExuc3ad3l
	 1x3YhLIQQw76MIKoVvc17QYWvZtRQ1kX6vvOg8tjkzHKYHyqjMS43qtP4sPqpFBYEz
	 2/Ci+FiD/VvFcpkBSOijf1Xt1/kn98tzhfhxNVRG4AOafoWw9dP9JKfpDV6ndYoXpq
	 qCbdH7LWCgvfA==
From: Josh Poimboeuf <jpoimboe@kernel.org>
To: Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>
Cc: linux-kernel@vger.kernel.org,
	Ard Biesheuvel <ardb@kernel.org>,
	linux-arm-kernel@lists.infradead.org,
	live-patching@vger.kernel.org,
	Song Liu <song@kernel.org>,
	Miroslav Benes <mbenes@suse.cz>,
	Petr Mladek <pmladek@suse.com>,
	Joe Lawrence <joe.lawrence@redhat.com>,
	Mark Rutland <mark.rutland@arm.com>,
	Mark Brown <broonie@kernel.org>,
	Nick Desaulniers <ndesaulniers@google.com>,
	Kees Cook <kees@kernel.org>,
	Nathan Chancellor <nathan@kernel.org>,
	linux-toolchains@vger.kernel.org
Subject: [PATCH 09/12] efi/libstub: Preserve the GNU property note
Date: Fri, 14 Aug 2026 21:45:26 -0700
Message-ID: <0445b20df50894615ada70abb1e6238f33c78a2e.1786768375.git.jpoimboe@kernel.org>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <cover.1786768375.git.jpoimboe@kernel.org>
References: <cover.1786768375.git.jpoimboe@kernel.org>
Precedence: bulk
X-Mailing-List: live-patching@vger.kernel.org
List-Id: <live-patching.vger.kernel.org>
List-Subscribe: <mailto:live-patching+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:live-patching+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

With "-z force-bti" the linker warns (or errors with CONFIG_WERROR) for
every libstub object:

  warning: BTI is required by -z force-bti, but this input object file lacks the necessary property note.

On arm64 the EFI stub is part of vmlinux, so its objects are annotated
as __init at the section level by running objcopy with
--prefix-alloc-sections=.init.  That has the side effect of renaming
.note.gnu.property to .init.note.gnu.property, which LLD ignores,
resulting in the BTI bit getting removed.

That's only a problem for toolchains which advertise the branch
protection features solely through .note.gnu.property.  GCC 16 and Clang
20 also record them in .ARM.attributes, which objcopy leaves alone, but
older compilers emit only the note.

Rename the section back to its original name so the linker sees it, and
so the generic NOTES macro can discard it.  objcopy applies
--rename-section before --prefix-alloc-sections regardless of their
order on the command line, so this needs a second objcopy invocation
rather than another flag on the existing one.

RISC-V and LoongArch apply the same .init prefix, so key the rename off
that rather than on arm64 alone.  Neither emits .note.gnu.property
today, and renaming a section which isn't present is a no-op, so this
changes nothing for them for now, but it prevents a future silent
failure mode.

The note is still stripped by --remove-section=.note.gnu.property, so
this change is inert until that section removal goes away in a
subsequent patch.

Signed-off-by: Josh Poimboeuf <jpoimboe@kernel.org>
---
 drivers/firmware/efi/libstub/Makefile | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/drivers/firmware/efi/libstub/Makefile b/drivers/firmware/efi/libstub/Makefile
index 77a2b2d74f3f6..b1c95f69e807d 100644
--- a/drivers/firmware/efi/libstub/Makefile
+++ b/drivers/firmware/efi/libstub/Makefile
@@ -155,6 +155,12 @@ STUBCOPY_FLAGS-$(CONFIG_LOONGARCH)	+= --prefix-alloc-sections=.init \
 					   --prefix-symbols=__efistub_
 STUBCOPY_RELOC-$(CONFIG_LOONGARCH)	:= R_LARCH_MARK_LA
 
+# --prefix-alloc-sections=.init also renames .note.gnu.property, which the
+# linker then ignores, dropping the branch protection properties.  Rename it
+# back on any architecture which applies the prefix.
+STUBCOPY_RENAME-y = $(if $(findstring --prefix-alloc-sections,$(STUBCOPY_FLAGS-y)), \
+		      --rename-section .init.note.gnu.property=.note.gnu.property)
+
 $(obj)/%.stub.o: $(obj)/%.o FORCE
 	$(call if_changed,stubcopy)
 
@@ -171,4 +177,5 @@ quiet_cmd_stubcopy = STUBCPY $@
 		echo "$@: absolute symbol references not allowed in the EFI stub" >&2; \
 		/bin/false;						\
 	fi;								\
-	$(OBJCOPY) $(STUBCOPY_FLAGS-y) $< $@
+	$(OBJCOPY) $(STUBCOPY_FLAGS-y) $< $@				\
+	$(if $(STUBCOPY_RENAME-y),; $(OBJCOPY) $(STUBCOPY_RENAME-y) $@)
-- 
2.55.0


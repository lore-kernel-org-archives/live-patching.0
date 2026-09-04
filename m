Received: from mta0.migadu.com (out-141.mta0.migadu.com [91.218.175.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFC4C1F3BAC
	for <live-patching@vger.kernel.org>; Fri,  4 Sep 2026 01:19:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788484770; cv=none; b=ZXNR8gA1wpmksvPAa8/Vkiycm+XJ/J7ruIq18lAGqQ0aErI2zyzirAV103Mwl1RA/e/htdrbdqaEN6qNRinrsds5yN0RMK7/8+F9MEAB2wK1SEj+VojfgZ3E17MR5N4VxSM4WSyPqSZnbPjoLEJJdzDP1dF01Asa2dC3EJWpVI0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788484770; c=relaxed/simple;
	bh=kOjB9EUx2W1v/7kxzVeOxthVHt+Dm43TqpI5/i1TiXQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=iQ+aBhOirNcUXJdiGyXAy0zSiFELmcbPMobe4Cnqen7NKSq7L746NcHG6xj9xFn2SfQvbpsj8L+uGAtC5J0/D1YTGd+XpFFAiPad0XCzKRkpnxWeCHv3WL9wjkvYbUQ8j2zGDvss9WS16eOehV/VQORHbAAul9qM0uV7k1yGFPY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=VXTnKNi+; arc=none smtp.client-ip=91.218.175.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="VXTnKNi+"
X-Envelope-To: live-patching@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=kOjB9EUx2W1v/7kxzVeOxthVHt+Dm43TqpI5/i1TiXQ=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1788484767; v=1; x=1789089567;
 b=VXTnKNi+SJNeRM/1eXpdudn9h7lHvuvxQ6t1woolDsx+8GF64lAvFKVJ5ob9/LFf0fbK/6pz
 WrB/Dlm9EZjwJKjOnnLhIGBme6GX8ibQbjZFySO97ec69sIQ7s82lrQrtnw7cQEYI66PYQrCbzK
 ygHlL1FNolqdz148DEm5GysY=
X-Envelope-To: live-patching@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id 9674486ccf1fcb7f;
	Fri, 04 Sep 2026 01:19:26 +0000
X-Mizu-Trace-ID: 9674486ccf1fcb7f
X-Migadu-Flow: FLOW_OUT
From: "Jose Fernandez (Anthropic)" <jose.fernandez@linux.dev>
Date: Fri, 04 Sep 2026 01:18:35 +0000
Subject: [PATCH RFC 3/8] compiler_types: Let notrace keep the function
 prefix NOPs
Precedence: bulk
X-Mailing-List: live-patching@vger.kernel.org
List-Id: <live-patching.vger.kernel.org>
List-Subscribe: <mailto:live-patching+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:live-patching+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260904-b4-arm64-callops-kcfi-v1-3-ce6687739b0c@linux.dev>
References: <20260904-b4-arm64-callops-kcfi-v1-0-ce6687739b0c@linux.dev>
In-Reply-To: <20260904-b4-arm64-callops-kcfi-v1-0-ce6687739b0c@linux.dev>
To: Steven Rostedt <rostedt@goodmis.org>, 
 Masami Hiramatsu <mhiramat@kernel.org>, Mark Rutland <mark.rutland@arm.com>, 
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, 
 Nathan Chancellor <nathan@kernel.org>, Nicolas Schier <nsc@kernel.org>, 
 Nick Desaulniers <ndesaulniers@google.com>, 
 Bill Wendling <morbo@google.com>, Justin Stitt <justinstitt@google.com>, 
 Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>, 
 Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
 Andrii Nakryiko <andrii@kernel.org>, Eduard Zingerman <eddyz87@gmail.com>, 
 Kumar Kartikeya Dwivedi <memxor@gmail.com>, 
 Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>, 
 Yonghong Song <yonghong.song@linux.dev>, Jiri Olsa <jolsa@kernel.org>, 
 Emil Tsalapatis <emil@etsalapatis.com>, 
 Puranjay Mohan <puranjay@kernel.org>, Xu Kuohai <xukuohai@huaweicloud.com>, 
 Ard Biesheuvel <ardb@kernel.org>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Miguel Ojeda <ojeda@kernel.org>, Boqun Feng <boqun@kernel.org>, 
 Gary Guo <gary@garyguo.net>, 
 =?utf-8?q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
 Benno Lossin <lossin@kernel.org>, Andreas Hindborg <a.hindborg@kernel.org>, 
 Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>, 
 Danilo Krummrich <dakr@kernel.org>, 
 Daniel Almeida <daniel.almeida@collabora.com>, 
 Tamir Duberstein <tamird@kernel.org>, 
 Alexandre Courbot <acourbot@nvidia.com>, 
 =?utf-8?q?Onur_=C3=96zkan?= <work@onurozkan.dev>, 
 Sami Tolvanen <samitolvanen@google.com>, Kees Cook <kees@kernel.org>
Cc: Leon Hwang <leon.hwang@linux.dev>, 
 Ihor Solodrai <ihor.solodrai@linux.dev>, 
 Josh Poimboeuf <jpoimboe@kernel.org>, live-patching@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org, 
 linux-kbuild@vger.kernel.org, llvm@lists.linux.dev, 
 linux-arm-kernel@lists.infradead.org, bpf@vger.kernel.org, 
 linux-efi@vger.kernel.org, rust-for-linux@vger.kernel.org, 
 Ben Cressey <ben@cressey.dev>, 
 "Florent Revest (Anthropic)" <florent.revest@linux.dev>, 
 "Jose Fernandez (Anthropic)" <jose.fernandez@linux.dev>
X-Mailer: b4 0.15.2

Let notrace keep the prefix NOPs when the architecture defines
CC_USING_PATCHABLE_FUNCTION_PREFIX. kCFI callers check the type hash
at a fixed offset before the entry point, so a notrace function needs
the same prefix NOPs as any other. Record the entry in a section the
linker drops, so ftrace never sees it. Clang 21 takes a section name
as a third argument of the attribute. Nothing defines the macro yet,
so no functional change.

Reviewed-by: Ben Cressey <ben@cressey.dev>
Reviewed-by: Florent Revest (Anthropic) <florent.revest@linux.dev>
Assisted-by: LLM
Signed-off-by: Jose Fernandez (Anthropic) <jose.fernandez@linux.dev>
---
 include/linux/compiler_types.h | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/include/linux/compiler_types.h b/include/linux/compiler_types.h
index c5921f1390079..87e10920acba7 100644
--- a/include/linux/compiler_types.h
+++ b/include/linux/compiler_types.h
@@ -211,6 +211,12 @@ struct ftrace_likely_data {
 
 #if defined(CC_USING_HOTPATCH)
 #define notrace			__attribute__((hotpatch(0, 0)))
+#elif defined(CC_USING_PATCHABLE_FUNCTION_PREFIX) && !defined(__BINDGEN__)
+/* bindgen generates no code and its libclang may not take the section argument. */
+#define notrace								\
+	__attribute__((patchable_function_entry(CC_USING_PATCHABLE_FUNCTION_PREFIX, \
+						 CC_USING_PATCHABLE_FUNCTION_PREFIX, \
+						 ".discard.patchable_function_entries")))
 #elif defined(CC_USING_PATCHABLE_FUNCTION_ENTRY)
 #define notrace			__attribute__((patchable_function_entry(0, 0)))
 #else

-- 
2.52.0


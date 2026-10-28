Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793223965;
	b=PoTNBc6JqdozfERT37/IoSwa7EWgHLMucfVr8G9yk1bUydCejaZOyAOdO7ZmL5odwUT8
	 TnAamf3nnKcIUC9KRKYy8a8mXMwKlpCictuh/acu6rCVx71i61bvi0j8lJq9wVw8CEPBl
	 fKbLBkGYM7FEcZvvlMDFpI/BRNgJUFh3Wh6nOkuJEm6YMkiqIsr+AuXKPD14+kG3tuKwh
	 mn0g0A5ILVXhvs9NPZg5PuzFjbHqsFpQMHZwVxBXhpcvFDzhrjk1SnXbjGvOZb1K+tPth
	 g5kZ9svMuByk4ig/b1O2ePeWfMvpWbGeHO8bDbcEmjT1K8ElRpoWfRan05bgefjbKwA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793223965;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=ExcGfUivncMIxLRDWI+khPLlDldpFaREfvlx3s7d6yI=;
	b=ABFlByRBNf/WU2eaA7IL/tc2uaUxiyEuWZCkikkZO6XWjdFl8KwyfmPYJq/KnKtuD8es
	 jPBa1XMEDP+BKdb1MY/oexzxUUrshk2xeDv3Zgb1Bx1ewwONNqOpq1YdUWZuqt27ZV0wv
	 aDw1eXx7VaU2DfVf6kl4sAQY+66gRufphi5/qhUxEftMkpLA3U0IpZnFO8WcT9ernhkf8
	 VQkwB+GlW0q8CN1HcEiaAwxHmgIWa9BuL/J3UBF/BPsVlLDkjF2AeyzdGdHM1Hzyi1Cfy
	 Dnf8nmyfaEsnxcffSY6WC3Z578hzs0nF5cMhNqMNc2+oBHxJy4dz/z1II1br6BAYBCg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=oGYCzA40;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84103606A32A;
	Wed, 28 Oct 2026 21:46:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=oGYCzA40
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 333E81F01825;
	Wed, 28 Oct 2026 21:46:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793223965;
	bh=ExcGfUivncMIxLRDWI+khPLlDldpFaREfvlx3s7d6yI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=oGYCzA40hx1+Xbh75Dg61Z0c3C/FMNv62uGFiYj6ZeLeEZTo1TCY+U3rUFwGPDQ9b
	 uWu1DQ/zLRtmlEOAL1ZT/EJ45YmTOVcKiWErN2eN4Q4R0jEQH4jPS0offmaB1tR2qX
	 VnrqTgPE2OZCDN+aMxxoFCvdmz9GW80veA9ypXVxFO6ilbv3iF6/m0si/wuxFj9o1z
	 ZSHsAxxurbs4ASDY5cEk1qmaZAZI/8R4NyGyxLxwxYVrqDyrxiXaSiwd9yxJ5m3B/l
	 vRfA4wHO7GcuHnrvVi0ZfI3ga42pxydlg5680tkULLqy8/E7STN8+n16xmIsyQw4Uh
	 n7iFovqMRMmGg==
From: Song Liu <song@kernel.org>
To: live-patching@vger.kernel.org,
	linux-kselftest@vger.kernel.org
Cc: jpoimboe@kernel.org,
	jikos@kernel.org,
	mbenes@suse.cz,
	pmladek@suse.com,
	joe.lawrence@redhat.com,
	shuah@kernel.org,
	linux-kernel@vger.kernel.org,
	Song Liu <song@kernel.org>
Subject: [PATCH v2 05/12] selftests/livepatch: Test klp-prepare-patch with dependent patches
Date: Wed, 28 Oct 2026 14:45:27 -0700
Message-ID: <20261028214534.1919398-6-song@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261028214534.1919398-1-song@kernel.org>
References: <20261028214534.1919398-1-song@kernel.org>
X-Mailing-List: live-patching@vger.kernel.org
List-Id: <live-patching.vger.kernel.org>
List-Post: <mailto:live-patching@vger.kernel.org>
List-Help: <mailto:live-patching+help@vger.kernel.org>
List-Subscribe: <mailto:live-patching+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:live-patching+unsubscribe@vger.kernel.org>
List-Owner: <mailto:live-patching+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add a test case where the second patch changes lines added by the
first, so it only applies on top of it.  klp-prepare-patch has to
combine the two into a single patch against the original source, rather
than fixing each one against the original source on its own.

The case uses the same source file and first patch as the single patch
test, so add it to test-basic.sh.

Assisted-by: Claude:claude-opus-5
Signed-off-by: Song Liu <song@kernel.org>
---
 .../livepatch/test_klp_build/test-basic.sh    | 36 +++++++++++++++++++
 1 file changed, 36 insertions(+)

diff --git a/tools/testing/selftests/livepatch/test_klp_build/test-basic.sh b/tools/testing/selftests/livepatch/test_klp_build/test-basic.sh
index 127d678a07ce..70a653ee72aa 100755
--- a/tools/testing/selftests/livepatch/test_klp_build/test-basic.sh
+++ b/tools/testing/selftests/livepatch/test_klp_build/test-basic.sh
@@ -54,4 +54,40 @@ expect_patch <<'EOT'
  	return x;
 EOT
 
+# - a patch which changes lines added by an earlier patch doesn't apply to the
+#   original source on its own, but the combined patch does
+
+start_test "patch which depends on an earlier one"
+
+add_patch 0002-foo-again.patch <<'EOT'
+--- a/drivers/foo/foo.c
++++ b/drivers/foo/foo.c
+@@ -1,8 +1,8 @@
+ int foo(int x)
+ {
+ 	if (!x)
+-		return 0;
++		return 1;
+ 	if (x < 0)
+ 		return -1;
+ 	return x;
+ }
+EOT
+
+run_klp_prepare_patch 0001-foo.patch 0002-foo-again.patch
+
+expect_patch <<'EOT'
+--- a/drivers/foo/foo.c
++++ b/drivers/foo/foo.c
+@@ -1,5 +1,8 @@
+ int foo(int x)
+ {
++	if (!x)
++		return 1;
++#line 3
+ 	if (x < 0)
+ 		return -1;
+ 	return x;
+EOT
+
 exit 0
-- 
2.53.0-Meta


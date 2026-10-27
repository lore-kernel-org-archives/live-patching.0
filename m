Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793065438;
	b=IGStIOd4dygU1xI5BKGOVVlTc/dMxcUayag1/u6UB3XWHgg2lLSp3bOVnZKpLlhvvjia
	 DGp/bkYXBIXlK3icZjUkm5nbYW2pYvdVlcq571FiMV9WO1BS53YR5MXjn67ahE1Q16dl3
	 yLnuy878fH4NQw6NMTFwVuzeRPqtZdMp90vcZlBTgWvU9A6k7Kmr1UkxNAr9gkVPsHscX
	 e2iEmbITpANLjR0jgOFu78uSEyLajiP/G287vlYF1QeNF5C5sXVdNYk3GjDUhreUGyTBV
	 5/ysKjRk6FHOU8Nmjh3+KRF4X7mYlqL9fHzN6oky6+gYIEFZhsuLPuLRTJZyqRBac+A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793065438;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=gHMFMQXqzSRs+VRK4YQTy0GUfL3/Ra2rTOLetkxT53M=;
	b=xFG0IO8/aMOvzomzD8Tz2JjnxRrLgjJGnb+AO5aCzAwAlPNwQI9m3G9mEo6XdqHODfJD
	 u63lxH7SgZUdoD5aE8DYvUdvIK3WBj+o6nvw2RbFOdCjzRU7VXoihkljHRsPBrEsSCtHT
	 5hPP/OzUpblt0m38apU6CRJtqnLkJaZOOOAlY6xPHfDUO2qjjbgzbK+mvt43h2f2P2lA8
	 OYKOT5YgSPqDnyR/AhTXkutfuw+q/1YIBYR2bPtoSlfTYgdf6e6fKmkdfZ3JM+4V0AdXQ
	 /oRApnuUAFbSUnRmf3+D/5MUIVHjwwnDIQUZd3NyJUqoztLOat+FLoQYrYcOx9//WcQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=YB8yyDsL;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2AA2606A31A;
	Tue, 27 Oct 2026 01:43:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=YB8yyDsL
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0F98A1F01825;
	Tue, 27 Oct 2026 01:43:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793065437;
	bh=gHMFMQXqzSRs+VRK4YQTy0GUfL3/Ra2rTOLetkxT53M=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=YB8yyDsLnTgfsOVoQUdsnaLRK0e8kBmgoY085E9r81q6y14pLrOBY1TlyFz2ZtoOn
	 u6XMqz2RvobprAGcA9DxXP/yTKdXv8ptbAGKbLqn3OYqmyB5hm/5LjtbYQeZJvBy+s
	 8eZiXI7O1zOr+qimBcduRSNYxDZrWkAChFZUKssuAS6Bxmw0W/MjvB1Y6OH6gqC3GV
	 IdD1m01xxoEMs59Rq1IkQltYQid0C4qGYY2klaCvD+hNQlRHyuvtBdUsVYWTjLQx7a
	 VsIUe+B3ogH903z8uAr+AgrfI1PPB3UWhcAitLgNbRJ356Gh05B+4/0615/Ou1wmDb
	 YEYEXSK+ZMXIg==
Date: Mon, 26 Oct 2026 18:43:55 -0700
From: Josh Poimboeuf <jpoimboe@kernel.org>
To: Song Liu <song@kernel.org>
Cc: live-patching@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	jikos@kernel.org, mbenes@suse.cz, pmladek@suse.com, joe.lawrence@redhat.com, 
	shuah@kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 01/11] klp-build: Fix dependent patches in a series
Message-ID: <at_1V3XcGM_D1bY1@jpoimboe>
References: <20261017002441.716615-1-song@kernel.org>
 <20261017002441.716615-2-song@kernel.org>
X-Mailing-List: live-patching@vger.kernel.org
List-Id: <live-patching.vger.kernel.org>
List-Post: <mailto:live-patching@vger.kernel.org>
List-Help: <mailto:live-patching+help@vger.kernel.org>
List-Subscribe: <mailto:live-patching+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:live-patching+unsubscribe@vger.kernel.org>
List-Owner: <mailto:live-patching+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20261017002441.716615-2-song@kernel.org>

On Fri, Oct 16, 2026 at 05:24:31PM -0700, Song Liu wrote:
> fix_patches() refreshes each patch on its own against the original
> source: it applies the patch, copies the patched files, and reverts it.
> If a later patch in the series depends on an earlier one, it doesn't
> apply to the original source, and klp-build fails even though
> validate_patches(), which applies the patches in order, accepted the
> series:
> 
>   $ ./scripts/livepatch/klp-build 0001-dummy.patch 0002-Revert-dummy.patch
>   Validating patch(es)
>   Building original kernel
>   Copying original object files
>   Fixing patch(es)
>   Reversed (or previously applied) patch detected!  Assume -R? [n]
>   Apply anyway? [n]
>   1 out of 1 hunk ignored
>   error: klp-build: .../klp-tmp/tmp.patch did not apply

The patch fixing step should probably be done earlier, during the patch
validating step, so any such errors get rooted out before the build.
That would simplify things and unify the apply/revert cycles.  (can be a
separate followup patch)

> +++ b/scripts/livepatch/klp-build
> @@ -467,60 +467,75 @@ do_init() {
>  	set_kernelversion
>  }
>  
> -# Refresh the patch hunk headers, specifically the line numbers and counts.
> -refresh_patch() {
> -	local patch="$1"
> +# Combine the patches into a single patch against the original source, with
> +# refreshed hunk headers.  The patches may depend on each other, so they can't
> +# be refreshed individually.

It's probably no longer accurate to describe this as refreshing things
since it's now creating a new patch?

> +combine_patches() {
> +	local outfile="$1"
>  	local tmpdir="$PATCH_TMP_DIR"
> -	local input_files=()
> -	local output_files=()
> +	local files=()
> +	local patch
> +	local file
>  
>  	rm -rf "$tmpdir"
> -	mkdir -p "$tmpdir/a"
> -	mkdir -p "$tmpdir/b"
> +	mkdir -p "$tmpdir"
>  
> -	# Get all source files affected by the patch
> -	get_patch_input_files "$patch" | mapfile -t input_files
> -	get_patch_output_files "$patch" | mapfile -t output_files

Now that these helpers are only called by get_patch_files(), can they
be folded into it and simplified with a single grep for '^(---|\+\+\+) '?

> +	# Get all source files affected by the patches
> +	for patch in "${PATCHES[@]}"; do
> +		get_patch_files "$patch"
> +	done | sort -u | mapfile -t files
>  
> -	# Copy orig source files to 'a'
> -	echo "${input_files[@]}" | xargs cp --parents --target-directory="$tmpdir/a"
> +	# Copy orig source files to $tmpdir
> +	for file in "${files[@]}"; do
> +		if [[ -e "$file" ]]; then
> +			cp --parents "$file" "$tmpdir"
> +		fi
> +	done
>  
> -	# Copy patched source files to 'b'
> -	apply_patch "$patch" "--silent"
> -	echo "${output_files[@]}" | xargs cp --parents --target-directory="$tmpdir/b"
> -	revert_patch "$patch"
> +	# Diff the orig source files against the patched ones in place to make a
> +	# clean patch.  Use /dev/null for created and deleted files.
> +	: > "$outfile"
> +	apply_patches "--silent"
> +	for file in "${files[@]}"; do
> +		local old="$tmpdir/$file"
> +		local new="$file"
> +		local old_label="a/$file"
> +		local new_label="b/$file"
> +		local status=0
> +
> +		if [[ ! -e "$old" ]]; then
> +			old=/dev/null
> +			old_label=/dev/null
> +		fi
> +		if [[ ! -e "$new" ]]; then
> +			new=/dev/null
> +			new_label=/dev/null
> +		fi
>  
> -	# Diff 'a' and 'b' to make a clean patch
> -	( cd "$tmpdir" && diff -Nupr a b > "$patch" ) || true
> +		diff -up --label "$old_label" --label "$new_label" "$old" "$new" >> "$outfile" || status=$?
> +		if (( status > 1 )); then
> +			die "diff failed for $file"
> +		fi
> +	done
> +	revert_patches
>  }
>  
> -# Copy the patches to a temporary directory, fix their lines so as not to
> -# affect the __LINE__ macro for otherwise unchanged functions further down the
> -# file, and update $PATCHES to point to the fixed patches.
> +# Combine the patches into a single patch, fix its lines so as not to affect
> +# the __LINE__ macro for otherwise unchanged functions further down the file,
> +# and update $PATCHES to point to the fixed patch.
>  fix_patches() {

This no longer fixes the patches, probably a function rename is
warranted?

> -	local idx
> -	local i
> +	local tmp_patch="$TMP_DIR/tmp.patch"
> +	local new_patch="$TMP_DIR/fixed.patch"
>  
>  	rm -f "$TMP_DIR"/*.patch
>  
> -	idx=0001
> -	for i in "${!PATCHES[@]}"; do
> -		local old_patch="${PATCHES[$i]}"
> -		local tmp_patch="$TMP_DIR/tmp.patch"
> -		local patch="${PATCHES[$i]}"
> -		local new_patch
> -
> -		new_patch="$TMP_DIR/$idx-fixed-$(basename "$patch")"
> +	combine_patches "$tmp_patch"
> +	[[ ! -s "$tmp_patch" ]] && die "no changes detected"
>  
> -		cp -f "$old_patch" "$tmp_patch"
> -		refresh_patch "$tmp_patch"
> -		"$FIX_PATCH_LINES" "$tmp_patch" | recountdiff > "$new_patch"
> +	"$FIX_PATCH_LINES" "$tmp_patch" | recountdiff > "$new_patch"
> +	PATCHES=("$new_patch")
>  
> -		PATCHES[i]="$new_patch"
> -
> -		rm -f "$tmp_patch"
> -		idx=$(printf "%04d" $(( 10#$idx + 1 )))
> -	done

It's confusing that from here on out, PATCHES becomes a single-element
array (yet its users treat it like it might have multiple entries).

It should probably be a separate variable (COMBINED_PATCH?), with its
users simplified.  And e.g., the "Fixing patch(es)" status message can
be changed.  "Processing patch(es)"?

> +	rm -f "$tmp_patch"

I think this doesn't need to be removed here, it shows an intermediate
state which could be useful for debugging.

-- 
Josh

#!/usr/bin/env bash
#  vim:ts=4:sts=4:sw=4:et
#
#  Author: Hari Sekhon
#  Date: 2020-08-25 15:54:23 +0100 (Tue, 25 Aug 2020)
#
#  https://github.com/HariSekhon/bash-tools
#
#  License: see accompanying Hari Sekhon LICENSE file
#
#  If you're using my code you're welcome to connect with me on LinkedIn and optionally send me feedback to help steer this or other code I publish
#
#  https://www.linkedin.com/in/HariSekhon
#

set -euo pipefail
[ -n "${DEBUG:-}" ] && set -x
srcdir="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

# shellcheck disable=SC1090
. "$srcdir/lib/utils.sh"

# shellcheck disable=SC2034,SC2154
usage_description="
Generates kubectl credentials and contexts for all GKE clusters in the current GCP project

This action is idempotent and fast way to get set up in new environments, or even just if new clusters have been added
"

# used by usage() in lib/utils.sh
# shellcheck disable=SC2034
usage_args=""

help_usage "$@"

gcloud container clusters list --format='value(name,zone)' |
while read -r cluster zone; do
    echo "Getting GKE creds for cluster '$cluster' in zone '$zone':"
    gcloud container clusters get-credentials "$cluster" --zone "$zone"
    echo
done

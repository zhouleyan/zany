set -o errexit
set -o nounset
set -o pipefail

KUBE_ROOT=$(dirname "${BASH_SOURCE[0]}")/../..
echo "$KUBE_ROOT"
source "${KUBE_ROOT}/hack/lib/init.sh"

kube::golang::build_binaries "$@"
kube::golang::place_bins

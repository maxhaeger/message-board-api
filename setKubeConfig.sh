set -e

# Überprüfen, ob die benötigten Befehle existieren
command -v linode-cli >/dev/null 2>&1 || { echo >&2 "linode-cli ist nicht installiert.  Abbruch."; exit 1; }
command -v base64 >/dev/null 2>&1 || { echo >&2 "base64 ist nicht installiert.  Abbruch."; exit 1; }

configid=$(linode-cli lke clusters-list --text --no-header | awk '{print $1}')
config=$(linode-cli lke kubeconfig-view $configid --text --no-headers | base64 -d)

# Verwenden einer temporären Datei anstelle einer Datei im Home-Verzeichnis
tempfile=$(mktemp)
echo "$config" > $tempfile
export KUBECONFIG=$tempfile
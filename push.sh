#!/bin/bash
set -e

# Directory dove si trova lo script (cartella dotfiles)
DOTFILES_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
cd "$DOTFILES_DIR"

echo "==> Controllo repository in $DOTFILES_DIR..."

# Verifica che sia un repository git
if [ ! -d ".git" ]; then
  echo "Errore: $DOTFILES_DIR non è un repository git." >&2
  exit 1
fi

# Rileva il branch corrente
BRANCH="$(git branch --show-current 2>/dev/null || echo "main")"

# Sincronizzazione preventiva con il repository remoto
echo "==> Verifica aggiornamenti remoti ($BRANCH)..."
git pull --rebase origin "$BRANCH" 2>/dev/null || true

# Controllo se ci sono file modificati o non tracciati
STATUS=$(git status --porcelain)

# Se non ci sono modifiche e siamo allineati al remote, esci
if [ -z "$STATUS" ]; then
  LOCAL=$(git rev-parse HEAD 2>/dev/null)
  REMOTE=$(git rev-parse "@{u}" 2>/dev/null || echo "$LOCAL")
  if [ "$LOCAL" = "$REMOTE" ]; then
    echo "Nessuna modifica rilevata. Il repository è già aggiornato su GitHub."
    exit 0
  fi
fi

# Controllo di sicurezza di base (token GitHub o chiavi private accidentalmente inserite)
echo "==> Controllo di sicurezza su token o credenziali..."
SUSPICIOUS=$(git diff | grep -E "ghp_[a-zA-Z0-9]{36}|gho_[a-zA-Z0-9]{36}|-----BEGIN (RSA|OPENSSH|EC|DSA) PRIVATE KEY-----" || true)
if [ -n "$SUSPICIOUS" ]; then
  echo "ATTENZIONE: Rilevati possibili token o chiavi private nelle modifiche:" >&2
  echo "$SUSPICIOUS" >&2
  echo "Operazione annullata per sicurezza. Rimuovi le credenziali prima di fare il push." >&2
  exit 1
fi

# Messaggio di commit: usa il primo argomento fornito o un default con data e ora
COMMIT_MSG="${1:-Update dotfiles: $(date '+%Y-%m-%d %H:%M:%S')}"

echo "==> Preparazione commit..."
git add -A

if ! git diff --cached --quiet; then
  git commit -m "$COMMIT_MSG"
  echo "Commit creato: $COMMIT_MSG"
else
  echo "Nessun nuovo commit da creare, invio i commit pendenti..."
fi

# Upload su GitHub
echo "==> Upload (push) su GitHub (origin/$BRANCH)..."
git push origin "$BRANCH"

echo "==> Upload completato con successo!"

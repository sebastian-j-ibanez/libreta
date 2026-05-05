#!/usr/bin/env bash
set -euo pipefail

# ---------------------------------------------------------------------------
# Colors
# ---------------------------------------------------------------------------
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
CYAN='\033[0;36m'
BOLD='\033[1m'
RESET='\033[0m'

# ---------------------------------------------------------------------------
# Paths
# ---------------------------------------------------------------------------
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
DB_PATH="$SCRIPT_DIR/database/libreta.db"
SCHEMA_SQL="$SCRIPT_DIR/database/schema.sql"
DATA_SQL="$SCRIPT_DIR/database/data.sql"
FRONTEND_DIR="$SCRIPT_DIR/frontend"

# Always run from the repo root regardless of where the script was invoked.
cd "$SCRIPT_DIR"

# ---------------------------------------------------------------------------
# Helpers
# ---------------------------------------------------------------------------
banner() { echo -e "${CYAN}${BOLD}[$1]${RESET} $2"; }
success() { echo -e "${GREEN}${BOLD}done:${RESET} $1"; }
err()     { echo -e "${RED}${BOLD}error:${RESET} $1" >&2; exit 1; }

preflight() {
    local missing=()
    for cmd in cargo npm sqlite3; do
        command -v "$cmd" &>/dev/null || missing+=("$cmd")
    done
    [[ ${#missing[@]} -eq 0 ]] || err "Missing required tools: ${missing[*]}"
}

build_frontend() {
    banner "BUILD" "Rebuilding frontend..."
    npm --prefix "$FRONTEND_DIR" run build
    success "Frontend built."
}

db_reset() {
    banner "DB" "Dropping and recreating schema (no data)..."
    rm -f "$DB_PATH"
    sqlite3 "$DB_PATH" < "$SCHEMA_SQL"
    success "Schema applied to $DB_PATH"
}

db_seed() {
    db_reset
    banner "DB" "Seeding database with test data..."
    sqlite3 "$DB_PATH" < "$DATA_SQL"
    success "Database seeded."
}

run_server() {
    local mode="${1:-debug}"
    if [[ "$mode" == "release" ]]; then
        banner "RUN" "Starting server in ${YELLOW}release${RESET} mode..."
        cargo run --release
    else
        banner "RUN" "Starting server in ${YELLOW}debug${RESET} mode..."
        cargo run
    fi
}

print_usage() {
    echo -e "
${BOLD}libreta.sh${RESET} — dev workflow shim for the libreta project

${BOLD}USAGE${RESET}
  ./libreta.sh <command> [options]

${BOLD}COMMANDS${RESET}
  ${CYAN}run${RESET}            Run the Rust server (no frontend rebuild)
  ${CYAN}serve${RESET}          Build frontend, then run the server
  ${CYAN}full${RESET}           Build frontend, seed DB fresh, then run the server

  ${CYAN}db reset${RESET}       Delete libreta.db and recreate schema (no data)
  ${CYAN}db seed${RESET}        Delete libreta.db, recreate schema, populate with test data

  ${CYAN}frontend dev${RESET}   Run the Vite dev server for hot-reload frontend work

${BOLD}OPTIONS${RESET}
  ${YELLOW}--release, -r${RESET}  Compile in release mode (applies to run, serve, full)
  ${YELLOW}--help, -h${RESET}     Show this help

${BOLD}EXAMPLES${RESET}
  ./libreta.sh run                # debug server, no build
  ./libreta.sh run --release      # release server, no build
  ./libreta.sh serve              # build frontend → debug server
  ./libreta.sh serve -r           # build frontend → release server
  ./libreta.sh full               # build frontend → seed DB → debug server
  ./libreta.sh db seed            # wipe DB, apply schema, load test data
  ./libreta.sh db reset           # wipe DB, apply schema only
  ./libreta.sh frontend dev       # Vite hot-reload dev server
"
}

# ---------------------------------------------------------------------------
# Argument parsing
# ---------------------------------------------------------------------------
COMMAND=""
SUBCOMMAND=""
MODE="debug"

for arg in "$@"; do
    case "$arg" in
        --release|-r) MODE="release" ;;
        --help|-h)    print_usage; exit 0 ;;
        -*)           err "Unknown flag: $arg" ;;
        *)
            if [[ -z "$COMMAND" ]]; then
                COMMAND="$arg"
            elif [[ -z "$SUBCOMMAND" ]]; then
                SUBCOMMAND="$arg"
            fi
            ;;
    esac
done

# ---------------------------------------------------------------------------
# Dispatch
# ---------------------------------------------------------------------------
preflight

case "$COMMAND" in
    run)
        run_server "$MODE"
        ;;
    serve)
        build_frontend
        run_server "$MODE"
        ;;
    full)
        build_frontend
        db_seed
        run_server "$MODE"
        ;;
    db)
        case "$SUBCOMMAND" in
            reset) db_reset ;;
            seed)  db_seed  ;;
            *)     err "Unknown db subcommand: '${SUBCOMMAND:-<none>}'. Use 'reset' or 'seed'." ;;
        esac
        ;;
    frontend)
        case "$SUBCOMMAND" in
            dev)
                banner "DEV" "Starting Vite dev server..."
                npm --prefix "$FRONTEND_DIR" run dev
                ;;
            *)  err "Unknown frontend subcommand: '${SUBCOMMAND:-<none>}'. Use 'dev'." ;;
        esac
        ;;
    "")
        print_usage
        exit 1
        ;;
    *)
        err "Unknown command: '$COMMAND'. Run './libreta.sh --help' for usage."
        ;;
esac

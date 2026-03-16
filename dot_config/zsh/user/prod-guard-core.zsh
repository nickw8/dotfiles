is_prod_target() {
  local candidate="${1:l}"
  local normalized exact token
  local -a tokens

  [[ -n "$candidate" ]] || return 1

  for exact in "${PROD_TARGET_NAMES[@]}"; do
    [[ "$candidate" == "${exact:l}" ]] && return 0
  done

  normalized="${candidate//[^[:alnum:]]/ }"
  tokens=(${=normalized})

  for token in "${tokens[@]}"; do
    (( ${PROD_TARGET_TOKENS[(Ie)$token]} )) && return 0
  done

  return 1
}

confirm_prod() {
  local target="$1"
  local typed

  echo
  print -P "%F{red}%BWARNING:%b%f production target detected: %F{yellow}${target}%f"
  echo -n "Type 'yes' to continue: "
  read -r typed </dev/tty || return 1

  [[ "$typed" == "yes" ]]
}

prod_guard_init_result() {
  typeset -gA PROD_GUARD_RESULT
  PROD_GUARD_RESULT=([cmd]="" [subcmd]="" [target]="" [summary]="" [skip]=0)
}

prod_guard_action_is_mutating() {
  local tool="$1"
  local cmd="${2:l}"
  local subcmd="${3:l}"
  local -a actions subactions

  actions=(${=PROD_MUTATING_ACTIONS[$tool]})
  (( ${actions[(Ie)$cmd]} )) && return 0

  subactions=(${=PROD_MUTATING_SUBACTIONS[$tool:$cmd]})
  (( ${subactions[(Ie)$subcmd]} )) && return 0

  return 1
}

prod_guard_maybe_confirm() {
  local tool="$1"
  local cmd="$2"
  local subcmd="$3"
  local target="$4"
  local summary="$5"
  local skip="${6:-0}"

  [[ "$skip" == "1" ]] && return 0
  prod_guard_action_is_mutating "$tool" "$cmd" "$subcmd" || return 0
  is_prod_target "$target" || return 0

  confirm_prod "$summary" || {
    echo "Cancelled."
    return 1
  }
}

prod_guard_run_wrapper() {
  local tool="$1"
  local real_bin="$2"
  local parser_fn="$3"
  shift 3

  [[ -n "$real_bin" ]] || return 127
  prod_guard_init_result
  "$parser_fn" "$real_bin" "$@" || return

  prod_guard_maybe_confirm \
    "$tool" \
    "$PROD_GUARD_RESULT[cmd]" \
    "$PROD_GUARD_RESULT[subcmd]" \
    "$PROD_GUARD_RESULT[target]" \
    "$PROD_GUARD_RESULT[summary]" \
    "$PROD_GUARD_RESULT[skip]" || return 1

  "$real_bin" "$@"
}

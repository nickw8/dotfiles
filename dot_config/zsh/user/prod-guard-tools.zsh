prod_guard_kubectl_is_dry_run() {
  local arg next_is_dry_run=false

  for arg in "$@"; do
    if $next_is_dry_run; then
      return 0
    fi

    case "$arg" in
      --dry-run)
        next_is_dry_run=true
        ;;
      --dry-run=*)
        return 0
        ;;
    esac
  done

  return 1
}

prod_guard_kubectl_current_context() {
  local real_kubectl="$1"
  shift

  "$real_kubectl" "$@" config current-context 2>/dev/null
}

prod_guard_parse_kubectl() {
  local real_kubectl="$1"
  shift

  local arg cmd="" subcmd="" ctx="" expect_value=false
  local -a global_args=()

  prod_guard_init_result

  for arg in "$@"; do
    if [[ -n "$cmd" ]]; then
      [[ -z "$subcmd" ]] && subcmd="$arg"
      break
    fi

    if $expect_value; then
      global_args+=("$arg")
      expect_value=false
      continue
    fi

    case "$arg" in
      --)
        break
        ;;
      --*=*)
        global_args+=("$arg")
        ;;
      -*)
        if (( ${KUBECTL_GLOBAL_FLAGS_WITH_VALUES[(Ie)$arg]} || ${KUBECTL_SHORT_FLAGS_WITH_VALUES[(Ie)$arg]} )); then
          expect_value=true
        fi
        global_args+=("$arg")
        ;;
      *)
        cmd="$arg"
        ;;
    esac
  done

  PROD_GUARD_RESULT[cmd]="$cmd"
  PROD_GUARD_RESULT[subcmd]="$subcmd"

  if ! prod_guard_action_is_mutating kubectl "$cmd" "$subcmd" || prod_guard_kubectl_is_dry_run "$@"; then
    PROD_GUARD_RESULT[skip]=1
    PROD_GUARD_RESULT[summary]="kubectl ${cmd:-command}"
    return 0
  fi

  ctx="$(prod_guard_kubectl_current_context "$real_kubectl" "${global_args[@]}")"
  PROD_GUARD_RESULT[target]="$ctx"
  PROD_GUARD_RESULT[summary]="kubectl ${cmd:-command} on context: ${ctx:-unknown}"
}

kubectl() {
  prod_guard_run_wrapper kubectl "${commands[kubectl]}" prod_guard_parse_kubectl "$@"
}

prod_guard_parse_terraform() {
  local real_terraform="$1"
  shift

  local arg cmd="" subcmd="" ws="" var_file="" next_flag_value=""

  prod_guard_init_result

  for arg in "$@"; do
    if [[ -n "$next_flag_value" ]]; then
      case "$next_flag_value" in
        -var-file)
          var_file="$arg"
          ;;
      esac

      next_flag_value=""
      continue
    fi

    case "$arg" in
      -chdir|-var-file)
        next_flag_value="$arg"
        continue
        ;;
      -var-file=*)
        var_file="${arg#-var-file=}"
        continue
        ;;
    esac

    if [[ -z "$cmd" && "$arg" != -* ]]; then
      cmd="$arg"
      continue
    fi

    if [[ -n "$cmd" && -z "$subcmd" && "$arg" != -* ]]; then
      subcmd="$arg"
    fi
  done

  PROD_GUARD_RESULT[cmd]="$cmd"
  PROD_GUARD_RESULT[subcmd]="$subcmd"

  if ! prod_guard_action_is_mutating terraform "$cmd" "$subcmd"; then
    PROD_GUARD_RESULT[skip]=1
    PROD_GUARD_RESULT[summary]="terraform ${cmd:-command}"
    return 0
  fi

  ws="$($real_terraform workspace show 2>/dev/null)"
  PROD_GUARD_RESULT[target]="${ws} ${var_file}"
  PROD_GUARD_RESULT[summary]="terraform ${cmd:-command} workspace=${ws:-unknown}${var_file:+ var-file=$var_file}"
}

terraform() {
  prod_guard_run_wrapper terraform "${commands[terraform]}" prod_guard_parse_terraform "$@"
}

prod_guard_parse_liquibase() {
  local _real_liquibase="$1"
  shift

  local arg cmd="" context="" url="" next_is_context=false next_is_url=false

  prod_guard_init_result

  for arg in "$@"; do
    if $next_is_context; then
      context="$arg"
      next_is_context=false
      continue
    fi

    if $next_is_url; then
      url="$arg"
      next_is_url=false
      continue
    fi

    case "$arg" in
      --contexts|--context-filter)
        next_is_context=true
        ;;
      --contexts=*|--context-filter=*)
        context="${arg#--contexts=}"
        context="${context#--context-filter=}"
        ;;
      --url)
        next_is_url=true
        ;;
      --url=*)
        url="${arg#--url=}"
        ;;
      *)
        if [[ -z "$cmd" ]]; then
          cmd="$arg"
        fi
        ;;
    esac
  done

  PROD_GUARD_RESULT[cmd]="$cmd"

  if ! prod_guard_action_is_mutating liquibase "$cmd" ""; then
    PROD_GUARD_RESULT[skip]=1
    PROD_GUARD_RESULT[summary]="liquibase ${cmd:-command}"
    return 0
  fi

  PROD_GUARD_RESULT[target]="${context} ${url}"
  PROD_GUARD_RESULT[summary]="liquibase ${cmd:-command} context=${context:-unknown}${url:+ ($url)}"
}

liquibase() {
  prod_guard_run_wrapper liquibase "${commands[liquibase]}" prod_guard_parse_liquibase "$@"
}

prod_guard_parse_ku() {
  local real_kubectl="$1"
  local cmd="$2"
  local overlay="$3"
  local ctx=""

  prod_guard_init_result
  PROD_GUARD_RESULT[cmd]="$cmd"

  if ! prod_guard_action_is_mutating ku "$cmd" ""; then
    PROD_GUARD_RESULT[skip]=1
    PROD_GUARD_RESULT[summary]="ku ${cmd:-command} overlay=$overlay"
    return 0
  fi

  ctx="$(prod_guard_kubectl_current_context "$real_kubectl")"
  PROD_GUARD_RESULT[target]="${overlay} ${ctx}"
  PROD_GUARD_RESULT[summary]="ku ${cmd:-command} overlay=$overlay${ctx:+ context=$ctx}"
}

ku() {
  local subcmd="${1:-}"
  local overlay="${2:-}"
  local real_kubectl="${commands[kubectl]}"

  if [[ -z "$subcmd" || -z "$overlay" ]]; then
    echo "Usage: ku {apply|diff|dry} <overlay-path>"
    return 2
  fi

  [[ -n "$real_kubectl" ]] || return 127

  prod_guard_parse_ku "$real_kubectl" "$subcmd" "$overlay" || return
  prod_guard_maybe_confirm \
    ku \
    "$PROD_GUARD_RESULT[cmd]" \
    "$PROD_GUARD_RESULT[subcmd]" \
    "$PROD_GUARD_RESULT[target]" \
    "$PROD_GUARD_RESULT[summary]" \
    "$PROD_GUARD_RESULT[skip]" || return 1

  local build=(kustomize build --enable-helm --load-restrictor=LoadRestrictionsNone "$overlay")

  case "$subcmd" in
    apply)
      "${build[@]}" | "$real_kubectl" apply -f -
      ;;
    diff)
      "${build[@]}" | kubectl diff -f -
      ;;
    dry)
      "${build[@]}" | "$real_kubectl" apply --dry-run=client -f -
      ;;
    *)
      echo "Unknown subcommand: $subcmd"
      echo "Usage: ku {apply|diff|dry} <overlay-path>"
      return 2
      ;;
  esac
}

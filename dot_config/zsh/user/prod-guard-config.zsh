# Shared prod-guard configuration.
# Add exact account/context/workspace names to PROD_TARGET_NAMES when they don't contain a prod token.

typeset -ga PROD_TARGET_TOKENS
(( ${#PROD_TARGET_TOKENS} )) || PROD_TARGET_TOKENS=(prod production prd live)

typeset -ga PROD_TARGET_NAMES
(( ${#PROD_TARGET_NAMES} )) || PROD_TARGET_NAMES=()

typeset -gA PROD_MUTATING_ACTIONS
(( ${#PROD_MUTATING_ACTIONS} )) || PROD_MUTATING_ACTIONS=(
  kubectl 'apply create delete replace patch scale annotate label edit expose autoscale cordon uncordon drain taint set'
  terraform 'apply destroy import taint untaint force-unlock'
  liquibase 'update update-count update-to-tag update-testing-rollback rollback rollback-count rollback-one-update rollback-to-date drop-all changelog-sync changelog-sync-to-tag clear-checksums mark-next-changeset-ran tag'
  ku 'apply'
)

typeset -gA PROD_MUTATING_SUBACTIONS
(( ${#PROD_MUTATING_SUBACTIONS} )) || PROD_MUTATING_SUBACTIONS=(
  'kubectl:rollout' 'restart pause resume undo'
  'terraform:state' 'mv rm push replace-provider'
  'terraform:workspace' 'new delete'
)

typeset -ga KUBECTL_GLOBAL_FLAGS_WITH_VALUES
(( ${#KUBECTL_GLOBAL_FLAGS_WITH_VALUES} )) || KUBECTL_GLOBAL_FLAGS_WITH_VALUES=(
  --as --as-group --as-uid --cache-dir --certificate-authority --client-certificate --client-key
  --cluster --context --kubeconfig --kuberc --namespace --password --profile --request-timeout
  --server --tls-server-name --token --user --username
)

typeset -ga KUBECTL_SHORT_FLAGS_WITH_VALUES
(( ${#KUBECTL_SHORT_FLAGS_WITH_VALUES} )) || KUBECTL_SHORT_FLAGS_WITH_VALUES=(-n -s -u)

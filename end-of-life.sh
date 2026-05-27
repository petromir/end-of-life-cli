#!/bin/bash

# end-of-life.sh - A wrapper for the endoflife.date API
# Usage: ./end-of-life.sh <command> [args]

set -o errexit
set -o nounset
set -o pipefail

readonly VERSION="1.0.0"
readonly ENDOFLIFE_API_VERSION="1.2.1"
readonly BASE_URL="https://endoflife.date/api/v1"
CURRENT_DATE=$(date +%Y-%m-%d)
readonly CURRENT_DATE

finish() {
  local result=$?
  # Cleanup code if needed
  exit "${result}"
}
trap finish EXIT ERR

usage() {
    cat <<EOF >&2
Usage: $(basename "$0") <command> [args]

Commands:
  -v, --version                  Show the version of the script.
  index                          List the main endoflife.date API endpoints.
  products                       List all products summary.
  products-full                  List all products with full details.
  product <product>              Get details for a specific product.
  product-release <product> <release>
                                 Get details for a specific product release.
  product-release-latest <product>
                                 Get the latest release for a product.
  categories                     List all categories.
  products-category <category>   List all products in a category.
  tags                           List all tags.
  products-tag <tag>             List all products with a tag.
  identifier-types               List all identifier types.
  identifier-by-type <type>      List all identifiers for a given type.
  product-has-expired <product> [release]
                                 Check if a product or specific release has expired.
                                 If release is provided and expired, prints date and exits 1.
                                 If no release is provided, lists all expired versions.
EOF
    exit 1
}

api_get() {
    local endpoint="${1}"
    curl --silent --location "${BASE_URL}${endpoint}"
}

product_has_expired() {
    local product="${1}"
    local release="${2:-}"

    if [[ -n "${release}" ]]; then
        # Check specific release
        local response
        response=$(api_get "/products/${product}/releases/${release}")
        local eol_from
        eol_from=$(echo "${response}" | jq -r '.result.eolFrom // empty')
        
        if [[ -z "${eol_from}" ]] || [[ "${eol_from}" == "null" ]]; then
            printf "No EOL date found for %s %s.\n" "${product}" "${release}"
            return 0
        fi

        if [[ "${eol_from}" < "${CURRENT_DATE}" ]]; then
            printf "[EXPIRED] %s %s (EOL: %s)\n" "${product}" "${release}" "${eol_from}"
            return 1
        else
            printf "%s %s has not expired (EOL: %s).\n" "${product}" "${release}" "${eol_from}"
            return 0
        fi
    else
        # List all expired versions
        local response
        response=$(api_get "/products/${product}")
        echo "${response}" | jq -r --arg current "${CURRENT_DATE}" --arg product "${product}" '
            .result.releases[] | 
            select(.eolFrom != null and .eolFrom != false and .eolFrom < $current) | 
            "[EXPIRED] \($product) \(.name) (EOL: \(.eolFrom))"
        '
    fi
}

if [[ "$#" -lt 1 ]]; then
    usage
fi

command="${1}"
shift

case "${command}" in
    -v|--version|version)
        printf "end-of-life-cli version %s\n" "${VERSION}"
        ;;
    index)
        api_get "/"
        ;;
    products)
        api_get "/products"
        ;;
    products-full)
        api_get "/products/full"
        ;;
    product)
        if [[ "$#" -lt 1 ]]; then usage; fi
        api_get "/products/${1}"
        ;;
    product-release)
        if [[ "$#" -lt 2 ]]; then usage; fi
        api_get "/products/${1}/releases/${2}"
        ;;
    product-release-latest)
        if [[ "$#" -lt 1 ]]; then usage; fi
        api_get "/products/${1}/releases/latest"
        ;;
    categories)
        api_get "/categories"
        ;;
    products-category)
        if [[ "$#" -lt 1 ]]; then usage; fi
        api_get "/categories/${1}"
        ;;
    tags)
        api_get "/tags"
        ;;
    products-tag)
        if [[ "$#" -lt 1 ]]; then usage; fi
        api_get "/tags/${1}"
        ;;
    identifier-types)
        api_get "/identifiers"
        ;;
    identifier-by-type)
        if [[ "$#" -lt 1 ]]; then usage; fi
        api_get "/identifiers/${1}"
        ;;
    product-has-expired)
        if [[ "$#" -lt 1 ]]; then usage; fi
        if ! product_has_expired "${1}" "${2:-}"; then
            exit 1
        fi
        ;;
    *)
        printf "Error: Unknown command: %s\n" "${command}" >&2
        if [[ "$#" -ge 1 ]]; then
            printf "Maybe you meant: product-release %s %s?\n" "${command}" "${1}" >&2
        else
            printf "Maybe you meant: product %s?\n" "${command}" >&2
        fi
        printf "\n" >&2
        usage
        ;;
esac

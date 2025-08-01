#!/bin/bash

set -e  # Exit on any error

ERRORS=0

run_command() {
	if [ "$LINT_MODE" = "STRICT" ]; then
			"$@" || ERRORS=$((ERRORS + 1))
	else
			"$@"
	fi
}

echo "LintMode: $LINT_MODE"

# More portable way to get script directory
if [ -z "$SRCROOT" ]; then
    SCRIPT_DIR=$(dirname "$(readlink -f "$0")")
    PACKAGE_DIR="${SCRIPT_DIR}/.."
else
    PACKAGE_DIR="${SRCROOT}"     
fi

# Detect OS and set paths accordingly
if [ "$(uname)" = "Darwin" ]; then
    DEFAULT_MINT_PATH="/opt/homebrew/bin/mint"
elif [ "$(uname)" = "Linux" ] && [ -n "$GITHUB_ACTIONS" ]; then
    DEFAULT_MINT_PATH="$GITHUB_WORKSPACE/Mint/.mint/bin/mint"
elif [ "$(uname)" = "Linux" ]; then
    DEFAULT_MINT_PATH="/usr/local/bin/mint"
else
    echo "Unsupported operating system"
    exit 1
fi

# Use environment MINT_CMD if set, otherwise use default path
MINT_CMD=${MINT_CMD:-$DEFAULT_MINT_PATH}

export MINT_PATH="$PACKAGE_DIR/.mint"
MINT_ARGS="-n -m $PACKAGE_DIR/Mintfile --silent"
MINT_RUN="$MINT_CMD run $MINT_ARGS"

if [ "$LINT_MODE" = "NONE" ]; then
	exit
elif [ "$LINT_MODE" = "STRICT" ]; then
	SWIFTFORMAT_OPTIONS="--strict --configuration .swift-format"
	SWIFTLINT_OPTIONS="--strict"
else 
	SWIFTFORMAT_OPTIONS="--configuration .swift-format"
	SWIFTLINT_OPTIONS=""
fi

pushd $PACKAGE_DIR
run_command $MINT_CMD bootstrap -m Mintfile

if [ "$LINT_MODE" = "INSTALL" ]; then
	exit
fi

if [ -z "$CI" ]; then
	run_command $MINT_RUN swift-format format $SWIFTFORMAT_OPTIONS  --recursive --parallel --in-place Sources Tests
	run_command $MINT_RUN swiftlint --fix
fi

if [ -z "$FORMAT_ONLY" ]; then
    run_command $MINT_RUN swift-format lint --configuration .swift-format --recursive --parallel $SWIFTFORMAT_OPTIONS Sources Tests || exit 1
    run_command $MINT_RUN swiftlint lint $SWIFTLINT_OPTIONS || exit 1
fi

$PACKAGE_DIR/Scripts/header.sh -d  $PACKAGE_DIR/Sources -c "Leo Dion" -o "BrightDigit" -p "SyndiKit"

run_command $MINT_RUN swiftlint lint $SWIFTLINT_OPTIONS

run_command $MINT_RUN swift-format lint --recursive --parallel $SWIFTFORMAT_OPTIONS Sources Tests
#$MINT_RUN periphery scan $PERIPHERY_OPTIONS --disable-update-check

popd

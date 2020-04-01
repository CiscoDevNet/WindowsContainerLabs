#!/usr/bin/env bash

unset CDPATH

EXECUTOR_FILE_NAME="tool-executor.jar"
EXECUTOR_SUB_DIR="tool"
SCRIPT_FILE_NAME="$0"

# SCRIPT may be an arbitrarily deep series of symlinks. Loop until we have the concrete path.
while [ -h "$SCRIPT_FILE_NAME" ] ; do
    ls=`ls -ld "$SCRIPT_FILE_NAME"`
    # Drop everything prior to ->
    link=`expr "$ls" : '.*-> \(.*\)$'`
    if expr "$link" : '/.*' > /dev/null; then
        SCRIPT_FILE_NAME="$link"
    else
        SCRIPT_FILE_NAME=`dirname "$SCRIPT_FILE_NAME"`/"$link"
    fi
done

# Determine home absolute path
SCRIPT_HOME=`dirname "$SCRIPT_FILE_NAME"`
SCRIPT_HOME=`cd "$SCRIPT_HOME"; pwd`
DRY_RUN_MARKER="|"

# This is to avoid following symlinks.
pushd $SCRIPT_HOME
cd ..
export APPLICATION_HOME=$(pwd)
popd

execute() {
    if  [[ $1 == "start" ]];
    then
        # If start command, then run it in dry run mode and get the arguments from the executor.
        # We will then execute the program directly using exec and avoid the need for the executor
        # JVM from lingering.

        DRY_RUN_STR=$("$JAVA_CMD" -jar "$SCRIPT_HOME"/"$EXECUTOR_SUB_DIR"/"$EXECUTOR_FILE_NAME" "$@" -dr "$DRY_RUN_MARKER"  2>&1 \
        		  | if [ -w /dev/stderr ] ; then tee /dev/stderr ; else cat - ; fi \
        		  | awk -v marker=$DRY_RUN_MARKER -F${DRY_RUN_MARKER} '{for (i = 2; i <= NF; i++) { printf("%s%s", $i, marker) } }'
        )
        if [[ ! -z $DRY_RUN_STR ]];
        then
        	ORIG_IFS=$IFS
        	IFS=$DRY_RUN_MARKER
        	DRY_RUN_ARRAY=($DRY_RUN_STR)
        	IFS=$ORIG_IFS
        	echo ""
        	eval exec "$JAVA_CMD" "${DRY_RUN_ARRAY[@]}"
        fi
        exit 1
    else
        exec "$JAVA_CMD" -jar "$SCRIPT_HOME"/"$EXECUTOR_SUB_DIR"/"$EXECUTOR_FILE_NAME" "$@"
    fi
}
setJavaCmd () {
    [ "$JAVA_HOME" ] || JAVA_CMD=$(which java)
    [ "$JAVA_HOME" ] && [ -x "$JAVA_HOME/bin/java" ] && JAVA_CMD="$JAVA_HOME/bin/java"
}

setJavaCmd
[ "$JAVA_CMD" ] && execute $@
echo "Please set JAVA_HOME env variable"
exit 1

#!/usr/bin/env bash

JQ_FILTER='select(has("OverviewOpenedOrClosed")).OverviewOpenedOrClosed.is_open'

while IFS= read -r overview; do
    if [[ "$overview" == "true" ]]; then
        qs ipc call root showDock
    elif [[ "$overview" == "false" ]]; then
        qs ipc call root hideDock
    fi
done < <(niri msg --json event-stream |
     jq --unbuffered --raw-output "$JQ_FILTER")

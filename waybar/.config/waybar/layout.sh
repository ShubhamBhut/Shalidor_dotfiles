#!/usr/bin/env bash

hyprctl -j activeworkspace | python3 -c '
import json, sys

workspace = json.load(sys.stdin)
layout = workspace.get("tiledLayout", "unknown").lower()

labels = {
    "dwindle": "󰙀 DWINDLE",
    "master": "󰕰 MASTER",
    "scrolling": "󰖯 SCROLLING",
    "monocle": "󰊓 MONOCLE",
}

label = labels.get(layout, "󰘔 UNKNOWN")

print(json.dumps({
    "text": label,
    "tooltip": "Current layout: " + label
}))
'

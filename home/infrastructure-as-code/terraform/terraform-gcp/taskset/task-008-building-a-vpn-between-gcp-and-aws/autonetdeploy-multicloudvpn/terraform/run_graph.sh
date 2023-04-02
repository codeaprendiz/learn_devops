#!/bin/bash


# Run Terraform graph command with some color-formatting and emit a png.
# terraform graph -type plan | dot -Tpng > graph.png
#
# Useful graphviz links:
# graphviz docs: http://www.graphviz.org/doc/info/attrs.html
# graphviz colors: http://www.graphviz.org/doc/info/colors.html
# webgraphviz viewer: http://www.webgraphviz.com


function runGraph() {
  local THIS_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
  local T_CMD="terraform graph -type plan"
  local D_CMD='dot -Tpng'
  local SED_EX1='s/\[root\] //g'
  local SED_EX2='/.*aws.*shape = "box"/ s/shape = "box"/shape = "box", style = "filled", fillcolor = "coral"/'
  local SED_EX3='/.*google.*shape = "box"/ s/shape = "box"/shape = "box", style = "filled", fillcolor = "deepskyblue"/'
  local SED_EX4='s/shape = "diamond"/shape = "diamond", style = "filled", fillcolor = "aquamarine"/'
  local OUT_FILE="${THIS_DIR}/gcpawsvpn_plan_graph.png"

  if [ -e ${OUT_FILE} ]; then
    echo "${OUT_FILE} already exists. Exiting."
    exit 1
  fi

  ${T_CMD} | sed -e "${SED_EX1}" -e "${SED_EX2}" -e "${SED_EX3}" \
             -e "${SED_EX4}" | ${D_CMD} > ${OUT_FILE}
  echo "Wrote ${OUT_FILE}."
}

runGraph

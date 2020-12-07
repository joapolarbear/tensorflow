#!/bin/bash

RED='\033[0;31m'
NC='\033[0m'
GREEN='\033[0;32m'

BYTEPROFILE_TOOL_PREFIX="//tensorflow/compiler/byteprofile_xlatools"

declare -a BPF_TARGETS=("byteprofile_xlatools_c_api.so" 
                       "tfcompile_hlo"
                       "extract_cycles")

TF_XLA_TOOLS_PREFIX="//tensorflow/compiler/xla/tools"

declare -a TF_XLA_TOOL_TARGETS=("extract_features_from_hlo" 
                       "replay_computation_gpu")

bpf_failure_counter=0

for i in ${!BPF_TARGETS[@]}; do
    target=${BPF_TARGETS[$i]}
    if bazel build ${BYTEPROFILE_TOOL_PREFIX}/${target};
    then
        echo -e "${GREEN}[$((i+1)) / ${#BPF_TARGETS[@]}]${NC} target ${target} built successfully."
    else
        bpf_failure_counter=$((bpf_failure_counter+1))
        echo -e "${RED}[$((i+1))  / ${#BPF_TARGETS[@]}]${NC} Failed to build target ${target}."
    fi
done

if [ $bpf_failure_counter -ne 0 ];
then
    echo -e "Failed to build ${RED}${bpf_failure_counter}${NC} out of ${#BPF_TARGETS[@]} targets in ${BYTEPROFILE_TOOL_PREFIX} ."
fi

bpf_failure_counter=0

for i in ${!TF_XLA_TOOL_TARGETS[@]}; do
    target=${TF_XLA_TOOL_TARGETS[$i]}
    if bazel build ${TF_XLA_TOOLS_PREFIX}/${target};
    then
        echo -e "${GREEN}[$((i+1))  / ${#TF_XLA_TOOL_TARGETS[@]}]${NC} target ${target} built successfully."
    else
        bpf_failure_counter=$((bpf_failure_counter+1))
        echo -e "${RED}[$((i+1))  / ${#TF_XLA_TOOL_TARGETS[@]}]${NC} Failed to build target ${target}."
    fi
done

if [ $bpf_failure_counter -ne 0 ];
then
    echo -e "Failed to build ${RED}${bpf_failure_counter}${NC} out of ${#BPF_TARGETS[@]} targets in ${TF_XLA_TOOLS_PREFIX} ."
fi

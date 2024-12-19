#!/bin/sh

CPU_STR=$(sensors | grep "Package id 0:" | tr -d '+C' | awk '{print $4}')
CPU=${CPU_STR::-3}
NVME_STR=$(sensors | grep "Composite:" | tr -d '+C' | awk '{print $2}')
NVME=${NVME_STR::-3}

if [[ "${CPU}" -gt 90 ]]; then
    CPU_CLR="%{F#e60053}"
elif [[ "${CPU}" -gt 75 ]]; then
    CPU_CLR="%{F#e60053}"
elif [[ "${CPU}" -gt 60 ]]; then
    CPU_CLR="%{F#f9e2af}"
elif [[ "${CPU}" -gt 50 ]]; then
    CPU_CLR="%{F#f9e2af}"
elif [[ "${CPU}" -le 50 ]]; then
    CPU_CLR="%{F#95cae3}"
fi

if [[ "${NVME}" -gt 90 ]]; then
    NVME_CLR="%{F#e60053}"
elif [[ "${NVME}" -gt 75 ]]; then
    NVME_CLR="%{F#e60053}"
elif [[ "${NVME}" -gt 60 ]]; then
    NVME_CLR="%{F#f9e2af}"
elif [[ "${NVME}" -gt 50 ]]; then
    NVME_CLR="%{F#f9e2af}"
elif [[ "${NVME}" -le 50 ]]; then
    NVME_CLR="%{F#95cae3}"
fi

echo "%{F#6b6b6b} %{F-}$CPU_CLR$CPU°%{F-}  %{F#6b6b6b} %{F-}$NVME_CLR$NVME°%{F-}"

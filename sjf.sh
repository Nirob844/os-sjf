echo -n "Enter the number of processes: "
read N

BurstTime=()
WaitingTime=()
TurnAroundTime=()
ProcessId=()

for i in $(seq 1 1 $N); do
    echo -n "Process $i burst time: "
    read B
    BurstTime+=($B)
    ProcessId+=($i)
done

# Bubble Sort for BurstTime
for ((i = 0; i < $N - 1; i++)); do
    for ((j = 0; j < $N - i - 1; j++)); do
        if [ ${BurstTime[j]} -gt ${BurstTime[$((j + 1))]} ]; then
            # Swap
            temp=${BurstTime[j]}
            BurstTime[j]=${BurstTime[$((j + 1))]}
            BurstTime[$((j + 1))]=$temp

            temp=${ProcessId[j]}
            ProcessId[j]=${ProcessId[$((j + 1))]}
            ProcessId[$((j + 1))]=$temp
        fi
    done
done
# Print the sorted values
echo "Sorted BurstTime:"
echo "${BurstTime[@]}"

echo "Sorted ProcessId:"
echo "${ProcessId[@]}"

WaitingTime[0]=0
TurnAroundTime[0]=${BurstTime[0]}
TotalWaitingTime=0
TotalTrunAroundTime=${TurnAroundTime[0]}

for i in $(seq 1 1 $((N-1))); do
    WaitingTime[$i]=$((${WaitingTime[$((i - 1))]} + ${BurstTime[$((i - 1))]}))
    TurnAroundTime[$i]=$((${WaitingTime[$i]} + ${BurstTime[$i]}))

    TotalWaitingTime=$((TotalWaitingTime + ${WaitingTime[$i]}))
    TotalTrunAroundTime=$((TotalTrunAroundTime + ${TurnAroundTime[$i]}))
done

AvgWaitingTime=$((TotalWaitingTime / $N))
AvgTurnAroundTime=$((TotalTrunAroundTime / $N))

echo AverageWaitingTime : $AvgWaitingTime
echo AverageTurnAroundTime : $AvgTurnAroundTime

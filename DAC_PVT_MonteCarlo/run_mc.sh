#!/bin/bash

echo "run,I00,I01,I10,I11" > mc_results.txt

for i in {1..200}
do
    echo "Running $i/200..."

    result=$(ngspice -b mc_dac.spice 2>&1)

    i00=$(echo "$result" | awk '/^i00[[:space:]]*=/{print $3}')
    i01=$(echo "$result" | awk '/^i01[[:space:]]*=/{print $3}')
    i10=$(echo "$result" | awk '/^i10[[:space:]]*=/{print $3}')
    i11=$(echo "$result" | awk '/^i11[[:space:]]*=/{print $3}')

    echo "$i,$i00,$i01,$i10,$i11" >> mc_results.txt
done

echo "Monte Carlo completed."

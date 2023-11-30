#!/bin/bash

while read aLine ; do
    if [[ -z ${aLine} ]] || [[ ${aLine} = "#"* ]] ; then
        continue
    fi
    ID=$(echo $aLine | awk '{print $1}')
    IMAGE=$(echo $aLine | awk '{print $2}')
    INPUT=$(echo $aLine | awk '{print $3}')
    RMS=$(echo $aLine | awk '{print $4}')
    MASK=$(echo $aLine | awk '{print $5}')
    PSF=$(echo $aLine | awk '{print $6}')
    OUTPUT=$(echo $aLine | awk '{print $7}')
    PA=$(echo $aLine | awk '{print $8}')
    R_E=$(echo $aLine | awk '{print $9}')
    n=$(echo $aLine | awk '{print $10}')
    q=$(echo $aLine | awk '{print $11}')
    mag=$(echo $aLine | awk '{print $14}')
    echo "ID: $ID"
    echo "R_e: $R_E"
    echo "aLine: $aLine"
    echo "mag: $mag"    
    cat ./dummy_sersic.feedme | sed  "s@AAAAA@${IMAGE}@" | sed  "s@BBBBB@${OUTPUT}@" | sed  "s@CCCCC@${RMS}@" | sed  "s@DDDDD@${PSF}@"| sed  "s@FFFFF@${MASK}@"| sed  "s@TMTMTM@${mag}@"  | sed  "s@PAPAPAP@${PA}@" |sed  "s@RRRRR@${R_E}@" |sed  "s@NNNNN@${n}@" | sed  "s@XXXXX@${q}@" > ${INPUT}
    
    echo "Generated input file: ${INPUT}"
    
    ./galfit  ${INPUT}
    
    echo "Finished running galfit for ID: $ID"
    echo "Output: $OUTPUT"
    
done < inputdata_ofg.txt



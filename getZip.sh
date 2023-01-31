#echo "Start date: "
#read $1
#echo "End date: "
#read $2
if [ -d "Users/ttierney/Code/entity-viewer/data" ]
then
    cd data
else
    mkdir data
    cd data
fi
STARTYEAR="${1:0:4}"
CURRYEAR=$STARTYEAR
ENDYEAR="${2:0:4}"
STARTMON="${1:4:2}"
ENDMON="${2:4:2}"
while [ $CURRYEAR -le $ENDYEAR ] #year
do
    if [ $STARTYEAR -eq $ENDYEAR ]
    then
        MONLOOP=$( eval echo {$STARTMON..$ENDMON} )
    elif [ $CURRYEAR -eq $STARTYEAR ]
    then
        MONLOOP=$( eval echo {$STARTMON..12} )
    elif [ $CURRYEAR -eq $ENDYEAR ]
    then
        MONLOOP=$( eval echo {01..$ENDMON} )
    else
        MONLOOP=$( eval echo {01..12} )
    fi

    for i in $MONLOOP #month
    do
        if [ $ENDMON -eq $i ] && [ $CURRYEAR -eq $ENDYEAR ]
        then 
            ENDDAY="${2:6:2}"
        elif [ $i -eq 1 ] || [ $i -eq 3 ] || [ $i -eq 5 ] || [ $i -eq 7 ] || [ $i  -eq 8 ] || [ $i -eq 10 ] || [ $i -eq 12 ]
        then
            ENDDAY=31
        elif [ $i -eq 4 ] || [ $i -eq 6 ] || [ $i -eq 9 ] || [ $i -eq 11 ]
        then
            ENDDAY=30
        else
            ENDDAY=28
        fi
        
        if [ $STARTMON -eq $i ] && [ $CURRYEAR -eq $STARTYEAR ]
        then
            STARTDAY="${1:6:2}"
        else
            STARTDAY=01
        fi

        if [ $i -lt 10 ]
        then
            FM="0"
        else
            FM=""
        fi

        for j in $( eval echo {$STARTDAY..$ENDDAY} ) #day
        do
            if [ $j -lt 10 ]
            then 
                FD="0"
            else
                FD=""
            fi
            for k in 00 03 06 09 12 15 18 21
            do
                curl -LO http://data.gdeltproject.org/gdeltv2/"$CURRYEAR$FM$i$FD$j$k"0000.export.CSV.zip --output 2022"$CURRYEAR$FM$i$FD$j$k"00.export.CSV.zip
                unzip /Users/ttierney/Code/entity-viewer/data/"$CURRYEAR$FM$i$FD$j$k"0000.export.CSV.ZIP
                rm /Users/ttierney/Code/entity-viewer/data/"$CURRYEAR$FM$i$FD$j$k"0000.export.CSV.ZIP
            done
        done
    done
    ((CURRYEAR++))
done
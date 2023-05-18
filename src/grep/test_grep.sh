#!/bin/bash

SUCCESSFUL_TESTS=0
FAILED_TESTS=0
TEXTFILE1="text1.txt"
TEXTFILE2="text2.txt"
PATTERNFILE="patterns.txt"
MYUTIL="./s21_grep"
STDUTIL="grep"
MYUTIL_OUTPUT="s21grep_output.txt"
STDUTIL_OUTPUT="grep_output.txt"
PATTERN1="dolor"
PATTERN2="dorem"
LOG="log"
# date >  $LOG

for flag1 in  -v -c -l -n -h -s -i
do
    TEST1="$flag1 $PATTERN1 $TEXTFILE1"
    echo "$TEST1"
    $MYUTIL $TEST1 > $MYUTIL_OUTPUT
    $STDUTIL $TEST1 > $STDUTIL_OUTPUT
    DIFF_RESULT="$(diff $MYUTIL_OUTPUT $STDUTIL_OUTPUT)"
    if [ "$DIFF_RESULT" == "" ]
        then
            (( SUCCESSFUL_TESTS++ ))
        else
            echo "$TEST1" >>  $LOG
            (( FAILED_TESTS++ ))
    fi
    rm $MYUTIL_OUTPUT $STDUTIL_OUTPUT

    TEST2="$flag1 -e $PATTERN1 -e $STDUTIL $TEXTFILE1"
    echo "$TEST2"
    $MYUTIL $TEST2 > $MYUTIL_OUTPUT
    $STDUTIL $TEST2 > $STDUTIL_OUTPUT
    DIFF_RESULT="$(diff $MYUTIL_OUTPUT $STDUTIL_OUTPUT)"
    if [ "$DIFF_RESULT" == "" ]
        then
            (( SUCCESSFUL_TESTS++ ))
        else
            echo "$TEST2" >>  $LOG
            (( FAILED_TESTS++ ))
    fi
    rm $MYUTIL_OUTPUT $STDUTIL_OUTPUT

    TEST3="$flag1 -f $PATTERNFILE $TEXTFILE1"
    echo "$TEST3"
    $MYUTIL $TEST3 > $MYUTIL_OUTPUT
    $STDUTIL $TEST3 > $STDUTIL_OUTPUT
    DIFF_RESULT="$(diff $MYUTIL_OUTPUT $STDUTIL_OUTPUT)"
    if [ "$DIFF_RESULT" == "" ]
        then
            (( SUCCESSFUL_TESTS++ ))
        else
            echo "$TEST3" >>  $LOG
            (( FAILED_TESTS++ ))
    fi
    rm $MYUTIL_OUTPUT $STDUTIL_OUTPUT

    TEST4="$flag1 $PATTERN1 $TEXTFILE1 $TEXTFILE2"
    echo "$TEST4"
    $MYUTIL $TEST4 > $MYUTIL_OUTPUT
    $STDUTIL $TEST4 > $STDUTIL_OUTPUT
    DIFF_RESULT="$(diff $MYUTIL_OUTPUT $STDUTIL_OUTPUT)"
    if [ "$DIFF_RESULT" == "" ]
        then
            (( SUCCESSFUL_TESTS++ ))
        else
            echo "$TEST4" >>  $LOG
            (( FAILED_TESTS++ ))
    fi
    rm $MYUTIL_OUTPUT $STDUTIL_OUTPUT

    TEST5="$flag1 -e $PATTERN1 -e $STDUTIL $TEXTFILE1 $TEXTFILE2"
    echo "$TEST5"
    $MYUTIL $TEST5 > $MYUTIL_OUTPUT
    $STDUTIL $TEST5 > $STDUTIL_OUTPUT
    DIFF_RESULT="$(diff $MYUTIL_OUTPUT $STDUTIL_OUTPUT)"
    if [ "$DIFF_RESULT" == "" ]
        then
            (( SUCCESSFUL_TESTS++ ))
        else
            echo "$TEST5" >>  $LOG
            (( FAILED_TESTS++ ))
    fi
    rm $MYUTIL_OUTPUT $STDUTIL_OUTPUT

    TEST6="$flag1 -f $PATTERNFILE $TEXTFILE1 $TEXTFILE2"
    echo "$TEST6"
    $MYUTIL $TEST6 > $MYUTIL_OUTPUT
    $STDUTIL $TEST6 > $STDUTIL_OUTPUT
    DIFF_RESULT="$(diff $MYUTIL_OUTPUT $STDUTIL_OUTPUT)"
    if [ "$DIFF_RESULT" == "" ]
        then
            (( SUCCESSFUL_TESTS++ ))
        else
            echo "$TEST6" >>  $LOG
            (( FAILED_TESTS++ ))
    fi
    rm $MYUTIL_OUTPUT $STDUTIL_OUTPUT

    # -e and -f combination

    TEST7="$flag1 -e $PATTERN2 -f $PATTERNFILE $TEXTFILE1 $TEXTFILE2"
    echo "$TEST7"
    $MYUTIL $TEST7 > $MYUTIL_OUTPUT
    $STDUTIL $TEST7 > $STDUTIL_OUTPUT
    DIFF_RESULT="$(diff $MYUTIL_OUTPUT $STDUTIL_OUTPUT)"
    if [ "$DIFF_RESULT" == "" ]
        then
            (( SUCCESSFUL_TESTS++ ))
        else
            echo "$TEST7" >>  $LOG
            (( FAILED_TESTS++ ))
    fi
    rm $MYUTIL_OUTPUT $STDUTIL_OUTPUT

done

for flag1 in -v -l -n -h -s -i 
do
    for flag2 in -v -l -n -h -s -i
    do
        if [ $flag1 != $flag2 ]
        then
            TEST1="$flag1 $flag2 $PATTERN1 $TEXTFILE1"
            echo "$TEST1"
            $MYUTIL $TEST1 > $MYUTIL_OUTPUT
            $STDUTIL $TEST1 > $STDUTIL_OUTPUT
            DIFF_RESULT="$(diff $MYUTIL_OUTPUT $STDUTIL_OUTPUT)"
            if [ "$DIFF_RESULT" == "" ]
                then
                    (( SUCCESSFUL_TESTS++ ))
                else
                    echo "$TEST1" >>  $LOG
                    (( FAILED_TESTS++ ))
            fi
            rm $MYUTIL_OUTPUT $STDUTIL_OUTPUT

            TEST2="$flag1 $flag2 -e $PATTERN1 -e $STDUTIL $TEXTFILE1"
            echo "$TEST2"
            $MYUTIL $TEST2 > $MYUTIL_OUTPUT
            $STDUTIL $TEST2 > $STDUTIL_OUTPUT
            DIFF_RESULT="$(diff $MYUTIL_OUTPUT $STDUTIL_OUTPUT)"
            if [ "$DIFF_RESULT" == "" ]
                then
                    (( SUCCESSFUL_TESTS++ ))
                else
                    echo "$TEST2" >>  $LOG
                    (( FAILED_TESTS++ ))
            fi
            rm $MYUTIL_OUTPUT $STDUTIL_OUTPUT

            TEST3="$flag1 $flag2 -f $PATTERNFILE $TEXTFILE1"
            echo "$TEST3"
            $MYUTIL $TEST3 > $MYUTIL_OUTPUT
            $STDUTIL $TEST3 > $STDUTIL_OUTPUT
            DIFF_RESULT="$(diff $MYUTIL_OUTPUT $STDUTIL_OUTPUT)"
            if [ "$DIFF_RESULT" == "" ]
                then
                    (( SUCCESSFUL_TESTS++ ))
                else
                    echo "$TEST3" >>  $LOG
                    (( FAILED_TESTS++ ))
            fi
            rm $MYUTIL_OUTPUT $STDUTIL_OUTPUT


            # SAME 3 TEST WITH 2 FILES

            TEST4="$flag1 $flag2 $PATTERN1 $TEXTFILE1 $TEXTFILE2"
            echo "$TEST4"
            $MYUTIL $TEST4 > $MYUTIL_OUTPUT
            $STDUTIL $TEST4 > $STDUTIL_OUTPUT
            DIFF_RESULT="$(diff $MYUTIL_OUTPUT $STDUTIL_OUTPUT)"
            if [ "$DIFF_RESULT" == "" ]
                then
                    (( SUCCESSFUL_TESTS++ ))
                else
                    echo "$TEST4" >>  $LOG
                    (( FAILED_TESTS++ ))
            fi
            rm $MYUTIL_OUTPUT $STDUTIL_OUTPUT

            TEST5="$flag1 $flag2 -e $PATTERN1 -e $STDUTIL $TEXTFILE1 $TEXTFILE2"
            echo "$TEST5"
            $MYUTIL $TEST5 > $MYUTIL_OUTPUT
            $STDUTIL $TEST5 > $STDUTIL_OUTPUT
            DIFF_RESULT="$(diff $MYUTIL_OUTPUT $STDUTIL_OUTPUT)"
            if [ "$DIFF_RESULT" == "" ]
                then
                    (( SUCCESSFUL_TESTS++ ))
                else
                    echo "$TEST5" >>  $LOG
                    (( FAILED_TESTS++ ))
            fi
            rm $MYUTIL_OUTPUT $STDUTIL_OUTPUT

            TEST6="$flag1 $flag2 -f $PATTERNFILE $TEXTFILE1 $TEXTFILE2"
            echo "$TEST6"
            $MYUTIL $TEST6 > $MYUTIL_OUTPUT
            $STDUTIL $TEST6 > $STDUTIL_OUTPUT
            DIFF_RESULT="$(diff $MYUTIL_OUTPUT $STDUTIL_OUTPUT)"
            if [ "$DIFF_RESULT" == "" ]
                then
                    (( SUCCESSFUL_TESTS++ ))
                else
                    echo "$TEST6" >>  $LOG
                    (( FAILED_TESTS++ ))
            fi
            rm $MYUTIL_OUTPUT $STDUTIL_OUTPUT

            # -e and -f combination

            TEST7="$flag1 $flag2 -e $PATTERN2 -f $PATTERNFILE $TEXTFILE1 $TEXTFILE2"
            echo "$TEST7"
            $MYUTIL $TEST7 > $MYUTIL_OUTPUT
            $STDUTIL $TEST7 > $STDUTIL_OUTPUT
            DIFF_RESULT="$(diff $MYUTIL_OUTPUT $STDUTIL_OUTPUT)"
            if [ "$DIFF_RESULT" == "" ]
                then
                    (( SUCCESSFUL_TESTS++ ))
                else
                    echo "$TEST7" >>  $LOG
                    (( FAILED_TESTS++ ))
            fi
            rm $MYUTIL_OUTPUT $STDUTIL_OUTPUT
        fi
    done
done

echo "SUCCESSFUL TEST:  $SUCCESSFUL_TESTS"
echo "FAILED TEST:      $FAILED_TESTS"

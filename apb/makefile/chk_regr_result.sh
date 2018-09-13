#!/bin/bash

HAS_UVM_ERROR=""
HAS_UVM_FATAL=""
HAS_ASSERT=""
HAS_COMPILE_ERROR=""

total_num_of_tests=0
total_num_of_fails=0

test_name=""
seed_numb="unknown"

list_of_pass_tests=""
list_of_fail_tests=""

#New line "character"
NL=$'\n'

for dir in $1/runs/*;
  do
    ((total_num_of_tests++))
    test_name=`ls $dir/irun.log | sed 's/^.*regr_//' | sed 's/_run.*$//'`
    seed_numb=`ls $dir/irun.log | sed 's/^.*seed_//' | sed 's/\/irun.*$//'`

    HAS_UVM_ERROR=`grep UVM_ERROR $dir/irun.log | grep -v "UVM_ERROR reports" | grep -v -m 1 "UVM_ERROR :"`
    HAS_UVM_FATAL=`grep UVM_FATAL $dir/irun.log | grep -v "UVM_FATAL reports" | grep -v -m 1 "UVM_FATAL :"`
    HAS_ASSERT=`grep -m 1 "*E,ASRTST" $dir/irun.log`
    HAS_COMPILE_ERROR=`grep "ncvlog: " $dir/irun.log | grep -m 1 "*E"`
    HAS_COMPILE_ERROR+=`grep "irun: " $dir/irun.log | grep -m 1 "*E"`

    if [ "$HAS_COMPILE_ERROR" != "" ]
    then
      ((total_num_of_fails++))
      list_of_fail_tests+="${NL} TEST_NAME   : ${test_name}${NL} SEED        : unknown${NL} STATUS      : FAILED${NL} FIRST_ERROR : ${HAS_COMPILE_ERROR}${NL}"
    elif [ "$HAS_UVM_FATAL" != "" ]
    then
      ((total_num_of_fails++))
      list_of_fail_tests+="${NL} TEST_NAME   : ${test_name}${NL} SEED        : ${seed_numb}${NL} STATUS      : FAILED${NL} FIRST_ERROR : ${HAS_UVM_FATAL}${NL}"
    elif [ "$HAS_ASSERT" != "" ]
    then
      ((total_num_of_fails++))
      list_of_fail_tests+="${NL} TEST_NAME   : ${test_name}${NL} SEED        : ${seed_numb}${NL} STATUS      : FAILED${NL} FIRST_ERROR : ${HAS_ASSERT}${NL}"
    elif [ "$HAS_UVM_ERROR" != "" ]
    then
      ((total_num_of_fails++))
      list_of_fail_tests+="${NL} TEST_NAME   : ${test_name}${NL} SEED        : ${seed_numb}${NL} STATUS      : FAILED${NL} FIRST_ERROR : ${HAS_UVM_ERROR}${NL}"
    else
      list_of_pass_tests+="${NL} TEST_NAME   : ${test_name}${NL} SEED        : ${seed_numb}${NL} STATUS      : PASSED${NL}"
    fi
  done

echo "----------------------------------------------"                                      | tee    $1/regression_result.log
echo " REGRESSION RESULT:"                                                                 | tee -a $1/regression_result.log
echo "----------------------------------------------"                                      | tee -a $1/regression_result.log
echo " Total number of tests  : $total_num_of_tests"                                       | tee -a $1/regression_result.log
echo " Number of passed tests : $(($total_num_of_tests - $total_num_of_fails))"            | tee -a $1/regression_result.log
echo " Number of failed tests : $total_num_of_fails"                                       | tee -a $1/regression_result.log
echo " Regression pass rate   : $((100 - (100*$total_num_of_fails/$total_num_of_tests)))%" | tee -a $1/regression_result.log
echo "----------------------------------------------" >> $1/regression_result.log
echo >> $1/regression_result.log
echo >> $1/regression_result.log

if [ "$list_of_fail_tests" != "" ]
  then
    echo "----------------------------------------------" >> $1/regression_result.log
    echo " FAILING TESTS" >> $1/regression_result.log
    echo "----------------------------------------------" >> $1/regression_result.log
    echo "$list_of_fail_tests" >> $1/regression_result.log
fi
echo >> $1/regression_result.log

if [ "$list_of_pass_tests" != "" ]
  then
    echo "----------------------------------------------" >> $1/regression_result.log
    echo " PASSING TESTS" >> $1/regression_result.log
    echo "----------------------------------------------" >> $1/regression_result.log
    echo "$list_of_pass_tests" >> $1/regression_result.log
fi


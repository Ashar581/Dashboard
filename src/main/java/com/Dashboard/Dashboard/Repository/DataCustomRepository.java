package com.Dashboard.Dashboard.Repository;

import java.util.List;

public interface DataCustomRepository {

    List<String> all(String column);

    List<Integer> getFrequency(String topicName,int year,String column);

    List<Integer> getAllTimeFrequency(String name,String column);

    List<Integer> getAllSum(String column,String conditionHeader,String condition);

    List<Integer> countOneColumn(String column, String conditionColumn, String condition);

    List<Integer> countOneColumnExtraCondition(String column, String conditionColumn, String condition, String otherConditionColumn, String otherCondition);

    List<Integer> countMaxWithCondition(String column,String conditionColumn, String condition);

}

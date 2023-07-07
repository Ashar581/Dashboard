package com.Dashboard.Dashboard.Repository;

import jakarta.persistence.EntityManager;
import jakarta.persistence.PersistenceContext;

import java.util.List;

public class DataCustomRepositoryImpl implements DataCustomRepository{

    private List<String> yearList;
    private List<Integer> sum;

    private List<Integer> allTimeFrequency;
    private List<Integer> allTimeFrequencySector;
    private List<Integer> frequency;

    private List<Integer> countOneColumn;

    private List<Integer> countOneColumnExtraCondition;

    private List<Integer> countMax;

    @PersistenceContext
    private EntityManager entityManager;
    @Override
    public List<String> all(String column) {
        yearList = entityManager.createQuery("SELECT (d."+column+") FROM Data d").getResultList();
        return yearList;
    }

    @Override
    public List<Integer> getFrequency(String topicName, int year,String column) {
        frequency = entityManager.createQuery("SELECT COUNT(*) FROM Data d WHERE (d."+column+")='"+topicName+"'"+"AND (d.end_year)='"+year+"'").getResultList();
        // "SELECT (d.topic), COUNT(*) FROM Data d GROUP BY (d.topic) HAVING (d.topic=drug)"

        //"SELECT COUNT(*) FROM Data d WHERE (d.topic)='drug'"

        return frequency;
    }

    @Override
    public List<Integer> getAllTimeFrequency(String name,String column) {

        allTimeFrequency = entityManager.createQuery("SELECT COUNT(*) FROM Data d WHERE (d."+column+") = '"+name+"'").getResultList();

        return allTimeFrequency;
    }

    @Override
    public List<Integer> getAllSum(String column, String conditionHeader, String condition) {
        sum = entityManager.createQuery("SELECT SUM( CAST ("+column+" AS INTEGER)) FROM Data d WHERE (d."+conditionHeader+") = '"+condition+"'").getResultList();
        return sum;
    }

    @Override
    public List<Integer> countOneColumn(String column, String conditionColumn, String condition) {

        countOneColumn = entityManager.createQuery("SELECT COUNT(d."+column+") FROM Data d WHERE (d."+conditionColumn+") = '"+condition+"'").getResultList();

        return countOneColumn;
    }

    @Override
    public List<Integer> countOneColumnExtraCondition(String column, String conditionColumn, String condition, String otherConditionColumn, String otherCondition) {

        countOneColumnExtraCondition = entityManager.createQuery("SELECT COUNT(d."+column+") FROM Data d WHERE (d."+conditionColumn+") = '"+condition+"" +
                "' AND (d."+otherConditionColumn+") = '"+otherCondition+"'").getResultList();


        return countOneColumnExtraCondition;
    }

    @Override
    public List<Integer> countMaxWithCondition(String column, String conditionColumn, String condition) {

        countOneColumn = entityManager.createQuery("SELECT MAX(d."+column+") " +
                "FROM Data d WHERE (d."+conditionColumn+" = '"+condition+"')").getResultList();

        return countMax;
    }

    //SELECT SUM( CAST (relevance AS INT)) FROM DATA WHERE topic = 'oil'

}

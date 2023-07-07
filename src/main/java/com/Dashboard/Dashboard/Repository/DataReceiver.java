package com.Dashboard.Dashboard.Repository;

import org.springframework.beans.factory.annotation.Autowired;

import java.util.*;

public class DataReceiver {

    private int [] topFiveYears = new int[10];
    private List<String> allTopics;
    private List<String> allPestle;
    private List<String> allSwot;

    private List<String> allYear;
    private List<String> allSector;
    private List<String> allCountry;

    public int [] years(List<String> yearData){


        //Sorting The List By Calling Created Function for Duplicate Removal & Data Sorting
        List<String> sorting = RemoveDuplicate(yearData);
        sorting = SortData(sorting);

        int count=0;


        for (String str : sorting){
            topFiveYears[count++] = Integer.parseInt(str);
            if(count>9){
                break;
            }
        }

        return topFiveYears;
    }

    public void year(List<String> yearData){

        List<String> updatedYear = RemoveDuplicate(yearData);

        allYear = updatedYear;

    }
    public List<String> getAllYear(){

        return allYear;
    }



    public int [] get5Years(){
        return topFiveYears;
    }

    public void topics(List<String> topicData){

        List<String> updatedTopics = RemoveDuplicate(topicData);

        allTopics = updatedTopics;

    }

    public List<String> getTopic(){
        return allTopics;
    }

    public void sectors(List<String> sectorData){

        List<String> updateSectors= RemoveDuplicate(sectorData);

        allSector = updateSectors;
    }

    public List<String> getAllSector(){
        return allSector;
    }

    public void pestle(List<String> pestleData){

        List<String> updatePestle= RemoveDuplicate(pestleData);

        allPestle = updatePestle;
    }

    public List<String> getAllPestle(){
        return allPestle;
    }

    public void swot(List<String> swotData){

        List<String> updateSwot = RemoveDuplicate(swotData);

        allSwot = updateSwot;
    }

    public List<String> getAllSwot(){
        return allSwot;
    }

    public void country(List<String> countryData){

        List<String> updateSwot = RemoveDuplicate(countryData);

        allCountry = updateSwot;
    }

    public List<String> getAllCountry(){
        return allCountry;
    }

    //Function for removing duplicates
    public List<String> RemoveDuplicate(List<String> yearsList){

        //Duplicates Removed
        LinkedHashSet<String> dataAltered = new LinkedHashSet<>(yearsList);

        //Changing Back to ArrayList
        ArrayList<String> dataSorted = new ArrayList<>(dataAltered);

        return dataSorted;
    }

    public List<String> SortData(List<String> dataList){

        //Data Sorted Ascending Order
        ArrayList<String> dataSorted = new ArrayList<>(dataList);
        Collections.sort(dataSorted);

        return dataSorted;
    }
}

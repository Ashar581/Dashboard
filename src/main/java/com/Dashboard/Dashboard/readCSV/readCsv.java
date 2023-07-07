package com.Dashboard.Dashboard.readCSV;

import com.Dashboard.Dashboard.Entity.Data;
import com.opencsv.CSVReader;
import com.opencsv.exceptions.CsvValidationException;
import jakarta.persistence.Column;

import java.io.FileReader;
import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

public class readCsv {

    @SuppressWarnings("resource")
    public static List<Data> addUser() throws IOException, CsvValidationException {

        List<Data> getData = new ArrayList<>();

         String end_year;
         String citylng;
        String citylat;
         String intensity;
         String sector;
         String topic;
         String insight;
         String swot;
         String url;
         String region;
         String start_year;
         String impact;
         String added;
         String published;
         String city;
         String country;
         String relevance;
         String pestle;
         String source;
        String title;
        String likelihood;

        CSVReader csvReader = new CSVReader(new FileReader("data/Data.csv"));

        String [] readLine;
        int count=0;

        csvReader.readNext();

        while ( (readLine = csvReader.readNext()) != null){

            end_year = readLine[0];
            citylng = readLine[1];
            citylat = readLine[2];
            intensity = readLine[3];
            sector = readLine[4];
            topic = readLine[5];
            insight = readLine[6];
            swot = readLine[7];
            url = readLine[8];
            region = readLine[9];
            start_year = readLine[10];
            impact = readLine[11];
            added = readLine[12];
            published = readLine[13];
            city = readLine[14];
            country = readLine[15];
            relevance = readLine[16];
            pestle = readLine[17];
            source = readLine[18];
            title = readLine[19];
            likelihood = readLine[20];



            Data data=new Data();
            data.setAdded(added);
            data.setCity(city);
            data.setCitylat(citylat);
            data.setCitylng(citylng);
            data.setCountry(country);
            data.setEnd_year(end_year);
            data.setImpact(impact);
            data.setInsight(insight);
            data.setIntensity(intensity);
            data.setLikelihood(likelihood);
            data.setPestle(pestle);
            data.setPublished(published);
            data.setRegion(region);
            data.setRelevance(relevance);
            data.setSector(sector);
            data.setSource(source);
            data.setStart_year(start_year);
            data.setSwot(swot);
            data.setTitle(title);
            data.setTopic(topic);
            data.setUrl(url);


            getData.add(data);

        }

        return getData;
    }
}

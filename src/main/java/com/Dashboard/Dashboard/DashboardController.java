package com.Dashboard.Dashboard;

import com.Dashboard.Dashboard.Repository.DataReceiver;
import com.Dashboard.Dashboard.Repository.DataRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.ui.Model;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import java.util.List;

@Controller
public class DashboardController {

    @Autowired
    DataRepository dataRepository;
    DataReceiver dataReceiver = new DataReceiver();

    @RequestMapping("/")
    public String HomePage(Model model) {

        //Setting all years
        dataReceiver.years(dataRepository.all("end_year"));

        model.addAttribute("year1",dataReceiver.get5Years()[0]);
        model.addAttribute("year2",dataReceiver.get5Years()[1]);
        model.addAttribute("year3",dataReceiver.get5Years()[2]);
        model.addAttribute("year4",dataReceiver.get5Years()[3]);
        model.addAttribute("year5",dataReceiver.get5Years()[4]);


        //Initializing Topics To ArrayList
        dataReceiver.topics(dataRepository.all("topic"));
        List<String> allTopics = dataReceiver.getTopic();

        //Getting the name of the most frequent topic
        String topicName="";
        int itsFrequency = 0;

        for (String str:allTopics) {
            if (!str.isBlank()) {
                int temp = dataRepository.getAllTimeFrequency(str,"topic").get(0);

                if (temp > itsFrequency) {
                    topicName = str;
                    itsFrequency = temp;
                }
            }
        }

        //Setting most Frequent Topic
        model.addAttribute("topic",topicName);

        //Setting Data for the most frequent Topic for 5 years
        for (int i=0;i<5;i++){
            int frequency = dataRepository.getFrequency(topicName,dataReceiver.get5Years()[i],"topic").get(0);
            String a = "topicdata"+(i+1);

            //Sending the data to the bar chart
            model.addAttribute(a,frequency);

        }

        //Initializing Sectors to ArrayList
        dataReceiver.sectors(dataRepository.all("sector"));
        List<String> allSectors = dataReceiver.getAllSector();

        //Getting the name of the most frequent sector
        String sectorName="";
        int sectorFrequency = 0;

        for (String str:allSectors) {
            if (!str.isBlank()) {
                int temp = dataRepository.getAllTimeFrequency(str,"sector").get(0);

                if (temp > sectorFrequency) {
                    sectorName = str;
                    sectorFrequency = temp;
                }
            }
        }

        //Setting most frequent Sector
        model.addAttribute("topic2",sectorName);

        //Setting Data for the most frequent Sector for 5 years
        for (int i=0;i<5;i++){
            int frequency = dataRepository.getFrequency(sectorName,dataReceiver.get5Years()[i],"sector").get(0);
            String jspName = "sectordata"+(i+1);

            //Sending the data to the bar chart
            model.addAttribute(jspName,frequency);

        }

        //Initializing Pestle to ArrayList
        dataReceiver.pestle(dataRepository.all("pestle"));
        List<String> allPestle = dataReceiver.getAllPestle();

        //Getting the name of the most frequent sector
        String pestleName="";
        int pestleFrequency = 0;

        for (String str:allPestle) {
            if (!str.isBlank()) {
                int temp = dataRepository.getAllTimeFrequency(str,"pestle").get(0);

                if (temp > pestleFrequency) {
                    pestleName = str;
                    pestleFrequency = temp;
                }
            }
        }

        //Setting most frequent Sector
        model.addAttribute("topic3",pestleName);

        //Setting Data for the most frequent Sector for 5 years
        for (int i=0;i<5;i++){
            int frequency = dataRepository.getFrequency(pestleName,dataReceiver.get5Years()[i],"pestle").get(0);
            String jspName = "pestledata"+(i+1);

            //Sending the data to the bar chart
            model.addAttribute(jspName,frequency);

        }


        //Getting All Topics
//        List<String> allTopics= dataReceiver.topics(dataRepository.all("topic"));

        //Getting all the top 5 topics
        String [] setTopic = new String [allTopics.size()];
        int [] setFrequency = new int [allTopics.size()];

        //Outer loop for sending only first 5 years to the DataCustomRepository
        //Inner for each loop gets frequency of all topics per year
        //Another loop is created to sort them in descending order

        for (int i=0; i<dataReceiver.get5Years().length;i++) {
            int arrayIncrement = 0;
            for (String str : allTopics) {
                if(!str.isBlank()) {
                    setTopic[arrayIncrement] = str;
                    setFrequency[arrayIncrement] = dataRepository.getAllTimeFrequency(str,"topic").get(0);
                    arrayIncrement++;
                }
            }
            for(int j=0;j<setTopic.length;j++){

                for (int k=1;k<(setTopic.length-1);k++){

                    if( setFrequency[k-1] < setFrequency[k] ){

                        int temp = setFrequency[k];
                        setFrequency[k] = setFrequency[k-1];
                        setFrequency[k-1] = temp;

                        String temp1 = setTopic[k];
                        setTopic[k] = setTopic[k-1];
                        setTopic[k-1] = temp1;
                    }
                }
            }
        }

        //Configuring the sum of relevance intensity & likelihood of top 5 sectors
        for (int i=0;i<5;i++){
            int relevance = dataRepository.getAllSum("relevance","topic", setTopic[i]).get(0);
            int likelihood = dataRepository.getAllSum("likelihood","topic", setTopic[i]).get(0);
            int intensity = dataRepository.getAllSum("intensity","topic", setTopic[i]).get(0);

            String jspRelevance = "relevance"+(i+1);
            String jspLikelihood = "likelihood"+(i+1);
            String jspIntensity = "intensity"+(i+1);
            String jspLabel = "label"+(i+1);

            //Setting data for the chart
            model.addAttribute(jspRelevance,relevance);
            model.addAttribute(jspLikelihood,likelihood);
            model.addAttribute(jspIntensity,intensity);

            model.addAttribute(jspLabel,setTopic[i]);

        }

        //Setting comparison of 2 most frequent topics for 5 years
        for(int i=0;i<5;i++){
            int frequency1 = dataRepository.getFrequency(setTopic[0], dataReceiver.get5Years()[i],"topic").get(0);
            int frequency2 = dataRepository.getFrequency(setTopic[1], dataReceiver.get5Years()[i],"topic").get(0);

            String jpaTopic1 = "data"+(i+1);
            String jpaTopic2 = "second"+(i+1);

            model.addAttribute("compare1",setTopic[0]);
            model.addAttribute("compare2",setTopic[1]);

            model.addAttribute(jpaTopic1,frequency1);
            model.addAttribute(jpaTopic2,frequency2);

        }

        return "index";
    }

    @RequestMapping("/Sector")
    public String SectorPage(Model model){

        //Setting the years first
        dataReceiver.years(dataRepository.all("end_year"));

        for (int i=0;i<10;i++) {

            String jspYear="year"+(i+1);

            model.addAttribute(jspYear, dataReceiver.get5Years()[i]);

        }

        //Five Most Frequent Sectors

        //Initializing the get all sector query
        dataReceiver.sectors(dataRepository.all("sector"));
        List<String> allSector= dataReceiver.getAllSector();

        //Getting all the top 5 sectors
        String [] setTopic = new String [allSector.size()];
        int [] setFrequency = new int [allSector.size()];

        //Outer loop for sending only first 5 years to the DataCustomRepository
        //Inner for each loop gets frequency of all topics per year
        //Another loop is created to sort them in descending order

        for (int i=0; i<dataReceiver.get5Years().length;i++) {
            int arrayIncrement = 0;
            for (String str : allSector) {
                if(!str.isBlank()) {
                    setTopic[arrayIncrement] = str;
                    setFrequency[arrayIncrement] = dataRepository.getAllTimeFrequency(str,"sector").get(0);
                    arrayIncrement++;
                }
            }
            for(int j=0;j<setTopic.length;j++){

                for (int k=1;k<(setTopic.length-1);k++){

                    if( setFrequency[k-1] < setFrequency[k] ){

                        int temp = setFrequency[k];
                        setFrequency[k] = setFrequency[k-1];
                        setFrequency[k-1] = temp;

                        String temp1 = setTopic[k];
                        setTopic[k] = setTopic[k-1];
                        setTopic[k-1] = temp1;
                    }
                }
            }
        }

        //Variable for setting sectors
        String sectorName="";
        int sectorFrequency = 0;

        //Setting Data for the most frequent Sector for 10 years
        for (int i=0;i<10;i++){

            //First Data of Each Sector
            int frequency1 = dataRepository.getFrequency(setTopic[0], dataReceiver.get5Years()[i],"sector").get(0);
            int frequency2 = dataRepository.getFrequency(setTopic[1], dataReceiver.get5Years()[i],"sector").get(0);
            int frequency3 = dataRepository.getFrequency(setTopic[2], dataReceiver.get5Years()[i],"sector").get(0);
            int frequency4 = dataRepository.getFrequency(setTopic[3], dataReceiver.get5Years()[i],"sector").get(0);
            int frequency5 = dataRepository.getFrequency(setTopic[4], dataReceiver.get5Years()[i],"sector").get(0);


            String jspSector1 = "A"+(i+1);
            String jspSector2 = "B"+(i+1);
            String jspSector3 = "C"+(i+1);
            String jspSector4 = "D"+(i+1);
            String jspSector5 = "E"+(i+1);

            String sector = "name"+(i+1);

            //Sending the data to the bar chart
            model.addAttribute(jspSector1,frequency1);
            model.addAttribute(jspSector2,frequency2);
            model.addAttribute(jspSector3,frequency3);
            model.addAttribute(jspSector4,frequency4);
            model.addAttribute(jspSector5,frequency5);

            //Setting Sector Names
            model.addAttribute(sector,setTopic[i]);

        }

        //Intensity Likelihood & Relevance Of 5 Most Frequent Sectors


        //Configuring the sum of relevance intensity & likelihood of top 5 sectors
        for (int i=0;i<5;i++){
            int relevance = dataRepository.getAllSum("relevance","sector", setTopic[i]).get(0);
            int likelihood = dataRepository.getAllSum("likelihood","sector", setTopic[i]).get(0);
            int intensity = dataRepository.getAllSum("intensity","sector", setTopic[i]).get(0);

            //Data
            String jspRelevance = "relevance"+(i+1);
            String jspLikelihood = "likelihood"+(i+1);
            String jspIntensity = "intensity"+(i+1);
            //Label
            String jspLabel = "label"+(i+1);

            //Setting data for the chart
            model.addAttribute(jspRelevance,relevance);
            model.addAttribute(jspLikelihood,likelihood);
            model.addAttribute(jspIntensity,intensity);

            model.addAttribute(jspLabel,setTopic[i]);

        }

        //Five Most Frequent Sectors In A Region


        //Getting all the top 5 Sectors In A Region
        String [] setSector = new String [allSector.size()];
        int [] setFrequencyRegion = new int [allSector.size()];

        //Outer loop for sending only first 5 years to the DataCustomRepository
        //Inner for each loop gets frequency of all topics per year
        //Another loop is created to sort them in descending order

        for (int i=0; i<dataReceiver.get5Years().length;i++) {
            int arrayIncrement = 0;
            for (String str : allSector) {
                if(!str.isBlank()) {
                    setSector[arrayIncrement] = str; //SELECT COUNT( region ) FROM DATA WHERE sector = 'Healthcare'
                    setFrequencyRegion[arrayIncrement] = dataRepository.countOneColumn("region","sector",str).get(0);
                    arrayIncrement++;
                }
            }
            for(int j=0;j<setTopic.length;j++){

                for (int k=1;k<(setTopic.length-1);k++){

                    if( setFrequencyRegion[k-1] < setFrequencyRegion[k] ){

                        int temp = setFrequencyRegion[k];
                        setFrequencyRegion[k] = setFrequencyRegion[k-1];
                        setFrequencyRegion[k-1] = temp;

                        String temp1 = setSector[k];
                        setSector[k] = setSector[k-1];
                        setSector[k-1] = temp1;
                    }
                }
            }
        }


        //Setting Frequent Sectors In A Region
        for (int i=0;i<5;i++){

            //Data
            String jspSectorData = "sectorRegionCount"+(i+1);

            //Label
            String jspLabel = "bar"+(i+1);

            //Setting data for the chart
            model.addAttribute(jspSectorData,setFrequencyRegion[i]);

            model.addAttribute(jspLabel,setSector[i]);
        }

        //DropDown Data
        model.addAttribute("sectorList", allSector);
        return "Sector";
    }

    @RequestMapping("/FilterSector")
    public String FilterSectorPage(@RequestParam("sector") String option, Model model){

        dataReceiver.years(dataRepository.all("end_year"));

        if (option.isBlank()){
            SectorPage(model);
            return "Sector";
        }

        dataReceiver.sectors(dataRepository.all("sector"));
        List<String> allSector = dataReceiver.getAllSector();

        //End Year Of 5 Sectors In A Year

        model.addAttribute("name1",option);

        for (int i=0;i<10;i++){

            int endTenureFrequency = dataRepository.getFrequency(option,dataReceiver.get5Years()[i],"sector").get(0);

            String jspData = "A"+(i+1);
            String jspYear = "year"+(i+1);

            model.addAttribute(jspData,endTenureFrequency);
            model.addAttribute(jspYear,dataReceiver.get5Years()[i]);
        }

        //Sector's Intensity Livelihood and Relevance

        int relevance = dataRepository.getAllSum("relevance","sector", option).get(0);
        int likelihood = dataRepository.getAllSum("likelihood","sector", option).get(0);
        int intensity = dataRepository.getAllSum("intensity","sector", option).get(0);


        //Setting data for the chart
        model.addAttribute("intensity1",relevance);
        model.addAttribute("likelihood1",likelihood);
        model.addAttribute("relevance1",intensity);


        //Frequency Amongst Regions
        int regionFrequency = dataRepository.countOneColumn("region","sector",option).get(0);

        model.addAttribute("sectorRegionCount1",regionFrequency);



        //DropDown List
        model.addAttribute("sectorList",allSector);

        return "FilterSector";
    }

    @RequestMapping("/Topics")
    public String TopicPage(Model model){

        //Setting the years first
        dataReceiver.years(dataRepository.all("end_year"));

        model.addAttribute("year1",dataReceiver.get5Years()[0]);
        model.addAttribute("year2",dataReceiver.get5Years()[1]);
        model.addAttribute("year3",dataReceiver.get5Years()[2]);
        model.addAttribute("year4",dataReceiver.get5Years()[3]);
        model.addAttribute("year5",dataReceiver.get5Years()[4]);


        //Initializing Topics To ArrayList
        dataReceiver.topics(dataRepository.all("topic"));
        List<String> allTopics = dataReceiver.getTopic();

        //Getting all the top 5 topics
        String [] setTopic = new String [allTopics.size()];
        int [] setFrequency = new int [allTopics.size()];

        //Outer loop for sending only first 5 years to the DataCustomRepository
        //Inner for each loop gets frequency of all topics per year
        //Another loop is created to sort them in descending order

        for (int i=0; i<dataReceiver.get5Years().length;i++) {
            int arrayIncrement = 0;
            for (String str : allTopics) {
                if(!str.isBlank()) {
                    setTopic[arrayIncrement] = str;
                    setFrequency[arrayIncrement] = dataRepository.getAllTimeFrequency(str,"topic").get(0);
                    arrayIncrement++;
                }
            }
            for(int j=0;j<setTopic.length;j++){

                for (int k=1;k<(setTopic.length-1);k++){

                    if( setFrequency[k-1] < setFrequency[k] ){

                        int temp = setFrequency[k];
                        setFrequency[k] = setFrequency[k-1];
                        setFrequency[k-1] = temp;

                        String temp1 = setTopic[k];
                        setTopic[k] = setTopic[k-1];
                        setTopic[k-1] = temp1;
                    }
                }
            }
        }

        //Setting comparison of 3 most frequent topics for 5 years
        for(int i=0;i<5;i++){
            int frequency1 = dataRepository.getFrequency(setTopic[0], dataReceiver.get5Years()[i],"topic").get(0);
            int frequency2 = dataRepository.getFrequency(setTopic[1], dataReceiver.get5Years()[i],"topic").get(0);
            int frequency3 = dataRepository.getFrequency(setTopic[2], dataReceiver.get5Years()[i],"topic").get(0);

            String jpaTopic1 = "data"+(i+1);
            String jpaTopic2 = "second"+(i+1);
            String jpaTopic3 = "third"+(i+1);

            model.addAttribute("topic1",setTopic[0]);
            model.addAttribute("topic2",setTopic[1]);
            model.addAttribute("topic3",setTopic[2]);

            model.addAttribute(jpaTopic1,frequency1);
            model.addAttribute(jpaTopic2,frequency2);
            model.addAttribute(jpaTopic3,frequency3);

        }

        //Five Most Frequent Topics Pie Chart
        for (int i=0;i<5;i++) {

            int temp = dataRepository.getAllTimeFrequency(setTopic[i], "topic").get(0);

            String pieScriplet = "a"+(i+1);
            String pieData = "alphabet"+(i+1);

            model.addAttribute(pieScriplet,setTopic[i]);

            model.addAttribute(pieData,temp);

        }

        //Topic and Its Country and Relevance
        for (int i=0;i<5;i++){
            int relevance = dataRepository.getAllSum("relevance","topic", setTopic[i]).get(0);
            int country = dataRepository.countOneColumn("country","topic",setTopic[i]).get(0);

            String jspRelevance = "relevance"+(i+1);
            String jspLikelihood = "country"+(i+1);
            String jspLabel = "label"+(i+1);

            //Setting data for the chart
            model.addAttribute(jspRelevance,relevance);
            model.addAttribute(jspLikelihood,country);

            model.addAttribute(jspLabel,setTopic[i]);

        }

        //DropDown Data
        model.addAttribute("topicList", allTopics);

        return "Topics";
    }

    @RequestMapping("/FilterTopic")
    public String FilterTopic(@RequestParam("topic") String option,Model model){

        dataReceiver.years(dataRepository.all("end_year"));

        if (option.isBlank() || option.equalsIgnoreCase("") || option==null){
            TopicPage(model);
            return "Topic";
        }

        dataReceiver.topics(dataRepository.all("topic"));
        List<String> allTopic = dataReceiver.getTopic();

        model.addAttribute("name1",option);

        //Topic Frequency Year
        for(int i=0;i<10;i++){

            String jspYear = "year"+(i+1);

            model.addAttribute(jspYear,dataReceiver.get5Years()[i]);

            int frequency1 = dataRepository.getFrequency(option, dataReceiver.get5Years()[i],"topic").get(0);

            String jpaTopic1 = "data"+(i+1);

            model.addAttribute(jpaTopic1,frequency1);

        }

        //Topic's All Count of Intensity, Likelihood Relevance

        int intensity = dataRepository.countOneColumn("intensity","topic",option).get(0);
        int relevance = dataRepository.countOneColumn("relevance","topic",option).get(0);
        int likelihood = dataRepository.countOneColumn("likelihood","topic",option).get(0);

        model.addAttribute("intensity",intensity);
        model.addAttribute("relevance",relevance);
        model.addAttribute("likelihood",likelihood);

        //Country And Relevance
        int countryCount = dataRepository.countOneColumn("country","topic",option).get(0);

        model.addAttribute("c",countryCount);

        model.addAttribute("r",relevance);

        //Dropdown
        model.addAttribute("topicList",allTopic);

        return "FilterTopic";
    }

    @RequestMapping("/Year")
    public  String YearPage(Model model){

        //Comparison of 2 Frequent Topics over the years

        //Setting the years first
        dataReceiver.years(dataRepository.all("end_year"));

        for (int i=0;i<10;i++) {

            String jspYear="year"+(i+1);

            model.addAttribute(jspYear, dataReceiver.get5Years()[i]);

        }

        //2 Frequent Topic Ovet The Years

        //Initializing the get all sector query
        dataReceiver.topics(dataRepository.all("topic"));
        List<String> allTopic= dataReceiver.getTopic();

        //Getting all the top 5 sectors
        String [] setTopic = new String [allTopic.size()];
        int [] setFrequency = new int [allTopic.size()];

        //Outer loop for sending only first 5 years to the DataCustomRepository
        //Inner for each loop gets frequency of all topics per year
        //Another loop is created to sort them in descending order

        for (int i=0; i<dataReceiver.get5Years().length;i++) {
            int arrayIncrement = 0;
            for (String str : allTopic) {
                if(!str.isBlank()) {
                    setTopic[arrayIncrement] = str;
                    setFrequency[arrayIncrement] = dataRepository.getAllTimeFrequency(str,"topic").get(0);
                    arrayIncrement++;
                }
            }
            for(int j=0;j<setTopic.length;j++){

                for (int k=1;k<(setTopic.length-1);k++){

                    if( setFrequency[k-1] < setFrequency[k] ){

                        int temp = setFrequency[k];
                        setFrequency[k] = setFrequency[k-1];
                        setFrequency[k-1] = temp;

                        String temp1 = setTopic[k];
                        setTopic[k] = setTopic[k-1];
                        setTopic[k-1] = temp1;
                    }
                }
            }
        }

        for (int i=0;i<10;i++){

            model.addAttribute("label1",setTopic[0]);
            model.addAttribute("label2",setTopic[1]);

            String jspData1 = "first"+(i+1);
            String jspData2 = "second"+(i+1);

            int frequency1 = dataRepository.getFrequency(setTopic[0],dataReceiver.get5Years()[i],"topic").get(0) ;
            int frequency2 = dataRepository.getFrequency(setTopic[1],dataReceiver.get5Years()[i],"topic").get(0);

            model.addAttribute(jspData1,frequency1);
            model.addAttribute(jspData2,frequency2);

        }




        //Sector and Intensity Per Year

        //Initializing the get all sector query
        dataReceiver.sectors(dataRepository.all("sector"));
        List<String> allSector= dataReceiver.getAllSector();

        //Getting all the top 5 sectors
        String [] setSector = new String [allSector.size()];
        int [] setFrequencySector = new int [allSector.size()];

        //Outer loop for sending only first 5 years to the DataCustomRepository
        //Inner for each loop gets frequency of all topics per year
        //Another loop is created to sort them in descending order

        for (int i=0; i<dataReceiver.get5Years().length;i++) {
            int arrayIncrement = 0;
            for (String str : allSector) {
                if(!str.isBlank()) {
                    setSector[arrayIncrement] = str;
                    setFrequencySector[arrayIncrement] = dataRepository.countOneColumn("intensity","sector",str).get(0);
                    arrayIncrement++;
                }
            }
            for(int j=0;j<setSector.length;j++){

                for (int k=1;k<(setSector.length-1);k++){

                    if( setFrequencySector[k-1] < setFrequencySector[k] ){

                        int temp = setFrequencySector[k];
                        setFrequencySector[k] = setFrequencySector[k-1];
                        setFrequencySector[k-1] = temp;

                        String temp1 = setSector[k];
                        setSector[k] = setSector[k-1];
                        setSector[k-1] = temp1;
                    }
                }
            }
        }



        //Setting Data for the most frequent Sector for 10 years
        for (int i=0;i<10;i++){

            //First Data of Each Sector
            int frequency1 = dataRepository.getFrequency(setSector[0], dataReceiver.get5Years()[i],"sector").get(0);
            int frequency2 = dataRepository.getFrequency(setSector[1], dataReceiver.get5Years()[i],"sector").get(0);
            int frequency3 = dataRepository.getFrequency(setSector[2], dataReceiver.get5Years()[i],"sector").get(0);
            int frequency4 = dataRepository.getFrequency(setSector[3], dataReceiver.get5Years()[i],"sector").get(0);
            int frequency5 = dataRepository.getFrequency(setSector[4], dataReceiver.get5Years()[i],"sector").get(0);


            String jspSector1 = "A"+(i+1);
            String jspSector2 = "B"+(i+1);
            String jspSector3 = "C"+(i+1);
            String jspSector4 = "D"+(i+1);
            String jspSector5 = "E"+(i+1);

            String sector = "name"+(i+1);

            //Sending the data to the bar chart
            model.addAttribute(jspSector1,frequency1);
            model.addAttribute(jspSector2,frequency2);
            model.addAttribute(jspSector3,frequency3);
            model.addAttribute(jspSector4,frequency4);
            model.addAttribute(jspSector5,frequency5);

            //Setting Sector Names
            model.addAttribute(sector,setTopic[i]);

        }


        //Five Most Frequent Sectors Per Year

        //Getting all the top 5 sectors per year
        String [] setSectorYear = new String [allSector.size()];
        int [] setFrequencySectorYear = new int [allSector.size()];

        //Outer loop for sending only first 5 years to the DataCustomRepository
        //Inner for each loop gets frequency of all topics per year
        //Another loop is created to sort them in descending order

        for (int i=0; i<dataReceiver.get5Years().length;i++) {
            int arrayIncrement = 0;
            for (String str : allSector) {
                if(!str.isBlank()) {
                    setSectorYear[arrayIncrement] = str;
                    setFrequencySectorYear[arrayIncrement] = dataRepository.getAllTimeFrequency(str,"sector").get(0);
                    arrayIncrement++;
                }
            }
            for(int j=0;j<setSector.length;j++){

                for (int k=1;k<(setSector.length-1);k++){

                    if( setFrequencySectorYear[k-1] < setFrequencySectorYear[k] ){

                        int temp = setFrequencySectorYear[k];
                        setFrequencySectorYear[k] = setFrequencySectorYear[k-1];
                        setFrequencySectorYear[k-1] = temp;

                        String temp1 = setSectorYear[k];
                        setSectorYear[k] = setSectorYear[k-1];
                        setSectorYear[k-1] = temp1;
                    }
                }
            }
        }


        //Sending Data For A Particular Year

        for (int i=0;i<5;i++){

            String jspData1 = "a"+(i+1);
            String jspData2 = "b"+(i+1);
            String jspData3 = "c"+(i+1);
            String jspData4 = "d"+(i+1);
            String jspData5 = "e"+(i+1);


            String jspSector = "peryearSector"+(i+1);

            int frequency1 = dataRepository.getFrequency(setSectorYear[0], dataReceiver.get5Years()[i],"sector").get(0);
            int frequency2 = dataRepository.getFrequency(setSectorYear[1], dataReceiver.get5Years()[i],"sector").get(0);
            int frequency3 = dataRepository.getFrequency(setSectorYear[2], dataReceiver.get5Years()[i],"sector").get(0);
            int frequency4 = dataRepository.getFrequency(setSectorYear[3], dataReceiver.get5Years()[i],"sector").get(0);
            int frequency5 = dataRepository.getFrequency(setSectorYear[4], dataReceiver.get5Years()[i],"sector").get(0);

            model.addAttribute(jspData1,frequency1);
            model.addAttribute(jspData2,frequency2);
            model.addAttribute(jspData3,frequency3);
            model.addAttribute(jspData4,frequency4);
            model.addAttribute(jspData5,frequency5);


            model.addAttribute(jspSector,setSectorYear[i]);

        }


        //Year Initialisation For Drop Down
        dataReceiver.year(dataRepository.all("end_year"));
        List<String> allYear = dataReceiver.getAllYear();

        //DropDown Data
        model.addAttribute("yearList", allYear);

        return "Year";
    }

    @RequestMapping("/FilterYear")
    public String FilterYearPage(@RequestParam("years") String option, Model model){

        dataReceiver.year(dataRepository.all("end_year"));
        List<String> allYear = dataReceiver.getAllYear();

        for(String str:allYear){
            System.out.println("Year: "+str);
        }

        if (option.isBlank()){
            YearPage(model);
            return "Year";
        }

        //2 Frequent Topic In A Year With Frequency

        //Initializing the get all topic query
        dataReceiver.topics(dataRepository.all("topic"));
        List<String> allTopic= dataReceiver.getTopic();

        //Getting all the top topics
        String [] setTopic = new String [allTopic.size()];
        int [] setFrequency = new int [allTopic.size()];

        //Outer loop for sending only first 5 years to the DataCustomRepository
        //Inner for each loop gets frequency of all topics per year
        //Another loop is created to sort them in descending order

        for (int i=0; i<dataReceiver.getAllYear().size();i++) {
            int arrayIncrement = 0;
            for (String str : allTopic) {
                if(!str.isBlank()) {
                    setTopic[arrayIncrement] = str;
                    setFrequency[arrayIncrement] = dataRepository.getFrequency(str,Integer.parseInt(option),"topic").get(0);
                    arrayIncrement++;
                }
            }
            for(int j=0;j<setTopic.length;j++){

                for (int k=1;k<(setTopic.length-1);k++){

                    if( setFrequency[k-1] < setFrequency[k] ){

                        int temp = setFrequency[k];
                        setFrequency[k] = setFrequency[k-1];
                        setFrequency[k-1] = temp;

                        String temp1 = setTopic[k];
                        setTopic[k] = setTopic[k-1];
                        setTopic[k-1] = temp1;
                    }
                }
            }
        }

        model.addAttribute("year1",option);


        model.addAttribute("label1",setTopic[0]);
        model.addAttribute("label2",setTopic[1]);

        model.addAttribute("first1",setFrequency[0]);
        model.addAttribute("second1",setFrequency[1]);


        //Intensity of 5 Most Frequent Sector in A Year

        //Sector and Intensity Per Year

        //Initializing the get all sector query
        dataReceiver.sectors(dataRepository.all("sector"));
        List<String> allSector= dataReceiver.getAllSector();

        //Getting all the top 5 sectors
        String [] setSector = new String [allSector.size()];
        int [] setFrequencySector = new int [allSector.size()];

        //Outer loop for sending only first 5 years to the DataCustomRepository
        //Inner for each loop gets frequency of all topics per year
        //Another loop is created to sort them in descending order

        for (int i=0; i<dataReceiver.get5Years().length;i++) {
            int arrayIncrement = 0;
            for (String str : allSector) {
                if(!str.isBlank()) {
                    setSector[arrayIncrement] = str;
                    setFrequencySector[arrayIncrement] = dataRepository.getFrequency(str,Integer.parseInt(option),"sector").get(0);
                    arrayIncrement++;
                }
            }
            for(int j=0;j<setSector.length;j++){

                for (int k=1;k<(setSector.length-1);k++){

                    if( setFrequencySector[k-1] < setFrequencySector[k] ){

                        int temp = setFrequencySector[k];
                        setFrequencySector[k] = setFrequencySector[k-1];
                        setFrequencySector[k-1] = temp;

                        String temp1 = setSector[k];
                        setSector[k] = setSector[k-1];
                        setSector[k-1] = temp1;
                    }
                }
            }
        }

        model.addAttribute("A1",setFrequencySector[0]);
        model.addAttribute("B1",setFrequencySector[1]);
        model.addAttribute("C1",setFrequencySector[2]);
        model.addAttribute("D1",setFrequencySector[3]);
        model.addAttribute("E1",setFrequencySector[4]);


        model.addAttribute("name1",setSector[0]);
        model.addAttribute("name2",setSector[1]);
        model.addAttribute("name3",setSector[2]);
        model.addAttribute("name4",setSector[3]);
        model.addAttribute("name5",setSector[4]);



        //DropDown Data
        model.addAttribute("yearList", allYear);

        return "FilterYear";
    }


    @RequestMapping("/Pestle")
    public String PestlePage(Model model){

        //5 Most Frequent Pestle's Likelihood Count

        //Initializing The Pestle ArrayList
        dataReceiver.pestle(dataRepository.all("pestle"));
        List<String> allPestle = dataReceiver.getAllPestle();

        //Getting all the top 5 Sectors In A Region
        String [] setPestle = new String [allPestle.size()];
        int [] setFrequencyPestle = new int [allPestle.size()];

        //Outer loop for sending only first 5 years to the DataCustomRepository
        //Inner for each loop gets frequency of all topics per year
        //Another loop is created to sort them in descending order

        for (int i=0; i<dataReceiver.get5Years().length;i++) {
            int arrayIncrement = 0;
            for (String str : allPestle) {
                if(!str.isBlank()) {
                    setPestle[arrayIncrement] = str; //SELECT COUNT( region ) FROM DATA WHERE sector = 'Healthcare'
                    setFrequencyPestle[arrayIncrement] = dataRepository.getAllTimeFrequency(str,"pestle").get(0);
                    arrayIncrement++;
                }
            }
            for(int j=0;j<setPestle.length;j++){

                for (int k=1;k<(setPestle.length-1);k++){

                    if( setFrequencyPestle[k-1] < setFrequencyPestle[k] ){

                        int temp = setFrequencyPestle[k];
                        setFrequencyPestle[k] = setFrequencyPestle[k-1];
                        setFrequencyPestle[k-1] = temp;

                        String temp1 = setPestle[k];
                        setPestle[k] = setPestle[k-1];
                        setPestle[k-1] = temp1;
                    }
                }
            }
        }

        for (int i = 0; i < 5; i++){

            int likelihoodFrequency = dataRepository.countOneColumn("likelihood","pestle",setPestle[i]).get(0);

            String jspBarName = "bar"+(i+1);
            String jspDataName = "bardata"+(i+1);

            model.addAttribute(jspBarName,setPestle[i]);

            model.addAttribute(jspDataName,likelihoodFrequency);

        }


        //Top 5 Pestle and its Intensity

        for (int i=0;i<5;i++){

            int intensityFrequency = dataRepository.countOneColumn("intensity","pestle",setPestle[i]).get(0);

            String jspHeads = "pestle"+(i+1);
            String jspData = "radar"+(i+1);

            model.addAttribute(jspHeads,setPestle[i]);
            model.addAttribute(jspData,intensityFrequency);

        }

        //Top 5 Pestle and top 5 SWOT Counts

        //Initializing The SWOT ArrayList
        dataReceiver.swot(dataRepository.all("swot"));
        List<String> allSwot = dataReceiver.getAllSwot();

        //Getting all the top 5 Sectors In A Region
        String [] setSwot = new String [allSwot.size()];
        int [] setFrequencySwot = new int [allSwot.size()];

        //Outer loop for sending only first 5 years to the DataCustomRepository
        //Inner for each loop gets frequency of all topics per year
        //Another loop is created to sort them in descending order

        for (int i=0; i<allSwot.size();i++) {
            int arrayIncrement = 0;
            for (String str : allSwot) {
                if(!str.isBlank() || str!=null) {
                    setSwot[arrayIncrement] = str; //SELECT COUNT( region ) FROM DATA WHERE sector = 'Healthcare'
                    setFrequencySwot[arrayIncrement] = dataRepository.getAllTimeFrequency(str,"swot").get(0);
                    arrayIncrement++;
                }
            }
            for(int j=0;j<setSwot.length;j++){

                for (int k=1;k<(setSwot.length-1);k++){

                    if( setFrequencySwot[k-1] < setFrequencySwot[k] ){

                        int temp = setFrequencySwot[k];
                        setFrequencySwot[k] = setFrequencySwot[k-1];
                        setFrequencySwot[k-1] = temp;

                        String temp1 = setSwot[k];
                        setSwot[k] = setSwot[k-1];
                        setSwot[k-1] = temp1;
                    }
                }
            }
        }

        for (int i=0; i<5;i++){

            int swotFrequency1 = dataRepository.countOneColumnExtraCondition("swot","pestle",setPestle[0],"swot",setSwot[i]).get(0);
            int swotFrequency2 = dataRepository.countOneColumnExtraCondition("swot","pestle",setPestle[1],"swot",setSwot[i]).get(0);
            int swotFrequency3 = dataRepository.countOneColumnExtraCondition("swot","pestle",setPestle[2],"swot",setSwot[i]).get(0);
            int swotFrequency4 = dataRepository.countOneColumnExtraCondition("swot","pestle",setPestle[3],"swot",setSwot[i]).get(0);
            int swotFrequency5 = dataRepository.countOneColumnExtraCondition("swot","pestle",setPestle[4],"swot",setSwot[i]).get(0);

            String jspSwotHead = "swothead"+(i+1);

            String jspSwotData1 = "g"+(i+1);
            String jspSwotData2 = "h"+(i+1);
            String jspSwotData3 = "i"+(i+1);
            String jspSwotData4 = "j"+(i+1);
            String jspSwotData5 = "k"+(i+1);


            model.addAttribute(jspSwotHead, setSwot[i]);


            model.addAttribute(jspSwotData1,swotFrequency1);
            model.addAttribute(jspSwotData2,swotFrequency2);
            model.addAttribute(jspSwotData3,swotFrequency3);
            model.addAttribute(jspSwotData4,swotFrequency4);
            model.addAttribute(jspSwotData5,swotFrequency5);


        }

        //DropDown Data
        model.addAttribute("pestleList", allPestle);

        return "Pestle";
    }

    @RequestMapping("/FilterPestle")
    public String FilterPestlePage(@RequestParam("pestle") String option, Model model){

        if (option.isBlank()){

            PestlePage(model);
            return "Pestle";

        }

        //Initializing Array List
        dataReceiver.pestle(dataRepository.all("pestle"));
        List<String> allPestle = dataReceiver.getAllPestle();

        dataReceiver.years(dataRepository.all("end_year"));

        //Pestle and Likelihood
        int likelihoodFrequency = dataRepository.countOneColumn("likelihood","pestle",option).get(0);

        model.addAttribute("name1",option);

        model.addAttribute("bardata1",likelihoodFrequency);


        //Pestle And Intensity

        int intensity = dataRepository.countOneColumn("intensity","pestle",option).get(0);

        model.addAttribute("radar1",intensity);

        dataReceiver.swot(dataRepository.all("swot"));
        List<String> allSwot = dataReceiver.getAllSwot();

        //Getting all the top 5 Sectors In A Region
        String [] setSwot = new String [allSwot.size()];
        int [] setFrequencySwot = new int [allSwot.size()];

        //Outer loop for sending only first 5 years to the DataCustomRepository
        //Inner for each loop gets frequency of all topics per year
        //Another loop is created to sort them in descending order

        for (int i=0; i<allSwot.size();i++) {
            int arrayIncrement = 0;
            for (String str : allSwot) {
                if(!str.isBlank() || str!=null) {
                    setSwot[arrayIncrement] = str; //SELECT COUNT( region ) FROM DATA WHERE sector = 'Healthcare'
                    setFrequencySwot[arrayIncrement] = dataRepository.getAllTimeFrequency(str,"swot").get(0);
                    arrayIncrement++;
                }
            }
            for(int j=0;j<setSwot.length;j++){

                for (int k=1;k<(setSwot.length-1);k++){

                    if( setFrequencySwot[k-1] < setFrequencySwot[k] ){

                        int temp = setFrequencySwot[k];
                        setFrequencySwot[k] = setFrequencySwot[k-1];
                        setFrequencySwot[k-1] = temp;

                        String temp1 = setSwot[k];
                        setSwot[k] = setSwot[k-1];
                        setSwot[k-1] = temp1;
                    }
                }
            }
        }
        for (int i=0; i<5;i++){

            int swotFrequency1 = dataRepository.countOneColumnExtraCondition("swot","pestle",option,"swot",setSwot[i]).get(0);


            String jspSwotHead = "swothead"+(i+1);

            String jspSwotData1 = "g"+(i+1);


            model.addAttribute(jspSwotHead, setSwot[i]);


            model.addAttribute(jspSwotData1,swotFrequency1);

        }


        //DropDown Data
        model.addAttribute("pestleList", allPestle);

        return "FilterPestle";
    }

    @RequestMapping("/Country")
    public String CountryPage(Model model){

        //Setting all years
        dataReceiver.years(dataRepository.all("end_year"));

        for (int i=0;i<10;i++){

            String jspYear = "year"+(i+1);

            model.addAttribute(jspYear,dataReceiver.get5Years()[i]);

        }

        // Name of Country With Its Likelihood in the Given Year

        //Initializing the country arrayList
        dataReceiver.country(dataRepository.all("country"));
        List<String> allCountry = dataReceiver.getAllCountry();

        //Getting all the top 5 Sectors In A Region
        String [] setCountry = new String [allCountry.size()];
        int [] setFrequencyCountry = new int [allCountry.size()];

        //Outer loop for sending only first 5 years to the DataCustomRepository
        //Inner for each loop gets frequency of all topics per year
        //Another loop is created to sort them in descending order

        for (int i=0; i<allCountry.size();i++) {
            int arrayIncrement = 0;
            for (String str : allCountry) {
                if(!str.isBlank()) {
                    setCountry[arrayIncrement] = str; //SELECT COUNT( region ) FROM DATA WHERE sector = 'Healthcare'
                    setFrequencyCountry[arrayIncrement] = dataRepository.getAllTimeFrequency(str,"country").get(0);
                    arrayIncrement++;
                }
            }
            for(int j=0;j<setCountry.length;j++){

                for (int k=1;k<(setCountry.length-1);k++){

                    if( setFrequencyCountry[k-1] < setFrequencyCountry[k] ){

                        int temp = setFrequencyCountry[k];
                        setFrequencyCountry[k] = setFrequencyCountry[k-1];
                        setFrequencyCountry[k-1] = temp;

                        String temp1 = setCountry[k];
                        setCountry[k] = setCountry[k-1];
                        setCountry[k-1] = temp1;
                    }
                }
            }
        }

        for (int i=0;i<10;i++){

            String jspLabelName = "name"+(i+1);

            String jspData1 = "A"+(i+1);
            String jspData2 = "B"+(i+1);
            String jspData3 = "C"+(i+1);
            String jspData4 = "D"+(i+1);
            String jspData5 = "E"+(i+1);

            int frequency1 = dataRepository.countOneColumnExtraCondition("likelihood","country",setCountry[0], "end_year", String.valueOf(dataReceiver.get5Years()[i])).get(0);
            int frequency2 = dataRepository.countOneColumnExtraCondition("likelihood","country",setCountry[1], "end_year", String.valueOf(dataReceiver.get5Years()[i])).get(0);
            int frequency3 = dataRepository.countOneColumnExtraCondition("likelihood","country",setCountry[2], "end_year", String.valueOf(dataReceiver.get5Years()[i])).get(0);
            int frequency4 = dataRepository.countOneColumnExtraCondition("likelihood","country",setCountry[3], "end_year", String.valueOf(dataReceiver.get5Years()[i])).get(0);
            int frequency5 = dataRepository.countOneColumnExtraCondition("likelihood","country",setCountry[4], "end_year", String.valueOf(dataReceiver.get5Years()[i])).get(0);

            //Setting Country Name On The Graph
            model.addAttribute(jspLabelName,setCountry[i]);

            //Setting Likelihood Value
            model.addAttribute(jspData1,frequency1);
            model.addAttribute(jspData2,frequency2);
            model.addAttribute(jspData3,frequency3);
            model.addAttribute(jspData4,frequency4);
            model.addAttribute(jspData5,frequency5);

        }

        //Top 5 Country and Intensity of Top 2 Topics

        //Initializing All Topics in ArrayList
        dataReceiver.topics(dataRepository.all("topic"));
        List<String> allTopics = dataReceiver.getTopic();

        //Getting all the top 5 topics
        String [] setTopic = new String [allTopics.size()];
        int [] setFrequency = new int [allTopics.size()];

        //Outer loop for sending only first 5 years to the DataCustomRepository
        //Inner for each loop gets frequency of all topics per year
        //Another loop is created to sort them in descending order

        for (int i=0; i<dataReceiver.get5Years().length;i++) {
            int arrayIncrement = 0;
            for (String str : allTopics) {
                if(!str.isBlank()) {
                    setTopic[arrayIncrement] = str;
                    setFrequency[arrayIncrement] = dataRepository.getAllTimeFrequency(str,"topic").get(0);
                    arrayIncrement++;
                }
            }
            for(int j=0;j<setTopic.length;j++){

                for (int k=1;k<(setTopic.length-1);k++){

                    if( setFrequency[k-1] < setFrequency[k] ){

                        int temp = setFrequency[k];
                        setFrequency[k] = setFrequency[k-1];
                        setFrequency[k-1] = temp;

                        String temp1 = setTopic[k];
                        setTopic[k] = setTopic[k-1];
                        setTopic[k-1] = temp1;
                    }
                }
            }
        }

        for (int i=0;i<5;i++){

            String jspCountry = "country"+(i+1);

            for (int j=0;j<2;j++) {

                String jspData1 = "a"+(i+1);
                String jspData2 = "b"+(i+1);

                int intensity1 = dataRepository.countOneColumnExtraCondition("intensity", "topic", setTopic[0], "country", setCountry[i]).get(0);
                int intensity2 = dataRepository.countOneColumnExtraCondition("intensity", "topic", setTopic[1], "country", setCountry[i]).get(0);

                model.addAttribute(jspData1,intensity1);
                model.addAttribute(jspData2,intensity2);

            }

            model.addAttribute("topic1",setTopic[0]);
            model.addAttribute("topic2",setTopic[1]);

            model.addAttribute(jspCountry,setCountry[i]);

        }

        //Intensity Relevance and Likelihood Of Top 5 Frequent Countries

        for (int i=0;i<5;i++){
            int relevance = dataRepository.getAllSum("relevance","country", setCountry[i]).get(0);
            int likelihood = dataRepository.getAllSum("likelihood","country", setCountry[i]).get(0);
            int intensity = dataRepository.getAllSum("intensity","country", setCountry[i]).get(0);

            String jspRelevance = "relevance"+(i+1);
            String jspLikelihood = "likelihood"+(i+1);
            String jspIntensity = "intensity"+(i+1);
            String jspLabel = "label"+(i+1);

            //Setting data for the chart
            model.addAttribute(jspRelevance,relevance);
            model.addAttribute(jspLikelihood,likelihood);
            model.addAttribute(jspIntensity,intensity);

            model.addAttribute(jspLabel,setCountry[i]);

        }


        model.addAttribute("countryList", allCountry);

        return "Country";
    }

    @RequestMapping("/FilterCountry")
    public String filterCountryPage(@RequestParam("con") String option, Model model){

        //Initializing All Country
        dataReceiver.country(dataRepository.all("country"));
        List<String> allCountry = dataReceiver.getAllCountry();

        if (option.isBlank()){
            CountryPage(model);
            return "Country";
        }

        //Country and Likelihood In A Year

        //Setting all years
        dataReceiver.years(dataRepository.all("end_year"));

        for (int i=0;i<10;i++){

            String jspYear = "year"+(i+1);

            model.addAttribute(jspYear,dataReceiver.get5Years()[i]);

        }

        for (int i=0;i<10;i++){

            String jspLabelName = "name"+(i+1);

            String jspData1 = "A"+(i+1);


            int frequency1 = dataRepository.countOneColumnExtraCondition("likelihood","country",option, "end_year", String.valueOf(dataReceiver.get5Years()[i])).get(0);

            //Setting Country Name On The Graph
            model.addAttribute(jspLabelName,option);

            //Setting Likelihood Value
            model.addAttribute(jspData1,frequency1);

        }


        //Country With Topic & Intensity

        //Finding most frequent topic in a country

        dataReceiver.topics(dataRepository.all("topic"));
        List<String> allTopics = dataReceiver.getTopic();

        String setTopic[] = new String[allTopics.size()];
        int setFrequency[] = new int[allTopics.size()];

        for (int i=0;i<allCountry.size();i++){
            int arrayIncrement = 0;
            for (String str : allTopics) {
                if(!str.isBlank()) {
                    setTopic[arrayIncrement] = str;
                    setFrequency[arrayIncrement] = dataRepository.countOneColumn("topic","country",option).get(0);
                    arrayIncrement++;
                }
            }
            for(int j=0;j<setTopic.length;j++){

                for (int k=1;k<(setTopic.length-1);k++){

                    if( setFrequency[k-1] < setFrequency[k] ){

                        int temp = setFrequency[k];
                        setFrequency[k] = setFrequency[k-1];
                        setFrequency[k-1] = temp;

                        String temp1 = setTopic[k];
                        setTopic[k] = setTopic[k-1];
                        setTopic[k-1] = temp1;
                    }
                }
            }
        }

        //Intensity Of that topic
        int intensity1 = dataRepository.countOneColumnExtraCondition("intensity","country",option,"topic",setTopic[0]).get(0);
        int intensity2 = dataRepository.countOneColumnExtraCondition("intensity","country",option,"topic",setTopic[1]).get(0);

        System.out.println(intensity1);
        System.out.println(intensity2);

        model.addAttribute("country1",option);

        model.addAttribute("topic1",setTopic[0]);
        model.addAttribute("topic2",setTopic[1]);

        model.addAttribute("a1",intensity1);
        model.addAttribute("b1",intensity2);



        //Country's Relevance Intensity And Likelihood

        int intensity = dataRepository.getAllSum("intensity","country", option).get(0);
        int likelihood = dataRepository.getAllSum("likelihood","country",option).get(0);
        int relevance = dataRepository.getAllSum("relevance","country",option).get(0);

        model.addAttribute("label1",option);
        model.addAttribute("intensity1",intensity);
        model.addAttribute("likelihood1",likelihood);
        model.addAttribute("relevance1",relevance);




        //DropDown Data
        model.addAttribute("countryList", allCountry);

        return "FilterCountry";

    }

}

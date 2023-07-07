<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Dashboard</title>
    <link rel="stylesheet" href="style.css">
</head>
<body>
    <div class="navBar">
            <a href="/">Home</a>
            <a href="/Topics">Topic</a>
            <a href="/Sector">Sector</a>
            <a href="/Year">Year</a>
            <a href="/Pestle">Pestle</a>
            <a href="/Country">Country</a>
        </div>
    
    <br>
     <div class="filterButton">
        <form action="/FilterSector">

        Select Sector:
        <Select name="sector">
            <c:forEach items="${sectorList}" var="sectorName" varStatus="loop">
                <option value="${sectorName}">
                    ${sectorName}
                </option>
            </c:forEach>
        </select>

        <button id="filter">Filter</button>

        </form>
     </div>
    
    <h2><center>End Year Of 5 Most Frequent Sectors</center></h2>
    
    <div class="chart1-container">
        <canvas id="chart1"></canvas>
    </div>
    
    <br>


    <h2><center>Intensity Likelihood & Relevance Of 5 Most Frequent Sectors</center></h2>
    <div class="chart2-container">
        <canvas id="chart2"></canvas>
    </div>
    <br>


    <h2><center>5 Most Frequent Sectors in Regions</center></h2>
    <div class="chart3-container">
        <canvas id="chart3"></canvas>
    </div>
    <br>

    <script src="https://cdn.jsdelivr.net/npm/chart.js"></script>
    <script>
        
        const xValues = ['<%= request.getAttribute("year1") %>','<%= request.getAttribute("year2") %>',
        '<%= request.getAttribute("year3") %>','<%= request.getAttribute("year4") %>',
        '<%= request.getAttribute("year5") %>','<%= request.getAttribute("year6") %>',
        '<%= request.getAttribute("year7") %>','<%= request.getAttribute("year8") %>',
        '<%= request.getAttribute("year9") %>','<%= request.getAttribute("year10") %>'];

        new Chart("chart1", {
        type: "line",
        data: {
            labels: xValues,
            datasets: [{
                    label: '<%= request.getAttribute("name1") %>',
                    data: ['<%= request.getAttribute("A1") %>','<%= request.getAttribute("A2") %>',
                    '<%= request.getAttribute("A3") %>','<%= request.getAttribute("A4") %>',
                    '<%= request.getAttribute("A5") %>','<%= request.getAttribute("A6") %>',
                    '<%= request.getAttribute("A7") %>','<%= request.getAttribute("A8") %>',
                    '<%= request.getAttribute("A9") %>','<%= request.getAttribute("A10") %>'],
                    borderColor: "rgba(255, 99, 132, 0.5)",
                    fill: false
                },{
                    label:'<%= request.getAttribute("name2") %>',
                    data: ['<%= request.getAttribute("B1") %>','<%= request.getAttribute("B2") %>',
                    '<%= request.getAttribute("B3") %>','<%= request.getAttribute("B4") %>',
                    '<%= request.getAttribute("B5") %>','<%= request.getAttribute("B6") %>',
                    '<%= request.getAttribute("B7") %>','<%= request.getAttribute("B8") %>',
                    '<%= request.getAttribute("B9") %>','<%= request.getAttribute("B10") %>'],
                    borderColor: "rgb(25, 167, 206)",
                    fill: false
                },{
                    label: '<%= request.getAttribute("name3") %>',
                    data: ['<%= request.getAttribute("C1") %>','<%= request.getAttribute("C2") %>',
                    '<%= request.getAttribute("C3") %>','<%= request.getAttribute("C4") %>',
                    '<%= request.getAttribute("C5") %>','<%= request.getAttribute("C6") %>',
                    '<%= request.getAttribute("C7") %>','<%= request.getAttribute("C8") %>',
                    '<%= request.getAttribute("C9") %>','<%= request.getAttribute("C10") %>'],
                    borderColor: "rgba(255, 206, 86, 0.5)",
                    fill: false
                },{
                    label: '<%= request.getAttribute("name4") %>',
                    data: ['<%= request.getAttribute("D1") %>','<%= request.getAttribute("D2") %>',
                    '<%= request.getAttribute("D3") %>','<%= request.getAttribute("D4") %>',
                    '<%= request.getAttribute("D5") %>','<%= request.getAttribute("D6") %>',
                    '<%= request.getAttribute("D7") %>','<%= request.getAttribute("D8") %>',
                    '<%= request.getAttribute("D9") %>','<%= request.getAttribute("D10") %>'],
                    borderColor: "rgb(175, 211, 226)",
                    fill: false
                },{
                    label: '<%= request.getAttribute("name5") %>',
                    data: ['<%= request.getAttribute("E1") %>','<%= request.getAttribute("E2") %>',
                    '<%= request.getAttribute("E3") %>','<%= request.getAttribute("E4") %>',
                    '<%= request.getAttribute("E5") %>','<%= request.getAttribute("E6") %>',
                    '<%= request.getAttribute("E7") %>','<%= request.getAttribute("E8") %>',
                    '<%= request.getAttribute("E9") %>','<%= request.getAttribute("E10") %>'],
                    borderColor: "rgb(20, 108, 148)",
                    fill: false
                }]
            },
            options: {
                legend: {display: true}
            }
        });

        var ctx2 = document.getElementById('chart2').getContext('2d');
        var myChart2 = new Chart(ctx2, {
            type: 'bar',
            data: {
                labels: ['<%= request.getAttribute("label1") %>', '<%= request.getAttribute("label2") %>',
                '<%= request.getAttribute("label3") %>', '<%= request.getAttribute("label4") %>',
                '<%= request.getAttribute("label5") %>'],
                datasets: [{
                label: 'Intensity',
                backgroundColor: 'rgb(175, 211, 226)',
                data: ['<%= request.getAttribute("intensity1") %>', '<%= request.getAttribute("intensity2") %>',
                '<%= request.getAttribute("intensity3") %>', '<%= request.getAttribute("intensity4") %>',
                '<%= request.getAttribute("intensity5") %>'],
            }, {
                label: 'Relevance',
                backgroundColor: 'rgb(25, 167, 206)',
                data: ['<%= request.getAttribute("relevance1") %>', '<%= request.getAttribute("relevance2") %>',
                '<%= request.getAttribute("relevance3") %>', '<%= request.getAttribute("relevance4") %>',
                '<%= request.getAttribute("relevance5") %>'],
            }, {
                label: 'Likelihood',
                backgroundColor: 'rgb(20, 108, 148)',
                data: ['<%= request.getAttribute("likelihood1") %>', '<%= request.getAttribute("likelihood2") %>',
                                '<%= request.getAttribute("likelihood3") %>', '<%= request.getAttribute("likelihood4") %>',
                                '<%= request.getAttribute("likelihood5") %>'],
            }]
        },
            options: {
                responsive: true,
                    scales: {
                        xAxes: [{
                        stacked: true,
                        }],
                        yAxes: [{
                        stacked: true,
                        ticks: {
                        beginAtZero: true,
                        }
                    }]
                }
            }
        });
           

//        var ctx3 = document.getElementById('chart3').getContext('2d');
//        var myChart3 = new Chart(ctx3, {
      var ctx3 = document.getElementById("chart3").getContext("2d");
      var myChart3 = new Chart(ctx3, {
         type: 'bar',
         data: {
            labels: ['<%= request.getAttribute("bar1") %>', '<%= request.getAttribute("bar2") %>',
            '<%= request.getAttribute("bar3") %>', '<%= request.getAttribute("bar4") %>',
            '<%= request.getAttribute("bar5") %>'],
            datasets: [{
                data: ['<%= request.getAttribute("sectorRegionCount1") %>', '<%= request.getAttribute("sectorRegionCount2") %>',
                '<%= request.getAttribute("sectorRegionCount3") %>', '<%= request.getAttribute("sectorRegionCount4") %>',
                '<%= request.getAttribute("sectorRegionCount5") %>'],
               backgroundColor: ['rgba(255, 99, 132, 0.5)', 'rgb(25, 167, 206)', 'rgba(255, 206, 86, 0.5)', 'rgb(175, 211, 226)', 'rgb(20, 108, 148)'],
               borderWidth: 2,
            }],
         },
         options: {
             plugins: {
                 legend: false
             },
            responsive: false,
         },
      });

    </script>
</body>
</html>

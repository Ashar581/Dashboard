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
            <a href="/Sector">Sector</a>
            <a href="/Topics">Topic</a>
            <a href="/Year">Year</a>
            <a href="/Pestle">Pestle</a>
            <a href="/Country">Country</a>
    </div>

    <br>

     <div class="filterButton">
        <form action="/FilterCountry">

        Select Country:
        <Select name="con">
            <c:forEach items="${countryList}" var="countryName" varStatus="loop">
                <option value="${countryName}">
                    ${countryName}
                </option>
            </c:forEach>
        </select>

        <button id="filter">Filter</button>

        </form>
     </div>

     <h2><center>Name of 5 Most Frequent Country With Its Likelihood in the Given Year</center></h2>


    <div class="chart-container">
        <canvas id="scatter-chart"></canvas>
    </div>


    <div class="chart-container">
        <canvas id="grouped-bar-chart"></canvas>
    </div>

    <div class="chart-container">
        <canvas id="floating-bar-chart"></canvas>
    </div>


    <script src="https://cdn.jsdelivr.net/npm/chart.js@3.5.1"></script>
    <script>


var ctx2 = document.getElementById('scatter-chart').getContext('2d');
var myChart2 = new Chart(ctx2, {
    type: 'line',
    data: {
        labels: ['<%= request.getAttribute("year1") %>','<%= request.getAttribute("year2") %>',
        '<%= request.getAttribute("year3") %>','<%= request.getAttribute("year4") %>',
        '<%= request.getAttribute("year5") %>','<%= request.getAttribute("year6") %>',
        '<%= request.getAttribute("year7") %>','<%= request.getAttribute("year8") %>',
        '<%= request.getAttribute("year9") %>','<%= request.getAttribute("year10") %>'],

        datasets: [{
            label: '<%= request.getAttribute("name1") %>',
            borderColor: 'rgba(255, 99, 132, 1)',
            data: ['<%= request.getAttribute("A1") %>', '<%= request.getAttribute("A2") %>',
            '<%= request.getAttribute("A3") %>', '<%= request.getAttribute("A4") %>',
            '<%= request.getAttribute("A5") %>', '<%= request.getAttribute("A6") %>',
            '<%= request.getAttribute("A7") %>', '<%= request.getAttribute("A8") %>',
            '<%= request.getAttribute("A9") %>', '<%= request.getAttribute("A10") %>'],
            fill: false,
        },{
            label: '<%= request.getAttribute("name2") %>',
            borderColor: 'rgba(54, 162, 235, 1)',
            data: ['<%= request.getAttribute("B1") %>', '<%= request.getAttribute("B2") %>',
            '<%= request.getAttribute("B3") %>', '<%= request.getAttribute("B4") %>',
            '<%= request.getAttribute("B5") %>', '<%= request.getAttribute("B6") %>',
            '<%= request.getAttribute("B7") %>', '<%= request.getAttribute("B8") %>',
            '<%= request.getAttribute("B9") %>', '<%= request.getAttribute("B10") %>'],
            fill: false,
        },{
            label: '<%= request.getAttribute("name3") %>',
            borderColor: 'rgba(255, 99, 132, 0.5)',
            data: ['<%= request.getAttribute("C1") %>', '<%= request.getAttribute("C2") %>',
                        '<%= request.getAttribute("C3") %>', '<%= request.getAttribute("C4") %>',
                        '<%= request.getAttribute("C5") %>', '<%= request.getAttribute("C6") %>',
                        '<%= request.getAttribute("C7") %>', '<%= request.getAttribute("C8") %>',
                        '<%= request.getAttribute("C9") %>', '<%= request.getAttribute("C10") %>'],
            fill: false,
        },{
            label: '<%= request.getAttribute("name4") %>',
            borderColor: 'rgba(54, 162, 235, 0.5)',
            data: ['<%= request.getAttribute("D1") %>', '<%= request.getAttribute("D2") %>',
                        '<%= request.getAttribute("D3") %>', '<%= request.getAttribute("D4") %>',
                        '<%= request.getAttribute("D5") %>', '<%= request.getAttribute("D6") %>',
                        '<%= request.getAttribute("D7") %>', '<%= request.getAttribute("D8") %>',
                        '<%= request.getAttribute("D9") %>', '<%= request.getAttribute("D10") %>'],
            fill: false,
        },{
            label: '<%= request.getAttribute("name5") %>',
            borderColor: 'rgba(255, 206, 86, 0.5)',
            data: ['<%= request.getAttribute("E1") %>', '<%= request.getAttribute("E2") %>',
                        '<%= request.getAttribute("E3") %>', '<%= request.getAttribute("E4") %>',
                        '<%= request.getAttribute("E5") %>', '<%= request.getAttribute("E6") %>',
                        '<%= request.getAttribute("E7") %>', '<%= request.getAttribute("E8") %>',
                        '<%= request.getAttribute("E9") %>', '<%= request.getAttribute("E10") %>'],
            fill: false,
        }]
    },
    options: {
        responsive: true,
        scales: {
            xAxes: [{
                ticks: {
                    beginAtZero: true,
                }
            }]
        }
    }
});



        // Custom data for countries, topics, and intensity
        const countryData2 = [
          { country: '<%= request.getAttribute("country1") %>', topic: '<%= request.getAttribute("topic1") %>', intensity: '<%= request.getAttribute("a1") %>' },
          { country: '<%= request.getAttribute("country1") %>', topic: '<%= request.getAttribute("topic2") %>', intensity: '<%= request.getAttribute("b1") %>' },
          { country: '<%= request.getAttribute("country2") %>', topic: '<%= request.getAttribute("topic1") %>', intensity: '<%= request.getAttribute("a2") %>' },
          { country: '<%= request.getAttribute("country2") %>', topic: '<%= request.getAttribute("topic2") %>', intensity: '<%= request.getAttribute("b2") %>' },
          { country: '<%= request.getAttribute("country3") %>', topic: '<%= request.getAttribute("topic1") %>', intensity: '<%= request.getAttribute("a3") %>' },
          { country: '<%= request.getAttribute("country3") %>', topic: '<%= request.getAttribute("topic2") %>', intensity: '<%= request.getAttribute("b3") %>' },
          { country: '<%= request.getAttribute("country4") %>', topic: '<%= request.getAttribute("topic1") %>', intensity: '<%= request.getAttribute("a4") %>' },
          { country: '<%= request.getAttribute("country4") %>', topic: '<%= request.getAttribute("topic2") %>', intensity: '<%= request.getAttribute("b4") %>' },
          { country: '<%= request.getAttribute("country5") %>', topic: '<%= request.getAttribute("topic1") %>', intensity: '<%= request.getAttribute("a5") %>' },
          { country: '<%= request.getAttribute("country5") %>', topic: '<%= request.getAttribute("topic2") %>', intensity: '<%= request.getAttribute("b5") %>' }
        ];

        // Group data by country and topic
        const groupedData = {};
        for (let i = 0; i < countryData2.length; i++) {
          const { country, topic, intensity } = countryData2[i];
          if (!groupedData[country]) {
            groupedData[country] = {};
          }
          groupedData[country][topic] = intensity;
        }

        // Extract unique topics and countries
        const topics = Object.keys(groupedData[Object.keys(groupedData)[0]]);
        const countries = Object.keys(groupedData);

        // Prepare data for chart
        const datasets = [];
        for (let i = 0; i < topics.length; i++) {
          const topic = topics[i];
          const data = [];
          for (let j = 0; j < countries.length; j++) {
            const country = countries[j];
            data.push(groupedData[country][topic]);
          }
          datasets.push({
            label: topic,
            data: data,
            backgroundColor: [`rgb(190, 90, 131)`, 'rgb(252, 200, 209)'],
            borderColor: `rgb(252, 200, 209)`,
            borderWidth: 1
          });
        }

        // Chart configuration
        const chart = document.getElementById('grouped-bar-chart').getContext('2d');

        const groupedBarChart = new Chart(chart, {
          type: 'bar',
          data: {
            labels: countries,
            datasets: datasets
          },
          options: {
    scales: {
      x: {
        title: {
          display: true,
          text: 'Country'
        }
      },
      y: {
        beginAtZero: true,
        title: {
          display: true,
          text: 'Intensity'
        }
      }
    },
    plugins: {
      title: {
        display: true,
        text: 'Topic Intensity by Country (Grouped Bar Chart)'
      }
    }
  }
});


var ctx2 = document.getElementById('floating-bar-chart').getContext('2d');
var myChart2 = new Chart(ctx2, {
    type: 'bar',
    data: {
        labels: ['<%= request.getAttribute("label1") %>', '<%= request.getAttribute("label2") %>',
        '<%= request.getAttribute("label3") %>', '<%= request.getAttribute("label4") %>',
         '<%= request.getAttribute("label5") %>'],
        datasets: [{
            label: 'Intensity',
            backgroundColor: 'rgb(175, 211, 226)',
            data: ['<%= request.getAttribute("intensity1") %>', '<%= request.getAttribute("intensity2") %>', '<%= request.getAttribute("intensity3") %>',
                               '<%= request.getAttribute("intensity4") %>', '<%= request.getAttribute("intensity5") %>'],
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


        function myFunction(){

            document.getElementById("filter").innerHTML = "Suck It";

        }


    </script>
</body>
</html>

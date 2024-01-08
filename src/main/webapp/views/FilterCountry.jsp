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

     <h2><center><%= request.getAttribute("name1") %> With Its Likelihood in the Given Year</center></h2>


    <div class="chart-container">
        <canvas id="scatter-chart"></canvas>
    </div>


    <div class="chart-container">
        <canvas id="grouped-bar-chart"></canvas>
    </div>

<h2><center><%= request.getAttribute("name1") %> And It Intensity, Relevance & Likelihood</center></h2>

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
        text: 'Topic Intensity by <%= request.getAttribute("name1")%> (Grouped Bar Chart)'
      }
    }
  }
});


var ctx2 = document.getElementById('floating-bar-chart').getContext('2d');
var myChart2 = new Chart(ctx2, {
    type: 'bar',
    data: {
        labels: ['<%= request.getAttribute("label1") %>'],
        datasets: [{
            label: 'Intensity',
            backgroundColor: 'rgb(175, 211, 226)',
            data: ['<%= request.getAttribute("intensity1") %>'],
        }, {
            label: 'Relevance',
            backgroundColor: 'rgb(25, 167, 206)',
            data: ['<%= request.getAttribute("relevance1") %>'],
        }, {
            label: 'Likelihood',
            backgroundColor: 'rgb(20, 108, 148)',
            data: ['<%= request.getAttribute("likelihood1") %>'],
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

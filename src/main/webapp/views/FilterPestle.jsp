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
        <form action="/FilterPestle">

        Select Country:
        <Select name="pestle">
            <c:forEach items="${pestleList}" var="pestleName" varStatus="loop">
                <option value="${pestleName}">
                    ${pestleName}
                </option>
            </c:forEach>
        </select>

        <button id="filter">Filter</button>

        </form>
     </div>

    <h2><center>Top 5 Pestle And Its Likelihood Counts</center></h2>


    <div class="chartX1-container">
        <center><canvas id="chart1"></canvas></center>
    </div>

    <h2><center><%= request.getAttribute("name1") %> And Its Intensity Counts</center></h2>

    <div class ="chartX2-container">
        <canvas id="radar-chart"></canvas>
      </div>

    <h2><center>Top 5 Pestle With Top 5 SWOT In Respective Of Pestle</center></h2>

      <div class ="chartX3-container">
        <canvas id="barchart"></canvas>
      </div>
      <script src="https://cdn.jsdelivr.net/npm/chart.js@3.5.1"></script>

    <!-- <script src="script.js"></script> -->

    <script>// Get data
var ctx3 = document.getElementById("chart1").getContext("2d");
      var myChart3 = new Chart(ctx3, {
         type: 'bar',
         data: {
            labels: ['<%= request.getAttribute("name1") %>'],
            datasets: [{
                data: ['<%= request.getAttribute("bardata1") %>'],
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



        // Prepare data for radar chart
        const radarData = {
            labels: ['<%= request.getAttribute("name1") %>'],
          datasets: [{
            label: 'Intensity',
                data: ['<%= request.getAttribute("radar1") %>'],
            backgroundColor: 'rgba(51, 102, 255, 0.2)',
            borderColor: 'rgba(51, 102, 255, 1)',
            borderWidth: 1,
          }]
        };

        // Chart configuration
        const radarConfig = {
          type: 'radar',
          data: radarData,
          options: {
            scales: {
              r: {
                suggestedMin: 0,
                suggestedMax: 100,
                ticks: {
                  stepSize: 20,
                  callback: function (value, index, values) {
                    return value + ' Intensity';
                  }
                }
              }
            }
          }
        };

        // Initialize radar chart
        const radarChart = new Chart(document.getElementById('radar-chart'), radarConfig);



// Data for the bar graph
var data2 = {
            labels: ['<%= request.getAttribute("name1") %>'],

    datasets: [
    {
      label: '<%= request.getAttribute("swothead1") %>',

      data: ['<%= request.getAttribute("g1") %>'],

      backgroundColor: 'rgb(183, 153, 255)'
    },
    {
      label: '<%= request.getAttribute("swothead2") %>',

      data: ['<%= request.getAttribute("g2") %>'],

      backgroundColor: 'rgb(172, 188, 255)'
    },
    {
      label: '<%= request.getAttribute("swothead3") %>',

      data: ['<%= request.getAttribute("g3") %>'],

       backgroundColor: 'rgb(176, 218, 255)'
    },
    {
      label: '<%= request.getAttribute("swothead4") %>',

      data: ['<%= request.getAttribute("g4") %>'],

      backgroundColor: 'rgb(176, 218, 255)'
    },
    {
      label: '<%= request.getAttribute("swothead5") %>',

      data: ['<%= request.getAttribute("g5") %>'],

      backgroundColor: 'rgb(185, 233, 252)'
    }
  ]
};

// Create the bar chart
var barchart = document.getElementById('barchart').getContext('2d');
var chart = new Chart(barchart, {
  type: 'bar',
  data: data2,
  options: {
    responsive: true,
    indexAxis: 'y',
    scales: {
      x: {
        beginAtZero: true,
      },
      y: {
        reverse: true,
      }
    }
  }
});

  </script>

  </body>
</html>



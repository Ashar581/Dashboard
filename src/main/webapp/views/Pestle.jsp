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

        Select Pestle:
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

    <h2><center>Top 5 Pestle And Its Intensity Counts</center></h2>

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
            labels: ['<%= request.getAttribute("bar1") %>', '<%= request.getAttribute("bar2") %>',
            '<%= request.getAttribute("bar3") %>', '<%= request.getAttribute("bar4") %>',
            '<%= request.getAttribute("bar5") %>'],
            datasets: [{
                data: ['<%= request.getAttribute("bardata1") %>', '<%= request.getAttribute("bardata2") %>',
                '<%= request.getAttribute("bardata3") %>', '<%= request.getAttribute("bardata4") %>',
                '<%= request.getAttribute("bardata5") %>'],
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
            labels: ['<%= request.getAttribute("pestle1") %>', '<%= request.getAttribute("pestle2") %>',
            '<%= request.getAttribute("pestle3") %>', '<%= request.getAttribute("pestle4") %>',
            '<%= request.getAttribute("pestle5") %>'],
          datasets: [{
            label: 'Intensity',
                data: ['<%= request.getAttribute("radar1") %>', '<%= request.getAttribute("radar2") %>',
                '<%= request.getAttribute("radar3") %>', '<%= request.getAttribute("radar4") %>',
                '<%= request.getAttribute("radar5") %>'],
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
            labels: ['<%= request.getAttribute("pestle1") %>', '<%= request.getAttribute("pestle2") %>',
            '<%= request.getAttribute("pestle3") %>', '<%= request.getAttribute("pestle4") %>',
            '<%= request.getAttribute("pestle5") %>'],

    datasets: [
    {
      label: '<%= request.getAttribute("swothead1") %>',

      data: ['<%= request.getAttribute("g1") %>', '<%= request.getAttribute("g2") %>',
      '<%= request.getAttribute("g3") %>', '<%= request.getAttribute("g4") %>',
      '<%= request.getAttribute("g5") %>'],

      backgroundColor: 'rgb(183, 153, 255)'
    },
    {
      label: '<%= request.getAttribute("swothead2") %>',

      data: ['<%= request.getAttribute("h1") %>', '<%= request.getAttribute("h2") %>',
      '<%= request.getAttribute("h3") %>', '<%= request.getAttribute("h4") %>',
      '<%= request.getAttribute("h5") %>'],

      backgroundColor: 'rgb(172, 188, 255)'
    },
    {
      label: '<%= request.getAttribute("swothead3") %>',

      data: ['<%= request.getAttribute("i1") %>', '<%= request.getAttribute("i2") %>',
      '<%= request.getAttribute("i3") %>', '<%= request.getAttribute("i4") %>',
      '<%= request.getAttribute("i5") %>'],

       backgroundColor: 'rgb(176, 218, 255)'
    },
    {
      label: '<%= request.getAttribute("swothead4") %>',

      data: ['<%= request.getAttribute("j1") %>', '<%= request.getAttribute("j2") %>',
      '<%= request.getAttribute("j3") %>', '<%= request.getAttribute("j4") %>',
      '<%= request.getAttribute("j5") %>'],

      backgroundColor: 'rgb(176, 218, 255)'
    },
    {
      label: '<%= request.getAttribute("swothead5") %>',

      data: ['<%= request.getAttribute("k1") %>', '<%= request.getAttribute("k2") %>',
      '<%= request.getAttribute("k3") %>', '<%= request.getAttribute("k4") %>',
      '<%= request.getAttribute("k5") %>'],

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



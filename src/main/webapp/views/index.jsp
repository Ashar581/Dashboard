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
    <h5><center><i><b>(Select Options from the Navigation Bar for Filtering Option)</b></i></center></h5>
        
    <h2><center>End Year of 5 Most Frequent Topics, Sectors & Pestles</center></h2>
    
    <div class="chart1-container">
        <canvas id="chart1"></canvas>
    </div>
    
    <br>


    <h2><center>Intensity Likelihood & Relevance Of 5 Most Frequent Topics</center></h2>
    <div class="chart2-container">
        <canvas id="chart2"></canvas>
    </div>
    <br>


    <h2><center>Topic and End_year of 5 Most Frequent Topics</center></h2>
    <div class="chart3-container">
        <canvas id="chart3"></canvas>
    </div>
    <br>

    <script src="https://cdn.jsdelivr.net/npm/chart.js"></script>
    <script>
        var ctx1 = document.getElementById('chart1').getContext('2d');
        var myChart1 = new Chart(ctx1, {
        type: 'bar',
        data: {
            labels: ['<%= request.getAttribute("year1") %>', '<%= request.getAttribute("year2") %>', '<%= request.getAttribute("year3") %>',
            '<%= request.getAttribute("year4") %>', '<%= request.getAttribute("year5") %>'],
            datasets: [{
            label: 'Topic: <%= request.getAttribute("topic") %>',
            backgroundColor: 'rgba(255, 99, 132, 0.5)',
            data: ['<%= request.getAttribute("topicdata1") %>', '<%= request.getAttribute("topicdata2") %>', '<%= request.getAttribute("topicdata3") %>',
                               '<%= request.getAttribute("topicdata4") %>', '<%= request.getAttribute("topicdata5") %>'],
        }, {
            label: 'Sector: <%= request.getAttribute("topic2") %>',
            backgroundColor: 'rgba(54, 162, 235, 0.5)',
            data: ['<%= request.getAttribute("sectordata1") %>', '<%= request.getAttribute("sectordata2") %>', '<%= request.getAttribute("sectordata3") %>',
                                                  '<%= request.getAttribute("sectordata4") %>', '<%= request.getAttribute("sectordata5") %>'],
        }, {
            label: 'Pestle: <%= request.getAttribute("topic3") %>',
            backgroundColor: 'rgba(255, 206, 86, 0.5)',
            data: ['<%= request.getAttribute("pestledata1") %>', '<%= request.getAttribute("pestledata2") %>', '<%= request.getAttribute("pestledata3") %>',
                                                                     '<%= request.getAttribute("pestledata4") %>', '<%= request.getAttribute("pestledata5") %>'],
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
           

var ctx3 = document.getElementById('chart3').getContext('2d');
var myChart3 = new Chart(ctx3, {
    type: 'line',
    data: {
        labels: ['<%= request.getAttribute("year1") %>', '<%= request.getAttribute("year2") %>', '<%= request.getAttribute("year3") %>',
                             '<%= request.getAttribute("year4") %>', '<%= request.getAttribute("year5") %>'],
        datasets: [{
            label: '<%= request.getAttribute("compare1") %>',
            borderColor: 'rgba(255, 99, 132, 1)',
            data: ['<%= request.getAttribute("data1") %>', '<%= request.getAttribute("data2") %>',
             '<%= request.getAttribute("data3") %>', '<%= request.getAttribute("data4") %>',
              '<%= request.getAttribute("data5") %>'],
            fill: false,
        }, {
            label: '<%= request.getAttribute("compare2") %>',
            borderColor: 'rgba(54, 162, 235, 1)',
            data: ['<%= request.getAttribute("second1") %>', '<%= request.getAttribute("second2") %>',
                                '<%= request.getAttribute("second3") %>', '<%= request.getAttribute("second4") %>',
                                 '<%= request.getAttribute("second5") %>'],
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

    </script>
</body>
</html>

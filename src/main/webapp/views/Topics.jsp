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
        <form action="/FilterTopic">

        Select Topic:
        <Select name="topic">
            <c:forEach items="${topicList}" var="topicName" varStatus="loop">
                <option value="${topicName}">
                    ${topicName}
                </option>
            </c:forEach>
        </select>

        <button id="filter">Filter</button>

        </form>
     </div>
    
    <h2><center>3 Most Frequent Topics Per Year</center></h2>

    <div class="chart1-container">
        <canvas id="chart1"></canvas>
    </div>
    <br>
    
    <h1><center>5 Most Frequent Topics</center></h1>

    <div class="chart2-container">
        <canvas id="chart2"></canvas>
    </div>
    <br>
    
    <h1><center>5 Most Frequent Topics And Total Frequency Of It's Country & Relevance </center></h1>
    
    <div class="chart3-container">
        <canvas id="chart3"></canvas>
    </div>

    <script src="https://cdn.jsdelivr.net/npm/chart.js"></script>
    

    <script>// Define data
        var labels = ['<%= request.getAttribute("year1") %>', '<%= request.getAttribute("year2") %>',
         '<%= request.getAttribute("year3") %>', '<%= request.getAttribute("year4") %>',
          '<%= request.getAttribute("year5") %>'];

        var regionLabels = ['<%= request.getAttribute("topic1") %>', '<%= request.getAttribute("topic2") %>',
         '<%= request.getAttribute("topic3") %>'];

        var data = [
            ['<%= request.getAttribute("data1") %>', '<%= request.getAttribute("data2") %>',
             '<%= request.getAttribute("data3") %>', '<%= request.getAttribute("data4") %>',
             '<%= request.getAttribute("data5") %>'],

            ['<%= request.getAttribute("second1") %>', '<%= request.getAttribute("second2") %>',
             '<%= request.getAttribute("second3") %>', '<%= request.getAttribute("second4") %>',
              '<%= request.getAttribute("second5") %>'],

            ['<%= request.getAttribute("third1") %>', '<%= request.getAttribute("third2") %>',
             '<%= request.getAttribute("third3") %>', '<%= request.getAttribute("third4") %>',
              '<%= request.getAttribute("third5") %>']

        ];
        
        // Create line chart
        var lineChart = new Chart(document.getElementById('chart1'), {
            type: 'line',
            data: {
                labels: labels,
                datasets: [{
                    label: regionLabels[0],
                    data: data[0],
                    backgroundColor: 'rgba(255, 99, 132, 0.2)',
                    borderColor: 'rgba(255, 99, 132, 1)',
                    borderWidth: 1
                }, {
                    label: regionLabels[1],
                    data: data[1],
                    backgroundColor: 'rgba(54, 162, 235, 0.2)',
                    borderColor: 'rgba(54, 162, 235, 1)',
                    borderWidth: 1
                }, {
                    label: regionLabels[2],
                    data: data[2],
                    backgroundColor: 'rgba(255, 206, 86, 0.2)',
                    borderColor: 'rgba(255, 206, 86, 1)',
                    borderWidth: 1
                }]
            },
            options: {
                title: {
                    display: true,
                    text: 'Topic Trend Line Chart'
                },
                scales: {
                    xAxes: [{
                        ticks: {
                            beginAtZero: true
                        }
                    }],
                    yAxes: [{
                        ticks: {
                            beginAtZero: true
                        }
                    }]
                }
            }
        });
        
        
        
        // Define topic labels and data
        var topicLabels = ['<%= request.getAttribute("a1") %>', '<%= request.getAttribute("a2") %>',
         '<%= request.getAttribute("a3") %>', '<%= request.getAttribute("a4") %>',
          '<%= request.getAttribute("a5") %>'];

        var topicData = ['<%= request.getAttribute("alphabet1") %>', '<%= request.getAttribute("alphabet2") %>',
         '<%= request.getAttribute("alphabet3") %>', '<%= request.getAttribute("alphabet4") %>',
          '<%= request.getAttribute("alphabet5") %>'];
        
        // Create pie chart
        var topicPieChart = new Chart(document.getElementById('chart2'), {
            type: 'pie',
            data: {
                labels: topicLabels,
                datasets: [{
                    data: topicData,
                    backgroundColor: [
                        '#AFD3E2',
                        '#05BFDB',
                        '#19A7CE',
                        '#3795BD',
                        '#009FBD',
                        
                        
                    ]
                }]
            },
            options: {
                title: {
                    display: true,
                    text: 'Topic Distribution'
                }
            }
        });
        
        
        
        
        
        var ctx2 = document.getElementById('chart3').getContext('2d');
        var myChart2 = new Chart(ctx2, {
            type: 'bar',
            data: {
                labels: ['<%= request.getAttribute("label1") %>', '<%= request.getAttribute("label2") %>',
                 '<%= request.getAttribute("label3") %>', '<%= request.getAttribute("label4") %>',
                  '<%= request.getAttribute("label5") %>'],
                datasets: [{
                    label: 'Country',
                    backgroundColor: '#46C2CB',
                    data: ['<%= request.getAttribute("country1") %>', '<%= request.getAttribute("country2") %>',
                    '<%= request.getAttribute("country3") %>', '<%= request.getAttribute("country4") %>',
                     '<%= request.getAttribute("country5") %>'],
                }, {
                    label: 'Relevance',
                    backgroundColor: '#ADE4DB',
                    data: ['<%= request.getAttribute("relevance1") %>', '<%= request.getAttribute("relevance2") %>',
                     '<%= request.getAttribute("relevance3") %>', '<%= request.getAttribute("relevance4") %>',
                      '<%= request.getAttribute("relevance5") %>'],
                }, 
                ]
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
                   </script>

</body>
</html>



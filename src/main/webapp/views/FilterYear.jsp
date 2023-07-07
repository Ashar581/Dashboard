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
        <form action="/FilterYear">

        Select Year:
        <Select name="years">
            <c:forEach items="${yearList}" var="yearName" varStatus="loop">
                <option value="${yearName}">
                    ${yearName}
                </option>
            </c:forEach>
        </select>

        <button id="filter">Filter</button>

        </form>
     </div>

    <h2><center>Comparison Of 2 Most Frequent Topics In The <%= request.getAttribute("year1")%></center></h2>

    <div class="chart1-container">
        <canvas id="chart1"></canvas>
    </div>

    <br>


    <h2><center>Intensity Of 5 Most Frequent Sectors In The <%= request.getAttribute("year1")%></center></h2>
    <div class="chart2-container">
        <canvas id="chart2"></canvas>
    </div>
    <br>


    <h2><center>5 Most Frequent Sectors Per Year</center></h2>
    <div class="chart3-container">
        <canvas id="chart3"></canvas>
    </div>
    <br>

    <script src="https://cdn.jsdelivr.net/npm/chart.js"></script>
    <script>

const ctx1 = document.getElementById('chart1').getContext('2d');
const chart = new Chart(ctx1, {
  type: 'bar',
  data: {
                labels: ['<%= request.getAttribute("year1") %>'],
                datasets: [{
                label: '<%= request.getAttribute("label1") %>',
                backgroundColor: 'rgb(175, 211, 226)',
                data: ['<%= request.getAttribute("first1") %>'],
            }, {
                label:'<%= request.getAttribute("label2") %>',
                backgroundColor: 'rgb(20, 108, 148)',
                data: ['<%= request.getAttribute("second1") %>'],
            }]
        },
  options: {
    indexAxis: 'y', // <-- here
    responsive: true
  }
});


var ctx2 = document.getElementById('chart2').getContext('2d');
var myChart2 = new Chart(ctx2, {
    type: 'line',
    data: {
        labels: ['<%= request.getAttribute("year1") %>'],

        datasets: [{
            label: '<%= request.getAttribute("name1") %>',
            borderColor: 'rgba(255, 99, 132, 1)',
            data: ['<%= request.getAttribute("A1") %>'],
            fill: false,
        },{
            label: '<%= request.getAttribute("name2") %>',
            borderColor: 'rgba(54, 162, 235, 1)',
            data: ['<%= request.getAttribute("B1") %>'],
            fill: false,
        },{
            label: '<%= request.getAttribute("name3") %>',
            borderColor: 'rgba(255, 99, 132, 0.5)',
            data: ['<%= request.getAttribute("C1") %>'],
            fill: false,
        },{
            label: '<%= request.getAttribute("name4") %>',
            borderColor: 'rgba(54, 162, 235, 0.5)',
            data: ['<%= request.getAttribute("D1") %>'],
            fill: false,
        },{
            label: '<%= request.getAttribute("name5") %>',
            borderColor: 'rgba(255, 206, 86, 0.5)',
            data: ['<%= request.getAttribute("E1") %>'],
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


//        var ctx3 = document.getElementById('chart3').getContext('2d');
//        var myChart3 = new Chart(ctx3, {
        var ctx3 = document.getElementById('chart3').getContext('2d');
        var myChart3 = new Chart(ctx3, {
        type: 'bar',
        data: {
            labels: ['<%= request.getAttribute("year1") %>'],
            datasets: [{
            label: '<%= request.getAttribute("name1") %>',
            backgroundColor: 'rgba(255, 99, 132, 0.5)',
            data: ['<%= request.getAttribute("A1") %>'],
        }, {
            label: '<%= request.getAttribute("name2") %>',
            backgroundColor: 'rgba(54, 162, 235, 0.5)',
            data: ['<%= request.getAttribute("B1") %>'],
        }, {
            label: '<%= request.getAttribute("name3") %>',
            backgroundColor: 'rgba(255, 206, 86, 0.5)',
            data: ['<%= request.getAttribute("C1") %>'],
        }, {
            label: '<%= request.getAttribute("name4") %>',
            backgroundColor: 'rgba(163, 220, 138)',
            data: ['<%= request.getAttribute("D1") %>'],
        }, {
            label: '<%= request.getAttribute("name5") %>',
            backgroundColor: 'rgba(113, 209, 209)',
            data: ['<%= request.getAttribute("E1") %>'],
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

    </script>
</body>
</html>

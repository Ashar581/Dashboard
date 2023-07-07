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
    
    <h2><center>Comparison Of 2 Most Frequent Topics Over The Years</center></h2>
    
    <div class="chart1-container">
        <canvas id="chart1"></canvas>
    </div>
    
    <br>


    <h2><center>Intensity Of 5 Most Frequent Sectors Over The Years</center></h2>
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
                labels: ['<%= request.getAttribute("year1") %>','<%= request.getAttribute("year2") %>',
                '<%= request.getAttribute("year3") %>','<%= request.getAttribute("year4") %>',
                '<%= request.getAttribute("year5") %>','<%= request.getAttribute("year6") %>',
                '<%= request.getAttribute("year7") %>','<%= request.getAttribute("year8") %>',
                '<%= request.getAttribute("year9") %>','<%= request.getAttribute("year10") %>'],
                datasets: [{
                label: '<%= request.getAttribute("label1") %>',
                backgroundColor: 'rgb(175, 211, 226)',
                data: ['<%= request.getAttribute("first1") %>','<%= request.getAttribute("first2") %>',
                '<%= request.getAttribute("first3") %>','<%= request.getAttribute("first4") %>',
                '<%= request.getAttribute("first5") %>','<%= request.getAttribute("first6") %>',
                '<%= request.getAttribute("first7") %>','<%= request.getAttribute("first8") %>',
                '<%= request.getAttribute("first9") %>','<%= request.getAttribute("first10") %>'],
            }, {
                label:'<%= request.getAttribute("label2") %>',
                backgroundColor: 'rgb(20, 108, 148)',
                data: ['<%= request.getAttribute("second1") %>','<%= request.getAttribute("second2") %>',
                '<%= request.getAttribute("second3") %>','<%= request.getAttribute("second4") %>',
                '<%= request.getAttribute("second5") %>','<%= request.getAttribute("second6") %>',
                '<%= request.getAttribute("second7") %>','<%= request.getAttribute("second8") %>',
                '<%= request.getAttribute("second9") %>','<%= request.getAttribute("second10") %>'],
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
           

//        var ctx3 = document.getElementById('chart3').getContext('2d');
//        var myChart3 = new Chart(ctx3, {
        var ctx3 = document.getElementById('chart3').getContext('2d');
        var myChart3 = new Chart(ctx3, {
        type: 'bar',
        data: {
            labels: ['2018', '2019', '2020', '2021', '2022'],
            datasets: [{
            label: '<%= request.getAttribute("peryearSector1") %>',
            backgroundColor: 'rgba(255, 99, 132, 0.5)',
            data: ['<%= request.getAttribute("a1") %>', '<%= request.getAttribute("a2") %>',
            '<%= request.getAttribute("a3") %>', '<%= request.getAttribute("a4") %>',
            '<%= request.getAttribute("a5") %>'],
        }, {
            label: '<%= request.getAttribute("peryearSector2") %>',
            backgroundColor: 'rgba(54, 162, 235, 0.5)',
            data: ['<%= request.getAttribute("b1") %>', '<%= request.getAttribute("b2") %>',
                        '<%= request.getAttribute("b3") %>', '<%= request.getAttribute("b4") %>',
                        '<%= request.getAttribute("b5") %>'],
        }, {
            label: '<%= request.getAttribute("peryearSector3") %>',
            backgroundColor: 'rgba(255, 206, 86, 0.5)',
            data: ['<%= request.getAttribute("c1") %>', '<%= request.getAttribute("c2") %>',
                        '<%= request.getAttribute("c3") %>', '<%= request.getAttribute("c4") %>',
                        '<%= request.getAttribute("c5") %>'],
        }, {
            label: '<%= request.getAttribute("peryearSector4") %>',
            backgroundColor: 'rgba(163, 220, 138)',
            data: ['<%= request.getAttribute("d1") %>', '<%= request.getAttribute("d2") %>',
                        '<%= request.getAttribute("d3") %>', '<%= request.getAttribute("d4") %>',
                        '<%= request.getAttribute("d5") %>'],
        }, {
            label: '<%= request.getAttribute("peryearSector5") %>',
            backgroundColor: 'rgba(113, 209, 209)',
            data: ['<%= request.getAttribute("e1") %>', '<%= request.getAttribute("e2") %>',
                        '<%= request.getAttribute("e3") %>', '<%= request.getAttribute("e4") %>',
                        '<%= request.getAttribute("e5") %>'],
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

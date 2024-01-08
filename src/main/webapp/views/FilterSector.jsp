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
    <h2><center>End Year Of <%= request.getAttribute("name1")%>  Sectors in 10 Years</center></h2>

    <div class="chart1-container">
        <canvas id="chart1"></canvas>
    </div>

    <br>


    <h2><center>Intensity Likelihood & Relevance Of <%= request.getAttribute("name1")%></center></h2>
    <div class="chart2-container">
        <canvas id="chart2"></canvas>
    </div>
    <br>


    <h2><center><%= request.getAttribute("name1")%> Sector Frequency in All Regions</center></h2>
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
                labels: ['<%= request.getAttribute("name1") %>'],
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


      var ctx3 = document.getElementById("chart3").getContext("2d");
      var myChart3 = new Chart(ctx3, {
         type: 'bar',
         data: {
            labels: ['<%= request.getAttribute("name1") %>'],
            datasets: [{
                data: ['<%= request.getAttribute("sectorRegionCount1") %>'],
               backgroundColor: ['rgba(255, 99, 132, 0.5)', 'rgb(25, 167, 206)', 'rgba(255, 206, 86, 0.5)', 'rgb(175, 211, 226)', 'rgb(20, 108, 148)'],
               borderWidth: 1,
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

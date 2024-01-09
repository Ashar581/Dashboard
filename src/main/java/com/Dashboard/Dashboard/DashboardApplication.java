package com.Dashboard.Dashboard;

import com.Dashboard.Dashboard.Entity.Data;
import com.Dashboard.Dashboard.Repository.DataReceiver;
import com.Dashboard.Dashboard.Repository.DataRepository;
import com.Dashboard.Dashboard.readCSV.readCsv;

import com.opencsv.exceptions.CsvValidationException;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.CommandLineRunner;
import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;

import java.io.IOException;
import java.util.List;

@SpringBootApplication
public class DashboardApplication implements CommandLineRunner{

	public DashboardApplication() throws CsvValidationException, IOException {
	}

	public static void main(String[] args) {
		SpringApplication.run(DashboardApplication.class, args);
	}

	@Autowired
	private DataRepository dataRepository;

	DataReceiver dataReceiver = new DataReceiver();

	List<Data> dataList = readCsv.addUser();

	@Override
	public void run(String... args) throws Exception {

		dataRepository.saveAll(dataList);

	}

}

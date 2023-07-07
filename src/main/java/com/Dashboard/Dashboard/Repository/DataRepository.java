package com.Dashboard.Dashboard.Repository;

import com.Dashboard.Dashboard.Entity.Data;
import org.springframework.data.repository.CrudRepository;

public interface DataRepository extends CrudRepository<Data,Integer>,DataCustomRepository {


}

















//    @PersistenceContext
//    private EntityManager entityManager;
//    public DataEstimation getdata(){
//        Query query = entityManager.createQuery("SELECT COUNT(d) FROM data d ");
//        int dataCount = (int) query.getSingleResult();
//
//        DataEstimation dataEstimation = new DataEstimation();
//
//        dataEstimation.setYearCount(dataCount);
//
//        return dataEstimation;
//
//    }
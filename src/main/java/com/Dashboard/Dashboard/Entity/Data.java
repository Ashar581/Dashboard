package com.Dashboard.Dashboard.Entity;

import jakarta.persistence.*;

@Entity
@Table(name = "Data")
public class Data {

    @Id
    @Column(name = "id")
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private int id;

    @Column(name = "end_year")
    private String end_year;
    @Column(name = "citylng")
    private String citylng;
    @Column(name = "citylat")
    private String citylat;
    @Column(name = "intensity")
    private String intensity;
    @Column(name = "sector")
    private String sector;
    @Column(name = "topic")
    private String topic;
    @Column(name = "insight",length = 500)
    private String insight;
    @Column(name = "swot",length = 500)
    private String swot;
    @Column(name = "url",length = 2000)
    private String url;
    @Column(name = "region")
    private String region;
    @Column(name = "start_year")
    private String start_year;
    @Column(name = "impact")
    private String impact;
    @Column(name = "added")
    private String added;
    @Column(name = "published")
    private String published;
    @Column(name = "city")
    private String city;
    @Column(name = "country")
    private String country;
    @Column(name = "relevance")
    private String relevance;
    @Column(name = "pestle")
    private String pestle;
    @Column(name = "source",length = 500)
    private String source;
    @Column(name = "title",length = 500)
    private String title;
    @Column(name = "likelihood")
    private String likelihood;


    public Data(){
        super();
    }

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public String getEnd_year() {
        return end_year;
    }

    public void setEnd_year(String end_year) {
        this.end_year = end_year;
    }

    public String getCitylng() {
        return citylng;
    }

    public void setCitylng(String citylng) {
        this.citylng = citylng;
    }

    public String getCitylat() {
        return citylat;
    }

    public void setCitylat(String citylat) {
        this.citylat = citylat;
    }

    public String getIntensity() {
        return intensity;
    }

    public void setIntensity(String intensity) {
        this.intensity = intensity;
    }

    public String getSector() {
        return sector;
    }

    public void setSector(String sector) {
        this.sector = sector;
    }

    public String getTopic() {
        return topic;
    }

    public void setTopic(String topic) {
        this.topic = topic;
    }

    public String getInsight() {
        return insight;
    }

    public void setInsight(String insight) {
        this.insight = insight;
    }

    public String getSwot() {
        return swot;
    }

    public void setSwot(String swot) {
        this.swot = swot;
    }

    public String getUrl() {
        return url;
    }

    public void setUrl(String url) {
        this.url = url;
    }

    public String getRegion() {
        return region;
    }

    public void setRegion(String region) {
        this.region = region;
    }

    public String getStart_year() {
        return start_year;
    }

    public void setStart_year(String start_year) {
        this.start_year = start_year;
    }

    public String getImpact() {
        return impact;
    }

    public void setImpact(String impact) {
        this.impact = impact;
    }

    public String getAdded() {
        return added;
    }

    public void setAdded(String added) {
        this.added = added;
    }

    public String getPublished() {
        return published;
    }

    public void setPublished(String published) {
        this.published = published;
    }

    public String getCity() {
        return city;
    }

    public void setCity(String city) {
        this.city = city;
    }

    public String getCountry() {
        return country;
    }

    public void setCountry(String country) {
        this.country = country;
    }

    public String getRelevance() {
        return relevance;
    }

    public void setRelevance(String relevance) {
        this.relevance = relevance;
    }

    public String getPestle() {
        return pestle;
    }

    public void setPestle(String pestle) {
        this.pestle = pestle;
    }

    public String getSource() {
        return source;
    }

    public void setSource(String source) {
        this.source = source;
    }

    public String getTitle() {
        return title;
    }

    public void setTitle(String title) {
        this.title = title;
    }

    public String getLikelihood() {
        return likelihood;
    }

    public void setLikelihood(String likelihood) {
        this.likelihood = likelihood;
    }
}

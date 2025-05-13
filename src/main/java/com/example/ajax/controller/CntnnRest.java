package com.example.ajax.controller;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RestController;

import com.example.ajax.mapper.CityMapper;
import com.example.ajax.mapper.CountryMapper;

@RestController

public class CntnnRest {

    @Autowired
    private CountryMapper countryMapper;

    @Autowired
    private CityMapper cityMapper;

    @GetMapping("/cntList/{continentNo}")
    public List<Map<String, Object>> cntList(@PathVariable int continentNo) {
        return countryMapper.selectCountriesByContinent(continentNo);
    }

    @GetMapping("/cityList/{countryNo}")
    public List<Map<String, Object>> cityList(@PathVariable int countryNo) {
        return cityMapper.selectCitiesByCountry(countryNo);
    }
}

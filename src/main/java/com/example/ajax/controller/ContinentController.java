package com.example.ajax.controller;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.example.ajax.mapper.CityMapper;
import com.example.ajax.mapper.ContinentMapper;
import com.example.ajax.mapper.CountryMapper;

@Controller
public class ContinentController {
    @Autowired
    private ContinentMapper continentMapper;
    @Autowired
    private CountryMapper countryMapper;
    @Autowired
    private CityMapper cityMapper;
    
    @GetMapping({"/", "/continentList"})
    public String continentList(@RequestParam(value = "continent", required = false) Integer continentNo,
                                @RequestParam(value = "country", required = false) Integer countryNo,
                                @RequestParam(value = "city", required = false) Integer cityNo,
                                Model model) {
        // 대륙 목록
        List<Map<String, Object>> continentList = continentMapper.selectContinentList();
        model.addAttribute("continentList", continentList);
        
        // 선택된 대륙에 해당하는 나라 목록
        List<Map<String, Object>> countryList = new ArrayList<>();
        if (continentNo != null) {
            countryList = countryMapper.selectCountriesByContinent(continentNo);
        }
        model.addAttribute("countryList", countryList);
        
        // 선택된 나라에 해당하는 도시 목록
        List<Map<String, Object>> cityList = new ArrayList<>();
        if (countryNo != null) {
            cityList = cityMapper.selectCitiesByCountry(countryNo);
        }
        model.addAttribute("cityList", cityList);

        // 선택된 대륙, 나라, 도시
        model.addAttribute("continentNo", continentNo);
        model.addAttribute("countryNo", countryNo);
        model.addAttribute("cityNo", cityNo);
        
        return "continentList";
    }
}

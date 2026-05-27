package com.krakedev.examen.vuelos.services;

import java.math.BigDecimal;
import java.util.List;
import java.util.Optional;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.krakedev.examen.vuelos.entities.Vuelo;
import com.krakedev.examen.vuelos.repositories.VueloRepository;

@Service
public class VueloService {

    @Autowired
    private VueloRepository vueloRepository;

    public Vuelo crear(Vuelo vuelo) {
        return vueloRepository.save(vuelo);
    }

    public List<Vuelo> listarTodos() {
        return vueloRepository.findAll();
    }

    public Optional<Vuelo> buscarPorId(Long id) {
        return vueloRepository.findById(id);
    }

    public Vuelo actualizar(Long id, Vuelo datos) {
        Vuelo vuelo = vueloRepository.findById(id)
            .orElseThrow(() -> new RuntimeException("Vuelo no encontrado"));
        vuelo.setCodigo(datos.getCodigo());
        vuelo.setPrecioBoleto(datos.getPrecioBoleto());
        vuelo.setAsientosDisponibles(datos.getAsientosDisponibles());
        vuelo.setDestino(datos.getDestino());
        return vueloRepository.save(vuelo);
    }

    public void eliminar(Long id) {
        if (!vueloRepository.existsById(id)) {
            throw new RuntimeException("Vuelo no encontrado");
        }
        vueloRepository.deleteById(id);
    }
    
    public List<Vuelo> buscarPorPrecioMenorA(BigDecimal precio) {
        return vueloRepository.findByPrecioBoletoLessThan(precio);
    }
}
package com.krakedev.examen.vuelos.entities;

import jakarta.persistence.*;
import java.math.BigDecimal;

@Entity
@Table(name = "vuelos")
public class Vuelo {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    @Column(name = "codigo", length = 10, nullable = false, unique = true)
    private String codigo;

    @Column(name = "precio_boleto", nullable = false)
    private BigDecimal precioBoleto;

    @Column(name = "asientos_disponibles", nullable = false)
    private Integer asientosDisponibles;

    // Getters y setters para todos los campos
    public Long getId() { return id; }
    public void setId(Long id) { this.id = id; }
    public String getCodigo() { return codigo; }
    public void setCodigo(String codigo) { this.codigo = codigo; }
    public BigDecimal getPrecioBoleto() { return precioBoleto; }
    public void setPrecioBoleto(BigDecimal precioBoleto) { this.precioBoleto = precioBoleto; }
    public Integer getAsientosDisponibles() { return asientosDisponibles; }
    public void setAsientosDisponibles(Integer asientosDisponibles) { this.asientosDisponibles = asientosDisponibles; }
}
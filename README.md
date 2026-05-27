# Brayan_Narv-ez_examen_bdd

## Parte 2
## Descripción
API REST para gestión de vuelos con Spring Boot y PostgreSQL.

## Video explicativo
https://drive.google.com/file/d/1ON04f3Ak6GJQs_92QqTKwtRlM7DF1HJc/view?usp=sharing


## Parte 3 — Cambios realizados

### Script SQL ejecutado
```sql
ALTER TABLE vuelos ADD COLUMN destino VARCHAR(100);
```

### Archivos modificados
- `src/.../entities/Vuelo.java` — se añadió campo destino con @Column y getters/setters
- `src/.../services/VueloService.java` — se incluyó destino en el método actualizar()
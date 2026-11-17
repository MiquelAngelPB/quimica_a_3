# QUÍMICA A3
Química A3 es un celular autómata que simula 2 químicos interactuando entre si en un mapa con espacios vacíos.

### Como funciona:
#### Las 3 reglas
--- 
1. **Quimico A:** Busca una casilla vacia en sus 4 ejes (Arriba - Abajo - Izquierda - Derecha) y, si encuentra uno, se expande.

2. **Quimico B:** Busca si hay Quimico A en cualquiera de las casillas adjacentes, si lo encuentra lo aniquila y ocupa el espacio.

3. **Life span:** Cada quimico B tiene un tiempo de vida definido, es un valor que asignamos en configuracion del entorno, cada ciclo le resta un punto de vida. Cuando su life span es de 0, muere, dejando vacio detras.

---

### TABLA DE REACCIONES:

|           |Quimico A|Quimico B|    Vacio   |
|-----------|---------|---------|------------|
|Quimico A  |  Nada   |  Muere  | Se expande |
|Quimico B  |  Mata   |  Nada   |    Nada    |

### Variables de configuración:
Podemos encontrar estas variabeles en "configuracion de estado inicial":
- ``` lifeSpan ``` Ajusta el tiempo de vida de quimico B.
- ``` spawnPercentB ``` Ajusta el spawnrate del quimico B.
- ``` spawnPercentA ``` Ajusta el spawnrate del quimico A.

### Buffer de reacciones:
El bufer de reacciones almacena una copia temporal de las array antes y despues de su reaccion.

Es decir antes de que a reaccione se le pasa su estado actual, para una vez hecho el calculo de la reaccion, actualizar ese estado como estado siguiente.

Asi evitamos errores de solapado de estados y conservacion de estados ya no validos.
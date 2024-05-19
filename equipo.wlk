class Partido {
	const jugadas = []
	const local
	const visitante
	
	method mejoroAlFinal() {
		return self.cantJugadasSegundo() > self.cantJugadas()/2
	}	
	method cantJugadasSegundo(){
		return jugadas.count{jugada=>jugada.esSegundoTiempo()}
	}
	
	method cantJugadas() = jugadas.size()
	
	method puntos(equipo) {
		const golesConvertidos = self.cantGoles(equipo)
		const golesRecibidos = self.cantGoles(self.adversario(equipo))
			
		if (golesConvertidos > golesRecibidos) return 3
		if (golesConvertidos == golesRecibidos) return 1
		return 0
	}
	method cantGoles(equipo){
		return jugadas.count{jugada=>jugada.esGolDe(equipo)}
	}
	method adversario(equipo){
		return if (equipo == local) visitante else local
	}
	method cantidadTarjetas(equipo){
		return jugadas.sum{jugada=>jugada.cuantasTarjetasPara(equipo)}
	}	
}


class Equipo {
	var property ganoMundiales = false
}

class Jugador {
	var property equipo
	var property nombre
}
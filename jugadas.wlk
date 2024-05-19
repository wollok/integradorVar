import referi.*
import equipo.*

class Jugada {
	var property minuto = 1
	var property jugador
	
	method esSegundoTiempo() = minuto > 45	
	
	method cuantasTarjetasPara(equipo){
		return if (self.sacaTarjeta() && self.esDe(equipo)) self.cuantosJugadoresDe(equipo) else 0
	}
	method sacaTarjeta()
	
	method esDe(equipo) = equipo == jugador.equipo()
	method cuantosJugadoresDe(equipo) = 1
	method esGolDe(equipo) = false
}

class JugadaDeGol inherits Jugada{

	const circunstanciasEspeciales = []
	
	method esGol() {
		return referiVAR.terminoEnGol(self)  
	}
	override method esGolDe(equipo) {
		return self.esGol() && self.esDe(equipo) 
	}
	
	override method sacaTarjeta() = self.tiene("saco camiseta")
	
	method noTieneCircunstanciasEspeciales() = circunstanciasEspeciales.isEmpty()
	
	method tieneAlguna(circunstancias) = circunstancias.any{cir=>self.tiene(cir)}
	
	method tiene(circunstancia) = circunstanciasEspeciales.contains(circunstancia)
	
}


class Falta  inherits Jugada{
	const intensidadDeLaFalta
	
	override method sacaTarjeta() {
 		return intensidadDeLaFalta > 75
	}
}

class PeleaEnLaCancha inherits Jugada{
	const jugadores = []
	
	method equipos() = jugadores.map{jugador=>jugador.equipo()}.asSet() 

	override method sacaTarjeta() {
		return 
			jugadores.size() > 5 && 
			self.equipos().size() == 2
	}
	
	override method cuantosJugadoresDe(equipo){
		return jugadores.count{jugador=>jugador.equipo() == equipo}
	}

	override method esDe(equipo) = self.equipos().contains(equipo)

}

class Insulto inherits Jugada {
	const insultoDicho
	
	override method sacaTarjeta() {
       return insultoDicho == "madre"
	}
}

